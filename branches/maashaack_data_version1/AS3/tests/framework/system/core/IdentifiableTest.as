
package system.core 
{
    import buRRRn.ASTUce.framework.TestCase;            

    public class IdentifiableTest extends TestCase 
    {

        public function IdentifiableTest(name:String = "")
        {
            super( name );
        }
        
        public function testInterface():void
        {
            
            var c:IdentifiableClass = new IdentifiableClass( 9999 );
            
            assertTrue( c is Identifiable ) ;
            
            assertEquals( c.id , 9999 ) ;
            
        }         
        
    }
}

import system.core.Identifiable;

class IdentifiableClass implements Identifiable
{

    public function IdentifiableClass( index:uint=0 )
    {
        this.id = index ;    
    }
    
    private var _id:uint ;

    public function get id():*
    {
    	return _id ;
    }
    
    public function set id(id:*):void
    {
    	_id = id ;
    }
}