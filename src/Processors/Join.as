package Processors {

	/**
	 * Mash those strings together, following a pattern.
	 *
	 * @author Raphael Pohl
	 */
	public class Join extends Processor {

		public function Join() {
			input_count = 2;
			output_count = 1;

			input_labels = ["X", "Y"];

			_options = [
				{ name: "zipper", label: Language.words['zipper'], type: "checkbox" },
				{ type: "seperator" },
				{ type: "label", text: Language.words['take_chars'] + "X" },
				{ name: "take1", type: "spinner", "min": 1, "max": 100 },
				{ type: "label", text: Language.words['take_chars'] + "Y" },
				{ name: "take2", type: "spinner", "min": 1, "max": 100 }
			];

			_width = 8;
			_height = 3;
			_name = Language.words['join'];
			_preview = "AABAABAAB";

			initialize();
		}

		override public function process():void {
			var values:Object = options.get_values();
			var text1:String = inputs[0].value();
			var text2:String = inputs[1].value();

			var index:int = 0;
			var index1:int = 0;
			var index2:int = 0;
			var inc1:int = values["take1"];
			var inc2:int = values["take2"];

			var length:int = Math.max(text1.length, text2.length);
			var i:int;
			var t:int;

			var joined:String = new String;
			if (values["zipper"]) {
				// zipper mode (don't loose any character, take them all!)
				for (i = 0; i < length; i++) {
					for (t = 0; t < inc1; t++) {
						joined += text1.charAt(index1++);
					}
					for (t = 0; t < inc2; t++) {
						joined += text2.charAt(index2++);
					}
				}
			} else {
				// pick X, drop Y; then pick Y, drop X.
				for (i = 0; i < length; i++) {
					if (i % 2 == 0) {
						for (t = 0; t < inc1; t++) {
							joined += text1.charAt(index++);
						}
					} else {
						for (t = 0; t < inc2; t++) {
							joined += text2.charAt(index++);
						}
					}
				}
			}

			this.set_output(0, joined);
		}
	}
}
