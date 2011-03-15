package Social {
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;
	
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;
	import flash.net.URLLoaderDataFormat;
	
	import flash.filters.DropShadowFilter;
	import com.adobe.crypto.MD5;
	import com.adobe.serialization.json.JSON;
	import com.tweenman.TweenMan;
	
	/**
	 * @author Raphael Pohl
	 */
	public class Load extends Sprite {
		
		private var text_format:TextFormat;
		private var text_field:TextField;
		
		private var button_close:Button;
		private var button_list:Array = new Array;
		
		public function Load() {
			alpha = 0; // hide everything until the list is loaded; it will look way nicer!
			
			this.filters = [ new DropShadowFilter(2, 90, 0x000000, 0.3, 6, 6) ];
			
			text_format = new TextFormat;
			text_format.font = "eiszfuchs.simple.regular";
			text_format.size = 16;
			text_format.leftMargin = 2;
			text_format.rightMargin = 2;
			text_field = new TextField;
			text_field.type = TextFieldType.DYNAMIC;
			text_field.width = Main.master.stage.stageWidth * 0.3;
			text_field.wordWrap = true;
			text_field.textColor = Theme.text_color;
			text_field.embedFonts = true;
			text_field.selectable = false;
			text_field.autoSize = TextFieldAutoSize.LEFT;
			text_field.defaultTextFormat = this.text_format;
			text_field.text = Language.words['load_help'];
			this.addChild(text_field);
			
			button_close = new Button(Language.words['close'], fade);
			button_close.y = text_field.height + 4;
			this.addChild(button_close);
			
			draw();
			Main.curtain.fade_in();
			
			x = Math.round(Main.master.stage.stageWidth / 2 - width / 2);
			
			load();
		}
		
		private function load():void {
			var file_loader:URLLoader = new URLLoader();
			file_loader.dataFormat = URLLoaderDataFormat.TEXT;
			var variables:URLVariables = new URLVariables();
			variables.project = Main.project_name;
			variables.nick = Main.userbar.user.name;
			variables.password = Main.userbar.user.pass;
			file_loader.addEventListener(Event.COMPLETE, onFileLoaded);
			
			function onFileLoaded(e:Event):void {
				var object:Object = JSON.decode(e.target.data);
				if (object.status) {
					for (var file:* in object.creations) {
						var filename:String = object.creations[file];
						// can't generate anonymous function here, it will use the same filename for every button
						button_list.push(new Button(filename, generate_callback(filename)));
					}
					for (var button:* in button_list) {
						addChild(button_list[button]);
					}
					draw();
					fade_in();
				}
			}
			var request:URLRequest = new URLRequest(Main.social_home + "get_creations.php");
			request.method = URLRequestMethod.POST;
			request.data = variables;
			file_loader.load(request);
		}
		
		// why is this such a pain in the ass?
		private function generate_callback(_filename:String):Function {
			// create a new variable scope ...
			return function():void {
				trace(_filename);
				Main.load(Main.social_home + _filename, true);
				fade();
			}
		}
		
		private function draw():void {
			this.graphics.clear();
			
			var _y:int = text_field.height + 4;
			for (var button:* in button_list) {
				button_list[button].y = _y;
				_y += button_list[button].height + 8;
			}
			button_close.y = _y;
			
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
		
		private function fade_in():void {
			y = Main.grid - height;
			alpha = 1;
			TweenMan.addTween(this, { y: Main.grid * 2.5, time: Main.animation_duration, ease: "easeInOutQuart" } );
		}
		
		public function die(e:Event = null):void {
			Main.curtain.fade_out();
			Main.master.removeChild(this);
		}
	}
}
