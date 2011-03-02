package Dialogs {
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;
	
	import flash.filters.DropShadowFilter;
	import com.tweenman.TweenMan;
	
	/**
	 * @author Raphael Pohl
	 */
	public class Import extends Sprite {
		
		private var text_format:TextFormat;
		private var text_field:TextField;
		
		private var button_close:Button;
		private var button_import:Button;
		
		public function Import() {
			this.filters = [ new DropShadowFilter(2, 90, 0x000000, 0.3, 6, 6) ];
			
			text_format = new TextFormat;
			text_format.font = "eiszfuchs.simple.regular";
			text_format.size = 16;
			text_format.leftMargin = 2;
			text_format.rightMargin = 2;
			text_field = new TextField;
			text_field.type = TextFieldType.INPUT;
			text_field.width = Main.master.stage.stageWidth * 0.75;
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
			text_field.text = "";
			this.addChild(text_field);
			
			button_close = new Button(Language.words['close'], fade);
			button_close.y = text_field.height + 4;
			this.addChild(button_close);
			
			button_import = new Button(Language.words['import'], import_action);
			button_import.x = button_close.width + 4;
			button_import.y = text_field.height + 4;
			this.addChild(button_import);
			
			draw();
			Main.curtain.fade_in();
			
			x = Math.round(Main.master.stage.stageWidth / 2 - width / 2);
			y = Main.grid - height;
			
			TweenMan.addTween(this, { y: Main.grid * 2.5, time: Main.animation_duration, ease: "easeInOutQuart" } );
			
			text_field.addEventListener(Event.CHANGE, change_listener);
		}
		public function change_listener(e:Event):void {
			draw();
		}
		
		private function draw():void {
			this.graphics.clear();
			button_close.y = text_field.height + 4;
			button_import.y = text_field.height + 4;
			
			var _width:int = this.width;
			var _height:int = this.height;
			
			this.graphics.beginFill(Theme.back_color);
			this.graphics.drawRect( -Main.grid / 2, -Main.grid / 2, _width + Main.grid, _height + Main.grid);
			this.graphics.endFill();
			this.graphics.beginFill(Theme.front_color);
			this.graphics.drawRect( -Main.grid / 2 + 1, -Main.grid / 2 + 1, _width + Main.grid - 2, _height + Main.grid - 2);
			this.graphics.endFill();
		}
		
		private function import_action(e:Event = null):void {
			if (Main.load(text_field.text)) {
				fade();
			}
		}
		private function fade(e:Event = null):void {
			TweenMan.addTween(this, { y: 0, alpha: 0, time: Main.animation_duration * 2, ease: "easeInOutQuart", onComplete: function():void { die(); } } );
		}
		
		public function die(e:Event = null):void {
			Main.curtain.fade_out();
			Main.master.removeChild(this);
		}
	}
}
