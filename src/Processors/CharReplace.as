package Processors {
	
	/**
	 * @author Raphael Pohl
	 */
	
	public class CharReplace extends Processor {
		
		public function CharReplace() {
			input_count = 3;
			output_count = 1;
			
			input_labels = [Language.words['haystack'], Language.words['needle'], Language.words['replacement']];
			output_labels = [Language.words['result']];
			
			_options = [
				{ name: "ignore", label: Language.words['ignore_undefined'], type: "checkbox" }
			];
			
			_width = 8;
			_name = Language.words['char_replace'];
			_preview = "T |e->a| xt";
			
			initialize();
		}
		
		override public function process():void {
			var values:Object = options.get_values();
			
			var haystack:String = inputs[0].value();
			var needle:String = inputs[1].value();
			var replacement:String = inputs[2].value();
			
			var i:int;
			var char:String;
			var error:Boolean;
			
			// needle und replacement gleich lang?
			if (needle.length != replacement.length) {
				inputs[1].set_error(true);
				inputs[2].set_error(true);
			}
			
			// prüfe needle
			for (i = 0; i < needle.length; i++) {
				char = needle.charAt(i);
				if (needle.indexOf(char) != needle.lastIndexOf(char)) {
					inputs[1].set_error(true);
					break;
				}
			}
			// prüfe replacement
			for (i = 0; i < replacement.length; i++) {
				char = replacement.charAt(i);
				if (replacement.indexOf(char) != replacement.lastIndexOf(char)) {
					inputs[2].set_error(true);
					break;
				}
			}
			
			if (error) return;
			
			// ausgabe berechnen
			var replaced:String = new String;
			var index:int;
			
			for (i = 0; i < haystack.length; i++) {
				char = haystack.charAt(i);
				index = needle.indexOf(char);
				if (index < 0 && !values["ignore"]) {
					replaced += char;
				} else {
					replaced += replacement.charAt(index);
				}
			}
			
			this.set_output(0, replaced);
		}
	}
}
