package Processors {
	
	/**
	 * @author Raphael Pohl
	 */
	public class Glue extends Processor {
		
		public function Glue() {
			input_count = 2;
			output_count = 1;
			
			input_types = ['list', 'string'];
			output_types = ['string'];
			
			_width = 5;
			_name = Language.words['glue'];
			_preview = "ab+cd+ef";
			
			initialize();
		}
		
		override public function process():void {
			this.set_output(0, inputs[0].value().join(inputs[1].value()));
		}
	}
}
