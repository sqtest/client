package {
    import field.SQGameScene;
    
    import flash.display.Sprite;
    
    import network.SQResponceRouter;
    import network.SQTcpClient;
	
    import org.osflash.signals.natives.NativeSignal;
	
	[SWF(width='800', height='600', frameRate="24")]
	
    public class Client extends Sprite {

		private var tcpClient:SQTcpClient;

		private var tcpRespoouter:SQResponceRouter;
		
		private var respRouter : SQResponceRouter;
		private var gui : SQGui;
        public function Client() {
			tcpClient = new SQTcpClient();
			tcpClient.connect(SQShared.SERVER_HOST, SQShared.SERVER_PORT);
			
			respRouter = new SQResponceRouter(tcpClient);
			var gameScene: SQGameScene = new SQGameScene(stage, respRouter, this);
			gui = new SQGui(stage, respRouter, gameScene.mouseHandler);

        }
		
	}
}

