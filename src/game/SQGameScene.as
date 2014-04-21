package game
{
	import as3isolib.geom.Pt;
	
	import flash.display.Bitmap;
	import flash.events.Event;
	import as3isolib.display.IsoSprite;
	
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
			SQShared.ROOT.addEventListener(Event.ENTER_FRAME, gameLoop, false, 1, true);

			var lib:SQSpriteLib = new SQSpriteLib();
			lib.load('grass.png', generateMap);
			
		}
		private function generateMap(texture:Bitmap): void {
			var iso:IsoSprite;
			var spriteImg:Bitmap;
			for (var i:int = 0; i < _sizex; i++) 
			{
				for (var j:int = 0; j < _sizey; j++) 
				{
					var duplicate:Bitmap = new Bitmap();
					duplicate.bitmapData = texture.bitmapData;
					duplicate.x = -duplicate.width/2;
					duplicate.y = 0;

					iso = new IsoSprite();
					iso.moveBy(i*SQShared.GRID_CELL_SIZE, j*SQShared.GRID_CELL_SIZE, 0);
					iso.sprites = [duplicate];
					SQShared.SCENE.addChild(iso);
				}
				
			}
		}
		
		private function gameLoop(e:Event):void
		{
			SQShared.SCENE.render();
		}
		
		private function getFieldId() : int 
		{
			// TODO : replace to dynamic
			return 1; 
		}

	}
}