package Social {
	
	import flash.display.Sprite;
	import flash.display.GradientType;
	import flash.geom.Matrix;

	/**
	 * @author Raphael Pohl
	 */
	public class Userbar extends Sprite {
		
		public var user:User;
		public var avatar:Avatar;
		
		private var buttons:Array = new Array;
		
		public function Userbar() {
			user = new User;
			
			avatar = new Avatar;
			addChild(avatar);
			
			draw();
			
			buttons.push(new BarButton(Language.words['register'], function():void { Main.master.addChild(new Register()); } ));
			buttons.push(new BarButton(Language.words['login'], function():void { Main.master.addChild(new Login()); } ));
			create_buttons(buttons);
		}
		
		// TODO: draw, redraw, rearrange and stuff looks a bit messy.
		
		public function redraw():void {
			avatar.redraw();
			for (var i:* in buttons) {
				buttons[i].redraw();
			}
			draw();
			rearrange();
		}
		
		private function draw():void {
			var type:String = GradientType.LINEAR;
			var colors:Array = [Theme.hover_color, Theme.front_color]; 
			var alphas:Array = [1, 1]; 
			var ratios:Array = [0, 255]; 
			
			var matrix:Matrix = new Matrix(); 
			var boxWidth:Number = 1; 
			var boxHeight:Number = Main.grid * 2 - 1; 
			var boxRotation:Number = Math.PI/2; // 90° 
			var tx:Number = 0; 
			var ty:Number = 0; 
			matrix.createGradientBox(boxWidth, boxHeight, boxRotation, tx, ty); 
			
			this.graphics.beginGradientFill(type, colors, alphas, ratios, matrix);
			this.graphics.drawRect(0, 0, Main.master.stage.stageWidth, Main.grid * 2 - 1);
			this.graphics.beginFill(Theme.back_color);
			this.graphics.drawRect(0, Main.grid * 2 - 1, Main.master.stage.stageWidth, 1);
			this.graphics.endFill();
		}
		
		public function rearrange():void {
			resize();
			
			var r_x:int = avatar.width + 8;
			for (var i:* in buttons) {
				buttons[i].x = r_x;
				r_x += buttons[i].width;
			}
		}
		
		public function resize():void {
			draw();
		}
		
		public function clear_buttons():void {
			for (var i:* in buttons) {
				removeChild(buttons[i]);
			}
			buttons = new Array;
			rearrange();
		}
		
		private function create_buttons(buttons:Array):void {
			for (var i:* in buttons) {
				addChild(buttons[i]);
			}
			rearrange();
		}
		
		public function login_buttons():void {
			clear_buttons();
			buttons.push(new BarButton(Language.words['load'], function():void { Main.master.addChild(new Load); } ));
			buttons.push(new BarButton(Language.words['save'], function():void { Main.master.addChild(new Save); } ));
			create_buttons(buttons);
		}
	}
}
