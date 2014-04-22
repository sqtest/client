package network {
	import flash.events.EventDispatcher;
	
	import org.osflash.signals.Signal;

    public class SQResponceRouter {
		public var authSig : Signal;
		public var loadFieldSig : Signal;
		public var loadTemplatesSig : Signal;
		public var moneyCheckSig : Signal;
		public var resetBuildingSig : Signal;
		public var alertSig : Signal;
		public var guiSig : Signal;

		public var coinChangeSig : Signal;
		public var popChangeSig : Signal;
		public var powChangeSig : Signal;

		public var contractStartSig : Signal;
		public var moveObjectSig : Signal;
		public var sellObjectSig : Signal;
		
		public var client : SQTcpClient;
		
        public function SQResponceRouter(tcpClient : SQTcpClient) {
			client =  tcpClient;
			client.addEventListener(SQTcpClientEvent.ONDATARECEIVED, routeResponce);
			authSig = new Signal();
			loadTemplatesSig = new Signal(XMLList);
			loadFieldSig = new Signal(XMLList);
			moneyCheckSig = new Signal();
			resetBuildingSig = new Signal(String);
			alertSig  = new Signal(String);
			guiSig  = new Signal();
			
			contractStartSig = new Signal(XMLList);
			moveObjectSig = new Signal(XMLList);
			sellObjectSig = new Signal(XMLList);
			
			coinChangeSig = new Signal(String);
			popChangeSig = new Signal(String);
			powChangeSig = new Signal(String);
        }
		
		public function routeResponce(e: SQTcpClientEvent) : void {
			var xml : XML = new XML(e.data);
			if(xml.action!=undefined) {
				switch(xml.action.toString()) {
					case "ActionAuth":
						if(xml.params.result == true)
							authSig.dispatch();
						break;
					case "ActionLoadTemplates":
						loadTemplatesSig.dispatch(xml.params);
						break;
					case "ActionLoadField":
						loadFieldSig.dispatch(xml.params);
						break;
					case "ActionCheckContract":
						if(xml.params.result.result == true) {
							moneyCheckSig.dispatch();
							resetBuildingSig.dispatch(String(xml.params.result.id));
						}
						break;
					case "ActionMoneyCheck":
						if(xml.params.result.result == true) {
							coinChangeSig.dispatch(String(xml.params.result.coins));
							popChangeSig.dispatch(String(xml.params.result.population));
							powChangeSig.dispatch(String(xml.params.result.power));
						}
					case "ActionStartContract":
						if(xml.params.result.result == true) {
							contractStartSig.dispatch(xml.params);
						}
						
					case "ActionMoveObject":
						if(xml.params.result.result == true) {
							moveObjectSig.dispatch(xml.params);
						}
						break;
					case "ActionSellObject":
						if(xml.params.result.result == true) {
							sellObjectSig.dispatch(xml.params);
						}
						break;
					case "ActionAlert":
						alertSig.dispatch(String(xml.params.result.message));
						break;
					default:
						trace(xml);
				}
			} else trace(xml);
		}
    }
}

