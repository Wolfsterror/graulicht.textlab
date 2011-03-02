package {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.utils.getDefinitionByName;
	
	/**
	 * @author Raphael Pohl
	 */
	public class Preloader extends MovieClip {
		
		public var indicator:PreloaderIndicator = new PreloaderIndicator();
		
		private var _alpha:Number = 0;
		private var _callback:Function = null;
		
		public function Preloader() {
			if (stage) {
				stage.scaleMode = StageScaleMode.NO_SCALE;
				stage.align = StageAlign.TOP_LEFT;
			}
			addEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.addEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.addEventListener(IOErrorEvent.IO_ERROR, ioError);

			// ==>> SHOW LOADER <<==
			
			// set theme first
			Theme.theme_default();
			
			this.graphics.clear();
			this.graphics.lineStyle();
			this.graphics.beginFill(Theme.back_color);
			this.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			this.graphics.endFill();
			
			// when resizing the stage, everything should be organized.
			stage.addEventListener(Event.RESIZE, resize_listener);
			resize_listener();
			
			_alpha = 1;
			indicator.alpha = 0;
			addChild(indicator);
			// ENTERFRAME for fadein/-out
			stage.addEventListener(Event.ENTER_FRAME, enterframe_listener);
		}
		
		private function ioError(e:IOErrorEvent):void {
			trace(e.text);
		}
		
		private function progress(e:ProgressEvent):void {
			// ==>> UPDATE LOADER <<==
			indicator.progress = e.bytesLoaded / e.bytesTotal;
		}
		
		private function enterframe_listener(e:Event = null):void {
			var step:Number = 0.05;
			if(indicator.alpha <= _alpha && _alpha == 0) {
				// execute _callback
				_callback();
			} else if (_alpha > 0) {
				// fade in
				indicator.alpha = Math.min(1, indicator.alpha + step);
			} else if(_alpha < 1) {
				// fade out
				indicator.alpha -= step;
			}
		}
		
		private function resize_listener(e:Event = null):void {
			this.graphics.clear();
			this.graphics.lineStyle();
			this.graphics.beginFill(Theme.back_color);
			this.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			this.graphics.endFill();
			
			indicator.x = Math.round((this.stage.stageWidth / 2) - (indicator.width / 2));
			indicator.y = Math.round((this.stage.stageHeight / 2) - (indicator.height / 2));
		}
		
		private function checkFrame(e:Event):void {
			if (currentFrame == totalFrames) {
				stop();
				loadingFinished();
			}
		}
		
		private function loadingFinished():void {
			removeEventListener(Event.ENTER_FRAME, checkFrame);
			loaderInfo.removeEventListener(ProgressEvent.PROGRESS, progress);
			loaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, ioError);
			
			// ==>> HIDE LOADER <<==
			
			_alpha = 0;
			_callback = function():void {
				removeChild(indicator);
				stage.removeEventListener(Event.ENTER_FRAME, enterframe_listener);
				startup();
			}
		}
		
		private function startup():void {
			var mainClass:Class = getDefinitionByName("Main") as Class;
			addChild(new mainClass() as DisplayObject);
		}
	}
}
