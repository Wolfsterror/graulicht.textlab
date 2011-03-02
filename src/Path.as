package  {
	/**
	 * @author Raphael Pohl
	 */
	public class Path {
		
		public function Path() {
		}
		
		public static function compute(_x1:int, _y1:int, _x2:int, _y2:int):Array {
			var startx:int = Math.round(_x1 / Main.grid) + 1;
			var starty:int = Math.round(_y1 / Main.grid);
			var endx:int = Math.round(_x2 / Main.grid) - 1;
			var endy:int = Math.round(_y2 / Main.grid);
			
			var path:Array = new Array;
			path.push( { x: _x1, y: _y1 } );
			
			// TODO: draw lines around boxes (nice-to-have)
			
			path.push( { x: _x2, y: _y2 } );
			return path;
		}
	}
}