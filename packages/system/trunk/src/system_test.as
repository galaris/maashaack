package
{
    import flash.display.Sprite;
    
    import system.metadata;

    [SWF(width="400", height="400", backgroundColor="0xffffff", frameRate="24", pageTitle="system", scriptRecursionLimit="1000", scriptTimeLimit="60")]
    public class system_test extends Sprite
    {
        public function system_test()
        {
            super();
            
            trace( "system" );
            metadata.about( true, true );
        }
    }
}