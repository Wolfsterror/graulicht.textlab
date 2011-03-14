package Social {
	
	import com.adobe.crypto.MD5;
	
	/**
	 * @author Raphael Pohl
	 */
	public class User {
		
		public var name:String = new String;
		public var email:String = new String;
		public var pass:String = new String; // MD5
		
		public function User(_name:String = "", _email:String = "", _pass:String = "") {
			name = _name;
			email = _email;
			pass = _pass;
		}
		
	}

}