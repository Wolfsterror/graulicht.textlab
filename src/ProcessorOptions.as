package  {

	import flash.display.MovieClip;
	import Options.*;
	
	/**
	 * @author Raphael Pohl
	 */
	public class ProcessorOptions extends MovieClip {
		
		private var _values:Object = { };
		
		public  var maxwidth:int;
		private var sidepadding:int = 6;
		
		private var options:Array = new Array;
		private var _controller:Processor;
		
		private var displays:Object = {  };
		
		public function ProcessorOptions(_options:Array, controller:Processor) {
			_controller = controller;
			
			maxwidth = (_controller._width - (_controller.output_count > 0?1:0) - (_controller.input_count > 0?1:0)) * Main.grid - 1 - sidepadding * 2;
			
			var i:int;
			var label:Label;
			var text:Text;
			var input:Input;
			var checkbox:Checkbox;
			var spinner:Spinner;
			var seperator:Seperator;
			var button:SmallButton;
			var lamp:Lamp;
			
			for (i = 0; i < _options.length; i++) {
				switch(_options[i].type) {
					case 'input':
						_values[_options[i].name] = new String;
						
						label = new Label(_options[i].label);
						options.push(label);
						input = new Input(this, _options[i].name);
						options.push(input);
						
						displays[_options[i].name] = input;
						
						addChild(label);
						addChild(input);
						
						break;
					case 'text':
						_values[_options[i].name] = new String;
						
						label = new Label(_options[i].label);
						options.push(label);
						text = new Text(this, _values[_options[i].name]);
						options.push(text);
						
						displays[_options[i].name] = text;
						
						addChild(label);
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
						
						label = new Label(_options[i].label);
						options.push(label);
						spinner = new Spinner(this, _options[i].name, _options[i].min, _options[i].max, _options[i].value);
						options.push(spinner);
						
						displays[_options[i].name] = spinner;
						
						addChild(label);
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
			
			if(fire) {
				// burn!
				Main.fire();
			}
		}
	}
}
