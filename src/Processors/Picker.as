package Processors {

	import com.gskinner.utils.Rndm;

	/**
	 * Use a mask to randomly pick from two sets of given character sets.
	 * This comes in useful if you're looking for weird names.
	 *
	 * @author Raphael Pohl
	 */
	public class Picker extends Processor {

		public function Picker() {
			input_count = 3;
			output_count = 1;

			input_labels = ["X?", "Y?", Language.words['map']];

			_options = [
				{ type: "label", text: Language.words['seed'] },
				{ name: "seed", type: "spinner", "min": 1, "max": 99999, "value": Math.floor(1+Math.random()*99999) }
			];

			_width = 8;
			_height = 3;
			_name = Language.words['picker'];
			_preview = "XYXX --> AKEO";

			initialize();
		}

		override public function process():void {
			var values:Object = options.get_values();

			var set1:String = inputs[0].value();
			var set2:String = inputs[1].value();
			var pick_map:String = inputs[2].value().toLowerCase();

			var output:String = new String;

			var r:Rndm = new Rndm(values['seed']);
			for(var i:int = 0; i < pick_map.length; i++) {
				switch(pick_map.charAt(i)) {
					case 'x':
						output += set1.charAt(Math.floor(r.random()*set1.length));
						break;
					case 'y':
						output += set2.charAt(Math.floor(r.random()*set2.length));
						break;
					default:
						output += pick_map.charAt(i);
				}
			}

			this.set_output(0, output);
		}
	}
}
