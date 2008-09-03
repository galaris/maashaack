
package system.core 
{
    import buRRRn.ASTUce.framework.TestCase;                    

    /**
     * @author eKameleon
     */
    public class RunnableTest extends TestCase 
    {

        public function RunnableTest(name:String = "")
        {
            super( name );
        }
        
        public function testInterface():void
        {
            
            var c:RunnableClass = new RunnableClass();
            
            assertTrue( c is Runnable ) ;
            
            try
            {
            	c.run() ;
            	fail( "The Runnable interface failed, the RunnableClass must throw an error") ;
            }
            catch( e1:Error )
            {
            	//assertEquals( e1.toString() , "run invoked 0" , "The Runnable interface failed.") ;
            }

            try
            {
                c.run(2,3,4) ;
                fail( "The Runnable interface failed, the RunnableClass must throw an error") ;
            }
            catch( e2:Error )
            {
                //assertEquals( e2.toString() , "run invoked 3" , "The Runnable interface failed.") ;
            }

            
        }
    
        
        
    }
}

import system.core.Runnable;

class RunnableClass implements Runnable
{

    public function RunnableClass()
    {
        //    
    }
    
    public function run(...arguments:Array):void
    {
    	throw new Error( "run invoked " + arguments.length ) ;
    }
}