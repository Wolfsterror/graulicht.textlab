package  {

	import flash.display.MovieClip;
	import flash.display.Shader;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;

	import flash.geom.Point;
	import flash.display.Shape;
	
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;

	import flash.text.TextFormat;
	import flash.text.AntiAliasType;

	import com.tweenman.TweenMan;

	/**
	 * @author Raphael Pohl
	 */
	public class ProcessorTitlebar extends MovieClip {
		
		private var _width:int;
		private var _height:int;
		private var _text:String;
		private var _controller:Processor;
		
		private var _dragstart:Point = new Point;
		
		private var textfield_format:TextFormat;
		private var textfield_title:TextField;
		
		private var shape:Shape = new Shape;
		private var shape_hover:Shape = new Shape;
		
		public function ProcessorTitlebar(width:int, height:int, text:String, controller:Processor) {
			_width = width;
			_height = height;
			_text = text;
			_controller = controller;
			
			this.addChild(shape);
			this.addChild(shape_hover);
			shape_hover.alpha = 0;
			
			// init title
			this.textfield_format = new TextFormat();
			this.textfield_format.font = "raffix.simple.upcase";
			this.textfield_format.size = 8;
			this.textfield_title = new TextField;
			this.textfield_title.textColor = Theme.main_color;
			this.textfield_title.embedFonts = true;
			this.textfield_title.selectable = false;
			this.textfield_title.autoSize = TextFieldAutoSize.LEFT;
			this.textfield_title.defaultTextFormat = this.textfield_format;
			this.textfield_title.text = _text;
			this.addChild(this.textfield_title);
			textfield_title.x = 4;
			textfield_title.y = 0;
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, mousedown_listener);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseup_listener);
			
			draw();
			
			add_hover_effects();
		}
		
		private function draw():void {
			shape.graphics.clear();
			shape.graphics.beginFill(Theme.front_color);
			shape.graphics.drawRect(0, 0, _width, _height);
			shape.graphics.endFill();
			
			shape_hover.graphics.clear();
			shape_hover.graphics.beginFill(Theme.hover_color);
			shape_hover.graphics.drawRect(0, 0, _width, _height);
			shape_hover.graphics.endFill();
			
			this.textfield_title.textColor = Theme.main_color;
		}
		
		public function redraw():void {
			draw();
		}
		
		private function add_hover_effects():void {
			// hover effects
			this.addEventListener(MouseEvent.MOUSE_OVER, mouseover_listener);
			this.addEventListener(MouseEvent.MOUSE_OUT, mouseout_listener);
		}
		private function remove_hover_effects():void {
			// hover effects
			this.removeEventListener(MouseEvent.MOUSE_OVER, mouseover_listener);
			this.removeEventListener(MouseEvent.MOUSE_OUT, mouseout_listener);
		}
		
		private function mouseover_listener(e:Event):void {
			hover_fade_in();
		}
		private function mouseout_listener(e:Event):void {
			hover_fade_out();
		}
		
		private function hover_fade_in():void {
			TweenMan.removeTweens(shape_hover);
			TweenMan.addTween(shape_hover, { alpha: 1, time: Main.animation_duration * 2 } );
		}
		private function hover_fade_out():void {
			TweenMan.removeTweens(shape_hover);
			TweenMan.addTween(shape_hover, { alpha: 0, time: Main.animation_duration * 2 } );
		}
		
		private function mousedown_listener(e:Event):void {
			Main.master.bring_front(_controller);
			
			// release outside listener
			this.parent.stage.addEventListener(MouseEvent.MOUSE_UP, mouseup_listener);
			
			remove_hover_effects();
			hover_fade_in();
			
			_dragstart = new Point(this.mouseX, this.mouseY);
			this.addEventListener(Event.ENTER_FRAME, onenterframe_listener);
		}
		private function mouseup_listener(e:Event):void {
			// delete release outside listener
			this.parent.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseup_listener);
			
			add_hover_effects();
			
			this.removeEventListener(Event.ENTER_FRAME, onenterframe_listener);
			
			if (_controller.selected) {
				var walkers:Array = Main.get_selected();
				var i:int;
				
				for (i = 0; i < walkers.length; i++) {
					walkers[i].align();
				}
			} else {
				_controller.align();
			}
		}
		private function onenterframe_listener(e:Event):void {
			if (_controller.selected) {
				var walkers:Array = Main.get_selected();
				var i:int;
				
				for (i = 0; i < walkers.length; i++) {
					if (walkers[i] != _controller) {
						walkers[i].x += _controller.mouseX - _dragstart.x;
						walkers[i].y += _controller.mouseY - _dragstart.y;
					}
				}
			}
			_controller.x += _controller.mouseX - _dragstart.x;
			_controller.y += _controller.mouseY - _dragstart.y;
			
			_controller.draw_connections();
		}
	}
}