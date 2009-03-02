package core
{
    import buRRRn.ASTUce.framework.TestCase;    

    public class versionTest extends TestCase
    {
        public function versionTest(name:String="")
        {
            super(name);
        }
        
        public function testBasic():void
        {
            var v:version = new version();
            assertNotNull(v) ;
        }
        
    }
}