package  {
	import flash.display.Sprite;
	import flash.display.Shape;
	import flash.events.Event;
	import flash.filters.DropShadowFilter;
	
	import com.tweenman.TweenMan;
	import com.adobe.crypto.MD5;
	
	import flash.display.BlendMode;
	
	/**
	 * @author Raphael Pohl
	 */
	public class Processor extends Sprite {
		
		public var  inputs:Array = [];
		public var outputs:Array = [];
		
		public var  input_labels:Array = [];
		public var output_labels:Array = [];
		
		public var  input_count:int = 0;
		public var output_count:int = 0;
		
		public var _width:int = 6;
		public var _height:int = 2;
		
		public var _options:Array = [];
		public var options:ProcessorOptions;
		
		public var bodyshape:Shape = new Shape;
		public var selected:Boolean = false;
		public var selection:Shape = new Shape;
		
		public var _name:String = "Generic";
		public var _preview:String = "ABC";
		
		public var _identifier:String;
		
		public function Processor() {
			// you can have UI Fun here
			this.blendMode = BlendMode.NORMAL;
			this.filters = [ new DropShadowFilter(2, 90, 0x000000, 0.3, 6, 6) ];
			
			Main.puppets.push(this);
			
			_identifier = ((this.toString()).substring(8)).replace(']', '')
			_identifier += Main.counter++;
			_identifier = MD5.hash(_identifier);
			
			this.alpha = 0;
			TweenMan.addTween(this, { alpha: 1, time: Main.animation_duration, ease: "easeInOutQuart" } );
			
			this.mouseEnabled = false; // work-around for click-through on I/O-labels
		}
		
		public function process():void {
		}
		
		public function initialize():void {
			this.build();
			
			// draw window
			draw();
		}
		
		private var buttondelete:ProcessorButtonDelete;
		private var titlebar:ProcessorTitlebar;
		
		public function redraw():void {
			draw();
			buttondelete.redraw();
			titlebar.redraw();
			
			var i:int;
			for (i = 0; i < input_count; i++) {
				inputs[i].redraw();
			}
			for (i = 0; i < output_count; i++) {
				outputs[i].redraw();
			}
			
			options.redraw();
		}
		
		public function build():void {
			selection.alpha = 0;
			addChild(selection);
			addChild(bodyshape);
			
			var i:int;
			
			// initialize inputs
			inputs = new Array;
			for (i = 0; i < input_count; i++) {
				if(input_labels[i]) {
					inputs[i] = new ProcessorInput(this, i, input_labels[i]);
				} else {
					inputs[i] = new ProcessorInput(this, i);
				}
				addChild(inputs[i]);
			}
			
			// initialize outputs
			outputs = new Array;
			for (i = 0; i < output_count; i++) {
				if(output_labels[i]) {
					outputs[i] = new ProcessorOutput(this, i, output_labels[i]);
				} else {
					outputs[i] = new ProcessorOutput(this, i);
				}
				addChild(outputs[i]);
			}
			
			// title bar
			titlebar = new ProcessorTitlebar(Main.grid * (_width - 1) - 1, Main.grid - 1, _name, this);
			addChild(titlebar);
			
			// delete button
			buttondelete = new ProcessorButtonDelete(this);
			buttondelete.x = Main.grid * (_width-1);
			addChild(buttondelete);
			
			options = new ProcessorOptions(_options, this);
			addChild(options);
		}
		
		public function draw():void {
			this.graphics.clear();
			bodyshape.graphics.clear();
			selection.graphics.clear();
			
			// draw background shape
			this.graphics.beginFill(Theme.back_color);
			this.graphics.drawRect(-1, -1, Main.grid*_width+1, Main.grid*_height+1);
			this.graphics.endFill();
			selection.graphics.beginFill(Theme.highlight_color);
			selection.graphics.drawRect(-1, -1, Main.grid*_width+1, Main.grid*_height+1);
			selection.graphics.endFill();
			
			// draw window shape
			bodyshape.graphics.beginFill(Theme.front_color);
			var startx:int = input_count > 0?Main.grid:0;
			var starty:int = Main.grid;
			var windoww:int = Main.grid * (_width - (output_count > 0?1:0)) - 1 - startx;
			var windowh:int = Main.grid * (_height - 1) - 1;
			bodyshape.graphics.drawRect(startx, starty, windoww, windowh);
			bodyshape.graphics.endFill();
			
			if (input_count > 0) {
				// draw input background shape
				bodyshape.graphics.beginFill(Theme.front_color);
				bodyshape.graphics.drawRect(0, Main.grid, Main.grid - 1, Main.grid * (_height - 1) - 1);
				bodyshape.graphics.endFill();
			}
			if (output_count > 0) {
				// draw output background shape
				bodyshape.graphics.beginFill(Theme.front_color);
				bodyshape.graphics.drawRect(Main.grid * (_width - 1), Main.grid, Main.grid - 1, Main.grid * (_height - 1) - 1);
				bodyshape.graphics.endFill();
			}
		}
		
		public function align():void {
			var cx:int; 
			var cy:int;
			
			cx = this.x;
			cy = this.y;
			
			cx = Math.max(cx, Main.grid); // clipped < 0
			cy = Math.max(cy, Main.grid * 7); // clipped < 0
			
			cx = Math.min(cx, Main.master.stage.stageWidth - (_width + 1) * Main.grid); // clipped > 0
			cy = Math.min(cy, Main.master.stage.stageHeight - (_height + 1) * Main.grid); // clipped > 0
			
			var _x:int = Math.round(cx / Main.grid) * Main.grid;
			var _y:int = Math.round(cy / Main.grid) * Main.grid;
			
			TweenMan.removeTweens(this);
			TweenMan.addTween(this, { x: _x, y: _y, time: Main.animation_duration, ease: "easeInOutQuart", onUpdate: function ():void { draw_connections(); } } );
			if (alpha < 1) {
				TweenMan.addTween(this, { alpha: 1, time: Main.animation_duration, ease: "easeInOutQuart" } );
			}
		}
		
		public function draw_connections():void {
			var i:int;
			Main.draw_connections.graphics.clear();
			for (i = 0; i < Main.connections.length; i++) {
				Main.connections[i].draw();
			}
		}
		
		public function set_output(_output:int, _value:String):void {
			outputs[_output].value(_value);
		}
		
		public function select():void {
			selected = true;
			TweenMan.removeTweens(selection);
			TweenMan.addTween(selection, { alpha: 1, time: Main.animation_duration } );
		}
		public function deselect():void {
			selected = false;
			TweenMan.removeTweens(selection);
			TweenMan.addTween(selection, { alpha: 0, time: Main.animation_duration } );
		}
		
		public function kill():void {
			var i:int;
			
			for (i = 0; i < input_count; i++) {
				inputs[i].kill_connection();
			}
			for (i = 0; i < output_count; i++) {
				outputs[i].kill_connections();
			}
			
			var index:int = Main.puppets.indexOf(this);
			if (index >= 0) {
				Main.puppets.splice(index, 1);
			}
		}
	}
}
