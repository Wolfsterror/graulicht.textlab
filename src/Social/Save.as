package Social {
	
	import Dialogs.Message;
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
	
	import com.adobe.serialization.json.JSON;
	import flash.filters.DropShadowFilter;
	import com.tweenman.TweenMan;
	
	/**
	 * @author Raphael Pohl
	 */
	public class Save extends Sprite {
		
		private var field_format:TextFormat;
		private var field_description:TextField;
		private var field_filename:TextField;
		
		private var button_close:Button;
		private var button_save:Button;
		
		public function Save() {
			this.filters = [ new DropShadowFilter(2, 90, 0x000000, 0.3, 6, 6) ];
			
			field_format = new TextFormat();
			field_format.font = "eiszfuchs.simple.regular";
			field_format.size = 16;
			field_format.leftMargin = this.field_format.rightMargin = 2;
			
			field_description = new TextField;
			field_filename = new TextField;
			
			field_description.textColor = field_filename.textColor = Theme.text_color;
			field_description.embedFonts = field_filename.embedFonts = true;
			field_description.selectable = false;
			field_description.type = TextFieldType.DYNAMIC;
			field_filename.selectable = true;
			field_description.defaultTextFormat = field_filename.defaultTextFormat = field_format;
			field_description.autoSize = TextFieldAutoSize.LEFT;
			
			field_description.text = Language.words['save_help'];
			
			field_filename.width = field_description.width;
			field_filename.type = TextFieldType.INPUT;
			field_filename.height = 16;
			field_filename.background = true;
			field_filename.backgroundColor = Theme.back_color;
			
			field_filename.text = "my_creation";
			field_filename.restrict = "0-9a-z\\-_";
			
			this.addChild(field_description);
			this.addChild(field_filename);
			
			button_close = new Button(Language.words['close'], fade);
			this.addChild(button_close);
			
			button_save = new Button(Language.words['save'], save_action);
			button_save.x = button_close.width + 4;
			this.addChild(button_save);
			
			draw();
			Main.curtain.fade_in();
			
			x = Math.round(Main.master.stage.stageWidth / 2 - width / 2);
			y = Main.grid - height;
			
			TweenMan.addTween(this, { y: Main.grid * 2.5, time: Main.animation_duration, ease: "easeInOutQuart" } );
		}
		
		private function draw():void {
			this.graphics.clear();
			
			field_filename.y = field_description.height + 4;
			
			button_save.y = button_close.y = field_filename.y + field_filename.height + 4;
			
			var _width:int = this.width;
			var _height:int = this.height;
			
			this.graphics.beginFill(Theme.back_color);
			this.graphics.drawRect( -Main.grid / 2, -Main.grid / 2, _width + Main.grid, _height + Main.grid);
			this.graphics.endFill();
			this.graphics.beginFill(Theme.front_color);
			this.graphics.drawRect( -Main.grid / 2 + 1, -Main.grid / 2 + 1, _width + Main.grid - 2, _height + Main.grid - 2);
			this.graphics.endFill();
		}
		
		private function save_action(e:Event = null):void {
			var file_loader:URLLoader = new URLLoader();
			file_loader.dataFormat = URLLoaderDataFormat.TEXT;
			var variables:URLVariables = new URLVariables();
			variables.project = Main.project_name;
			variables.nick = Main.userbar.user.name;
			variables.password = Main.userbar.user.pass;
			variables.filename = field_filename.text;
			variables.machine = JSON.encode(Main.export());
			file_loader.addEventListener(Event.COMPLETE, onFileLoaded);
			
			function onFileLoaded(e:Event):void {
				var object:Object = JSON.decode(e.target.data);
				if (object.status) {
					fade();
				} else {
					Main.master.addChild(new Message(Language.words['error_msg'] + "\r" + object.message));
				}
			}
			var request:URLRequest = new URLRequest(Main.social_home + "save_creation.php");
			request.method = URLRequestMethod.POST;
			request.data = variables;
			file_loader.load(request);
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
