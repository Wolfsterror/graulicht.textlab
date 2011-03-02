package Options {
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;
	
	import com.tweenman.TweenMan;
	
	/**
	 * @author Raphael Pohl
	 */
	public class Lamp extends MovieClip {
		
		private var label_format:TextFormat;
		private var label_field:TextField;
		
		private var _connector:ProcessorOptions;
		private var _name:String;
		private var _value:String;
		
		private var _bool:Boolean = false;
		
		private var shape:Shape = new Shape;
		private var shape_lamp:Shape = new Shape;
		
		public function Lamp(connector:ProcessorOptions, name:String, value:String) {
			_connector = connector;
			_value = value;
			_name = name;
			
			label_format = new TextFormat;
			label_format.font = "raffix.simple.upcase";
			label_format.size = 8;
			label_field = new TextField;
			label_field.type = TextFieldType.DYNAMIC;
			label_field.width = _connector.maxwidth - Main.grid + 4;
			label_field.textColor = Theme.back_color;
			label_field.embedFonts = true;
			label_field.selectable = false;
			label_field.multiline = true;
			label_field.wordWrap = true;
			label_field.autoSize = TextFieldAutoSize.LEFT;
			label_field.defaultTextFormat = this.label_format;
			label_field.text = _value;
			
			this.addChild(label_field);
			
			label_field.x = Main.grid - 4;
			label_field.y = 1;
			
			this.addChild(shape);
			this.addChild(shape_lamp);
			
			draw();
			refresh();
		}
		
		public function value(_newvalue:Boolean):void {
			_bool = _newvalue;
			refresh();
		}
		
		private function refresh():void {
			TweenMan.removeTweens(shape_lamp);
			if (_bool) {
				TweenMan.addTween(shape_lamp, { alpha: 1, time: Main.animation_duration, ease: "easeInOutQuart" } );
			} else {
				TweenMan.addTween(shape_lamp, { alpha: 0, time: Main.animation_duration, ease: "easeInOutQuart" } );
			}
		}
		
		public function redraw():void {
			draw();
		}
		
		private function draw():void {
			shape.graphics.clear();
			shape.graphics.beginFill(Theme.back_color);
			shape.graphics.drawRect(0, 3, Main.grid - 6, Main.grid - 6);
			shape.graphics.endFill();
			shape.graphics.beginFill(Theme.main_color);
			shape.graphics.drawRect(1, 4, Main.grid - 8, Main.grid - 8);
			shape.graphics.endFill();
			
			shape_lamp.graphics.clear();
			shape_lamp.graphics.beginFill(Theme.highlight_color);
			shape_lamp.graphics.drawRect(3, 6, Main.grid - 12, Main.grid - 12);
			shape_lamp.graphics.endFill();
			
			label_field.textColor = Theme.back_color;
		}
	}
}
