package Social {
	
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.filters.DropShadowFilter;
	
	import flash.display.GradientType;
	import flash.geom.Matrix;
	
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	import com.tweenman.TweenMan;
	
	/**
	 * @author Raphael Pohl
	 */
	public class BarButton extends Sprite {
		
		private var textfield_format:TextFormat;
		private var textfield:TextField;
		
		private var button_shape:Shape = new Shape;
		private var hover_shape:Shape = new Shape;
		
		public function BarButton(_label:String, _callback:Function) {
			addChild(button_shape);
			addChild(hover_shape);
			hover_shape.alpha = 0;
			
			this.buttonMode = true;
			this.mouseChildren = false;
			
			this.textfield_format = new TextFormat();
			this.textfield_format.font = "raffix.simple.upcase";
			this.textfield_format.size = 8;
			this.textfield_format.leftMargin = this.textfield_format.rightMargin = 8;
			
			this.textfield = new TextField;
			this.textfield.embedFonts = true;
			this.textfield.selectable = false;
			this.textfield.autoSize = TextFieldAutoSize.LEFT;
			this.textfield.defaultTextFormat = this.textfield_format;
			this.textfield.text = _label;
			this.addChild(this.textfield);
			
			textfield.y = ((Main.grid * 2) - textfield.height) / 2;
			
			draw();
			
			this.addEventListener(MouseEvent.MOUSE_OVER, mouseover_listener);
			this.addEventListener(MouseEvent.MOUSE_OUT, mouseout_listener);
			
			this.addEventListener(MouseEvent.CLICK, _callback);
		}
		
		public function redraw():void {
			draw();
		}
		private function draw():void {
			this.textfield.textColor = Theme.main_color;
			this.textfield.filters = [ new DropShadowFilter(1, 90, Theme.back_color, 0.5, 0, 0) ];
			
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
			
			button_shape.graphics.clear();
			button_shape.graphics.beginGradientFill(type, colors, alphas, ratios, matrix);
			button_shape.graphics.drawRect(2, 0, textfield.width-2, Main.grid * 2 - 1);
			
			button_shape.graphics.beginFill(Theme.front_color);
			button_shape.graphics.drawRect(0, 0, 1, Main.grid * 2 - 1);
			button_shape.graphics.beginFill(Theme.hover_color);
			button_shape.graphics.drawRect(1, 0, 1, Main.grid * 2 - 1);
			
			button_shape.graphics.endFill();
			
			hover_shape.graphics.clear();
			hover_shape.graphics.beginFill(Theme.front_color, 1);
			hover_shape.graphics.drawRect(2, 0, textfield.width-2, Main.grid * 2 - 1);
			hover_shape.graphics.endFill();
		}
		
		// visual feedback
		private function mouseover_listener(e:Event):void {
			TweenMan.removeTweens(hover_shape);
			TweenMan.addTween(hover_shape, { alpha: 1, time: Main.animation_duration * 2 } );
		}
		private function mouseout_listener(e:Event):void {
			TweenMan.removeTweens(hover_shape);
			TweenMan.addTween(hover_shape, { alpha: 0, time: Main.animation_duration * 2 } );
		}
	}
}
