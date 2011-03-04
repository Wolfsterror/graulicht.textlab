package {
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;
	
	import com.tweenman.TweenMan;

	/**
	 * Generic Button Class that can do ANYTHING YOU WANT!
	 * yeah... really.
	 * 
	 * @author Raphael Pohl
	 */
	public class Button extends Sprite {
		
		private var connector:ProcessorOptions;
		
		private var text_format:TextFormat;
		private var text_field:TextField;
		
		private var button_shape:Shape = new Shape;
		private var hover_shape:Shape = new Shape;
		
		public var padding:int = 2;
		public var margin:int = 0;
		
		public function Button(_label:String, _callback:Function, _connector:ProcessorOptions = null) {
			connector = _connector;
			
			this.buttonMode = true;
			this.mouseChildren = false;
			addChild(button_shape);
			addChild(hover_shape);
			hover_shape.alpha = 0;
			
			this.addEventListener(MouseEvent.MOUSE_OVER, mouseover_listener);
			this.addEventListener(MouseEvent.MOUSE_OUT, mouseout_listener);
			
			this.addEventListener(MouseEvent.CLICK, _callback);
			
			text_format = new TextFormat;
			text_format.font = "raffix.simple.upcase";
			text_format.size = 8;
			text_format.leftMargin = text_format.rightMargin = padding;
			
			text_field = new TextField;
			text_field.embedFonts = true;
			text_field.selectable = false;
			text_field.autoSize = TextFieldAutoSize.LEFT;
			text_field.defaultTextFormat = this.text_format;
			text_field.text = _label;
			addChild(text_field);
			
			draw();
		}
		
		public function redraw():void {
			draw();
		}
		
		public function draw():void {
			text_field.x = padding;
			text_field.y = padding + margin;
			
			button_shape.graphics.clear();
			button_shape.graphics.beginFill(Theme.front_color);
			button_shape.graphics.drawRect(0, 0, 1, margin);
			button_shape.graphics.endFill();
			button_shape.graphics.beginFill(Theme.front_color);
			button_shape.graphics.drawRect(0, text_field.height + padding * 2 + margin, 1, margin);
			button_shape.graphics.endFill();
			
			button_shape.graphics.beginFill(Theme.back_color);
			button_shape.graphics.drawRect(0, margin, text_field.width + padding * 2, text_field.height + padding * 2);
			button_shape.graphics.endFill();
			
			hover_shape.graphics.clear();
			hover_shape.graphics.beginFill(Theme.hover_color);
			hover_shape.graphics.drawRect(0, margin, text_field.width + padding * 2, text_field.height + padding * 2);
			hover_shape.graphics.endFill();
			
			text_field.textColor = Theme.main_color;
		}
		
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
