package game  {
    
    import asunit.asserts.*;
    import asunit.framework.IAsync;
    import flash.display.Sprite;

    public class SQMouseEventHandlerTest {

        [Inject]
        public var async:IAsync;

        [Inject]
        public var context:Sprite;

        private var instance:SQMouseEventHandler;

        [Before]
        public function setUp():void {
            instance = new SQMouseEventHandler();
        }

        [After]
        public function tearDown():void {
            instance = null;
        }

        [Test]
        public function shouldBeInstantiated():void {
            assertTrue("instance is SQMouseEventHandler", instance is SQMouseEventHandler);
        }
    }
}

