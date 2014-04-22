package game {
	import eDpLib.events.ProxyEvent;
	
	import flash.events.MouseEvent;

    public class SQMouseEventHandler {
		private var _mousePressed : Boolean = false;
		
        public function mouseUp(e: ProxyEvent) : void {
			_mousePressed = false;
		}

		public function mouseDown(e: ProxyEvent) : void {
			_mousePressed = true;
		}

		public function mouseMove(e: ProxyEvent) : void {
			if(_mousePressed) { 
				trace(1);
			}
		}
	}
}

