/**
 * 
 * ----------------------------------------------------------------------------
 * 
 *                    eisfuchsLabor / graulicht / textlab
 *                     http://eisfuchslabor.de/graulicht/
 * 
 *                    developed and (c) 2011 by Raphael Pohl
 * 
 * ----------------------------------------------------------------------------
 * 
 *            THIS PROJECT USES THIRD-PARTY PACKAGES AND PROJECTS.
 * 
 * ----------------------------------------------------------------------------
 * 
 * mikechambers / as3corelib
 * 
 * An ActionScript 3 Library that contains a number of classes and utilities
 * for working with ActionScript? 3. These include classes for MD5 and SHA 1
 * hashing, Image encoders, and JSON serialization as well as general String,
 * Number and Date APIs.
 * 
 * Code is released under a BSD License:
 * http://www.opensource.org/licenses/bsd-license.php
 * 
 * Copyright (c) 2008, Adobe Systems Incorporated
 * All rights reserved.
 * 
 * 
 * 
 * danro / tweenman-as3
 * 
 * TweenMan AS3 tweening library for Flash & Flex
 * 
 * TweenMan requires fl.motion.Color, which comes compiled in the TweenMan swc.
 * 
 * For updates and examples, visit: http://www.tweenman.com
 * Author: Dan Rogers - dan@danro.net
 * 
 * ----------------------------------------------------------------------------
 * 
 */

