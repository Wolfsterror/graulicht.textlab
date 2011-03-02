package Processors {
	/**
	 * @author Raphael Pohl
	 */
	public class Trace extends Processor {
		
		public function Trace() {
			input_count = 1;
			output_count = 0;
			
			_options = [ { name: "output", label: Language.words['output'], type: "text" } ];
			
			_width = 16;
			_name = Language.words['tracer'];
			_preview = "> Text";
			
			initialize();
		}
		
		override public function process():void {
			if (inputs[0]._connection == null)
				return;
			options.set_value("output", inputs[0].value());
		}
	}
}