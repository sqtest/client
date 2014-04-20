package helpers  {
    
    import asunit.asserts.*;
    import asunit.framework.IAsync;
    import flash.display.Sprite;

    public class SQXmlHelperTest {

        [Inject]
        public var async:IAsync;

        [Inject]
        public var context:Sprite;

        private var instance:SQXmlHelper;

        [Before]
        public function setUp():void {
            instance = new SQXmlHelper();
        }

        [After]
        public function tearDown():void {
            instance = null;
        }

        [Test]
        public function shouldBeInstantiated():void {
            assertTrue("instance is SQXmlHelper", instance is SQXmlHelper);
        }
    }
}

