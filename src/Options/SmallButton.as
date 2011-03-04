package Options {
	
	/**
	 * @author Raphael Pohl
	 */
	public class SmallButton extends Button {
		
		public function SmallButton(_label:String, _callback:Function, _connector:ProcessorOptions = null) {
			super(_label, _callback, _connector);
			
			padding = 1;
			margin = 6;
			
			draw();
		}
	}
}
