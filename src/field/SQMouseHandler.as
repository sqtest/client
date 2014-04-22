package field
{
	import as3isolib.geom.IsoMath;
	import as3isolib.geom.Pt;
	
	import eDpLib.events.ProxyEvent;
	
	import field.objects.SQGrid;
	import field.objects.SQScene;
	import field.objects.SQSprite;
	import field.objects.SQView;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.events.StatusEvent;
	import flash.geom.Point;
	import flash.utils.getQualifiedClassName;

	public class SQMouseHandler
	{
		private var isMousePressed : Boolean = false;
		private var _panPt: Point
		public var stage : Stage;
		public var view : SQView; 
		public var grid : SQGrid; 
		public var isStageMove : Boolean = false;
		private var is_click : Boolean = false;
		private var _target : SQSprite;
		private var p:Pt;
		public var scene : SQScene;

		public function mouseDownHandler(e: *) : void {
			is_click = true;
			if (!isStageMove && getQualifiedClassName(e.target)=="field.objects::SQSprite") {
				_target = e.target as SQSprite;
				_target.container.mouseEnabled = false;
			} else _target = null;
			_panPt = stage.globalToLocal(new Point(stage.mouseX, stage.mouseY));
			isMousePressed = true;
		}
		
		public function switchMove() {
			isStageMove = !isStageMove;
			if(isStageMove) {
				scene.container.mouseEnabled = true;
				view.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
				view.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
				view.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
				view.addEventListener(MouseEvent.CLICK, mouseClickHandler);

				grid.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
				grid.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
				grid.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
				grid.removeEventListener(MouseEvent.CLICK, mouseClickHandler);

			} else {
				
				grid.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
				grid.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
				grid.addEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
				grid.addEventListener(MouseEvent.CLICK, mouseClickHandler);
				
				view.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
				view.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
				view.removeEventListener(MouseEvent.MOUSE_MOVE, mouseMoveHandler);
				view.removeEventListener(MouseEvent.CLICK, mouseClickHandler);

			}
		}
		
		public function mouseUpHandler(e:*) : void {
			is_click = true;
			isMousePressed = false;
			if(_target !== null) {
				_target.container.mouseEnabled = true;
				_target.positionSave(Math.floor(p.x/SQShared.GRID_CELL_SIZE), Math.floor(p.y/SQShared.GRID_CELL_SIZE))
			}
		}

		public function mouseMoveHandler(e :*) : void {
			if(isMousePressed) {
				is_click = false;
				if(isStageMove) {
					view.pan(_panPt.x-stage.mouseX, _panPt.y-stage.mouseY);
					_panPt.x = stage.mouseX ;
					_panPt.y = stage.mouseY;
				} else {
					var me : MouseEvent = MouseEvent(e.targetEvent);
					p = new Pt(me.localX, me.localY, 0);
					IsoMath.screenToIso(p);
					if(_target !== null) {
						_target.moveTo(Math.floor(p.x/SQShared.GRID_CELL_SIZE)*SQShared.GRID_CELL_SIZE,Math.floor(p.y/SQShared.GRID_CELL_SIZE)*SQShared.GRID_CELL_SIZE, 0);
					}
				}
			}
		}

		public function mouseClickHandler(e:*) : void {
			if(_target !== null)
				_target.container.mouseEnabled = true;
			
			if(is_click) {
				if (getQualifiedClassName(e.target)=="field.objects::SQSprite") {
					e.target.checkContract();
				}
			}
			is_click = false;
			isMousePressed = false;
		}
	}
}