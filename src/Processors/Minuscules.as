package Processors {
	/**
	 * @author Raphael Pohl
	 */
	public class Minuscules extends Processor {
		
		public function Minuscules() {
			input_count = 1;
			output_count = 1;
			
			_width = 6;
			_name = Language.words['minuscules'];
			_preview = "text";
			
			initialize();
		}
		
		override public function process():void {
			// special cases (German language)
			var needle:String = "ẞ";
			var replacement:String = "ß";
			
			var lowcase:String = inputs[0].value();
			lowcase = lowcase.toLowerCase();
			
			var myvalue:String = new String;
			var i:int;
			var c:int;
			for (c = 0; c < lowcase.length; c++) {
				i = needle.indexOf(lowcase.charAt(c));
				if (i >= 0) {
					myvalue += replacement.charAt(i);
				} else {
					myvalue += lowcase.charAt(c);
				}
			}
			
			this.set_output(0, myvalue);
		}
	}
}