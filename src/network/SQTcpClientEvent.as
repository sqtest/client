package network {
	import flash.events.Event;
	public dynamic class SQTcpClientEvent extends Event
	{
		static public const ONCONNECTED                     :String = "onConnected";
		static public const ONDATARECEIVED                  :String = "onDataReceived";	
		
		public function TcpClientEvent(type:String, data:Object, bubbles:Boolean=false, cancelable:Boolean=false) {
			super(type, bubbles, cancelable) ;
			for(var name:String in data) this[name] = data[name];
		}
	}
}

