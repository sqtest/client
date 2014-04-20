package network  {
    
    import asunit.asserts.*;
    import asunit.framework.IAsync;
    import flash.display.Sprite;

    public class SQTcpClientEventTest {

        [Inject]
        public var async:IAsync;

        [Inject]
        public var context:Sprite;

        private var instance:SQTcpClientEvent;

        [Before]
        public function setUp():void {
            instance = new SQTcpClientEvent();
        }

        [After]
        public function tearDown():void {
            instance = null;
        }

        [Test]
        public function shouldBeInstantiated():void {
            assertTrue("instance is SQTcpClientEvent", instance is SQTcpClientEvent);
        }
    }
}

