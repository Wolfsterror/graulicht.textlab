package Processors {

	/**
	 * I'm sorry, what does this and that?
	 *
	 * @author Raphael Pohl
	 */
	public class Comment extends Processor {

		public function Comment() {
			input_count = 0;
			output_count = 0;

			_options = [ { name: "comment", type: "input" } ];

			_width = 10;
			_name = Language.words['comment'];
			_preview = "Text";

			initialize();
		}

		override public function process():void {
		}
	}
}
