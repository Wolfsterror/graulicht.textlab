package  {
	
	/**
	 * @author Raphael Pohl
	 */
	public class StringInput extends Input {
		
		public var _value:String;
		
		public function StringInput(controller:Processor, id:int, label:String = "") {
			_type = 'string';
			kill_value();
			super(controller, id, label);
		}
		
		override public function kill_value():void {
			_value = new String;
		}
		
		public function value(_newvalue:String = null):String {
			if (_newvalue != null) {
				_value = _newvalue;
				changed = false;
			}
			return _value;
		}
		
	}
}
