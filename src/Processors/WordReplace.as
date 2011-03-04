package Processors {
	
	/**
	 * @author Raphael Pohl
	 */
	
	public class WordReplace extends Processor {
		
		public function WordReplace() {
			input_count = 3;
			output_count = 1;
			
			input_labels = [Language.words['haystack'], Language.words['needle'], Language.words['replacement']];
			output_labels = [Language.words['result']];
			
			_options = [{ type: 'label', text: Language.words['help_words'] }]
			
			_width = 7;
			_name = Language.words['word_replace'];
			_preview = "|Text|->Word";
			
			initialize();
		}
		
		override public function process():void {
			var values:Object = options.get_values();
			
			var haystack:String = inputs[0].value();
			var needle:String = inputs[1].value();
			var replacement:String = inputs[2].value();
			
			// calculate output
			var replaced:String = new String;
			replaced = haystack.split(needle).join(replacement);

			this.set_output(0, replaced);
		}
	}
}
