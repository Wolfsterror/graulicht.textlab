package Processors {

	/**
	 * Talk Like A Dump Troll From One Of Those Terry Pratchett Books!
	 *
	 * @author Raphael Pohl
	 */
	public class Capitalizer extends Processor {

		public function Capitalizer() {
			input_count = 1;
			output_count = 1;

			_width = 6;
			_name = Language.words['capitalizer'];
			_preview = "Man Of Cool";

			initialize();
		}

		override public function process():void {
			// special cases (German language)
			var small:String = "ß";
			var large:String = "ẞ";

			var input:String = inputs[0].value();
			var output:String = new String;

			var capitalize:Boolean = true;
			for(var i:int = 0; i < input.length; i++) {
				var char:String = input.charAt(i);
				if(capitalize) {
					if(char == small) {
						char = large;
					}
					output += char.toUpperCase();

					capitalize = false;
				} else {
					if(char == large) {
						char = small;
					}
					output += char.toLowerCase();
				}
				if(char == ' ') {
					capitalize = true;
				}
			}

			this.set_output(0, output);
		}
	}
}
