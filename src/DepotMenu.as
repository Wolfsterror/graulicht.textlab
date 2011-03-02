package  {
	
	import flash.display.MovieClip;
	
	/**
	 * @author Raphael Pohl
	 */
	public class DepotMenu extends MovieClip {
		
		private var buttons:Array = new Array;
		
		public function DepotMenu(classes:Array) {
			var button:DepotButton;
			
			var i:int;
			for (i = 0; i < classes.length; i++) {
				button = new DepotButton(classes[i]);
				buttons.push(button);
				addChild(button);
			}
			rearrange();
		}
		
		public function redraw():void {
			var i:int;
			for (i = 0; i < buttons.length; i++) {
				buttons[i].redraw();
			}
		}
		
		private function rearrange():void {
			var i:int;
			var _x:int = 4;
			
			for (i = 0; i < buttons.length; i++) {
				buttons[i].x = _x;
				_x += buttons[i].width + 4;
				buttons[i].y = 4;
			}
		}
	}
}
