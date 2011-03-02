package Processors {
	/**
	 * @author Raphael Pohl
	 */
	public class Repeat extends Processor {
		
		public function Repeat() {
			input_count = 1;
			output_count = 1;
			
			_options = [ { name: "chars", label: Language.words['chars'], type: "checkbox" } ];
			
			_width = 6;
			_name = Language.words['repeat'];
			_preview = "eecchhoo";
			
			initialize();
		}
		
		override public function process():void {
			var values:Object = options.get_values();
			var text:String = inputs[0].value();
			
			var i:int;
			
			var repeated:String = new String;
			if (values["chars"]) {
				// jedes zeichen einzeln wiederholen
				for (i = 0; i < text.length; i++) {
					repeated += text.charAt(i) + text.charAt(i);
				}
			} else {
				// die ganze zeichenkette wiederholen
				repeated = text + text;
			}
			
			this.set_output(0, repeated);
		}
	}
}
