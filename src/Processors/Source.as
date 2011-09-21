package Processors {

	/**
	 * It emits the character set that was typed in by the user to its output.
	 * (Connect it to a Trace and watch the magic go boom!)
	 *
	 * @author Raphael Pohl
	 */
	public class Source extends Processor {

		public function Source() {
			input_count = 0;
			output_count = 1;

			_options = [ { name: "input", type: "input" } ];

			_width = 16;
			_name = Language.words['source'];
			_preview = "Text|";

			initialize();
		}

		override public function process():void {
			var values:Object = options.get_values();
			this.set_output(0, values["input"]);
		}
	}
}
