package  {
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;
	
	import flash.filters.DropShadowFilter;
	
	/**
	 * @author Raphael Pohl
	 */
	public class Output extends Sprite {
		
		public  var _connections:Array = new Array;
		private var _value:String = new String;
		private var _label:String = Language.words['out'];
		private var _description:String = "generischer Ausgang";
		
		public var _id:int;
		
		public  var _controller:Processor;
		private var shape:Sprite = new Sprite;
		
		private var label_format:TextFormat;
		private var label_field:TextField;
		
		public function Output(controller:Processor, id:int, label:String = "") {
			_controller = controller;
			_id = id;
			if (label == "") {
				label = Language.words['out'];
			}
			_label = label;
			
			label_format = new TextFormat;
			label_format.font = "raffix.simple.upcase";
			label_format.size = 8;
			label_field = new TextField;
			label_field.type = TextFieldType.DYNAMIC;
			label_field.textColor = Theme.front_color;
			label_field.embedFonts = true;
			label_field.mouseEnabled = false;
			label_field.selectable = false;
			label_field.autoSize = TextFieldAutoSize.LEFT;
			label_field.defaultTextFormat = this.label_format;
			label_field.text = _label;
			
			draw();
			this.addChild(shape);
			
			if(_label != "" && _label != " ") {
				this.addChild(label_field);
			}
			
			shape.addEventListener(MouseEvent.MOUSE_DOWN, mousedown_listener);
			shape.addEventListener(MouseEvent.MOUSE_UP, mouseup_listener);
			shape.buttonMode = true;
			
			this.mouseEnabled = false; // work-around for click-through on I/O-labels
			
			align();
		}
		
		public function value(_newvalue:String = null):String {
			var i:int;
			if (_newvalue != null) {
				_value = _newvalue;
				for (i = 0; i < _connections.length; i++) {
					var input:Input;
					input = _connections[i].receiver;
					input.value(_value);
				}
			}
			return _value;
		}
		
		public function align():void {
			x = (_controller._width - 1) * Main.grid;
			y = (_id + 1) * Main.grid;
			label_field.x = Main.grid + 1;
		}
		
		public function redraw():void {
			draw();
		}
		
		public function draw():void {
			shape.graphics.clear();
			shape.graphics.beginFill(Theme.main_color);
			shape.graphics.drawCircle((Main.grid-1) / 2, (Main.grid-1) / 2, 5);
			shape.graphics.endFill();
			
			label_field.filters = [
				new DropShadowFilter(1,   0, Theme.back_color, 0.85, 0, 0),
				new DropShadowFilter(1,  90, Theme.back_color, 0.85, 0, 0),
				new DropShadowFilter(1, 180, Theme.back_color, 0.85, 0, 0),
				new DropShadowFilter(1, 270, Theme.back_color, 0.85, 0, 0)
			];
			
			label_field.textColor = Theme.front_color;
		}
		
		private function mousedown_listener(e:Event):void {
			// release outside listener
			this.parent.stage.addEventListener(MouseEvent.MOUSE_UP, mouseup_listener);
			
			this.addEventListener(Event.ENTER_FRAME, onenterframe_listener);
		}
		private function onenterframe_listener(e:Event):void {
			_controller.draw_connections();
			var pos:Point;
			pos = this.localToGlobal(new Point);
			Main.draw_connections.graphics.lineStyle(3, Theme.hover_color, 1, true);
			Main.draw_connections.graphics.moveTo(pos.x + 7, pos.y + 7);
			Main.draw_connections.graphics.lineTo(Main.master.mouseX, Main.master.mouseY);
		}
		private function mouseup_listener(e:Event):void {
			// delete release outside listener
			this.parent.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseup_listener);
			
			this.removeEventListener(Event.ENTER_FRAME, onenterframe_listener);
			
			if (e.target.parent != this) {
				var input:Input = e.target.parent as Input;
				if(input != null) {
					if (input._connection == null) {
						// no connection on input yet
						input._connection = new Connection(this, input);
						_connections.push(input._connection);
					} else {
						// already connected, change
						input.kill_connection();
						input._connection = new Connection(this, input);
						_connections.push(input._connection);
					}
					Main.fire();
				}
			}
			_controller.draw_connections();
		}
		
		public function kill_connections():void {
			var i:int;
			for (i = 0; i < _connections.length; i++) {
				var index:int = Main.connections.indexOf(_connections[i]);
				if (index >= 0) {
					Main.connections.splice(index, 1);
				}
				_connections[i].receiver.kill_connection(true);
			}
			_controller.draw_connections();
		}
	}
}