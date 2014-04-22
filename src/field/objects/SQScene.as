package field.objects {
	import as3isolib.display.scene.IsoScene;
	
	import flash.events.MouseEvent;
	
	import org.osflash.signals.natives.NativeSignal;
	
    public class SQScene extends IsoScene {
		public var mouseDown : NativeSignal; 
		public var mouseUp : NativeSignal;
		public var mouseMove : NativeSignal;
		public var mouseClick : NativeSignal;

        public function SQScene() {
			mouseDown = new NativeSignal(this,MouseEvent.MOUSE_DOWN, MouseEvent);
			mouseUp = new NativeSignal(this,MouseEvent.MOUSE_UP, MouseEvent);
			mouseClick = new NativeSignal(this,MouseEvent.CLICK, MouseEvent); 
			mouseMove = new NativeSignal(this,MouseEvent.MOUSE_MOVE, MouseEvent);
    	}
	}
}

