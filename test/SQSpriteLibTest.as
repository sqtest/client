package  {
    
    import asunit.asserts.*;
    import asunit.framework.IAsync;
    import flash.display.Sprite;

    public class SQSpriteLibTest {

        [Inject]
        public var async:IAsync;

        [Inject]
        public var context:Sprite;

        private var instance:SQSpriteLib;

        [Before]
        public function setUp():void {
            instance = new SQSpriteLib();
        }

        [After]
        public function tearDown():void {
            instance = null;
        }

        [Test]
        public function shouldBeInstantiated():void {
            assertTrue("instance is SQSpriteLib", instance is SQSpriteLib);
        }
    }
}

