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
						'welcome': "Willkommen im textlab v2!\r\r- Drücke Strg+S, um Deine Schöpfung in ein speicherbares Format umzuwandeln.\r- Mit Strg+L kannst Du vorher gespeicherte Schöpfungen wieder einlesen.\r- Mit Strg+T schaltest Du das Theme um.\r- Strg+Leertaste wählt alle Prozessoren aus.\r\rViel Spaß! -- eiszfuchs",
						'close': "schließen",
						'in': "ein",
						'out': "aus",
						'map': "Matrix",
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
						'char_replace': "Zeichen ersetzen",
						'word_replace': "Worte ersetzen",
						'help_words': "Worte können auch Zeichenketten sein.",
						'reverse': "Rückwärts",
						'list_reverse': "Rückwärts",
						'shifter': "Alphabetschieber",
						'source': "Quelle",
						'tracer': "Ausgabe",
						'void': "Nichts",
						'space': "Leer",
						'x': "X",
						'jumper': "Springer",
						'picker': "Aufnehmer",
						'capitalizer': "Erste groß",
						'seed': "Salz",
						'tweet_quote': "Tweet-Zitat",
						'refresh': "aktualisieren",
						'output': "Ausgabe",
						'input': "Eingabe",
						'chars': "Zeichen",
						'offset': "Verschiebung",
						'zipper': "Reißverschluss",
						'length': "Länge",
						'result': "Ergebnis",
						'base': "Basis",
						'decorative': "Dekoration",
						'simple': "Einfach",
						'tools': "Werkzeuge",
						'complex': "Komplex",
						'toys': "Spielzeug",
						'list_tools': "Listen",
						'tweet': "Tweet",
						'cutter': "Schnitter",
						'glue': "Kleber",
						'is_loading': "läd ...",
						'import': "Importieren",
						'take_chars': "Zeichen aus ",
						'login': "einloggen",
						'register': "registrieren",
						'save': "sichern",
						'save_help': "Tipp' einen Namen für die Datei ein.",
						'load': "laden",
						'load_help': "Lade zuvor gespeicherte Kreationen.",
						'register_help': "Du musst Dich registrieren, um die Online-Inhalte nutzen zu können.\rUm Dich zu registrieren, gib' einfach Deinen Namen, Deine E-Mail-Adresse und ein Passwort an.\rFertig!",
						'login_help': "Log' Dich mit Deinem Benutzerkonto ein.\rDu hast noch kein Benutzerkonto? Erstelle eines!",
						'no_login': "nicht eingeloggt",
						'error_msg': "Es gab einen Fehler.",
						'bad_login': "Passwort oder Benutzername falsch.",
						'user_created': "Benutzer wurde angelegt."
					};
					break;
				case "en":
					words = {
						'welcome': "Welcome to textlab v2!\r\r- Press Ctrl+S to convert your machine into a copyable format.\r- With Ctrl+L, you can read in a converted machine.\r- Press Ctrl+T to switch between themes.\r- Ctrl+Space selects all processors.\r\rHave fun! -- eiszfuchs",
						'close': "Close",
						'in': "in",
						'out': "out",
						'map': "map",
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
						'char_replace': "replace chars",
						'word_replace': "replace words",
						'help_words': "words can be sequences of chars.",
						'reverse': "reverse",
						'list_reverse': "reverse",
						'shifter': "char shifter",
						'source': "source",
						'tracer': "trace",
						'void': "void",
						'space': "space",
						'x': "X",
						'jumper': "jumper",
						'picker': "Picker",
						'capitalizer': "Capitalizer",
						'seed': "Seed",
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
						'decorative': "decorative",
						'simple': "simple",
						'tools': "tools",
						'complex': "complex",
						'toys': "toys",
						'list_tools': "lists",
						'tweet': "tweet",
						'cutter': "cutter",
						'glue': "glue",
						'is_loading': "loading ...",
						'import': "import",
						'take_chars': "chars from ",
						'login': "log in",
						'register': "register",
						'save': "save",
						'save_help': "Type a filename for your creation.",
						'load': "load",
						'load_help': "You can load your creations here.",
						'register_help': "You have to register to use the online-features.\rJust type your nick name, your e-mail address and a password.\rDone!",
						'login_help': "Log in with your account. Don't have an account? Register one!",
						'no_login': "no login",
						'error_msg': "An error has occurred.",
						'bad_login': "Bad login / password!",
						'user_created': "User has been created."
					};
					break;
				default:
					break;
			}
		}
	}
}
