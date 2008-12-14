/*
  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at
  http://www.mozilla.org/MPL/
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the
  License.
  
  The Original Code is [maashaack framework].
  
  The Initial Developers of the Original Code are
  Zwetan Kjukov <zwetan@gmail.com> and Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developers are Copyright (C) 2006-2009
  the Initial Developers. All Rights Reserved.
  
  Contributor(s):
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
*/

package system.data.collections 
{
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.data.Collection;
    import system.data.Typeable;
    import system.data.Validator;    

    public class TypedCollectionTest extends TestCase 
    {

        public function TypedCollectionTest(name:String = "")
        {
            super( name );
        }
        
        // test constructor
        
        public function testConstructorBasic():void
        {
        	
        	var co:Collection = new ArrayCollection() ;
        	var tc:TypedCollection ;
        	
        	// 01 - basic test
            tc = new TypedCollection( String , co ) ;
            assertNotNull(tc, "01 - TypedCollection constructor failed.") ;
        }
        
        public function testConstructorTypeArgument():void
        {

            var co:Collection = new ArrayCollection() ;
            var tc:TypedCollection ;
                    	
            tc = new TypedCollection( String, co ) ;
            assertEquals( tc.type , String , "01 - TypedCollection constructor failed with a specific type argument in this constructor.") ;

            tc = new TypedCollection( null , co ) ;
            assertNull( tc.type , "02 - TypedCollection constructor failed with a specific type argument in this constructor.") ;

            tc = new TypedCollection( [] , co ) ; // 
            assertNull( tc.type , "03 - TypedCollection constructor failed with a specific type argument in this constructor, other type, must use a Class or a Function value.") ;

        }
        
        public function testConstructorCollectionArgument():void
        {
        	
            
            var co:Collection = new ArrayCollection() ;
            var tc:TypedCollection ;        	
        	
            // 01 - test "collection" argument is null
            try
            {
                tc = new TypedCollection( String, null ) ;
                fail( "01-01 - TypedCollection constructor failed." ) ;
            }
            catch( e:Error )
            {
                assertTrue( e is ArgumentError , "01-02 - TypedCollection constructor failed." ) ;
                assertEquals( e.message , "The passed-in 'collection' argument not must be 'null' or 'undefined'.", "01-03 - TypedCollection constructor failed." ) ;
            }        	
                    	
            // 02 - basic test with a no empty Collection
            
            co.add("item1") ;
            co.add("item2") ;
            
            tc = new TypedCollection( String , co ) ;
            assertNotNull(tc, "02-01 - TypedCollection constructor failed with a no empty collection of String values.") ;        	
            assertEquals(tc.size(), co.size() , "02-02 - TypedCollection constructor failed with a no empty collection of String values.") ;
        	
            // 03 - test "collection" argument contains an invalid value
            co.add( 1 ) ;
            try
            {
                tc = new TypedCollection( String, co ) ;
                fail( "03-01 - TypedCollection constructor failed." ) ;
            }
            catch( e:Error )
            {
                assertTrue( e is TypeError , "03-02 - TypedCollection constructor failed." ) ;
                assertEquals( e.message , "system.data.collections.TypedCollection.validate(1) is mismatch.", "03-03 - TypedCollection constructor failed." ) ;
            }
                

        }
        
        public function testInterface():void
        {
            var co:Collection = new ArrayCollection() ;
            var tc:TypedCollection ;
            
            // 01 - basic test
            tc = new TypedCollection( String , co ) ;
            
            assertTrue( tc is Collection , "01 - The TypedCollection class must implement the Collection interface." ) ;
            assertTrue( tc is Typeable   , "02 - The TypedCollection class must implement the Typeable interface." ) ;
            assertTrue( tc is Validator  , "03 - The TypedCollection class must implement the Validator interface." ) ;
        }

    }
}
