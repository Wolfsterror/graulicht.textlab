package Processors {

	/**
	 * This emits an empty string. You sometimes need it and it's smaller than an empty Source.
	 *
	 * @author Raphael Pohl
	 */
	public class Void extends Processor {

		public function Void() {
			input_count = 0;
			output_count = 1;

			output_labels = [Language.words['void']];

			_width = 4;
			_name = Language.words['void'];
			_preview = "[]";

			initialize();
		}

		override public function process():void {
			this.set_output(0, new String);
		}
	}
}
