package Processors {
	/**
	 * @author Raphael Pohl
	 */
	public class Marquee extends Processor {
		
		public function Marquee() {
			input_count = 1;
			output_count = 1;
			
			_options = [ { name: "offset", label: Language.words['offset'], type: "spinner", "min": -1000, "max": 1000, "value": 0 } ];
			
			_width = 7;
			_name = Language.words['marquee'];
			_preview = "Text tTex";
			
			initialize();
		}
		
		override public function process():void {
			var values:Object = options.get_values();
			var text:String = inputs[0].value();
			
			var shifted:String = new String;
			var offset:Number = values["offset"];
			
			var i:int;
			var c:int;
			for (c = 0; c < text.length; c++) {
				i = c - offset;
				while (i >= text.length) {
					i -= text.length;
				}
				while (i < 0) {
					i += text.length;
				}
				shifted += text.charAt(i);
			}
			
			this.set_output(0, shifted);
		}
	}
}
