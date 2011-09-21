package Processors {

	/**
	 * Shift letters in the alphabet with the given offset. Use it to create ROT-13 messages or even more fancy stuff.
	 *
	 * @author Raphael Pohl
	 */
	public class Shift extends Processor {

		public function Shift() {
			input_count = 1;
			output_count = 1;

			_options = [
				{ type: "label", text: Language.words['offset'] },
				{ name: "offset", type: "spinner", "min": 0, "max": 25 }
			];

			_width = 7;
			_name = Language.words['shifter'];
			_preview = "ABC BCD CDE";

			initialize();
		}

		override public function process():void {
			var values:Object = options.get_values();
			var text:String = inputs[0].value();

			var shifted:String = new String;
			var offset:Number = values["offset"];

			var i:int;
			for (i = 0; i < text.length; i++) {
				// TODO: is A-Z really enough? Can it be more?
				var char:Number = text.charCodeAt(i);
				if (char >= 65 && char <= 90) {
					// A-Z
					char = ((char - 65) + offset) % 26 + 65;
				} else if (char >= 97 && char <= 122) {
					// a-z
					char = ((char - 97) + offset) % 26 + 97;
				}
				shifted += String.fromCharCode(char);
			}

			this.set_output(0, shifted);
		}
	}
}