package {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.geom.Point;
	
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import Dialogs.*;
	import Processors.*;
	
	import com.adobe.serialization.json.*;

	/**
	 * 
	 *   Main Class
	 * 
	 * Creates interface and embeds font sources.
	 * It handles selection, the main events and redrawing.
	 * 
	 * @author Raphael Pohl
	 * 
	 */
	[Frame(factoryClass="Preloader")]
	public class Main extends Sprite {
		
		public static const animation_duration:Number = 0.25;	// how long (seconds) the animations should last
		public static const grid:int = 16;						// this aligns everything
		
		public static var master:Main;							// "master of puppets", reference to Main (_root workaround)
																// TODO: is this really a nice way?
		public static var depot:Depot;							// reference to processor menu
		public static var curtain:Curtain;						// reference to curtain for dialogs (makes everythin unclickable)
		public static var puppets:Array = new Array;			// array with all processor references on stage
		public static var counter:int = 0;						// unique counter to identify processors (this will come in handy for hash generation)
		
		public static var connections:Array = new Array;		// array with all connection references
		public static var draw_connections:Shape = new Shape;	// shape on that all connections are drawn
		
		private var _dragstart:Point = new Point;				// helper for drag-and-drop (where the mouse started to drag)
		
		/**
		 * The font files in this archive were created using Fontstruct the free, online font-building tool.
		 * These fonts were created by Raphael Pohl.
		 *
		 * Try Fontstruct at http://fontstruct.com/
		 * It’s easy and it’s fun.
		 */
		[Embed(source = 'assets/fonts/raffix_simple_regular.ttf', embedAsCFF = "false", fontFamily = 'raffix.simple.regular')] private static const FONT_RAFFIX_SIMPLE_REGULAR: Class;
		[Embed(source = 'assets/fonts/raffix_simple_upcase.ttf', embedAsCFF = "false", fontFamily = 'raffix.simple.upcase')] private static const FONT_RAFFIX_SIMPLE_UPCASE: Class;
		[Embed(source = 'assets/fonts/eiszfuchs_simple_regular.ttf', embedAsCFF = "false", fontFamily = 'eiszfuchs.simple.regular')] private static const FONT_EISZFUCHS_SIMPLE_REGULAR: Class;
		
		[Embed(source = 'assets/bg_noise.png')] private static const BACKGROUND_NOISE: Class;	// it's the famous noise of eisfuchslabor.de!
		private var background_noisy:Bitmap = new Bitmap();										// it's the noisy bitmap that will be repeated
		
		// wait for the content to be loaded
		public function Main():void {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		// everything's fine, now DO IT!
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			
			// ==>> ENTRY POINT <<==
			
			Language.set(); // initialize words
			background_noisy = new BACKGROUND_NOISE();
			
			// überclass _root :)
			master = this;
			
			// when resizing the stage, everything should be organized.
			stage.addEventListener(Event.RESIZE, resize_listener);
			// when dragging on stage, it should be a selection.
			stage.addEventListener(MouseEvent.MOUSE_DOWN, mousedown_listener);
			stage.addEventListener(MouseEvent.MOUSE_UP, mouseup_listener);
			
			// listen for keyboard shortcuts
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keydown_listener);
			
			addChild(draw_connections);
			
			// create menu or else the user cannot do anything
			depot = new Depot;
			addChild(depot);
			
			// create the curtain that prevents clicking on anything but dialogs
			curtain = new Curtain;
			addChild(curtain);
			
			// resize everything once for beauty
			resize_listener();
			
			// create welcome message
			var puppet:Processor = new Comment;
			puppet.options.set_value("comment", Language.words['welcome']);
			addChild(puppet);
			puppet.align();
		}
		
		/**
		 * Handle the KEYDOWN event.
		 * 
		 * @param	e	The event that was fired
		 */
		private function keydown_listener(e:KeyboardEvent):void {
			// keyboard shortcuts
			if (e.keyCode == 83) {
				// S
				if (e.ctrlKey) {
					// Ctrl + S
					addChild(new Export(JSON.encode(export()))); // add Export dialog to stage
				}
			} else if (e.keyCode == 76) {
				// L
				if (e.ctrlKey) {
					// Ctrl + L
					addChild(new Import()); // add Import dialog to stage
				}
			} else if (e.keyCode == 84) {
				// T
				if (e.ctrlKey) {
					// Ctrl + T
					addChild(new ThemeSelector()); // add Theme Selection dialog to stage
				}
			}
		}
		
		/**
		 * Handle the MOUSEDOWN event.
		 * It basically stores the position where the mouse started dragging
		 * and registers a new ENTER_FRAME listener
		 * 
		 * @param	e	The event that was fired
		 */
		private function mousedown_listener(e:Event):void {
			_dragstart = new Point(this.mouseX, this.mouseY);
			if (e.target != this) {
				// if the target which was dragged is not the stage
				return;
			}
			this.addEventListener(Event.ENTER_FRAME, onenterframe_listener);
		}
		/**
		 * Handle the MOUSEUP event.
		 * Removes the ENTER_FRAME listener and selects processors if any
		 * 
		 * @param	e	The event that was fired
		 */
		private function mouseup_listener(e:Event):void {
			this.removeEventListener(Event.ENTER_FRAME, onenterframe_listener); // remove that, that is useless now
			resize_listener(); // redraw stage (and background)
			
			if (e.target != this) {
				// no action needed?
			}
			
			// initialize positions
			var x1:int = _dragstart.x;
			var y1:int = _dragstart.y;
			var x2:int = this.mouseX - x1;
			var y2:int = this.mouseY - y1;
			
			// point objects for rectangle and intersection test
			var topleft:Point = new Point(Math.min(x1, x2 + x1), Math.min(y1, y2 + y1));
			var bottomright:Point = new Point(Math.max(x1, x2 + x1), Math.max(y1, y2 + y1));
			
			var i:int;
			var puppet:Processor;
			for (i = 0; i < puppets.length; i++) {
				// check for every processor whether it is completely inside the selection rectangle
				puppet = puppets[i];
				if(puppet.x >= topleft.x && (puppet.x + puppet._width * Main.grid) <= bottomright.x
				   && puppet.y >= topleft.y && (puppet.y + puppet._height * Main.grid) <= bottomright.y) {
					puppet.select();
				} else {
					puppet.deselect();
				}
			}
		}
		
		/**
		 * Clears the selection of processors
		 */
		private function deselect_all():void {
			var i:int;
			var puppet:Processor;
			for (i = 0; i < puppets.length; i++) {
				puppet = puppets[i];
				puppet.deselect();
			}
		}
		
		/**
		 * Is active when mouse is down and on pressed on stage.
		 * It draws the selection rectangle for visual feedback
		 */
		private function onenterframe_listener(e:Event):void {
			resize_listener(); // clear stage and refresh
			
			this.graphics.lineStyle(2, Theme.highlight_color);
			this.graphics.beginFill(Theme.front_color);
			this.graphics.drawRect(_dragstart.x, _dragstart.y, (this.mouseX - _dragstart.x), (this.mouseY - _dragstart.y));
			this.graphics.endFill();
		}
		
		/**
		 * Sets the depth index of any child that it is displayed on top of all children
		 * 
		 * @param	_controller	The child that is supposed to be in front of everything
		 */
		public function bring_front(_controller:*):void {
			setChildIndex(_controller, this.numChildren - 1);
			// BOOM
		}
		
		/**
		 * Is called when the window is resized.
		 * Use this to reset dimensions and positions
		 * 
		 * @param	e	The event that is fired, is null if this is no callback of an listener
		 */
		private function resize_listener(e:Event = null):void {
			// clear stage and redraw THE COLOURS
			this.graphics.clear();
			this.graphics.lineStyle();
			
			this.graphics.beginFill(Theme.back_color);
			this.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			// here comes the noise!
			this.graphics.beginBitmapFill(background_noisy.bitmapData);
			this.graphics.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			
			this.graphics.endFill();
			
			// resize the curtain for dialogs
			curtain.resize();
			
			// BUG: Processors will remain outside stage when resizing has finished
		}
		
		/**
		 * Gets all processors by selection and stores them in an array
		 * 
		 * @return list of all selected processors
		 */
		public static function get_selected():Array {
			var i:int;
			var puppet:Processor;
			var selection:Array = new Array;
			
			for (i = 0; i < puppets.length; i++) {
				puppet = puppets[i];
				if (puppet.selected) {
					selection.push(puppet);
				}
			}
			
			return selection;
		}
		
		/**
		 * Reads out any JSON-encoded string and regenerates the processors and connections
		 * 
		 * @param	_json	JSON-encoded string
		 * @return			whether the function was successful
		 */
		public static function load(_json:String):Boolean {
			try {
				var object:Object = new Object;
				object = JSON.decode(_json);
			} catch (e:JSONParseError) {
				// MEGA FAIL
				return false;
			} 
			// TODO: check whether the provided object is a saved machine
			
			var mind:Object = new Object; // stores references to processors by their hash according to JSON object
			
			var i:int; // puppet
			var o:*; // option
			
			Main.master.deselect_all(); // we will select all new processors
			
			// processor creation
			
			var puppet:Processor;
			for (i = 0; i < object.processors.length; i++) {
				// look for processor type and create new instance according to it
				switch(object.processors[i].type) {
					case 'Append':			puppet = new Append;		break;
					case 'Comment':			puppet = new Comment;		break;
					case 'Counter':			puppet = new Counter;		break;
					case 'Cross':			puppet = new Cross;			break;
					case 'Join':			puppet = new Join;			break;
					case 'Majuscules':		puppet = new Majuscules;	break;
					case 'Marquee':			puppet = new Marquee;		break;
					case 'Minuscules':		puppet = new Minuscules;	break;
					case 'Repeat':			puppet = new Repeat;		break;
					case 'Replace':			puppet = new Replace;		break;
					case 'Reverse':			puppet = new Reverse;		break;
					case 'Shift': 			puppet = new Shift;			break;
					case 'Source':			puppet = new Source;		break;
					case 'Trace':			puppet = new Trace;			break;
					case 'Tweet':			puppet = new Tweet;			break;
					case 'Void':			puppet = new Void;			break;
					case 'X':				puppet = new X;				break;
					// TODO: what to do when there is an unknown type?
					default:				puppet = null;
				}
				
				if (puppet) {
					// if puppet is an instance
					
					// set position of new puppet accourding to JSON object
					puppet.x = object.processors[i].x;
					puppet.y = object.processors[i].y;
					
					for (o in object.processors[i].options) {
						// set options (checkboxes, etc)
						puppet.options.set_value(o, object.processors[i].options[o]);
					}
					// keep instance in mind, we need that later for connections
					mind[object.processors[i].id] = puppet;
					Main.master.addChild(puppet);
					// select all new puppets
					puppet.select();
				}
			}
			
			// now for the connections
			
			var sender:Processor;
			var output_id:int;
			var receiver:Processor;
			var input_id:int;
			
			for (i = 0; i < object.connections.length; i++) {
				// go through defined connections
				
				// get sender and receiver
				sender = mind[object.connections[i].sender[0]];
				receiver = mind[object.connections[i].receiver[0]];
				output_id = object.connections[i].sender[1];
				input_id = object.connections[i].receiver[1];
				
				// create instances of inputs / outputs
				var the_output:ProcessorOutput = sender.outputs[output_id] as ProcessorOutput;
				var the_input:ProcessorInput = receiver.inputs[input_id] as ProcessorInput;
				
				// create a new connection
				the_input._connection = new Connection(the_output, the_input);
				the_output._connections.push(the_input._connection);
				
				sender.draw_connections(); // draw connection
			}
			return true;
		}
		
		/**
		 * Reads out all processors/connections and generates an objects
		 * 
		 * @return	object with all relevant information
		 */
		public static function export():Object {
			var i:int;
			var puppet:Processor;
			var connection:Connection;
			
			var export:Object = new Object; // fresh object as storage
			
			export["processors"] = new Array;
			for (i = 0; i < puppets.length; i++) {
				puppet = puppets[i];
				if(puppet.parent) {
					var puppet_object:Object = new Object;
					
					puppet_object.x = puppet.x;
					puppet_object.y = puppet.y;
					puppet_object.id = puppet._identifier;
					
					puppet_object.type = ((puppet.toString()).substring(8)).replace(']', '');
					puppet_object.options = puppet.options.get_values();
					
					export.processors.push(puppet_object);
				}
			}
			export["connections"] = new Array;
			for (i = 0; i < connections.length; i++) {
				connection = connections[i];
				
				var connection_object:Object = new Object;
				
				connection_object.sender = [connection.sender._controller._identifier, connection.sender._id];
				connection_object.receiver = [connection.receiver._controller._identifier, connection.receiver._id];
				
				export.connections.push(connection_object);
			}
			
			return export;
		}
		
		/**
		 * Redraws all objects master knows of.
		 * This is usually called when changing themes.
		 */
		public static function redraw():void {
			Main.master.resize_listener();
			depot.redraw();
			curtain.redraw();
			
			var i:int;
			var puppet:Processor;
			for (i = 0; i < puppets.length; i++) {
				puppet = puppets[i];
				puppet.redraw();
			}
			puppet.draw_connections();
		}
		
		/**
		 * The Heart of the whole project.
		 * It traces the way back from every processor that has no output to every processor that has no input.
		 * 
		 * fire() is a port of the function that was created in textlab v1 by Raphael Pohl
		 * 
		 * @author Raphael Pohl
		 * @version 1.0.1
		 */
		public static function fire():void {
			var i:int;
			var t:int;
			
			var e:Processor;
			var pull:Processor;
			var stack:Array; // the processors that have to be processed
			var input:ProcessorInput;
			
			// we pretend everything "changed"
			for (i = 0; i < puppets.length; i++) {
				pull = puppets[i];
				if (pull.input_count > 0) {
					for (t = 0; t < pull.input_count; t++) {
						input = pull.inputs[t];
						input.changed = true;
						input.set_error(); // we pretend that there is "no error" on that input
					}
				}
			}
			
			for (i = 0; i < puppets.length; i++) {
				if (puppets[i].output_count > 0)
					continue;
				
				pull = puppets[i];
				
				// initialize stack
				stack = new Array;
				stack.push(pull);
				
				var error:Boolean = false;
				
				while (stack.length > 0 && !error) {
					var current:Processor = stack[stack.length - 1];
					if (current.input_count > 0) {
						if (stack.indexOf(current) != stack.lastIndexOf(current)) {
							error = true;
						}
						var actions:int = 0;
						for (t = 0; t < current.input_count; t++) {
							input = current.inputs[t];
							if(input.changed && !input.error && input._connection != null) {
								actions++;
							} else if (input._connection == null) {
								input.set_error(true);
								error = true;
							} else if (input.error) {
								error = true;
							}
						}
						if(actions > 0) {
							for (t = 0; t < current.input_count; t++) {
								input = current.inputs[t];
								if (input.changed && !input.error && input._connection != null) {
									stack.push(input._connection.sender._controller);
									break;
								} else if(input._connection == null) {
									input.set_error(true);
									error = true;
								} else if (input.error) {
									error = true;
								}
							}
						} else {
							e = stack.pop();
							e.process();
						}
					} else {
						e = stack.pop();
						e.process();
					}
				}
			}
		}
	}
}
