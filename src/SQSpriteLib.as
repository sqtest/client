package {
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.net.URLRequest;

    public class SQSpriteLib {
		public static var sprites: Object = new Object;
		private var _loader: Loader;
		private var _id: String;
		
        public function load(id : String, callBack : Function) : void {
			if(sprites[id]==null) {
				_loader = new Loader();
				_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e : Event) : void{
					var li:LoaderInfo = LoaderInfo(e.target);
					if(sprites[id]==null) 
						sprites[id] = li.content;
	
					callBack(sprites[id]);
				});
				var url: String = 'http://' + SQShared.SERVER_HOST+ '/'+id;
				_loader.load(new URLRequest(url));
			}
			else callBack(sprites[id]);
		}
    }
}

