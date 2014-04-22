package {
	import flash.display.Bitmap;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import flashx.textLayout.formats.BaselineOffset;
	
	import org.osflash.signals.Signal;

    public class SQSpriteLib {
		public static var sprites: Object = new Object;
		
		public var loadSig :Signal;
		
		private var _loader: Loader;
		private var _id: String;
		
		public function SQSpriteLib() : void {
			loadSig = new Signal(Bitmap);
			_loader = new Loader();	
		}
		
        public function load(id : String) : void {
			if(sprites[id]==null) {
				_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function(e : Event) : void{
					var li:LoaderInfo = LoaderInfo(e.target);
					if(sprites[id]==null) 
						sprites[id] = li.content;
					loadSig.dispatch(sprites[id]);
				});
				var url: String = 'http://' + SQShared.SERVER_HOST+ '/'+id+'.png';
				_loader.load(new URLRequest(url));
			}
			else loadSig.dispatch(sprites[id]);
		}
    }
}

