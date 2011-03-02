package  {
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	/**
	 * @author Raphael Pohl
	 */
	public class PreloaderIndicator extends Sprite {
		
		public var progress:Number = 0;
		
		public function PreloaderIndicator() {
			this.addEventListener(Event.ENTER_FRAME, onenterframe_listener);
			draw();
		}
		private function onenterframe_listener(e:Event):void {
			draw();
		}
		private function draw():void {
			this.graphics.clear();
			
			this.graphics.beginFill(Theme.front_color);
			this.graphics.drawRect(0, 0, 64, 8);
			this.graphics.endFill();
			
			this.graphics.beginFill(Theme.main_color);
			this.graphics.drawRect(0, 0, Math.round(64 * progress), 8);
			this.graphics.endFill();
		}
	}
}