package Processors {

	/**
	 * Append the on B after A.
	 *
	 * @author Raphael Pohl
	 */
	public class Append extends Processor {

		public function Append() {
			input_count = 2;
			output_count = 1;

			input_labels = ["A", "B"];
			output_labels = ["A+B"];

			_width = 4;
			_name = Language.words['append'];
			_preview = "A+B";

			initialize();
		}

		override public function process():void {
			var text1:String = inputs[0].value();
			var text2:String = inputs[1].value();

			var appended:String = new String;

			appended += text1;
			appended += text2;

			this.set_output(0, appended);
		}
	}
}
