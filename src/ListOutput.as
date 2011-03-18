package  {
	
	/**
	 * @author Raphael Pohl
	 */
	public class ListOutput extends Output {
		
		private var _value:Array = new Array;
		
		public function ListOutput(controller:Processor, id:int, label:String = "") {
			_type = 'list';
			super(controller, id, label);
		}
		
		public function value(_newvalue:Array = null):Array {
			var i:int;
			if (_newvalue != null) {
				_value = _newvalue;
				for (i = 0; i < _connections.length; i++) {
					var input:ListInput;
					input = _connections[i].receiver;
					input.value(_value);
				}
			}
			return _value;
		}
	}
}
