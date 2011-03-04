package Processors {
	/**
	 * @author Raphael Pohl
	 */
	public class Counter extends Processor {
		
		public function Counter() {
			input_count = 1;
			output_count = 0;
			
			_options = [ { name: "length", type: "text" } ];
			
			_width = 6;
			_name = Language.words['counter'];
			_preview = "140";
			
			initialize();
			
			options.set_value("length", 0);
		}
		
		override public function process():void {
			options.set_value("length", inputs[0].value().length);
		}
	}
}