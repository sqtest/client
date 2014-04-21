package {
    import as3isolib.display.IsoSprite;
    import as3isolib.display.IsoView;
    import as3isolib.display.scene.IsoGrid;
    import as3isolib.display.scene.IsoScene;
    import as3isolib.geom.IsoMath;
    import as3isolib.geom.Pt;
    
    import eDpLib.events.ProxyEvent;
    
    import flash.display.Bitmap;
    import flash.display.Loader;
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.net.URLRequest;
    
    import game.SQGameScene;
    
    import network.SQResponceRouter;
    import network.SQTcpClient;
	
	[SWF(width='800', height='600', frameRate="24")]
	
    public class Client extends Sprite {
		private var scene:IsoScene;
		private var grid:IsoGrid;
		private var view:IsoView;

		private var tcpClient:SQTcpClient;

		private var tcpRespoouter:SQResponceRouter;

		private var gameScene:SQGameScene = new SQGameScene();
		
        public function Client() {
			SQShared.STAGE = stage;
			SQShared.ROOT = this;
			SQShared.TCPClient.connect(SQShared.SERVER_HOST, SQShared.SERVER_PORT);
			SQShared.ResponceRouter = new SQResponceRouter(SQShared.TCPClient);
			SQShared.gameScene.initScene();
        }
		
		private function createMap(e : Event):void {
			var iso:IsoSprite;
			var spriteImg:Bitmap;
			for (var i:int = 0; i < 10; i++) 
			{
				for (var j:int = 0; j < 10; j++) 
				{
					spriteImg = new Bitmap(e.target.content.bitmapData);
					spriteImg.x = -spriteImg.width/2;
					spriteImg.y = 0;

					iso = new IsoSprite();
					iso.moveBy(i*50, j*50, 0);
					iso.sprites = [spriteImg];
					scene.addChild(iso);
				}
				
			}
			scene.render();
		}
		
		private function gridClick(event : ProxyEvent):void
		{
			var me : MouseEvent = MouseEvent(event.targetEvent);
			var p: Pt = new Pt(me.localX, me.localY);
			IsoMath.screenToIso(p);
		}
	
	}
}

