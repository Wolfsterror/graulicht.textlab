package Dialogs {
	
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import com.tweenman.TweenMan;

	/**
	 * @author Raphael Pohl
	 */
	public class Curtain extends Sprite {
		
		private var hidden:Boolean = false;
		
		public function Curtain() {
			x = y = 0;
			draw();
			
			this.buttonMode = false;
			this.addEventListener(MouseEvent.MOUSE_DOWN, resize);
			
			fade_out();
		}
		
		public function redraw():void {
			draw();
		}
		
		private function draw():void {
			this.graphics.clear();
			this.graphics.lineStyle();
			this.graphics.beginFill(Theme.front_color);
			this.graphics.drawRect(0, 0, 1, 1);
			this.graphics.endFill();
		}
		
		public function fade_out():void {
			TweenMan.removeTweens(this);
			TweenMan.addTween(this, { alpha: 0, time: Main.animation_duration, onComplete: function():void { hide(); }  } );
		}
		public function fade_in():void {
			hidden = false;
			resize();
			
			Main.master.bring_front(this);
			
			TweenMan.removeTweens(this);
			TweenMan.addTween(this, { alpha: 0.7, time: Main.animation_duration } );
		}
		
		private function hide():void {
			hidden = true;
			width = 0;
			height = 0;
		}
		
		public function resize(e:Event = null):void {
			if(!hidden) {
				width = Main.master.stage.stageWidth;
				height = Main.master.stage.stageHeight;
			}
		}
	}
}