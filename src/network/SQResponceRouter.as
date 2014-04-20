package network {
	import flash.events.EventDispatcher;

    public class SQResponceRouter {

        public function SQResponceRouter(tcpClient : SQTcpClient) {
			tcpClient.addEventListener(SQTcpClientEvent.ONDATARECEIVED, routeResponce);
        }
		
		public function routeResponce(e: SQTcpClientEvent) : void {
			var xml : XML = new XML(e.data);
			if(xml.action!=undefined) {
				switch(xml.action.toString()) {
					case "ActionAuth":
						if(xml.params.result == true)
							SQShared.gameScene.loadField();
						break;
					case "ActionLoadField":
						SQShared.gameScene.buildField(xml.params);
						break;
					default:
						trace(xml.action);
				}
//				if(xml.action == 'ActionAuth')
//				{
//					if(xml.params.result == true)
//						SQShared.gameScene.loadField();
//				} else if(xml.action == 'ActionAuth'
			}
		}
    }
}

