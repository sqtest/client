package
{
	import eDpLib.events.ProxyEvent;
	
	import field.SQMouseHandler;
	import field.SQTemplates;
	import field.objects.SQSprite;
	
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import network.SQResponceRouter;

	public class SQGui
	{
		private var stage : Stage;
		private var respRouter : SQResponceRouter;
		private var panel: MovieClip = new MovieClip();
		
		private var coin: TextField;
		private var population: TextField;
		private var power: TextField;
		
		private var mouseHandler : SQMouseHandler; 
		
		public function SQGui(st : Stage, r :SQResponceRouter, h: SQMouseHandler)
		{
			mouseHandler = h;
			stage = st;
			respRouter = r;
			respRouter.alertSig.add(alert);
			respRouter.guiSig.add(drawPanel);
		}
		
		public function alert(s: String) : void{
			var mc1: MovieClip = new MovieClip();
			mc1.graphics.lineStyle(2);
			mc1.graphics.beginFill(0x00ff64);
			mc1.graphics.drawRect(0,0, stage.stageWidth, stage.stageHeight);
			stage.addChild(mc1); 
			mc1.addEventListener(MouseEvent.CLICK, function(e: MouseEvent): void {
				stage.removeChild(mc1);
			});
		}
		
		private function addBlock(x: int, y: int) : TextField {
			var up:Sprite = new Sprite();
			up.graphics.lineStyle(1, 0x000000);
			up.graphics.beginFill(0xCCFF00);
			up.graphics.drawRect(x, y,100,30);
			stage.addChild(up);

			var text:TextField = new TextField();
			text.y = y +5; 
			text.x = x +5;
			text.width=up.width-5;
			text.height=up.height-5;
			up.addChild(text);
			return text;
		}
		
		
		
		private function drawPanel() : void {
			addButton(5, 5, 'Создать', function(e: MouseEvent):void{
				var up:Sprite = new Sprite();
				up.graphics.lineStyle(1, 0x000000);
				up.graphics.beginFill(0xCCFF00);
				up.graphics.drawRect(0,0,stage.width,stage.height);
				stage.addChild(up);
				
				
				var lib:SQSpriteLib = new SQSpriteLib();
				var f : Function = function(texture:Bitmap) : void {
					var duplicate:Bitmap = new Bitmap(); 
					duplicate.bitmapData = texture.bitmapData;
					duplicate.x = 10;
					duplicate.y = 0;
					up.addChild(duplicate);
				}
				lib.loadSig.add(f);
				lib.load('grass');

				
			});
			addButton(5, 40, 'Переместить', function(e: MouseEvent) :void{
				mouseHandler.switchMove();
			});
			addButton(5, 75, 'Продать', function(e: MouseEvent):void{
			});
			
			coin = addBlock(stage.width -330, 5);
			population = addBlock(stage.width -220, 5);
			power = addBlock(stage.width -110, 5);

			respRouter.coinChangeSig.add(onCoinChnge);
			respRouter.popChangeSig.add(function(s: String): void {
				population.text = "Pop: "+s;
			});
			respRouter.powChangeSig.add(function(s: String): void {
				power.text = "Pow: "+s;
			});
		}
		
		private function onCoinChnge(s: String) : void {
			coin.text = "Coin: "+s; trace(1);
		}
		
		public function addButton(x: int, y: int, capt : String, cb : Function) : void{
			var up:Sprite = new Sprite();
			up.graphics.lineStyle(1, 0x000000);
			up.graphics.beginFill(0xCCFF00);
			up.graphics.drawRect(x,y,100,30);
			
			var over:Sprite = new Sprite();
			over.graphics.lineStyle(1, 0x000000);
			over.graphics.beginFill(0x00CCFF);
			over.graphics.drawRect(x,y,100,30);

			var button: SimpleButton=new SimpleButton(up,over,over,up);
			button.useHandCursor  = true;
			
			var text:TextField = new TextField();
			text.text = capt;
			text.y = y +5; 
			text.x = x +5;
			text.width=up.width-5;
			text.height=up.height-5;
			up.addChild(text);
			
			text = new TextField();
			text.text = capt;
			text.y = y +5; 
			text.x = x +5;
			text.width=over.width-5;
			text.height=over.height-5;
			over.addChild(text);

			button.addEventListener(MouseEvent.CLICK, cb);
			stage.addChild( button );
		}
	}
}