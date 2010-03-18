package
{
    import flash.display.Sprite;
    
    import system.terminals.console;
    
    [SWF(width="400", height="400", backgroundColor="0xffffff", frameRate="24", pageTitle="system.terminals", scriptRecursionLimit="1000", scriptTimeLimit="60")]
    public class system_terminals extends Sprite
    {
        public function system_terminals()
        {
            trace( "system.terminals" );
            
            //basic usage
            console.write( "hello {0}", "world" );
            console.writeLine( " & bonjour {0} {1}", "le", "monde" );
            console.writeLine( "{0} {1} {2}", 1, 2, 3 );
            console.write( 1, 2, 3 );
            console.writeLine( 4, 5, 6 );
        }
    }
}
