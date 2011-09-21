package Processors {

	/**
	 * Make your Machine all interactive with this way-too-nice input-crossing processor!
	 *
	 * @author Raphael Pohl
	 */
	public class Cross extends Processor {

		public function Cross() {
			input_count = 2;
			output_count = 2;

			input_labels = ["A", "B"];
			output_labels = ["C", "D"];

			_options = [ { name: "cross", label: "A -> D", type: "checkbox" } ];

			_width = 6;
			_name = Language.words['cross'];
			_preview = "A->C / A->D";

			initialize();
		}

		override public function process():void {
			var values:Object = options.get_values();
			if (values["cross"]) {
				this.set_output(0, inputs[1].value());
				this.set_output(1, inputs[0].value());
			} else {
				this.set_output(0, inputs[0].value());
				this.set_output(1, inputs[1].value());
			}
		}
	}
}
