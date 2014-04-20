package {
    import as3isolib.display.IsoView;
    import as3isolib.display.scene.IsoGrid;
    import as3isolib.display.scene.IsoScene;
    import as3isolib.geom.IsoMath;
    import as3isolib.geom.Pt;
    
    import eDpLib.events.ProxyEvent;
    
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    
    import network.SQTcpClient;
    import network.SQResponceRouter;
	
	[SWF(width='800', height="600", backgroundColor='#000000', frameRate="24")]
	
    public class Client extends Sprite {
		private var scene:IsoScene;
		private var grid:IsoGrid;
		private var view:IsoView;

		private var tcpClient:SQTcpClient;

		private var tcpRespoouter:SQResponceRouter;
		
        public function Client() {
			tcpClient = new SQTcpClient();
			tcpRespoouter = new SQResponceRouter(tcpClient);
			tcpClient.connect();
			
			tcpClient.sendRequest({action : 'ActionAuth', params : {fieldid : 1}});
			
			view = new IsoView();
			view.setSize(800, 600);
			view.centerOnPt(new Pt(200, 200, 0));

			grid = new IsoGrid();
			grid.setGridSize(10, 10, 0);
			grid.cellSize = 50;
			grid.addEventListener(MouseEvent.CLICK, gridClick);
			
			scene = new IsoScene;
			scene.addChild(grid);
			scene.render();
			
			view.addScene(scene);
			addChild(view);		
        }
		
		private function gridClick(event : ProxyEvent):void
		{
			var me : MouseEvent = MouseEvent(event.targetEvent);
			var p: Pt = new Pt(me.localX, me.localY);
			IsoMath.screenToIso(p);
		}
		
		
	}
}

