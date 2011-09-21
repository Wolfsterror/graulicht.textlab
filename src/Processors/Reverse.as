package Processors {

	/**
	 * .sdrawkcab nrut dlrow ruoy ekaM
	 *
	 * @author Raphael Pohl
	 */
	public class Reverse extends Processor {

		public function Reverse() {
			input_count = 1;
			output_count = 1;

			_width = 5;
			_name = Language.words['reverse'];
			_preview = "yzarc";

			initialize();
		}

		override public function process():void {
			var text:String = inputs[0].value();
			var reverse:String = new String;

			var i:int;
			for (i = text.length-1; i >= 0; i--) {
				reverse += text.charAt(i);
			}

			this.set_output(0, reverse);
		}
	}
}