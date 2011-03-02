package Options {
	
	import flash.display.MovieClip;
	import flash.display.Shape;
	
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;
	
	/**
	 * @author Raphael Pohl
	 */
	public class Text extends MovieClip {
		
		private var gutter:Shape = new Shape;
		
		private var text_format:TextFormat;
		private var text_field:TextField;
		
		public function Text(_connector:ProcessorOptions, _text:String) {
			this.addChild(gutter);
			
			text_format = new TextFormat;
			text_format.font = "eiszfuchs.simple.regular";
			text_format.size = 16;
			text_format.leftMargin = 2;
			text_format.rightMargin = 2;
			text_field = new TextField;
			text_field.type = TextFieldType.DYNAMIC;
			text_field.width = _connector.maxwidth;
			text_field.wordWrap = true;
			text_field.textColor = Theme.text_color;
			text_field.embedFonts = true;
			text_field.selectable = true;
			text_field.border = true;
			text_field.borderColor = Theme.front_color;
			text_field.background = true;
			text_field.backgroundColor = Theme.back_color;
			text_field.autoSize = TextFieldAutoSize.LEFT;
			text_field.defaultTextFormat = this.text_format;
			text_field.text = _text;
			this.addChild(text_field);
		}
		
		public function redraw():void {
			text_field.textColor = Theme.text_color;
			text_field.borderColor = Theme.front_color;
			text_field.backgroundColor = Theme.back_color;
		}
		
		public function value(_newvalue:String):void {
			text_field.text = _newvalue;
			
			gutter.graphics.clear();
			gutter.graphics.beginFill(Theme.highlight_color, 0);
			gutter.graphics.drawRect(0, 0, 1, text_field.height + 3);
			gutter.graphics.endFill();
		}
	}
}
