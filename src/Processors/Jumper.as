package Processors {

	import com.gskinner.utils.Rndm;

	/**
	 * It jumps randomly between two given phases. MaKe yOur cAPITalIsATiON ALL wROnG!
	 * @author Raphael Pohl
	 */
	public class Jumper extends Processor {

		public function Jumper() {
			input_count = 2;
			output_count = 2;

			input_labels = ["X", "Y"];
			output_labels = ["phase a", "phase b"];

			_options = [
				{ type: "label", text: Language.words['seed'] },
				{ name: "seed", type: "spinner", "min": 1, "max": 99999, "value": Math.floor(1+Math.random()*99999) }
			];

			_width = 8;
			_height = 3;
			_name = Language.words['jumper'];
			_preview = "ABAABBBBA";

			initialize();
		}

		override public function process():void {
			var values:Object = options.get_values();

			var text1:String = inputs[0].value();
			var text2:String = inputs[1].value();

			var output1:String = new String;
			var output2:String = new String;

			var r:Rndm = new Rndm(values['seed']);
			for(var i:int = 0; i < Math.max(text1.length, text2.length); i++) {
				if(r.random() > 0.5) {
					output1 += text1.charAt(i);
					output2 += text2.charAt(i);
				} else {
					output1 += text2.charAt(i);
					output2 += text1.charAt(i);
				}
			}

			this.set_output(0, output1);
			this.set_output(1, output2);
		}
	}
}
