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
  Portions created by the Initial Developers are Copyright (C) 2006-2011
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

package system.data.sets 
{
    import library.ASTUce.framework.ArrayAssert;
    import library.ASTUce.framework.TestCase;
    
    import system.data.Collection;
    import system.data.Iterator;
    import system.data.Set;
    import system.data.Typeable;
    import system.data.Validator;
    
    public class TypedSetTest extends TestCase 
    {
        public function TypedSetTest(name:String = "")
        {
            super( name );
        }
        
        // test constructor
        
        public function testConstructorBasic():void
        {
            var co:Set = new ArraySet() ;
            var tc:TypedSet = new TypedSet( String , co ) ;
            assertNotNull(tc, "TypedSet constructor failed.") ;
        }
        
        public function testConstructorTypeArgument():void
        {
            var se:Set = new ArraySet() ;
            var tc:TypedSet ;
                        
            tc = new TypedSet( String, se ) ;
            assertEquals( tc.type , String , "01 - TypedSet constructor failed with a specific type argument in this constructor.") ;
            
            tc = new TypedSet( null , se ) ;
            assertNull( tc.type , "02 - TypedSet constructor failed with a specific type argument in this constructor.") ;
            
            tc = new TypedSet( [] , se ) ; // 
            assertNull( tc.type , "03 - TypedSet constructor failed with a specific type argument in this constructor, other type, must use a Class or a Function value.") ;
        }
        
        public function testConstructorCollectionArgument():void
        {
            var se:Set = new ArraySet() ;
            var tc:TypedSet ;
            
            // 01 - test "collection" argument is null
            try
            {
                tc = new TypedSet( String, null ) ;
                fail( "01-01 - TypedSet constructor failed." ) ;
            }
            catch( e:Error )
            {
                assertTrue( e is ArgumentError , "01-02 - TypedSet constructor failed." ) ;
                assertEquals( e.message , "The passed-in 'collection' argument not must be 'null' or 'undefined'.", "01-03 - TypedSet constructor failed." ) ;
            }
            
            // 02 - basic test with a no empty Collection
            
            se.add("item1") ;
            se.add("item2") ;
            
            tc = new TypedSet( String , se ) ;
            assertNotNull(tc, "02-01 - TypedSet constructor failed with a no empty collection of String values.") ;            
            assertEquals(tc.size(), se.size() , "02-02 - TypedSet constructor failed with a no empty collection of String values.") ;
            
            // 03 - test "collection" argument contains an invalid value
            se.add( 1 ) ;
            try
            {
                tc = new TypedSet( String, se ) ;
                fail( "03-01 - TypedSet constructor failed." ) ;
            }
            catch( e:Error )
            {
                assertTrue( e is TypeError , "03-02 - TypedSet constructor failed." ) ;
                assertEquals( e.message , "TypedSet.validate(1) is mismatch.", "03-03 - TypedSet constructor failed." ) ;
            }
        }
        
        public function testInterface():void
        {
            var se:Set = new ArraySet() ;
            var tc:TypedSet ;
            
            // 01 - basic test
            tc = new TypedSet( String , se ) ;
            
            assertTrue( tc is Collection , "01 - The TypedSet class must implement the Collection interface." ) ;
            assertTrue( tc is Typeable   , "02 - The TypedSet class must implement the Typeable interface." ) ;
            assertTrue( tc is Validator  , "03 - The TypedSet class must implement the Validator interface." ) ;
        }
        
        // test methods and attributes
        
        public function testType():void
        {
            var se:Set = new ArraySet() ;
            
            var tc:TypedSet = new TypedSet( String , se ) ;
            assertEquals( tc.type , String , "01 - The TypedSet type property failed." ) ;
            
            tc.type = Number ;
            assertEquals( tc.type , Number , "02 - The TypedSet type property failed." ) ;
            
            var clazz:Function = function():void {} ;
            tc.type = clazz ;
            assertEquals( tc.type , clazz , "03 - The TypedSet type property failed." ) ;
            
            tc.type = null ;
            assertNull( tc.type , "04 - The TypedSet type property failed." ) ;
            
            tc.type = 2 ;
            assertNull( tc.type , "05 - The TypedSet type property failed." ) ;
        }
        
        public function testAdd():void
        {
            var se:Set = new ArraySet() ;
            
            var tc:TypedSet = new TypedSet( String , se ) ;
            
            assertTrue( tc.add("item1") , "01-01 - The TypedSet add method failed." ) ;
            assertEquals( tc.size() , 1 , "01-02 - The TypedSet add method failed." ) ;
            
            try
            {
                tc.add(3) ;
                fail("02-01 - The TypedSet add method failed.") ;
            }
            catch( e:Error )
            {
                assertTrue( e is TypeError , "02-02 - The TypedSet add method failed.") ;
                assertEquals( e.message, "TypedSet.validate(3) is mismatch." , "02-03 - The TypedSet add method failed." ) ;
            }
        }
        
        public function testClear():void
        {
            var se:Set = new ArraySet(["item1", "item2"]) ;
            var tc:TypedSet = new TypedSet( String , se ) ;
            tc.clear() ;
            assertEquals( tc.size() , 0 , "The TypedSet clear method failed." ) ;
        }
        
        public function testClone():void
        {
            var se:Set = new ArraySet(["item1", "item2"]) ;
            var tc:TypedSet = new TypedSet( String , se ) ;
            var clone:TypedSet = tc.clone() as TypedSet ;
            assertNotNull( clone , "01 - The TypedSet clone method failed." ) ;
            assertEquals( tc.size() , clone.size() , "02 - The TypedSet clone method failed." ) ;
        } 
        
        public function testGet():void
        {
            var se:Set = new ArraySet(["item1", "item2"]) ;
            var tc:TypedSet = new TypedSet( String , se ) ;
            assertEquals( tc.get(0) , "item1" , "The TypedSet get method failed." ) ;
        }
        
        public function testIndexOf():void
        {
            var se:Set = new ArraySet(["item1", "item2"]) ;
            var tc:TypedSet = new TypedSet( String , se ) ;
            assertEquals( tc.indexOf("item2") , 1 , "01 - The TypedSet indexOf method failed." ) ;
            assertEquals( tc.indexOf("item4") , -1 , "02 - The TypedSet indexOf method failed." ) ;
        } 
        
        public function testIsEmpty():void
        {
            var se:Set = new ArraySet(["item1", "item2"]) ;
            var tc:TypedSet = new TypedSet( String , se ) ;
            assertFalse(tc.isEmpty() , "01 - The TypedSet isEmpty method failed." ) ;
            tc.clear() ;
            assertTrue(tc.isEmpty() , "02 - The TypedSet isEmpty method failed." ) ;
        } 
        
        public function testIterator():void
        {
            var se:Set = new ArraySet(["item1", "item2"]) ;
            var tc:TypedSet = new TypedSet( String , se ) ;
            var it:Iterator = tc.iterator() ;
            assertNotNull( it, "The TypedSet iterator method failed." ) ;
        }          
        
        public function testRemove():void
        {
            var se:Set = new ArraySet(["item1", "item2"]) ;
            var tc:TypedSet = new TypedSet( String , se ) ;
            
            assertTrue( tc.remove("item1"), "The TypedSet remove method failed." ) ;
            assertFalse( tc.remove("item4"), "The TypedSet remove method failed." ) ;
        } 
        
        public function testSize():void
        {
            var se:Set = new ArraySet(["item1", "item2"]) ;
            var tc:TypedSet = new TypedSet( String , se ) ;
            assertEquals( tc.size() , se.size() , "The TypedSet size method failed." ) ;
        } 
        
        public function testSupports():void
        {
            var se:Set = new ArraySet(["item1", "item2"]) ;
            var tc:TypedSet = new TypedSet( String , se ) ;
            assertTrue( tc.supports("hello world") , "01 - Must support a String value in argument.") ;
            assertFalse( tc.supports(1) , "02 - Must support a String value in argument and not a number.") ;
        }
        
        public function testToArray():void
        {
            var se:Set      = new ArraySet(["item1", "item2"]) ;
            var tc:TypedSet = new TypedSet( String , se ) ;
            ArrayAssert.assertEquals(tc.toArray() , se.toArray(), "The TypedSet toArray method failed.") ;
        }
        
        public function testToSource():void
        {
            var se:Set = new ArraySet(["item1", "item2"]) ;
            var tc:TypedSet = new TypedSet( String , se ) ;
            assertEquals( tc.toSource() , 'new system.data.sets.TypedSet(String,new system.data.sets.ArraySet(["item1","item2"]))' , "The TypedSet toSource method failed." ) ;     
        }
        
        public function testToString():void
        {
            var se:ArraySet = new ArraySet(["item1", "item2"]) ;
            var tc:TypedSet = new TypedSet( String , se ) ;
            assertEquals( tc.toString() , se.toString() , "The TypedSet toString method failed." ) ;
        }
        
        public function testValidate():void
        {
            var se:Set = new ArraySet(["item1", "item2"]) ;
            var tc:TypedSet = new TypedSet( String , se ) ;
            
            try
            {
                tc.validate( "hello" ) ;
            }
            catch( e:Error )
            {
                fail("01 - the validate method must validate a String value and not throw an error") ;
            }
            
            try
            {
                tc.validate( 1 ) ;
                fail("02-01 - the validate method must throw a TypeError.") ;
            }
            catch( e:Error )
            {
                assertTrue( e is TypeError , "02-02 - the validate method must throw a TypeError.") ;   
                assertEquals( e.message , "TypedSet.validate(1) is mismatch." , "03-02 - the validate method must throw a TypeError.") ;
            }
            
        }
    }
}
