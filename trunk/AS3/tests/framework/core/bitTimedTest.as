package core
{
    import buRRRn.ASTUce.extensions.TimedTestCase;

    public class bitTimedTest extends TimedTestCase
    {
        public function bitTimedTest(name:String="", maxElapsedTime:int = 400 )
        {
            super(name, maxElapsedTime);
        }
        
        public function testShift():void
        {
            var b:bit = new bit( uint.MAX_VALUE );
            var max:uint = 1000;
            
            for( var i:uint = 0; i<max; i++ )
            {
                while( b.valueOf() != 0 )
                {
                    b.shift();
                }
                assertEquals( "0000", b.toString() );
                
                if( i != (max-1) )
                {
                    b = new bit( uint.MAX_VALUE );
                }
            }
            //trace( "elapsed: " + elapsedTime );
        }
        
    }
}