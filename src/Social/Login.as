package Social {
	
	import Dialogs.Message;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.net.URLRequestMethod;
	import flash.net.URLLoaderDataFormat;
	
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;
	
	import flash.filters.DropShadowFilter;
	import com.adobe.crypto.MD5;
	import com.adobe.serialization.json.JSON;
	import com.tweenman.TweenMan;
	
	/**
	 * @author Raphael Pohl
	 */
	public class Login extends Sprite {
		
		private var field_format:TextFormat;
		private var field_description:TextField;
		private var field_name:TextField;
		private var field_password:TextField;
		
		private var button_close:Button;
		private var button_register:Button;
		
		private var objects:Array = new Array;
		
		public function Login() {
			this.filters = [ new DropShadowFilter(2, 90, 0x000000, 0.3, 6, 6) ];
			
			field_format = new TextFormat();
			field_format.font = "eiszfuchs.simple.regular";
			field_format.size = 16;
			field_format.leftMargin = this.field_format.rightMargin = 2;
			
			field_description = new TextField;
			field_name = new TextField;
			field_password = new TextField;
			
			field_description.textColor = field_name.textColor = field_password.textColor = Theme.text_color;
			field_description.embedFonts = field_name.embedFonts = field_password.embedFonts = true;
			field_description.selectable = false;
			field_description.type = TextFieldType.DYNAMIC;
			field_name.selectable = field_password.selectable = true;
			field_description.defaultTextFormat = field_name.defaultTextFormat = field_password.defaultTextFormat = field_format;
			field_description.autoSize = TextFieldAutoSize.LEFT;
			
			field_description.text = "Du musst Dich registrieren, um die Online-Inhalte nutzen zu können.\rUm Dich zu registrieren, gib' einfach Deinen Namen, Deine E-Mail-Adresse und ein Passwort an.\rFertig!";
			
			field_name.width = field_password.width = field_description.width;
			field_name.type = field_password.type = TextFieldType.INPUT;
			field_name.height = field_password.height = 16;
			field_name.background = field_password.background = true;
			field_name.backgroundColor = field_password.backgroundColor = Theme.back_color;
			
			field_password.displayAsPassword = true;
			
			field_name.text = "Nick";
			field_password.text = "1234";
			
			this.addChild(field_description);
			this.addChild(field_name);
			this.addChild(field_password);
			
			// FIXME: It has problems with tab order.
			
			button_close = new Button(Language.words['close'], fade);
			this.addChild(button_close);
			
			button_register = new Button(Language.words['login'], login_action);
			button_register.x = button_close.width + 4;
			this.addChild(button_register);
			
			objects.push(field_description);
			objects.push(field_name);
			objects.push(field_password);
			objects.push(button_close);
			
			draw();
			Main.curtain.fade_in();
			
			x = Math.round(Main.master.stage.stageWidth / 2 - width / 2);
			y = Main.grid - height;
			
			TweenMan.addTween(this, { y: Main.grid * 2.5, time: Main.animation_duration, ease: "easeInOutQuart" } );
		}
		
		private function draw():void {
			this.graphics.clear();
			
			var r_y:int = 0;
			for (var i:* in objects) {
				objects[i].y = r_y;
				r_y += objects[i].height + Main.grid / 2;
			}
			
			button_register.y = button_close.y;
			
			var _width:int = this.width;
			var _height:int = this.height;
			
			this.graphics.beginFill(Theme.back_color);
			this.graphics.drawRect( -Main.grid / 2, -Main.grid / 2, _width + Main.grid, _height + Main.grid);
			this.graphics.endFill();
			this.graphics.beginFill(Theme.front_color);
			this.graphics.drawRect( -Main.grid / 2 + 1, -Main.grid / 2 + 1, _width + Main.grid - 2, _height + Main.grid - 2);
			this.graphics.endFill();
		}
		
		private function login_action(e:Event = null):void {
			var register_loader:URLLoader = new URLLoader();
			register_loader.dataFormat = URLLoaderDataFormat.TEXT;
			
			var variables:URLVariables = new URLVariables();
			variables.project = Main.project_name;
			variables.nick = field_name.text;
			variables.password = MD5.hash(field_password.text);
			
			register_loader.addEventListener(Event.COMPLETE, onRegistrationLoaded);
			
			function onRegistrationLoaded(e:Event):void {
				var object:Object = JSON.decode(e.target.data);
				if (object.status) {
					Main.userbar.user = new User(object.user.name, object.user.email, object.user.pass);
					Main.userbar.redraw()
					Main.userbar.clear_buttons();
					fade(); 
				} else {
					Main.master.addChild(new Message("Benutzername oder Kennwort falsch."));
				}
			}
			var request:URLRequest = new URLRequest(Main.social_home + "check_user.php");
			request.method = URLRequestMethod.POST;
			request.data = variables;
			register_loader.load(request);
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
