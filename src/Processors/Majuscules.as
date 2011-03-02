package Processors {
	/**
	 * @author Raphael Pohl
	 */
	public class Majuscules extends Processor {
		
		public function Majuscules() {
			input_count = 1;
			output_count = 1;
			
			_width = 6;
			_name = Language.words['majuscules'];
			_preview = "TEXT";
			
			initialize();
		}
		
		override public function process():void {
			// special cases (German language)
			var needle:String = "ß";
			var replacement:String = "ẞ";
			
			var upcase:String = inputs[0].value();
			upcase = upcase.toUpperCase();
			
			var myvalue:String = new String;
			var i:int;
			var c:int;
			for (c = 0; c < upcase.length; c++) {
				i = needle.indexOf(upcase.charAt(c));
				if (i >= 0) {
					myvalue += replacement.charAt(i);
				} else {
					myvalue += upcase.charAt(c);
				}
			}
			
			this.set_output(0, myvalue);
		}
	}
}
