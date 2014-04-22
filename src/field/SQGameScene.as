package field {
	import as3isolib.geom.Pt;
	
	import eDpLib.events.ProxyEvent;
	
	import field.objects.SQGrid;
	import field.objects.SQScene;
	import field.objects.SQSprite;
	import field.objects.SQView;
	
	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import network.SQResponceRouter;

    public class SQGameScene {
		public var grid : SQGrid = new SQGrid();
		public var scene : SQScene = new SQScene();
		public var view : SQView = new SQView();
		public var stage : Stage;
		public var mouseHandler: SQMouseHandler;
		
		private var respRouter : SQResponceRouter;
		private var _sizeX : int;
		private var _sizeY : int;
		
		private var _hostContainer : DisplayObjectContainer;
		
        public function SQGameScene(stg : Stage, r: SQResponceRouter, h :DisplayObjectContainer) {
			_hostContainer = h;
			respRouter = r;
			stage = stg;
			mouseHandler = new SQMouseHandler();
			mouseHandler.stage = stage;
			
			respRouter.authSig.add(loadTemplates);
			respRouter.loadTemplatesSig.add(loadField)
			respRouter.loadFieldSig.add(buildField)
			respRouter.moneyCheckSig.add(moneyCheck);
				
			initScene();
        }
		
		public function initScene() : void
		{
			respRouter.client.sendRequest({action : 'ActionAuth', params : {fieldid : getFieldId()}});
		}
		
		public function moneyCheck() : void{
			respRouter.client.sendRequest({action : 'ActionMoneyCheck'});
		}
		
		public function loadTemplates() : void 
		{
			respRouter.client.sendRequest({action : 'ActionLoadTemplates'});
		}

		public function loadField(xml: XMLList) : void 
		{
			SQTemplates.addTemplates(xml);
			respRouter.client.sendRequest({action : 'ActionLoadField'});
		}
		
		public function buildField(xml: XMLList) : void{
			grid.setGridSize(xml.field.@sizex, xml.field.@sizey, 0	);
			grid.cellSize = SQShared.GRID_CELL_SIZE;
			grid.showOrigin = false;
			scene.addChild(grid);
			scene.hostContainer =  _hostContainer;
			
			mouseHandler.scene = scene;
			mouseHandler.grid = grid;
			mouseHandler.view = view;
			
			view.addScene(scene);
			view.setSize(stage.stageWidth,stage.stageHeight);

			_sizeX = xml.field.@sizex;
			_sizeY = xml.field.@sizey;

			view.centerOnPt(new Pt(
				_sizeX*SQShared.GRID_CELL_SIZE/2,
				_sizeY*SQShared.GRID_CELL_SIZE/2,
				0
			));
			
			mouseHandler.switchMove();
			
			stage.addChild(view);
			stage.addEventListener(Event.ENTER_FRAME, gameLoop);
			
			respRouter.guiSig.dispatch();
			respRouter.coinChangeSig.dispatch(String(xml.field.@coins));
			respRouter.popChangeSig.dispatch(String(xml.field.@population));
			respRouter.powChangeSig.dispatch(String(xml.field.@power));
			
			var lib:SQSpriteLib = new SQSpriteLib();
			var f : Function = function(texture:Bitmap) : void {
				generateMap(texture);
				for (var i:int=0; i<xml.field.children().length(); i++){
					placeObjects(xml.field.children()[i]);
				}
			}
			lib.loadSig.add(f);
			lib.load('grass');
		}
		
		public function placeObjects(xml : XML): void {
			var lib:SQSpriteLib = new SQSpriteLib();
			var f : Function = function(texture:Bitmap) : void {
				var duplicate:Bitmap = new Bitmap();
				duplicate.bitmapData = texture.bitmapData;
				duplicate.x = -duplicate.width/2;
				duplicate.y = 0;
				
				var sp: SQSprite = new SQSprite();
				sp.moveBy(xml.@x*SQShared.GRID_CELL_SIZE, xml.@y*SQShared.GRID_CELL_SIZE, 0);
				sp.sprites = [duplicate];
				sp.mouseClick.add(mouseHandler.mouseClickHandler);
				sp.mouseMove.add(mouseHandler.mouseMoveHandler);
				sp.mouseDown.add(mouseHandler.mouseDownHandler);
				sp.mouseUp.add(mouseHandler.mouseUpHandler);
				
				sp.template = xml.name();
				sp.contract = xml.@contract;
				sp.time = xml.@time;
				sp.id = xml.@id;
				sp.stage = stage;
				sp.respRouter = respRouter;
				sp.updateStatus();
				sp.respRouter.resetBuildingSig.add(sp.reset);
				sp.respRouter.contractStartSig.add(sp.contractStart);
				sp.respRouter.sellObjectSig.add(sp.sellObject);
				scene.addChild(sp);
				scene.render();
			}
				
			lib.loadSig.add(f);
			lib.load(xml.name());
		}
		
		private function generateMap(texture:Bitmap) : void{
			for (var i:int = 0; i < _sizeX; i++) 
			{
				for (var j:int = 0; j < _sizeY; j++) 
				{
					var duplicate:Bitmap = new Bitmap();
					duplicate.bitmapData = texture.bitmapData;
					duplicate.x = -duplicate.width/2;
					duplicate.y = 0;

					var sp: SQSprite = new SQSprite();
					sp.moveBy(i*SQShared.GRID_CELL_SIZE, j*SQShared.GRID_CELL_SIZE, 0);
					sp.sprites = [duplicate];
					sp.container.mouseEnabled = false;
					
					scene.addChild(sp);
				}
			}
		}

		private function gameLoop(e: Event) : void {
 			scene.render();			
		}
		
		private function getFieldId(): int {
			return 1;
		}

    }
}

