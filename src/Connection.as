package  {
	import flash.geom.Point;

	/**
	 * @author Raphael Pohl
	 */
	public class Connection {
		
		public var sender:Output;
		public var receiver:Input;
		
		public function Connection(_sender:Output = null, _receiver:Input = null) {
			sender = _sender;
			receiver = _receiver;
			
			Main.connections.push(this);
		}
		
		public function draw():void {
			var startpos:Point = sender.localToGlobal(new Point);
			var endpos:Point = receiver.localToGlobal(new Point);
			
			switch(sender._type) {
				case 'list':
					Main.draw_connections.graphics.lineStyle(3, Theme.node_colors['list'], 1, true);
					break;
				case 'string':
				default:
					Main.draw_connections.graphics.lineStyle(3, Theme.node_colors['string'], 1, true);
			}
			
			var path:Array = Path.compute(startpos.x, startpos.y, endpos.x, endpos.y);
			Main.draw_connections.graphics.moveTo(path[0].x + 7, path[0].y + 7);
			
			var i:int;
			for (i = 1; i < path.length; i++) {
				Main.draw_connections.graphics.lineTo(path[i].x + 7, path[i].y + 7);
			}
		}
	}
}