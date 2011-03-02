package  {
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import flash.display.BitmapData;
	import flash.display.Bitmap;
	
	import com.tweenman.TweenMan;
	
	/**
	 * Every processor has an Afterlife when deleted.
	 * It shows an addicting animation in which the processor is ripped in two.
	 * 
	 * @author Raphael Pohl
	 */
	public class Afterlife extends MovieClip {
		
		// at the risk of messing odd and even up again ...
		public var half_first:Bitmap;	// odd stripes
		public var half_second:Bitmap;	// even stripes
		
		public function Afterlife(_controller:Processor) {
			// TODO: Nice to have - first fold it like a piece of paper, then rip it.
			//       something like http://www.flasheff.com/patternsshowcase/?pattern=FESUnpack
			
			x = _controller.x;
			y = _controller.y;
			
			// HERE COMES THE FIRE - THE CLEANSING FIRE
			var temp:BitmapData;
			
			// draw the processor
			temp = new BitmapData(_controller._width*Main.grid-1, _controller._height*Main.grid-1);
			half_first = new Bitmap(temp);
			temp = new BitmapData(_controller._width*Main.grid-1, _controller._height*Main.grid-1);
			half_second = new Bitmap(temp);
			half_first.bitmapData.draw(_controller);
			half_second.bitmapData.draw(_controller);
			
			// NOW THAT ALL THE DAMAGE IS DONE
			
			// kill controller
			_controller.kill();
			Main.master.removeChild(_controller);
			
			// YOUR WRETCHED SOUL IS ON THE RUN
			var _x:int;
			var _y:int;
			var rip:int = Math.floor(Main.grid / 2); // a stripe's width
			for (_y = 0; _y < _controller.height; _y++) {
				for (_x = 0; _x < _controller.width; _x++) {
					// remove pixels as you run through the stripes
					if((Math.floor((_x - _y) / rip) % rip) % 2 == 0) {
						half_first.bitmapData.setPixel32(_x, _y, 0x00ffffff);
					} else {
						half_second.bitmapData.setPixel32(_x, _y, 0x00ffffff);
					}
					// RIDDLED WITH GUILT YOU WANNA COME UNDONE
				}
			}
			
			this.addChild(half_first);
			this.addChild(half_second);
			
			// LET IT IN LET THE MOURNING COME
			TweenMan.addTween(half_first, { x: -Main.grid/3*2, y: -Main.grid/3*2, time: Main.animation_duration, ease: "easeInOutQuart" } );
			TweenMan.addTween(half_second, { x: Main.grid/3*2, y: Main.grid/3*2, time: Main.animation_duration, ease: "easeInOutQuart", onComplete: function():void {
				TweenMan.addTween(half_first, { alpha: 0, time: Main.animation_duration, ease: "easeInOutQuart" } );
				TweenMan.addTween(half_second, { alpha: 0, time: Main.animation_duration, ease: "easeInOutQuart", onComplete: function():void {
					// finally you can...
					die();
				} } );
			} } );
			
		}
		
		/**
		 * Removes the child from stage
		 */
		public function die():void {
			// FEEL THE HEAT
			Main.master.removeChild(this);
		}
	}
}

// www.emilbulls.de
