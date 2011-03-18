package  {

	import flash.display.MovieClip;
	import Options.*;
	
	/**
	 * @author Raphael Pohl
	 */
	public class ProcessorOptions extends MovieClip {
		
		private var _values:Object = { };
		
		public  var maxwidth:int;
		private var sidepadding:int = 4;
		
		private var settings:Array = new Array;
		
		private var options:Array = new Array;
		private var _controller:Processor;
		
		private var displays:Object = {  };
		
		public function ProcessorOptions(_options:Array, controller:Processor) {
			_controller = controller;
			settings = _options; // save it for later
			
			maxwidth = (_controller._width - (_controller.output_count > 0?1:0) - (_controller.input_count > 0?1:0)) * Main.grid - 1 - sidepadding * 2;
			
			var i:int;
			var label:Label;
			var text:Text;
			var input:TextInput;
			var checkbox:Checkbox;
			var spinner:Spinner;
			var seperator:Seperator;
			var button:SmallButton;
			var lamp:Lamp;
			
			for (i = 0; i < _options.length; i++) {
				switch(_options[i].type) {
					case 'input':
						_values[_options[i].name] = new String;
						
						input = new TextInput(this, _options[i].name);
						options.push(input);
						
						displays[_options[i].name] = input;
						
						addChild(input);
						
						break;
					case 'text':
						_values[_options[i].name] = new String;
						
						text = new Text(this, _values[_options[i].name]);
						options.push(text);
						
						displays[_options[i].name] = text;
						
						addChild(text);
						
						break;
					case 'checkbox':
						_values[_options[i].name] = new Boolean;
						
						checkbox = new Checkbox(this, _options[i].name, _options[i].label);
						options.push(checkbox);
						
						displays[_options[i].name] = checkbox;
						
						addChild(checkbox);
						
						break;
					case 'spinner':
						_values[_options[i].name] = new Number;
						if(_options[i].value != null) {
							_values[_options[i].name] = _options[i].value;
						} else {
							_values[_options[i].name] = _options[i].min;
						}
						
						spinner = new Spinner(this, _options[i].name, _options[i].min, _options[i].max, _options[i].value);
						options.push(spinner);
						
						displays[_options[i].name] = spinner;
						
						addChild(spinner);
						
						break;
					case 'seperator':
						seperator = new Seperator(this);
						options.push(seperator);
						
						addChild(seperator);
						
						break;
					case 'button':
						button = new SmallButton(_options[i].label, _options[i].action, this);
						options.push(button);
						
						addChild(button);
						
						break;
					case 'lamp':
						_values[_options[i].name] = new Boolean;
						
						lamp = new Lamp(this, _options[i].name, _options[i].label);
						options.push(lamp);
						
						displays[_options[i].name] = lamp;
						
						addChild(lamp);
						
						break;
					case 'label':
						label = new Label(_options[i].text, this);
						options.push(label);
						
						addChild(label);
						
						break;
					default:
						// skip
				}
			}
			rearrange();
		}
		
		public function rearrange():void {
			var i:int;
			var gutter:int = -1;
			var _y:int = Main.grid;
			
			if (settings.length > 0) {
				if (settings[0].type == "text" || settings[0].type == "input") {
					_y += sidepadding / 2;
				}
			}
			
			for (i = 0; i < options.length; i++) {
				options[i].y = _y;
				_y += gutter + options[i].height;
			}
			
			x = sidepadding;
			if (_controller.input_count > 0) {
				x += Main.grid;
			}
			
			_y += 2;
			_controller._height = Math.max(Math.ceil(_y / Main.grid), _controller.input_count + 1, _controller.output_count + 1);
			_controller.draw();
		}
		
		public function redraw():void {
			var i:int;
			for (i = 0; i < options.length; i++) {
				options[i].redraw();
			}
		}
		
		public function get_values():Object {
			return _values;
		}
		public function set_value(_name:String, _value:*, fire:Boolean = false):void {
			if (displays[_name]) {
				displays[_name].value(_value);
			}
			
			rearrange();
			_values[_name] = _value;
			
			if(fire && _controller.output_count > 0) {
				// burn!
				Main.fire();
			}
		}
	}
}
