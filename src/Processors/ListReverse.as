package Processors {

	/**
	 * Reverse the order of elements in the provided list.
	 *
	 * @author Raphael Pohl
	 */
	public class ListReverse extends Processor {

		public function ListReverse() {
			input_count = 1;
			output_count = 1;

			input_types = ['list'];
			output_types = ['list'];

			_width = 5;
			_name = Language.words['list_reverse'];
			_preview = "def abc";

			initialize();
		}

		override public function process():void {
			var list:Array = inputs[0].value();
			var reverse:Array = new Array;

			reverse = list.reverse();

			this.set_output(0, reverse);
		}
	}
}