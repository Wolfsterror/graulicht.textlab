package  {
	
	/**
	 * @author Raphael Pohl
	 */
	public class ListInput extends Input {
		
		public var _value:Array;
		
		public function ListInput(controller:Processor, id:int, label:String = "") {
			_type = 'list';
			kill_value();
			super(controller, id, label);
		}
		
		override public function kill_value():void {
			_value = new Array;
		}
		
		public function value(_newvalue:Array = null):Array {
			if (_newvalue != null) {
				_value = _newvalue;
				changed = false;
			}
			return _value;
		}
		
	}
}
