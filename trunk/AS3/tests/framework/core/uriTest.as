package core
{
    import buRRRn.ASTUce.framework.TestCase;
    
    public class uriTest extends TestCase
    {
        public function uriTest(name:String="")
        {
            super(name);
        }
        
        public function testBasic():void
        {
            var u:uri = new uri( "http://www.google.com" );
        }
        
    }
}