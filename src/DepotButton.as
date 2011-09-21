package  {

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;

	import flash.geom.Point;
	import flash.utils.getDefinitionByName;

	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	import flash.text.AntiAliasType;

	/**
	 * @author Raphael Pohl
	 */
	public class DepotButton extends Sprite {

		private var _classname:Class;

		private var text_format:TextFormat;
		private var title_field:TextField;
		private var preview_field:TextField;

		private var _puppet:Processor = null;
		private var _dragstart:Point = new Point;

		private var border:int = 4;
		private var reference:Processor;

		private var button_shape:Sprite = new Sprite;

		public function DepotButton(classname:Class) {
			_classname = classname;
			reference = new _classname;

			build();
			draw();
		}

		public function redraw():void {
			draw();
		}

		private function build():void {
			var _width:int = Math.min(reference._width, 8);

			var startx:int = reference.input_count > 0?Main.grid:0;
			var starty:int = Main.grid;
			var windoww:int = Main.grid * (_width - (reference.output_count > 0?1:0)) - 1 - startx;
			var windowh:int = Main.grid * (2 - 1) - 1;

			this.buttonMode = true;
			this.mouseChildren = false;
			addChild(button_shape);
			this.addEventListener(MouseEvent.MOUSE_DOWN, mousedown_listener);

			text_format = new TextFormat;
			text_format.font = "raffix.simple.upcase";
			text_format.size = 8;
			text_format.leftMargin = text_format.rightMargin = 4;

			title_field = new TextField;
			title_field.textColor = Theme.main_color;
			title_field.embedFonts = true;
			title_field.selectable = false;
			title_field.width = Main.grid * (_width-1);
			title_field.autoSize = TextFieldAutoSize.LEFT;
			title_field.defaultTextFormat = this.text_format;
			title_field.text = reference._name;
			addChild(title_field);
			title_field.x = border;
			title_field.y = border;

			if (_width > 2) {
				text_format.font = "raffix.simple.regular";

				preview_field = new TextField;
				preview_field.textColor = Theme.front_color;
				preview_field.embedFonts = true;
				preview_field.selectable = false;
				preview_field.width = windoww;
				preview_field.autoSize = TextFieldAutoSize.LEFT;
				preview_field.defaultTextFormat = this.text_format;
				preview_field.text = reference._preview;
				addChild(preview_field);
				preview_field.x = startx + border;
				preview_field.y = starty + border;
			}
		}
		private function draw():void {
			var _width:int = Math.min(reference._width, 8);

			var startx:int = reference.input_count > 0?Main.grid:0;
			var starty:int = Main.grid;
			var windoww:int = Main.grid * (_width - (reference.output_count > 0?1:0)) - 1 - startx;
			var windowh:int = Main.grid * (2 - 1) - 1;

			button_shape.graphics.beginFill(Theme.canvas_color);
			button_shape.graphics.drawRect(0, 0, Main.grid * _width - 1 + border*2, Main.grid * 2 - 1 + border*2);

			if(Theme.use_noise) {
				button_shape.graphics.beginBitmapFill(Main.master.background_noisy);
				button_shape.graphics.drawRect(0, 0, Main.grid * _width - 1 + border*2, Main.grid * 2 - 1 + border*2);
			}
			button_shape.graphics.endFill();

			button_shape.graphics.beginFill(Theme.back_color);
			button_shape.graphics.drawRect(border-1, border-1, Main.grid * _width + 1, Main.grid * 2 + 1);
			button_shape.graphics.endFill();

			button_shape.graphics.beginFill(Theme.front_color);
			button_shape.graphics.drawRect(border, border, Main.grid * (_width-1) - 1, Main.grid - 1);
			button_shape.graphics.endFill();
			button_shape.graphics.beginFill(Theme.front_color);
			button_shape.graphics.drawRect(Main.grid * (_width-1) + border, border, Main.grid - 1, Main.grid - 1);
			button_shape.graphics.endFill();

			button_shape.graphics.beginFill(Theme.front_color);
			button_shape.graphics.drawRect(startx + border, starty + border, windoww, windowh);
			button_shape.graphics.endFill();

			var i:int;
			var last_type:String = new String;

			if (reference.input_count > 0) {
				// draw input background shape
				button_shape.graphics.beginFill(Theme.front_color);
				button_shape.graphics.drawRect(border, Main.grid + border, Main.grid - 1, Main.grid - 1);
				button_shape.graphics.endFill();

				last_type = 'string';
				button_shape.graphics.beginFill(Theme.node_colors[last_type]);
				for (i = 0; i < reference.input_count; i++) {
					if(reference.input_types[i] != last_type && reference.input_types[i]) {
						last_type = reference.input_types[i];
						button_shape.graphics.endFill();
						button_shape.graphics.beginFill(Theme.node_colors[last_type]);
					}
					button_shape.graphics.drawCircle(border + (Main.grid - 1) / 2, border + Main.grid + (Main.grid - 1) / 2, 5 - (i * 2));
				}
				button_shape.graphics.endFill();
			}
			if (reference.output_count > 0) {
				// draw output background shape
				button_shape.graphics.beginFill(Theme.front_color);
				button_shape.graphics.drawRect(Main.grid * (_width-1) + border, Main.grid + border, Main.grid - 1, Main.grid - 1);
				button_shape.graphics.endFill();

				last_type = 'string';
				button_shape.graphics.beginFill(Theme.node_colors[last_type]);
				for (i = 0; i < reference.output_count; i++) {
					if(reference.output_types[i] != last_type && reference.output_types[i]) {
						last_type = reference.output_types[i];
						button_shape.graphics.endFill();
						button_shape.graphics.beginFill(Theme.node_colors[last_type]);
					}
					button_shape.graphics.drawCircle(border + Main.grid * (_width-1) + (Main.grid - 1) / 2, border + Main.grid + (Main.grid - 1) / 2, 5 - (i * 2));
				}
				button_shape.graphics.endFill();
			}

			if(_width > 2) {
				button_shape.graphics.beginFill(Theme.back_color);
				button_shape.graphics.drawRect(startx + border + 2, starty + border + 2, windoww - 4, windowh - 4);
				button_shape.graphics.endFill();

				// text field colors
				preview_field.textColor = Theme.front_color;
			}

			// text field colors
			title_field.textColor = Theme.main_color;
		}

		private function mousedown_listener(e:Event = null):void {
			var pc:Processor = new _classname;
			Main.master.addChild(pc);

			// release outside listener
			this.parent.stage.addEventListener(MouseEvent.MOUSE_UP, mouseup_listener);

			_puppet = pc;
			_dragstart = new Point(this.mouseX - 4, this.mouseY - 4);
			this.addEventListener(Event.ENTER_FRAME, onenterframe_listener);
		}
		private function onenterframe_listener(e:Event):void {
			if (_puppet != null) {
				_puppet.x = Main.master.mouseX - _dragstart.x;
				_puppet.y = Main.master.mouseY - _dragstart.y;
			}
		}
		private function mouseup_listener(e:Event = null):void {
			// delete release outside listener
			this.parent.stage.removeEventListener(MouseEvent.MOUSE_UP, mouseup_listener);

			this.removeEventListener(Event.ENTER_FRAME, onenterframe_listener);
			_puppet.align();

			_puppet = null;
		}
	}
}
