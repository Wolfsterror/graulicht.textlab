package  {
	
	/**
	 * This class holds and sets all words.
	 * 
	 * @author Raphael Pohl
	 * 
	 */
	public class Language {
		
		public static var words:Object = new Object;
		
		public function Language() {
		}
		
		public static function set(_lang:String = "de"):void {
			switch(_lang) {
				case "de":
					words = {
						'welcome': "Willkommen im textlab v2!\r\r- Drücke Strg+S, um Deine Schöpfung in ein speicherbares Format umzuwandeln.\r- Mit Strg+L kannst Du vorher gespeicherte Schöpfungen wieder einlesen.\r- Mit Strg+T schaltest Du das Theme um.\r\rViel Spaß! -- eiszfuchs",
						'close': "Schließen",
						'in': "ein",
						'out': "aus",
						'needle': "Nadel",
						'haystack': "Heuhaufen",
						'replacement': "Ersetzung",
						'ignore_undefined': "undefinierte ignorieren",
						'append': "Anfügen",
						'comment': "Kommentar",
						'counter': "Zeichenzähler",
						'cross': "Kreuz",
						'join': "Zusammenfügen",
						'majuscules': "Großbuchstaben",
						'marquee': "Textschieber",
						'minuscules': "Kleinbuchstaben",
						'repeat': "Wiederholen",
						'replace': "Ersetzen",
						'reverse': "Rückwärts",
						'shifter': "Alphabetschieber",
						'source': "Quelle",
						'tracer': "Ausgabe",
						'void': "Nichts",
						'x': "X",
						'tweet_quote': "Tweet-Zitat",
						'refresh': "Aktualisieren",
						'output': "Ausgabe",
						'input': "Eingabe",
						'chars': "Zeichen",
						'offset': "Verschiebung",
						'zipper': "Reißverschluss",
						'length': "Länge",
						'result': "Ergebnis",
						'base': "Basis",
						'makeup': "Make-Up",
						'simple': "Einfach",
						'tools': "Werkzeuge",
						'complex': "Komplex",
						'toys': "Spielzeug",
						'tweet': "Tweet",
						'is_loading': "läd ...",
						'import': "Importieren",
						'take_chars': "Zeichen aus "
					};
					break;
				case "en":
					words = {
						'welcome': "Welcome to textlab v2!\r\r- Press Ctrl+S to convert your machine into a copyable format.\r- With Ctrl+L, you can read in a converted machine.\r- Press Ctrl+T to switch between themes.\r\rHave fun! -- eiszfuchs",
						'close': "Close",
						'in': "in",
						'out': "out",
						'needle': "needle",
						'haystack': "haystack",
						'replacement': "replacement",
						'ignore_undefined': "ignore undefined",
						'append': "append",
						'comment': "comment",
						'counter': "char counter",
						'cross': "cross",
						'join': "join",
						'majuscules': "majuscules",
						'marquee': "text shifter",
						'minuscules': "minuscules",
						'repeat': "repeat",
						'replace': "replace",
						'reverse': "reverse",
						'shifter': "char shifter",
						'source': "source",
						'tracer': "trace",
						'void': "void",
						'x': "X",
						'tweet_quote': "Tweet Quote",
						'refresh': "refresh",
						'output': "output",
						'input': "input",
						'chars': "chars",
						'offset': "offset",
						'zipper': "zipper mode",
						'length': "length",
						'result': "result",
						'base': "base",
						'makeup': "decorative",
						'simple': "simple",
						'tools': "tools",
						'complex': "complex",
						'toys': "toys",
						'tweet': "tweet",
						'is_loading': "loading ...",
						'import': "import",
						'take_chars': "chars from "
					};
					break;
				default:
					break;
			}
		}
	}
}
