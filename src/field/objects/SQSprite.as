package field.objects {
	import as3isolib.display.IsoSprite;
	
	import field.SQTemplates;
	
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.text.TextField;
	import flash.utils.Timer;
	
	import helpers.SQXmlHelper;
	
	import network.SQResponceRouter;
	
	import org.osflash.signals.natives.NativeSignal;

    public class SQSprite extends IsoSprite{
		public var mouseDown : NativeSignal; 
		public var mouseUp : NativeSignal;
		public var mouseMove : NativeSignal;
		public var mouseClick : NativeSignal;
		public var mouseRollOver : NativeSignal;
		public var mouseRollOut : NativeSignal;
		
		public var contract : int;
		public var time : int;
		public var objId : int;
		public var template : String;
		
		public var stage: Stage;
		public var respRouter : SQResponceRouter;
		
		public var status : int = 2;
		
		private var _timer : Timer; 
		
		private var statuses : Array = ["Простаивает", "Готово к сбору"]
		
        public function SQSprite() {
			mouseDown = new NativeSignal(this,MouseEvent.MOUSE_DOWN, MouseEvent);
			mouseUp = new NativeSignal(this,MouseEvent.MOUSE_UP, MouseEvent);
			mouseClick = new NativeSignal(this,MouseEvent.CLICK, MouseEvent); 
			mouseMove = new NativeSignal(this,MouseEvent.MOUSE_MOVE, MouseEvent);
			mouseRollOver = new NativeSignal(this,MouseEvent.ROLL_OVER, MouseEvent); 
			mouseRollOut = new NativeSignal(this,MouseEvent.ROLL_OUT, MouseEvent);
			
			this._timer = new Timer(1000); 
			this._timer.addEventListener(TimerEvent.TIMER, intervalUpdate);
			this._timer.start();
        }
		
		public function reset(i: String) : void{
			if(i==this.id) {
				this.status = 0;

				if(SQTemplates.templates[template]['autotask']>0 && status === 0)
					respRouter.client.sendRequest({action : 'ActionStartContract', params : {
						id : this.id, 
						contractid: String(SQTemplates.templates[template]['autotask'])
					}});

				updateStatus();
			}
		}
		
		public function contractStart(xml: XMLList) : void {
			if(xml.result.id==this.id) {
				this.status = 2;
				contract=xml.result.contractid;
				time = xml.result.time;
				this._timer.start();
			}
		}
		
		public function moveObject(xml: XMLList) : void {
			if(xml.result.id==this.id) {
				this.moveTo(xml.result.x*SQShared.GRID_CELL_SIZE, xml.result.y*SQShared.GRID_CELL_SIZE, 0);
			}
		}

		public function sellObject(xml: XMLList) : void {
			if(xml.result.id==this.id) {
				this.sprites=[];
				respRouter.client.sendRequest({action : 'ActionMoneyCheck'});
			}
		}
		
		private function intervalUpdate(e : TimerEvent): void {
			if(this.sprites[1]!=null) {
				var currentDate : Date = new Date();
				var totalSec : int = time - Math.round(currentDate.getTime()/1000);
				if(totalSec <= 0) {
					e.target.stop();
					if(contract > 0)
						this.status=1;
					else
						this.status=0;
					this.updateStatus();
				} else {
					var sec : int = totalSec % 60;
					var min : int = Math.ceil(totalSec / 60);
					if(sec==0 && totalSec>=60) min +=1; else min -=1;
					var timeStr : String = 'Время до сбора ';
					if(min<10) timeStr +='0';
					timeStr += min+':';
					if(sec<10) timeStr +='0';
					timeStr += sec;
					this.sprites[1].text = timeStr;
				}
			}
		}
		
		public function checkContract(): void {
			trace(this.status);
			if(this.status==1)
				respRouter.client.sendRequest({action : 'ActionCheckContract', params : {id : this.id}});
		}
		
		public function positionSave(x:int, y: int) : void{
			respRouter.client.sendRequest({action : 'ActionMoveObject', params : {id : this.id, x: x, y: y}});
		}
		
		public function updateStatus() : void {
			if(this.sprites.length==1) {
				this.sprites.push(new TextField());
				this.sprites[1].textColor =  0xFFFFFF;
				this.sprites[1].height = 20;
				this.sprites[1].background = true;
				this.sprites[1].backgroundColor = 0xFF0000;
				this.sprites[1].mouseEnabled = false;
				if(SQTemplates.templates[template]['autotask']<0)
					this.sprites[1].width = 0;
				else
					this.sprites[1].width = 120;
			}
			
			if(statuses[status]==null || SQTemplates.templates[template]['autotask']===-1) 
				this.sprites[1].text = "";
			else
				this.sprites[1].text = statuses[status];

		}
    }
}

