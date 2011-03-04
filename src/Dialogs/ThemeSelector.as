package Dialogs {
	
	import flash.display.Sprite;
	import flash.events.Event;
	
	import flash.filters.DropShadowFilter;
	import com.tweenman.TweenMan;
	
	/**
	 * @author Raphael Pohl
	 */
	public class ThemeSelector extends Sprite {
		
		private var button_close:Button;
		
		public function ThemeSelector() {
			this.filters = [ new DropShadowFilter(2, 90, 0x000000, 0.3, 6, 6) ];
			
			button_theme_eisfuchslabor = new Button('eisfuchsLabor', theme_eisfuchslabor);
			this.addChild(button_theme_eisfuchslabor);
			button_theme_dark_lime = new Button('Dunkle Limette', theme_dark_lime);
			this.addChild(button_theme_dark_lime);
			button_theme_contrast = new Button('Hoher Kontrast', theme_contrast);
			this.addChild(button_theme_contrast);
			button_theme_textlab = new Button('grauLicht (textlab)', theme_textlab);
			this.addChild(button_theme_textlab);
			button_theme_paintlab = new Button('grauLicht (paintlab)', theme_paintlab);
			this.addChild(button_theme_paintlab);
			button_theme_pinklover = new Button('Pink Lover', theme_pinklover);
			this.addChild(button_theme_pinklover);
			
			button_close = new Button(Language.words['close'], fade);
			this.addChild(button_close);
			
			draw();
			Main.curtain.fade_in();
			
			x = Math.round(Main.master.stage.stageWidth / 2 - width / 2);
			y = Main.grid - height;
			
			TweenMan.addTween(this, { y: Main.grid * 2.5, time: Main.animation_duration, ease: "easeInOutQuart" } );
		}
		
		private function draw():void {
			this.graphics.clear();
			
			button_theme_eisfuchslabor.x = 0;
			button_theme_eisfuchslabor.y = 0;
			button_theme_dark_lime.x = button_theme_eisfuchslabor.width + 4;
			button_theme_dark_lime.y = 0;
			button_theme_contrast.x = button_theme_dark_lime.width + button_theme_eisfuchslabor.width + 4 * 2;
			button_theme_contrast.y = 0;
			
			button_theme_textlab.x = 0;
			button_theme_textlab.y = button_theme_eisfuchslabor.height + 4;
			button_theme_paintlab.x = button_theme_textlab.width + 4;
			button_theme_paintlab.y = button_theme_eisfuchslabor.height + 4;
			
			button_theme_pinklover.x = 0;
			button_theme_pinklover.y = button_theme_eisfuchslabor.height + button_theme_textlab.height + 4 * 2;
			
			button_close.x = width - button_close.width;
			button_close.y = button_theme_textlab.height + button_theme_eisfuchslabor.height + button_theme_pinklover.height + 4 * 3;
			
			var _width:int = this.width;
			var _height:int = this.height;
			
			this.graphics.beginFill(Theme.back_color);
			this.graphics.drawRect( -Main.grid / 2, -Main.grid / 2, _width + Main.grid, _height + Main.grid);
			this.graphics.endFill();
			this.graphics.beginFill(Theme.front_color);
			this.graphics.drawRect( -Main.grid / 2 + 1, -Main.grid / 2 + 1, _width + Main.grid - 2, _height + Main.grid - 2);
			this.graphics.endFill();
			
		}
		
		private function fade(e:Event = null):void {
			TweenMan.addTween(this, { y: 0, alpha: 0, time: Main.animation_duration * 2, ease: "easeInOutQuart", onComplete: function():void { die(); } } );
		}
		
		public function die(e:Event = null):void {
			Main.curtain.fade_out();
			Main.master.removeChild(this);
		}
		
		private var button_theme_eisfuchslabor:Button;
		private var button_theme_dark_lime:Button;
		private var button_theme_contrast:Button;
		private var button_theme_textlab:Button;
		private var button_theme_paintlab:Button;
		private var button_theme_pinklover:Button;
		
		private function theme_eisfuchslabor(e:Event = null):void {
			Theme.theme_eisfuchslabor();
			refresh();
		}
		private function theme_dark_lime(e:Event = null):void {
			Theme.theme_dark_lime();
			refresh();
		}
		private function theme_contrast(e:Event = null):void {
			Theme.theme_highcontrast();
			refresh();
		}
		private function theme_textlab(e:Event = null):void {
			Theme.theme_graulicht_textlab();
			refresh();
		}
		private function theme_paintlab(e:Event = null):void {
			Theme.theme_graulicht_paintlab();
			refresh();
		}
		private function theme_pinklover(e:Event = null):void {
			Theme.theme_pinklover();
			refresh();
		}
		
		private function refresh():void {
			Main.redraw();
		}
	}
}
