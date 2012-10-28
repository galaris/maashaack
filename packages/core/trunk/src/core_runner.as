package
{
    import flash.display.Sprite;
    
    import library.ASTUce.Runner;
    import core.AllTests;
    
    [SWF(width="400", height="400", backgroundColor="0xffffff", frameRate="24", pageTitle="core tests runner", scriptRecursionLimit="1000", scriptTimeLimit="60")]
    public class core_runner extends Sprite
    {
        public function core_runner()
        {
            super();
            
            library.ASTUce.metadata.config.maxColumn           = 64 ;
            library.ASTUce.metadata.config.showConstructorList = false ;
            
            Runner.main( core.AllTests.suite() );
        }
    }
}