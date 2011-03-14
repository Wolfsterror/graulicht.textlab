package Social {
	
	import flash.display.Shape;
	import flash.display.Sprite;
	import com.adobe.crypto.MD5;
	
	import flash.display.Bitmap;
	
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import flash.filters.BevelFilter;
	
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFieldAutoSize;
	
	/**
	 * @author Raphael Pohl
	 */
	public class Avatar extends Sprite {
		
		private const size:int = 18;
		private var border:Shape = new Shape;
		
		private var textfield_format:TextFormat;
		private var textfield:TextField;
		
		public function Avatar() {
			x = y = ((Main.grid * 2) - size) / 2;
			
			this.textfield_format = new TextFormat();
			this.textfield_format.font = "eiszfuchs.simple.regular";
			this.textfield_format.size = 16;
			
			this.textfield = new TextField;
			this.textfield.textColor = Theme.main_color;
			this.textfield.embedFonts = true;
			this.textfield.selectable = false;
			this.textfield.autoSize = TextFieldAutoSize.LEFT;
			this.textfield.defaultTextFormat = this.textfield_format;
			this.textfield.text = "nicht eingeloggt";
			this.addChild(this.textfield);
			
			textfield.x = size + 6;
			textfield.y = 1;
			
			addChild(border);
			draw();
		}
		
		public function redraw():void {
			draw();
			if (Main.userbar.user.email) {
				load();
				this.textfield.text = Main.userbar.user.name;
			}
		}
		public function load():void {
			var imageLoader:Loader = new Loader();
			
			imageLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			function onComplete(e:Event):void {
				var image:Bitmap = new Bitmap(e.target.content.bitmapData);
				addChild(image);
			}
			
			var hash:String = MD5.hash(Main.userbar.user.email);
			
			var imageRequest:URLRequest = new URLRequest("http://www.gravatar.com/avatar/" + hash + "?s=" + size);
			imageLoader.load(imageRequest);
		}
		
		private function draw():void {
			border.filters = [new BevelFilter(1, 45, Theme.front_color, 0.2, Theme.hover_color, 0.7, 2, 2, 1)];
			this.textfield.textColor = Theme.main_color;
			
			border.graphics.clear();
			border.graphics.beginFill(Theme.main_color);
			border.graphics.drawRect( -2, -2, size+4, size+4);
			border.graphics.drawRect( 0, 0, size, size);
			border.graphics.endFill();
			
			graphics.clear();
			graphics.beginFill(Theme.front_color, 0.5);
			graphics.drawRect( 0, 0, size, size);
			graphics.endFill();
		}
		
	}

}