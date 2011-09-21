package Processors {

	/**
	 * Emits a single space whitespace character. It's useful if you need it but don't want to use a Source.
	 *
	 * @author Raphael Pohl
	 */
	public class Space extends Processor {

		public function Space() {
			input_count = 0;
			output_count = 1;

			output_labels = [Language.words['space']];

			_width = 3;
			_name = Language.words['space'];
			_preview = "\" \"";

			initialize();
		}

		override public function process():void {
			this.set_output(0, " ");
		}
	}
}
