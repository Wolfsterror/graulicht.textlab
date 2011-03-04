package Options {
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;
	
	import com.tweenman.TweenMan;
	
	/**
	 * @author Raphael Pohl
	 */
	public class Checkbox extends MovieClip {
		
		private var label_format:TextFormat;
		private var label_field:TextField;
		
		private var _connector:ProcessorOptions;
		private var _name:String;
		private var _value:String;
		
		private var _bool:Boolean = false;
		
		private var shape:Sprite = new Sprite;
		private var tick:Sprite = new Sprite;
		
		public function Checkbox(connector:ProcessorOptions, name:String, value:String) {
			_connector = connector;
			_value = value;
			_name = name;
			
			label_format = new TextFormat;
			label_format.font = "raffix.simple.upcase";
			label_format.size = 8;
			label_field = new TextField;
			label_field.type = TextFieldType.DYNAMIC;
			label_field.width = _connector.maxwidth - Main.grid + 4;
			label_field.textColor = Theme.back_color;
			label_field.embedFonts = true;
			label_field.selectable = false;
			label_field.multiline = true;
			label_field.wordWrap = true;
			label_field.autoSize = TextFieldAutoSize.LEFT;
			label_field.defaultTextFormat = this.label_format;
			label_field.text = _value;
			
			this.addChild(label_field);
			
			label_field.x = Main.grid - 4;
			label_field.y = 1;
			
			this.addChild(shape);
			this.addChild(tick);
			shape.addEventListener(MouseEvent.CLICK, change);
			shape.buttonMode = true;
			tick.mouseChildren = false;
			tick.mouseEnabled = false;
			
			draw();
		}
		
		public function redraw():void {
			draw();
		}
		
		private function refresh():void {
			TweenMan.removeTweens(tick);
			if (_bool) {
				TweenMan.addTween(tick, { alpha: 1, time: Main.animation_duration, ease: "easeInOutQuart" } );
			} else {
				TweenMan.addTween(tick, { alpha: 0, time: Main.animation_duration, ease: "easeInOutQuart" } );
			}
		}
		
		public function value(_newvalue:Boolean):void {
			_bool = _newvalue;
			refresh();
		}
		
		private function draw():void {
			var margin:int = 3;
			
			shape.graphics.clear();
			shape.graphics.beginFill(Theme.back_color);
			shape.graphics.drawRect(0, margin, Main.grid - 6, Main.grid - 6);
			shape.graphics.endFill();
			shape.graphics.beginFill(Theme.front_color);
			shape.graphics.drawRect(1, 1+margin, Main.grid - 8, Main.grid - 8);
			shape.graphics.endFill();
			
			tick.graphics.clear();
			tick.graphics.beginFill(Theme.main_color);
			tick.graphics.moveTo(0, 5+margin);
			tick.graphics.lineTo(4, 9+margin);
			tick.graphics.lineTo(12, 1+margin);
			tick.graphics.lineTo(10, -1+margin);
			tick.graphics.lineTo(4, 5+margin);
			tick.graphics.lineTo(2, 3+margin);
			tick.graphics.endFill();
			
			// BUG: tick only draws right for Main.grid = 16.
			
			label_field.textColor = Theme.back_color;
			
			refresh();
		}
		
		public function change(e:Event = null):void {
			_bool = !_bool;
			_connector.set_value(_name, _bool, true);
			refresh();
		}
	}
}
