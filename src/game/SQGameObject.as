package game
{
	import as3isolib.display.IsoSprite;
	import as3isolib.geom.IsoMath;
	import as3isolib.geom.Pt;
	
	import eDpLib.events.ProxyEvent;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	import org.osflash.signals.Signal;

	public class SQGameObject 
	{
		public var loadSpriteSig : Signal;
		private var spriteId : String;
		public function SQGameObject(id: String) :void {
			loadSpriteSig = new Signal(SQSprite);
			spriteId = id;
		}
		
		public function addTo(x: int = 0, y: int = 0, z: int = 0) : void {
//			var lib:SQSpriteLib = new SQSpriteLib();
//			
//			lib.load(spriteId, function(texture: Bitmap): void {
//				loadSpriteSig.dispatch(SQGameObject.placeTo(texture, x, y, z))
//			});
		}
		
		static public function placeTo(texture: Bitmap, x: int = 0, y: int = 0, z: int = 0): SQSprite {
			var duplicate:Bitmap = new Bitmap();
			duplicate.bitmapData = texture.bitmapData;
			duplicate.x = -duplicate.width/2;
			duplicate.y = 0;
			
			var iso: SQSprite = new SQSprite();
			iso.moveBy(x*SQShared.GRID_CELL_SIZE, y*SQShared.GRID_CELL_SIZE, z);
			iso.sprites = [duplicate];
			SQShared.SCENE.addChild(iso);
			return iso;
		}

	}
}