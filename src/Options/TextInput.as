package Options {
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.events.Event;
	
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;
	
	/**
	 * @author Raphael Pohl
	 */
	public class TextInput extends MovieClip {
		
		private var input_format:TextFormat;
		private var input_field:TextField;
		
		private var _connector:ProcessorOptions;
		private var _name:String;
		
		private var gutter:Shape = new Shape;
		
		public function TextInput(connector:ProcessorOptions, value:String) {
			this.addChild(gutter);
			
			_connector = connector;
			_name = value;
			
			input_format = new TextFormat;
			input_format.font = "eiszfuchs.simple.regular";
			input_format.size = 16;
			input_format.leftMargin = 2;
			input_format.rightMargin = 2;
			input_field = new TextField;
			input_field.type = TextFieldType.INPUT;
			input_field.width = _connector.maxwidth;
			input_field.wordWrap = true;
			input_field.multiline = true;
			input_field.textColor = Theme.text_color;
			input_field.embedFonts = true;
			input_field.selectable = true;
			input_field.border = true;
			input_field.borderColor = Theme.front_color;
			input_field.background = true;
			input_field.backgroundColor = Theme.back_color;
			input_field.autoSize = TextFieldAutoSize.LEFT;
			input_field.defaultTextFormat = this.input_format;
			input_field.text = _connector.get_values()[_name];
			this.addChild(input_field);
			gutter.alpha = 0;
			
			input_field.addEventListener(Event.CHANGE, change_listener);
		}
		
		private function draw():void {
			input_field.textColor = Theme.text_color;
			input_field.borderColor = Theme.front_color;
			input_field.backgroundColor = Theme.back_color;
		}
		
		public function redraw():void {
			draw();
			change_listener(null, false);
		}
		
		public function value(_newvalue:String):void {
			input_field.text = _newvalue;
			change_listener(null, false);
		}
		public function change_listener(e:Event = null, _send:Boolean = true):void {
			gutter.graphics.clear();
			gutter.graphics.beginFill(Theme.highlight_color, 0);
			gutter.graphics.drawRect(0, 0, 1, input_field.height + 3);
			gutter.graphics.endFill();
			
			if(_send) {
				_connector.set_value(_name, input_field.text, true);
			}
		}
	}
}
