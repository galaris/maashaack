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

package system.data.maps 
{
    import buRRRn.ASTUce.framework.ArrayAssert;
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.data.Iterator;
    import system.data.Map;
    import system.data.Typeable;
    import system.data.Validator;    

    public class TypedMapTest extends TestCase 
    {

        public function TypedMapTest(name:String = "")
        {
            super(name);
        }
        
        // test constructor
        
        public function testConstructorBasic():void
        {
            var ma:Map      = new ArrayMap() ;
            var tm:TypedMap = new TypedMap( String , ma ) ;
            assertNotNull(tm, "01 - TypedMap constructor failed.") ;
        }
        
        public function testConstructorTypeArgument():void
        {
            var ma:Map      = new ArrayMap() ;
            var tm:TypedMap = new TypedMap( String , ma ) ;
                        
            tm = new TypedMap( String, ma ) ;
            assertEquals( tm.type , String , "01 - TypedMap constructor failed with a specific type argument in this constructor.") ;

            tm = new TypedMap( null , ma ) ;
            assertNull( tm.type , "02 - TypedMap constructor failed with a specific type argument in this constructor.") ;

            tm = new TypedMap( [] , ma ) ; // 
            assertNull( tm.type , "03 - TypedMap constructor failed with a specific type argument in this constructor, other type, must use a Class or a Function value.") ;
        }
        
        public function testConstructorMapArgument():void
        {
            var ma:Map = new ArrayMap() ;
            var tm:TypedMap ;        
            
            // 01 - test "collection" argument is null
            try
            {
                tm = new TypedMap( String, null ) ;
                fail( "01-01 - TypedMap constructor failed." ) ;
            }
            catch( e:Error )
            {
                assertTrue( e is ArgumentError , "01-02 - TypedMap constructor failed." ) ;
                assertEquals( e.message , "The passed-in Map argument not must be 'null' or 'undefined'.", "01-03 - TypedCollection constructor failed." ) ;
            }           
                        
            // 02 - basic test with a no empty Collection
            
            ma.put("key1", "value1") ;
            ma.put("key2", "value2") ;
            
            tm = new TypedMap( String , ma ) ;
            assertNotNull(tm, "02-01 - TypedMap constructor failed with a no empty collection of String values.") ;          
            assertEquals(tm.size(), ma.size() , "02-02 - TypedMap constructor failed with a no empty map of String values.") ;
            
            // 03 - test "collection" argument contains an invalid value
            ma.put("key3", 1) ;
            try
            {
                tm = new TypedMap( String, ma ) ;
                fail( "03-01 - TypedMap constructor failed." ) ;
            }
            catch( e:Error )
            {
                assertTrue( e is TypeError , "03-02 - TypedMap constructor failed." ) ;
                assertEquals( e.message , "TypedMap.validate(1) is mismatch.", "03-03 - TypedMap constructor failed." ) ;
            }
        }
        
        public function testInterface():void
        {
            var ma:Map      = new ArrayMap() ;
            var tm:TypedMap = new TypedMap( String , ma ) ;
            
            assertTrue( tm is Map , "01 - The TypedMap class must implement the Map interface." ) ;
            assertTrue( tm is Typeable   , "02 - The TypedMap class must implement the Typeable interface." ) ;
            assertTrue( tm is Validator  , "03 - The TypedMap class must implement the Validator interface." ) ;
        }
        
        // test methods and attributes        
        
        public function testType():void
        {
            var ma:Map      = new ArrayMap(["key1","key2"],["value1","value2"]) ;
            var tm:TypedMap = new TypedMap( String , ma ) ;
            
            assertEquals( tm.type , String , "01 - The TypedMap type property failed." ) ;
            
            tm.type = Number ;
            assertEquals( tm.type , Number , "02 - The TypedMap type property failed." ) ;
            
            var clazz:Function = function():void {} ;
            tm.type = clazz ;
            assertEquals( tm.type , clazz , "03 - The TypedMap type property failed." ) ;
            
            tm.type = null ;
            assertNull( tm.type , "04 - The TypedMap type property failed." ) ;            

            tm.type = 2 ;
            assertNull( tm.type , "05 - The TypedMap type property failed." ) ;    
        }
        
        public function testClear():void
        {
            var ma:Map      = new ArrayMap(["key1","key2"],["value1","value2"]) ;
            var tm:TypedMap = new TypedMap( String , ma ) ;
            tm.clear() ;
            assertEquals( tm.size() , 0 , "The TypedMap clear method failed." ) ;
        }          
        
        public function testClone():void
        {
            var ma:Map      = new ArrayMap(["key1","key2"],["value1","value2"]) ;
            var tm:TypedMap = new TypedMap( String , ma ) ;
            var clone:TypedMap = tm.clone() as TypedMap ;
            assertNotNull( clone , "01 - The TypedMap clone method failed." ) ;
            assertEquals( tm.size() , clone.size() , "02 - The TypedMap clone method failed." ) ;
        }         

        public function testContainsKey():void
        {
            var ma:Map      = new ArrayMap(["key1","key2"],["value1","value2"]) ;
            var tm:TypedMap = new TypedMap( String , ma ) ;
            assertTrue( tm.containsKey("key1") , "01 - The TypedMap containsKey method failed." ) ;      
            assertFalse( tm.containsKey("key3") , "02 - The TypedMap containsKey method failed." ) ;
        }  

        public function testContainsValue():void
        {
            var ma:Map      = new ArrayMap(["key1","key2"],["value1","value2"]) ;
            var tm:TypedMap = new TypedMap( String , ma ) ;
            assertTrue( tm.containsValue("value1") , "01 - The TypedMap containsValue method failed." ) ;      
            assertFalse( tm.containsValue("value3") , "02 - The TypedMap containsValue method failed." ) ;
        }  

        public function testGet():void
        {
            var ma:Map      = new ArrayMap(["key1","key2"],["value1","value2"]) ;
            var tm:TypedMap = new TypedMap( String , ma ) ;
            assertEquals( tm.get("key1") , "value1",  "01 - The TypedMap get method failed." ) ;      
            assertNull( tm.get("key3") , "02 - The TypedMap get method failed." ) ;
        }   

        public function testGetKeys():void
        {
            var ma:Map      = new ArrayMap(["key1","key2"],["value1","value2"]) ;
            var tm:TypedMap = new TypedMap( String , ma ) ;
            ArrayAssert.assertEquals( tm.getKeys() , ["key1","key2"] , "The TypedMap getKeys method failed." ) ;
        }     

        public function testGetValues():void
        {
            var ma:Map      = new ArrayMap(["key1","key2"],["value1","value2"]) ;
            var tm:TypedMap = new TypedMap( String , ma ) ;
            ArrayAssert.assertEquals( tm.getValues() , ["value1","value2"] , "The TypedMap getValues method failed." ) ;      
        }     

        public function testIsEmpty():void
        {
            var ma:Map      = new ArrayMap(["key1","key2"],["value1","value2"]) ;
            var tm:TypedMap = new TypedMap( String , ma ) ;
            assertFalse(tm.isEmpty() , "01 - The TypedMap isEmpty method failed." ) ;     
            tm.clear() ;
            assertTrue(tm.isEmpty() , "02 - The TypedMap isEmpty method failed." ) ;
        } 
        
        public function testIterator():void
        {
            var ma:Map      = new ArrayMap(["key1","key2"],["value1","value2"]) ;
            var tm:TypedMap = new TypedMap( String , ma ) ;
            var it:Iterator = tm.iterator() ;
            assertNotNull( it, "The TypedMap iterator method failed." ) ;     
        }
     
        public function testKeyIterator():void
        {
            var ma:Map      = new ArrayMap(["key1","key2"],["value1","value2"]) ;
            var tm:TypedMap = new TypedMap( String , ma ) ;
            var it:Iterator = tm.keyIterator() ;
            assertNotNull( it, "The TypedMap keyIterator method failed." ) ;       
        }     
        
        public function testPut():void
        {
            var ma:Map      = new ArrayMap() ;
            var tm:TypedMap = new TypedMap( String , ma ) ;
            
            assertNull( tm.put("key1", "value1") , "01-01 - The TypedMap put method failed." ) ;       
            assertEquals( tm.put("key1", "value2") , "value1", "01-02 - The TypedMap put method failed." ) ;
            
            try
            {
                tm.put( "key3", 1 ) ;
                fail("02-01 - the put method must throw a TypeError.") ;
            }
            catch( e:Error )
            {
                assertTrue( e is TypeError , "02-02 - the put method must throw a TypeError.") ;   
                assertEquals( e.message , "TypedMap.validate(1) is mismatch." , "03-02 - the put method must throw a TypeError.") ;
            }
            
        }
        
        public function testPutAll():void
        {
            var ma1:Map      = new ArrayMap() ;
            var ma2:Map      = new ArrayMap(["key1","key2"],["value1","value2"]) ;
            var ma3:Map      = new ArrayMap(["key1","key2"],[1,2]) ;
            var tm:TypedMap = new TypedMap( String , ma1 ) ;
            
            try
            {
                tm.putAll(ma1) ;
            }
            catch( e:Error )
            {
                fail( "00 - The TypedMap putAll method failed." ) ;
            }            
            
            try
            {
                tm.putAll(ma2) ;
            }
            catch( e:Error )
            {
                fail( "01 - The TypedMap putAll method failed." ) ;
            }
            
            try
            {
                tm.putAll(ma3) ;
                fail("02-01 - the putAll method must throw a TypeError.") ;
            }
            catch( e:Error )
            {
                assertTrue( e is TypeError , "02-02 - the putAll method must throw a TypeError.") ;   
                assertEquals( e.message , "TypedMap.validate(1) is mismatch." , "03-02 - the putAll method must throw a TypeError.") ;
            }
        }
        
        public function testRemove():void
        {
            var ma:Map      = new ArrayMap(["key1","key2"],["value1","value2"]) ;
            var tm:TypedMap = new TypedMap( String , ma ) ;
            
            assertEquals( tm.remove("key1"), "value1", "01 - The TypedMap remove method failed." ) ;     
            assertNull( tm.remove("key5"), "02 - The TypedMap remove method failed." ) ;
        }         
        
        public function testSize():void
        {
            var ma:Map      = new ArrayMap(["key1","key2"],["value1","value2"]) ;
            var tm:TypedMap = new TypedMap( String , ma ) ;
            assertEquals( tm.size() , ma.size() , "The TypedMap size method failed." ) ;     
        }         
        
        public function testSupports():void
        {
            var ma:Map      = new ArrayMap(["key1","key2"],["value1","value2"]) ;
            var tm:TypedMap = new TypedMap( String , ma ) ;
            assertTrue( tm.supports("hello") , "01 - Must support a String value in argument.") ;
            assertFalse( tm.supports(1) , "02 - Must support a String value in argument and not a number.") ;
        }        
        
        public function testToSource():void
        {
            var ma:Map      = new ArrayMap(["key1","key2"],["value1","value2"]) ;
            var tm:TypedMap = new TypedMap( String , ma ) ;
            assertEquals( tm.toSource() , 'new system.data.maps.TypedMap(String,new system.data.maps.ArrayMap(["key1","key2"],["value1","value2"]))' , "The TypedMap toSource method failed." ) ;     
        }

        public function testToString():void
        {
            var ma:ArrayMap = new ArrayMap(["key1","key2"],["value1","value2"]) ;
            var tm:TypedMap = new TypedMap( String , ma ) ;
            assertEquals( tm.toString() , ma.toString() , "The TypedMap toString method failed." ) ;     
        }        
        
        public function testValidate():void
        {
            var ma:Map      = new ArrayMap() ;
            var tm:TypedMap = new TypedMap( String , ma ) ;
            
            try
            {
                tm.validate( "hello" ) ;         
            }
            catch( e:Error )
            {
                fail("01 - the validate method must validate a String value and not throw an error") ;
            }
            
            try
            {
                tm.validate( 1 ) ;
                fail("02-01 - the validate method must throw a TypeError.") ;
            }
            catch( e:Error )
            {
                assertTrue( e is TypeError , "02-02 - the validate method must throw a TypeError.") ;   
                assertEquals( e.message , "TypedMap.validate(1) is mismatch." , "03-02 - the validate method must throw a TypeError.") ;
            }
            
        }         
    }
}
