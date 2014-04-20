package network {

	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.Socket;
	
	import helpers.SQXmlHelper;
	
	public class SQSocket extends EventDispatcher
	{
		private var sc:Socket;
		private var data:String;
		public function SQSocket() {
			sc = new Socket();
			initListeners();
		}
		
		private function initListeners():void {
			sc.addEventListener( ProgressEvent.SOCKET_DATA, manageEvent, false, 0, true );
			sc.addEventListener( Event.CONNECT, manageEvent, false, 0, true  );
			sc.addEventListener( Event.CLOSE, manageEvent, false, 0, true  );
			sc.addEventListener( IOErrorEvent.IO_ERROR, manageEvent, false, 0, true );
			sc.addEventListener( SecurityErrorEvent.SECURITY_ERROR, manageEvent, false, 0, true );
		}
		
		private function delListeners():void {
			sc.removeEventListener( ProgressEvent.SOCKET_DATA, manageEvent );
			sc.removeEventListener( Event.CONNECT, manageEvent  );
			sc.removeEventListener( Event.CLOSE, manageEvent  );
			sc.removeEventListener( IOErrorEvent.IO_ERROR, manageEvent );
			sc.removeEventListener( SecurityErrorEvent.SECURITY_ERROR, manageEvent );
		}
		
		public function connect( adress:String = 'localhost', port:int = 4444 ):void { sc.connect(  adress, port ); }
		public function disconnect():void { sc.close(); }
		
		public function sendData( data:String ):void {
			sc.writeUTFBytes( data );
			sc.flush();
		}
		
		public function getData( data:String ):void {
			this.data = data;
			dispatchEvent( new SQTcpClientEvent( SQTcpClientEvent.ONDATARECEIVED, { info:"data received from server", data:data } ) );
		}
		
		public function dispose():void {
			disconnect();
			delListeners();
		}
		
		public function get receivedData():String { return data; }
		
		private function manageEvent( evt:* ):void {
			switch( evt.type ) {
				case SecurityErrorEvent.SECURITY_ERROR : 
					break;
				case ProgressEvent.SOCKET_DATA :
					sc.writeUTFBytes( 'client deconnecte' );
					var d:String = sc.readUTFBytes( sc.bytesAvailable );
					getData( d );
					break;
				
				case Event.CONNECT :
					dispatchEvent( new SQTcpClientEvent( SQTcpClientEvent.ONCONNECTED, { info:"connected to the server" } ) );
					break; 
				
				case Event.CLOSE :
					break;
				
				case IOErrorEvent.IO_ERROR :
					break;
				
				default : break;
			}
		}
		
		public function sendRequest(params : Object) :void {
			var xml : XML = SQXmlHelper.objectToXML(params);
			var requestString: String = xml.toString().replace(/\n/g,'');
			sendData(requestString+"\n");
		}
	}
}
