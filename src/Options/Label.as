package Options {
	
	import flash.display.MovieClip;
	
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;
	
	/**
	 * @author Raphael Pohl
	 */
	public class Label extends MovieClip {
		
		private var label_format:TextFormat;
		private var label_field:TextField;
		
		public function Label(_label:String) {
			label_format = new TextFormat;
			label_format.font = "raffix.simple.upcase";
			label_format.size = 8;
			label_field = new TextField;
			label_field.textColor = Theme.back_color;
			label_field.embedFonts = true;
			label_field.selectable = false;
			label_field.autoSize = TextFieldAutoSize.LEFT;
			label_field.defaultTextFormat = this.label_format;
			label_field.text = _label;
			this.addChild(label_field);
		}
		public function redraw():void {
			label_field.textColor = Theme.back_color;
		}
	}
}
