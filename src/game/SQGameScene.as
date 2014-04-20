package game
{
	import as3isolib.geom.Pt;
	
	import flash.events.Event;
	
	public class SQGameScene
	{
		public function initScene() : void
		{
			SQShared.TCPClient.sendRequest({action : 'ActionAuth', params : {fieldid : getFieldId()}});
		}
		
		public function loadField() : void 
		{
			SQShared.TCPClient.sendRequest({action : 'ActionLoadField'});
		}
		
		public function buildField(xml: XMLList) : void{
			trace(xml.field);
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
			
			SQShared.ROOT.addChild(SQShared.VIEW);
			SQShared.SCENE.render();
		}
		
		private function getFieldId() : int 
		{
			// TODO : replace to dynamic
			return 1; 
		}

	}
}