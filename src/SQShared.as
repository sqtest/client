package {
	import as3isolib.display.IsoView;
	import as3isolib.display.scene.IsoGrid;
	import as3isolib.display.scene.IsoScene;
	
	import flash.display.Sprite;
	import flash.display.Stage;
	
	import game.SQGameScene;
	
	import network.SQResponceRouter;
	import network.SQTcpClient;

    public class SQShared {
		
		static public const GRID_CELL_SIZE:int = 50;
		
		static public var ROOT : Sprite;
		static public var STAGE: Stage;
		
		static public var gameScene: SQGameScene = new SQGameScene();

		static public var TCPClient : SQTcpClient = new SQTcpClient();
		static public var ResponceRouter: SQResponceRouter;
		
		static public var SCENE : IsoScene = new IsoScene();
		static public var GRID : IsoGrid  = new IsoGrid();
		static public var VIEW : IsoView = new IsoView();
    }
}

