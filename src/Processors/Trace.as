package Processors {

	/**
	 * This prints the value at its input.
	 * It's the most important processor!
	 *
	 * @author Raphael Pohl
	 */
	public class Trace extends Processor {

		public function Trace() {
			input_count = 1;
			output_count = 0;

			_options = [ { name: "output", type: "text" } ];

			_width = 16;
			_name = Language.words['tracer'];
			_preview = "> Text";

			initialize();
		}

		override public function process():void {
			// prevent it from crashing
			if (inputs[0]._connection == null)
				return;
			options.set_value("output", inputs[0].value()); // don't confuse it with setOutput() here!
			                                                // - I just did. Damn.
		}
	}
}
