package  {
	
	/**
	 * This class holds and sets all UI colours.
	 * 
	 * http://kuler.adobe.com/#create/fromacolor
	 * max values: hsv(360, 100, 100)
	 * 
	 * @author Raphael Pohl
	 * 
	 */
	public class Theme {
		
		public static var canvas_color:uint		= 0x4C4C4C;
		public static var back_color:uint		= 0x4C4C4C;
		public static var hover_color:uint		= 0x333333;
		public static var front_color:uint		= 0x262626;
		public static var text_color:uint		= 0xBFBFBF;
		public static var main_color:uint		= 0x3060BF;
		public static var highlight_color:uint	= 0x5C8AE5;
		
		public static var noise_color:uint		= 0x5C8AE5;
		public static var noise_alpha:Number	= 0.05;
		public static var use_noise:Boolean		= true;
		
		public function Theme() {
		}
		
		public static function theme_default():void {
			theme_eisfuchslabor();
		}
		
		public static function random():void {
			var id:int = Math.floor(Math.random() * 5);
			switch(id) {
				case 1:
					theme_highcontrast();
					break;
				case 2:
					theme_eisfuchslabor();
					break;
				case 3:
					theme_dark_lime();
					break;
				case 4:
					theme_pinklover();
					break;
				default:
					theme_default();
			}
		}
		
		/**
		 * 
		 * == eisfuchsLabor.de inspired theme
		 * 
		 * @author eiszfuchs
		 * 
		 */
		public static function theme_eisfuchslabor():void {
			canvas_color    = 0xf2f2f2;
			back_color      = 0xf5f5f5;
			hover_color     = 0xD9D9D9;
			front_color     = 0xB2B2B2;
			text_color      = 0x123451;
			main_color      = 0x0f2c44;
			highlight_color = 0xFA9B0B;
			
			use_noise       = true;
			noise_alpha     = 0.05;
			noise_color     = 0x0f2c44;
		}
		
		/**
		 * 
		 * == classic themes
		 * 
		 */
		public static function theme_classic():void {
			theme_graulicht_textlab();
		}
		
		/**
		 * @author eiszfuchs
		 */
		public static function theme_graulicht_textlab():void {
			canvas_color    = 0x4C4C4C;	// hsv(  0,   0,  30)
			back_color      = 0x4C4C4C;	// hsv(  0,   0,  30)
			hover_color     = 0x333333;	// hsv(  0,   0,  20)
			front_color     = 0x262626;	// hsv(  0,   0,  15)
			text_color      = 0xBFBFBF;	// hsv(  0,   0,  75)
			main_color      = 0x3060BF;	// hsv(220,  75,  75)
			highlight_color = 0x5C8AE5;	// hsv(220,  60,  90)
			
			use_noise       = false;
		}
		public static function theme_graulicht_paintlab():void {
			canvas_color    = 0x4C4C4C;	// hsv(  0,   0,  30)
			back_color      = 0x4C4C4C;	// hsv(  0,   0,  30)
			hover_color     = 0x333333;	// hsv(  0,   0,  20)
			front_color     = 0x262626;	// hsv(  0,   0,  15)
			text_color      = 0xBFBFBF;	// hsv(  0,   0,  75)
			main_color      = 0xBF7830;	// hsv( 30,  75,  75)
			highlight_color = 0xE5A15C;	// hsv( 30,  60,  90)
			
			use_noise       = false;
		}
		
		/**
		 * 
		 * == lime coloured theme
		 * 
		 * @author eiszfuchs
		 * 
		 */
		public static function theme_dark_lime():void {
			canvas_color    = 0x747F66;	// hsv( 88,  20,  50)
			back_color      = 0x92998A;	// hsv( 88,  10,  60)
			hover_color     = 0x666652;	// hsv( 60,  20,  40)
			front_color     = 0x494C45;	// hsv( 88,  10,  30)
			text_color      = 0xD2E5B8;	// hsv( 88,  10,  30)
			main_color      = 0x98F230;	// hsv( 88,  80,  95)
			highlight_color = 0xBF1733;	// hsv(350,  88,  75)
			
			use_noise       = true;
			noise_alpha     = 0.2;
			noise_color     = 0x002200;
		}
		
		/**
		 * 
		 * == high contrast theme
		 * 
		 * @author eiszfuchs
		 * 
		 */
		public static function theme_highcontrast():void {
			canvas_color    = 0xF2F2F2;
			back_color      = 0x000000;	// hsv(  0,   0,   0)
			hover_color     = 0x7F7F7F;	// hsv(  0,   0,  50)
			front_color     = 0xFFFFFF;	// hsv(  0,   0, 100)
			text_color      = 0xFFFFFF;	// hsv(  0,   0, 100)
			main_color      = 0x7F7FFF;	// hsv(240,  50, 100)
			highlight_color = 0x0000FF;	// hsv(240, 100, 100)
			
			use_noise       = false;
		}
		
		/**
		 * 
		 * == Pink Lover theme
		 * 
		 * @author eiszfuchs
		 * 
		 */
		public static function theme_pinklover():void {
			canvas_color    = 0xF2EBEE;
			back_color      = 0xD9D9D9;
			hover_color     = 0x4C4C4C;
			front_color     = 0x7F7F7F;
			text_color      = 0x52122C;
			main_color      = 0xFF3388;
			highlight_color = 0x3497FA;
			
			use_noise       = true;
			noise_alpha     = 0.05;
			noise_color     = 0x110000;
		}
	}
}
