package field.objects
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import org.osflash.signals.natives.NativeSignal;
	public class SQStage extends Sprite
	{
		public var mouseDown : NativeSignal; 
		public var mouseUp : NativeSignal;
		public var mouseMove : NativeSignal;
		public var mouseClick : NativeSignal;
		
		public function SQStage(st : Sprite)
		{
			mouseDown = new NativeSignal(st,MouseEvent.MOUSE_DOWN, MouseEvent);
			mouseUp = new NativeSignal(st,MouseEvent.MOUSE_UP, MouseEvent);
			mouseClick = new NativeSignal(st,MouseEvent.CLICK, MouseEvent); 
			mouseMove = new NativeSignal(st,MouseEvent.MOUSE_MOVE, MouseEvent);
		}
	}
}