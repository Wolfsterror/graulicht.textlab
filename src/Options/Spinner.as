package Options {
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormatAlign;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;
	
	/**
	 * @author Raphael Pohl
	 */
	public class Spinner extends MovieClip {
		
		private var label_format:TextFormat;
		private var label_field:TextField;
		
		private var _connector:ProcessorOptions;
		private var _name:String;
		
		private var _value:Number = 0;
		private var _min:Number;
		private var _max:Number;
		
		private var plus:Sprite = new Sprite;
		private var minus:Sprite = new Sprite;
		
		public function Spinner(connector:ProcessorOptions, name:String, min:int, max:int, value:* = null) {
			_connector = connector;
			_name = name;
			
			if (value != null) {
				_value = value;
			} else {
				_value = min;
			}
			
			_min = min;
			_max = max;
			
			label_format = new TextFormat;
			label_format.font = "raffix.simple.upcase";
			label_format.size = 8;
			label_format.align = TextFormatAlign.RIGHT;
			label_field = new TextField;
			label_field.type = TextFieldType.DYNAMIC;
			label_field.width = Main.grid * 2;
			label_field.textColor = Theme.text_color;
			label_field.background = true;
			label_field.backgroundColor = Theme.back_color;
			label_field.embedFonts = true;
			label_field.selectable = false;
			label_field.multiline = true;
			label_field.wordWrap = true;
			label_field.autoSize = TextFieldAutoSize.RIGHT;
			label_field.defaultTextFormat = this.label_format;
			label_field.text = _value.toString();
			
			this.addChild(label_field);
			
			label_field.x = 0;
			label_field.y = 1;
			
			this.addChild(plus);
			this.addChild(minus);
			plus.buttonMode = true;
			minus.buttonMode = true;
			
			plus.addEventListener(MouseEvent.CLICK, plus_action);
			minus.addEventListener(MouseEvent.CLICK, minus_action);
			
			plus.x = Main.grid * 2 + 8;
			minus.x = Main.grid * 3 + 8;
			
			plus.y = minus.y = 4;
			
			draw();
		}
		
		public function value(_newvalue:Number):void {
			_value = _newvalue;
			label_field.text = _value.toString();
		}
		
		public function redraw():void {
			draw();
		}
		private function draw():void {
			plus.graphics.clear();
			plus.graphics.beginFill(Theme.main_color);
			
			var cell:int = Math.floor((Main.grid - 6) / 3);
			
			plus.graphics.drawRect(cell, 0, cell, cell*3);
			plus.graphics.drawRect(cell*0, cell*1, cell, cell);
			plus.graphics.drawRect(cell*2, cell*1, cell, cell);
			plus.graphics.endFill();
			
			minus.graphics.clear();
			minus.graphics.beginFill(Theme.main_color);
			minus.graphics.drawRect(0, cell, cell*3, cell);
			minus.graphics.endFill();
			
			label_field.textColor = Theme.text_color;
			label_field.backgroundColor = Theme.back_color;
		}
		
		private function plus_action(e:Event = null):void {
			_value++;
			if (_value > _max) {
				_value = _min;
			}
			change();
		}
		private function minus_action(e:Event = null):void {
			_value--;
			if (_value < _min) {
				_value = _max;
			}
			change();
		}
		
		public function change(e:Event = null):void {
			label_field.text = _value.toString();
			_connector.set_value(_name, _value, true);
		}
	}
}
