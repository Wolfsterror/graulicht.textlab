package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	
	import Processors.*;
	
	import com.tweenman.TweenMan;
	
	/**
	 * @author Raphael Pohl
	 */
	public class Depot extends MovieClip {
		
		private var menus:Array = new Array;
		private var tabs:Array = new Array;
		
		public var i:int = 0;
		
		public function Depot() {
			draw();
			
			add_group(Language.words['base'],		[Source, Trace]);
			add_group(Language.words['makeup'],		[Comment, X]);
			add_group(Language.words['simple'],		[Minuscules, Majuscules, Reverse, Shift, Marquee]);
			add_group(Language.words['tools'],		[Counter, Repeat, Append, Cross, Void]);
			add_group(Language.words['complex'],	[Join, Replace]);
			add_group(Language.words['toys'],		[Tweet]);
			
			rearrange();
			show_menu(0);
			
			// TODO: handle resizes when there is not enough space for all processors!
		}
		
		private function add_group(label:String, processors:Array):void {
			var menu:DepotMenu;
			var tab:DepotTab;
			
			tab = new DepotTab(label, i++);
			menu = new DepotMenu(processors);
			
			tabs.push(tab);
			menus.push(menu);
			addChild(tab);
			addChild(menu);
		}
		
		public function redraw():void {
			var i:int;
			for (i = 0; i < menus.length; i++) {
				menus[i].redraw();
			}
			for (i = 0; i < tabs.length; i++) {
				tabs[i].redraw();
			}
			draw();
		}
		
		private function draw():void {
			this.graphics.beginFill(Theme.front_color);
			this.graphics.drawRect(0, 0, 3000, Main.grid * 4);
			this.graphics.drawRect(0, Main.grid * 3 - 5, 3000, 1);
			this.graphics.drawRect(0, Main.grid * 4 + 1, 3000, 1);
			this.graphics.endFill();
		}
		
		private function rearrange():void {
			var i:int;
			var _x:int = 4;
			
			for (i = 0; i < tabs.length; i++) {
				tabs[i].x = _x;
				_x += tabs[i].width + 4;
				tabs[i].y = Main.grid * 3;
			}
		}
		
		public function hide_menus():void {
			var i:int;
			for (i = 0; i < menus.length; i++) {
				TweenMan.addTween(menus[i], { y: -Main.grid * 3, time: Main.animation_duration * 2, ease: "easeInOutQuart" } );
			}
			for (i = 0; i < tabs.length; i++) {
				TweenMan.addTween(tabs[i], { y: Main.grid * 3, time: Main.animation_duration, ease: "easeInOutQuart" } );
			}
		}
		public function show_menu(id:int):void {
			hide_menus();
			TweenMan.removeTweens(menus[id]);
			TweenMan.addTween(menus[id], { y: 0, time: Main.animation_duration * 2, ease: "easeInOutQuart" } );
			TweenMan.removeTweens(tabs[id]);
			TweenMan.addTween(tabs[id], { y: Main.grid * 3 - 4, time: Main.animation_duration, ease: "easeInOutQuart" } );
		}
	}
}
