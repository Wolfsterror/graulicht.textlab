package Options {
	
	import flash.display.MovieClip;
	
	/**
	 * @author Raphael Pohl
	 */
	public class Seperator extends MovieClip {
		
		public var gutter:int = 4;
		private var connector:ProcessorOptions;
		
		public function Seperator(_connector:ProcessorOptions) {
			connector = _connector;
			draw();
		}
		
		private function draw():void {
			this.graphics.clear();
			
			this.graphics.beginFill(Theme.front_color);
			this.graphics.drawRect(0, 0, connector.maxwidth, gutter);
			this.graphics.endFill();
			
			this.graphics.beginFill(Theme.main_color);
			this.graphics.drawRect(0, gutter, connector.maxwidth, 1);
			this.graphics.endFill();
			
			this.graphics.beginFill(Theme.front_color);
			this.graphics.drawRect(0, gutter+1, connector.maxwidth, gutter);
			this.graphics.endFill();
		}
		
		public function redraw():void {
			draw();
		}
	}
}
