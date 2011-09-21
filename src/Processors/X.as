package Processors {

	/**
	 * This is used for decoration. Use it to wrap connections as you like.
	 *
	 * @author Raphael Pohl
	 */
	public class X extends Processor {

		public function X() {
			input_count = 1;
			output_count = 1;

			input_labels = [" "];
			output_labels = [" "];

			_width = 2;
			_name = Language.words['x'];
			_preview = "";

			initialize();
		}

		override public function process():void {
			this.set_output(0, inputs[0].value());
		}
	}
}
