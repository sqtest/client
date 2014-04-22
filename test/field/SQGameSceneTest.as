package field  {
    
    import asunit.asserts.*;
    import asunit.framework.IAsync;
    import flash.display.Sprite;

    public class SQGameSceneTest {

        [Inject]
        public var async:IAsync;

        [Inject]
        public var context:Sprite;

        private var instance:SQGameScene;

        [Before]
        public function setUp():void {
            instance = new SQGameScene();
        }

        [After]
        public function tearDown():void {
            instance = null;
        }

        [Test]
        public function shouldBeInstantiated():void {
            assertTrue("instance is SQGameScene", instance is SQGameScene);
        }
    }
}

