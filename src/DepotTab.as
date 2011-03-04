package  {

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;
	
	/**
	 * @author Raphael Pohl
	 */
	public class DepotTab extends Sprite {
		
		private var label_format:TextFormat;
		private var label_field:TextField;
		
		private var _id:int;
		
		public function DepotTab(label:String, id:int) {
			_id = id;
			
			label_format = new TextFormat;
			label_format.font = "raffix.simple.upcase";
			label_format.size = 8;
			label_format.leftMargin = label_format.rightMargin = 4;
			
			label_field = new TextField;
			label_field.embedFonts = true;
			label_field.selectable = false;
			label_field.autoSize = TextFieldAutoSize.LEFT;
			label_field.defaultTextFormat = this.label_format;
			label_field.text = label;
			
			this.addChild(label_field);
			label_field.y = 2;
			
			draw();
			
			this.buttonMode = true;
			this.mouseChildren = false;
			this.addEventListener(MouseEvent.CLICK, click_listener);
		}
		
		public function redraw():void {
			draw();
		}
		private function draw():void {
			this.graphics.clear();
			this.graphics.beginFill(Theme.canvas_color);
			this.graphics.drawRect(0, 0, label_field.width, Main.grid + 4);
			this.graphics.endFill();
			
			label_field.textColor = Theme.highlight_color;
		}
		
		private function click_listener(e:Event = null):void {
			Main.depot.show_menu(_id);
		}
	}
}
