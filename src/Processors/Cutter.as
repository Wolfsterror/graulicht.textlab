package Processors {
	
	/**
	 * @author Raphael Pohl
	 */
	public class Cutter extends Processor {
		
		public function Cutter() {
			input_count = 2;
			output_count = 1;
			
			input_types = ['string', 'string'];
			output_types = ['list'];
			
			_width = 5;
			_name = Language.words['cutter'];
			_preview = "ab|cd|ef";
			
			initialize();
		}
		
		override public function process():void {
			this.set_output(0, inputs[0].value().split(inputs[1].value()));
		}
	}
}
