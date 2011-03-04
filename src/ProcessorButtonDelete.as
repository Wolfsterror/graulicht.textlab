package  {
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Shape;
	
	import com.tweenman.TweenMan;

	/**
	 * @author Raphael Pohl
	 */
	public class ProcessorButtonDelete extends MovieClip {
		
		private var _controller:Processor;
		
		private var shape_hover:Shape = new Shape;
		private var shape_cross:Shape = new Shape;
		
		public function ProcessorButtonDelete(controller:Processor) {
			_controller = controller;
			
			build();
			draw();
		}
		
		public function redraw():void {
			draw();
		}
		
		private function build():void {
			this.addChild(shape_hover);
			this.addChild(shape_cross);
			
			this.addEventListener(MouseEvent.MOUSE_OVER, mouseover_listener);
			this.addEventListener(MouseEvent.MOUSE_OUT, mouseout_listener);
			
			this.addEventListener(MouseEvent.CLICK, mouseclick_listener);
		}
		
		private function draw():void {
			// draw basic shape
			this.graphics.clear();
			this.graphics.beginFill(Theme.front_color);
			this.graphics.drawRect(0, 0, Main.grid-1, Main.grid-1);
			this.graphics.endFill();
			
			shape_hover.graphics.clear();
			shape_hover.graphics.beginFill(Theme.hover_color);
			shape_hover.graphics.drawRect(0, 0, Main.grid-1, Main.grid-1);
			shape_hover.graphics.endFill();
			shape_hover.alpha = 0;
			
			draw_cross(4, 4, 7);
		}
		private function draw_cross(_x:int, _y:int, _size:int):void {
			var i:int;
			shape_cross.graphics.clear();
			shape_cross.graphics.beginFill(Theme.back_color);
			for (i = 0; i < _size; i++) {
				shape_cross.graphics.drawRect(_x+i, _y+i, 1, 1);
				if(i != Math.ceil(_size/2)-1)
					shape_cross.graphics.drawRect(_x+i, _y+_size-i-1, 1, 1);
			}
			shape_cross.graphics.endFill();
		}
		
		private function mouseclick_listener(e:Event):void {
			if (_controller.selected) {
				// delete all selected processors
				var walkers:Array = Main.get_selected();
				var i:int;
				
				for (i = 0; i < walkers.length; i++) {
					Main.master.addChild(new Afterlife(walkers[i]));
				}
			} else {
				Main.master.addChild(new Afterlife(_controller));
			}
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
	}
}