package game
{
	import as3isolib.display.IsoSprite;
	import as3isolib.geom.Pt;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class SQGameScene
	{
		private var _sizex:int;
		private var _sizey:int;
		
		public function initScene() : void
		{
			SQShared.TCPClient.sendRequest({action : 'ActionAuth', params : {fieldid : getFieldId()}});
		}
		
		public function loadField() : void 
		{
			SQShared.TCPClient.sendRequest({action : 'ActionLoadField'});
		}
		
		public function buildField(xml: XMLList) : void{
			SQShared.GRID.setGridSize(xml.field.@sizex, xml.field.@sizey, 0	);
			SQShared.GRID.cellSize = SQShared.GRID_CELL_SIZE; 
			SQShared.SCENE.addChild(SQShared.GRID);
			SQShared.VIEW.addScene(SQShared.SCENE);
			SQShared.VIEW.setSize(SQShared.STAGE.stageWidth, SQShared.STAGE.stageHeight);
			SQShared.VIEW.centerOnPt(new Pt(
				xml.field.@sizex*SQShared.GRID_CELL_SIZE/2,
				xml.field.@sizey*SQShared.GRID_CELL_SIZE/2,
				0
			));
			
			_sizex = xml.field.@sizex;
			_sizey = xml.field.@sizey;
			
			SQShared.ROOT.addChild(SQShared.VIEW);
			SQShared.ROOT.addEventListener(Event.ENTER_FRAME, gameLoop, false, 0, true);
			SQShared.ROOT.addEventListener(MouseEvent.MOUSE_DOWN, SQShared.mouseHandler.mouseDown, true, 0, true);
			SQShared.ROOT.addEventListener(MouseEvent.MOUSE_UP, SQShared.mouseHandler.mouseUp, false, 0, true);
			SQShared.ROOT.addEventListener(MouseEvent.MOUSE_MOVE, SQShared.mouseHandler.mouseMove, false, 0, true);

			var lib:SQSpriteLib = new SQSpriteLib();
			//lib.load('grass', generateMap);
		}
		
		private function generateMap(texture:Bitmap): void {
			var iso:IsoSprite;
			var spriteImg:Bitmap;
			for (var i:int = 0; i < _sizex; i++) 
			{
				for (var j:int = 0; j < _sizey; j++) 
				{
					SQGameObject.placeTo(texture, i, j);
				}
				
			}
//			var a: SQGameObject = new SQGameObject('factory1');
//			a.addTo(3, 3);
//			a.loadSpriteSig.add(loadSpriteCb);
		}
		
		private function loadSpriteCb(iso: SQSprite): void {
			//iso.mouseDownSig.add(SQShared.mouseHandler.mouseDown);
			//iso.mouseUpSig.add(SQShared.mouseHandler.mouseUp);
		}
//		
//		private function mouseDown(e: Event) : void  {
//			_panPt = SQShared.ROOT.globalToLocal(new Point(SQShared.STAGE.mouseX, SQShared.STAGE.mouseY));
//			_mouseClicked = true;
//			_mouseTarget = e.target;
//		}
//		
//		private function mouseUp(e: Event) : void  {
//			_mouseClicked = false;
//		}
//		
//		public function checkPan() : void {
//			if(_mouseClicked) {
//				//_mouseTarget.moveTo(SQShared.STAGE.mouseX, SQShared.STAGE.mouseY, 0);
////				
////				SQShared.VIEW.pan(_panPt.x-SQShared.STAGE.mouseX, _panPt.y-SQShared.STAGE.mouseY);
////				_panPt.x = SQShared.STAGE.mouseX ;
////				_panPt.y = SQShared.STAGE.mouseY;
//			}
//		}
		
		private function gameLoop(e:Event):void
		{
			//checkPan();
			SQShared.SCENE.render();
		}
		
		private function getFieldId() : int 
		{
			// TODO : replace to dynamic
			return 1; 
		}

	}
}