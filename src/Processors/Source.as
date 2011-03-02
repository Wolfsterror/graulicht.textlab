package Processors {
	/**
	 * @author Raphael Pohl
	 */
	public class Source extends Processor {
		
		public function Source() {
			input_count = 0;
			output_count = 1;
			
			_options = [ { name: "input", label: Language.words['input'], type: "input" } ];
			
			_width = 16;
			_name = Language.words['source'];
			_preview = "Text|";
			
			initialize();
		}
		
		override public function process():void {
			var values:Object = options.get_values();
			this.set_output(0, values["input"]);
		}
	}
}