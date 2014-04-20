package {
	import flash.display.Loader;
	import flash.events.Event;
	import flash.net.URLRequest;

    public class SQSpriteLib {
		public static var sprites: Object = new Object;
		private var _loader: Loader;
		private var _id: String;
		
        public function load(id : String) : void {
			if(sprites[id]==null) {
				_loader = new Loader();
				
				_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadComplite);
				_loader.load(new URLRequest(id));
			}
		}
		
		private function loadComplite(e : Event) : void {
			
		}
    }
}

