package  {
	
	/**
	 * @author Raphael Pohl
	 */
	public class StringOutput extends Output {
		
		private var _value:String = new String;
		
		public function StringOutput(controller:Processor, id:int, label:String = "") {
			_type = 'string';
			super(controller, id, label);
		}
		
		public function value(_newvalue:String = null):String {
			var i:int;
			if (_newvalue != null) {
				_value = _newvalue;
				for (i = 0; i < _connections.length; i++) {
					var input:StringInput;
					input = _connections[i].receiver;
					input.value(_value);
				}
			}
			return _value;
		}
		
	}
}
