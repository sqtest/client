package game {
	import as3isolib.display.IsoSprite;
	
	import flash.events.MouseEvent;
	
	import org.osflash.signals.natives.NativeSignal;

    public class SQSprite extends IsoSprite{
		public var mouseDownSig : NativeSignal;
		public var mouseUpSig : NativeSignal;
        public function SQSprite() {
			super();
			mouseDownSig = new NativeSignal(this, MouseEvent.MOUSE_DOWN, MouseEvent); 
			//mouseUpSig = new NativeSignal(this, MouseEvent.MOUSE_UP, MouseEvent);
        }
    }
}

