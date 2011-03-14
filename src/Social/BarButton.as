package Social {
	
	import flash.display.Sprite;
	import flash.display.Shape;
	
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
			this.textfield.textColor = Theme.main_color;
			this.textfield.embedFonts = true;
			this.textfield.selectable = false;
			this.textfield.autoSize = TextFieldAutoSize.LEFT;
			this.textfield.defaultTextFormat = this.textfield_format;
			this.textfield.text = _label;
			this.addChild(this.textfield);
			
			textfield.x = Main.grid / 2;
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
			
			button_shape.graphics.clear();
			button_shape.graphics.beginFill(Theme.front_color, 1);
			button_shape.graphics.moveTo(0, Main.grid * 0.5);
			button_shape.graphics.lineTo(Main.grid * 0.5, Main.grid);
			button_shape.graphics.lineTo(0, Main.grid * 1.5);
			button_shape.graphics.drawRect( 0, 0, textfield.width + Main.grid / 2, Main.grid * 2 - 1);
			button_shape.graphics.endFill();
			
			hover_shape.graphics.clear();
			hover_shape.graphics.beginFill(Theme.hover_color, 1);
			hover_shape.graphics.moveTo(0, Main.grid * 0.5);
			hover_shape.graphics.lineTo(Main.grid * 0.5, Main.grid);
			hover_shape.graphics.lineTo(0, Main.grid * 1.5);
			hover_shape.graphics.drawRect( 0, 0, textfield.width + Main.grid / 2, Main.grid * 2 - 1);
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
