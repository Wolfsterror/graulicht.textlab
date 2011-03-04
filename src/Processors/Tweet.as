package Processors {
	
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.events.Event;
	import com.adobe.serialization.json.JSON;
	
	/**
	 * @author Raphael Pohl
	 */
	public class Tweet extends Processor {
		
		public function Tweet() {
			input_count = 0;
			output_count = 1;
			
			output_labels = [Language.words['tweet']];
			
			_options = [ { name: "refresh", label: Language.words['refresh'], type: "button", action: function():void {
				var tweet_loader:URLLoader = new URLLoader();
				tweet_loader.addEventListener(Event.COMPLETE, function(e:Event):void {
					var object:Object = JSON.decode(e.target.data);
					_value = _preview + object[0].text;
					
					_value = _value.replace("&lt;", "<");
					_value = _value.replace("&gt;", ">");
					_value = _value.replace("&quot;", '"');
					_value = _value.replace("&apos;", "\'");
					
					Main.fire();
					options.set_value("loading", false);
				});
				tweet_loader.load(new URLRequest("http://eisfuchslabor.de/graulicht/proxy.php?url=http://api.twitter.com/1/statuses/user_timeline/eiszfuchs.json?include_rts=true%26count=1"));
				options.set_value("loading", true);
			}}, { name: "loading", label: Language.words['is_loading'], type: "lamp" } ];
			
			_width = 6;
			_name = Language.words['tweet_quote'];
			_preview = "@eiszfuchs: ";
			
			initialize();
		}
		
		public var _value:String = "";
		
		override public function process():void {
			this.set_output(0, _value);
		}
	}
}
