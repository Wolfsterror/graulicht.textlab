package  {
	
	import flash.display.Shape;
	import flash.display.Sprite;
	
	import flash.events.MouseEvent;
	import flash.events.Event;
	
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;
	
	import flash.filters.DropShadowFilter;
	
	import com.tweenman.TweenMan;
	
	/**
	 * @author Raphael Pohl
	 */
	public class Input extends Sprite {
		
		public  var _connection:Connection;
		private var _label:String = Language.words['in'];
		private var _description:String = "generischer Eingang";
		public  var _type:String;
		
		public  var _id:int;
		
		public  var changed:Boolean = true;
		public  var error:Boolean = false;
		
		public  var _controller:Processor;
		private var shape:Sprite = new Sprite;
		private var error_shape:Shape = new Shape;
		
		private var label_format:TextFormat;
		private var label_field:TextField;
		
		public function Input(controller:Processor, id:int, label:String = "") {
			_controller = controller;
			_connection = null;
			_id = id;
			if (label == "") {
				label = Language.words['in'];
			}
			_label = label;
			
			if (!_type) _type = 'string';
			
			label_format = new TextFormat;
			label_format.font = "raffix.simple.upcase";
			label_format.size = 8;
			label_field = new TextField;
			label_field.type = TextFieldType.DYNAMIC;
			label_field.textColor = Theme.front_color;
			label_field.embedFonts = true;
			label_field.mouseEnabled = false;
			label_field.selectable = false;
			label_field.autoSize = TextFieldAutoSize.RIGHT;
			label_field.defaultTextFormat = this.label_format;
			label_field.text = _label;
			
			draw();
			
			this.addChild(shape);
			this.addChild(error_shape);
			
			if(_label != "" && _label != " ") {
				this.addChild(label_field);
			}
			
			shape.addEventListener(MouseEvent.CLICK, mouseclick_listener);
			shape.buttonMode = true;
			
			this.mouseEnabled = false; // work-around for click-through on I/O-labels
			
			align();
		}
		
		public function align():void {
			x = 0;
			y = (_id + 1) * Main.grid;
			label_field.x = -label_field.width - 1;
		}
		
		public function redraw():void {
			draw();
		}
		
		private function draw():void {
			shape.graphics.clear();
			switch(_type) {
				case 'list':
					shape.graphics.beginFill(Theme.node_colors['list']);
					break;
				case 'string':
				default:
					shape.graphics.beginFill(Theme.node_colors['string']);
			}
			shape.graphics.drawCircle((Main.grid-1) / 2, (Main.grid-1) / 2, 5);
			shape.graphics.endFill();
			
			var size:int = 9;
			
			error_shape.graphics.clear();
			error_shape.graphics.beginFill(Theme.highlight_color);
			error_shape.graphics.moveTo( 0, 2);
			error_shape.graphics.lineTo( 2, 0);
			error_shape.graphics.lineTo( size, size-2);
			error_shape.graphics.lineTo( size-2, size);
			error_shape.graphics.endFill();
			
			error_shape.graphics.beginFill(Theme.highlight_color);
			error_shape.graphics.moveTo( size-2, 0);
			error_shape.graphics.lineTo( size, 2);
			error_shape.graphics.lineTo( 2, size);
			error_shape.graphics.lineTo( 0, size-2);
			error_shape.graphics.endFill();
			
			error_shape.alpha = 0;
			error_shape.x = error_shape.y = 3;
			
			label_field.filters = [
				new DropShadowFilter(1,   0, Theme.back_color, 0.85, 0, 0),
				new DropShadowFilter(1,  90, Theme.back_color, 0.85, 0, 0),
				new DropShadowFilter(1, 180, Theme.back_color, 0.85, 0, 0),
				new DropShadowFilter(1, 270, Theme.back_color, 0.85, 0, 0)
			];
			
			// text field colors
			label_field.textColor = Theme.front_color;
			
			refresh();
		}
		
		private function mouseclick_listener(e:Event):void {
			kill_connection();
		}
		
		public function set_error(_error:Boolean = false):void {
			error = _error;
			refresh();
		}
		
		private function refresh():void {
			TweenMan.removeTweens(error_shape);
			if (error) {
				TweenMan.addTween(error_shape, { alpha: 1, time: Main.animation_duration } );
			} else {
				TweenMan.addTween(error_shape, { alpha: 0, time: Main.animation_duration } );
			}
		}
		
		public function kill_value():void {
		}
		
		public function kill_connection(self_only:Boolean = false):void {
			if(_connection != null) {
				var index:int;
				
				index = Main.connections.indexOf(_connection);
				if (index >= 0) {
					Main.connections.splice(index, 1);
				}
				
				if(!self_only) {
					index = _connection.sender._connections.indexOf(_connection);
					if (index >= 0) {
						_connection.sender._connections.splice(index, 1);
					}
				}
				
				_connection = null;
				kill_value();
				_controller.draw_connections();
				
				Main.fire();
			}
		}
	}
}
