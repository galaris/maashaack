/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [MaasHaack framework]
  
  The Initial Developer of the Original Code is
  Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  
*/

package system.data.maps 
{
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.data.Iterator;
    import system.data.iterators.ArrayIterator;
    import system.data.iterators.MapIterator;    

    public class HashMapTest extends TestCase 
    {

        public function HashMapTest( name:String = "" )
        {
            super( name );
        }
        
        public var map:HashMap ;
        
        public function setUp():void
        {
            map = new HashMap(["key1", "key2"],["value1", "value2"]) ;
        }

        public function tearDown():void
        {
            map = undefined ;
        }          
        
        public function testConstructor():void
        {
        	assertNotNull( map , "" ) ;
        	
            assertEquals( map.get("key1") , "value1" , "1 - The HashMap constructor failed : map.get('key1')") ;
            assertEquals( map.get("key2") , "value2" , "2 - The HashMap constructor failed : map.get('key2')") ;      	
        	
        	var m1:HashMap = new HashMap() ;
        	
        	assertEquals( m1.size() , 0 , "3 - The HashMap constructor failed : m.get('key1')") ;
        	
        	var m2:HashMap = new HashMap(null,["value1", "value2"]) ;
        	assertEquals( m2.size() , 0 , "3 - The HashMap constructor failed : m.get('key1')") ;
        	
        }         
        
        public function testProxy():void
        {
            map["key3"] = "value3" ;
            assertEquals(map["key3"] , "value3", "1 - The HashMap proxy failed with the [] notation") ;
            assertTrue( delete map["key3"] , "2 - The HashMap proxy failed with the [] notation") ;
            assertFalse( map.containsKey("key3") , "3 - The HashMap proxy failed with the [] notation") ;
            assertFalse( delete map["key4"] , "4 - The HashMap proxy failed with the [] notation") ;
        }        
        
        public function testClear():void
        {
            var m:HashMap = new HashMap(["key1", "key2"],["value1", "value2"]) ;
            m.clear() ;
            assertEquals( m.size() , 0 , "The HashMap clear method failed.") ;
        }
        
        public function testClone():void
        {
            var m:HashMap = map.clone() ;
            assertNotNull( m , "1 - The HashMap clone method failed.") ;
            assertEquals( m.size()  , m.size()  , "1 - The HashMap clone method failed.") ;
            assertEquals( m["key1"] , m["key1"] , "2 - The HashMap clone method failed.") ;
            assertEquals( m["key2"] , m["key2"] , "3 - The HashMap clone method failed.") ;
        }
        
        public function testContainsKey():void
        {
            assertTrue( map.containsKey("key1") , "1 - The HashMap containsKey method failed.") ;
            assertTrue( map.containsKey("key2") , "2 - The HashMap containsKey method failed.") ;
            assertFalse( map.containsKey("key3") , "2 - The HashMap containsKey method failed.") ;
        }
        
        public function testContainsValue():void
        {
            assertTrue( map.containsValue("value1") , "1 - The HashMap containsValue method failed.") ;
            assertTrue( map.containsValue("value2") , "2 - The HashMap containsValue method failed.") ;
            assertFalse( map.containsValue("value3") , "2 - The HashMap containsValue method failed.") ;
        }
        
        public function testGet():void
        {
            assertEquals( map.get("key1") , "value1"  , "1 - The HashMap get method failed.") ;
            assertEquals( map.get("key2") , "value2"  , "2 - The HashMap get method failed.") ;
            assertUndefined( map.get("key3") , "3 - The HashMap get method failed.") ;
        } 
       
        public function testGetKeys():void
        {
        	var keys:Array = map.getKeys() ;
        	assertTrue( keys.indexOf("key1") >  -1 , "1 - The HashMap getKeys method failed.") ;
        	assertTrue( keys.indexOf("key2") >  -1 , "2 - The HashMap getKeys method failed.") ;
        	assertTrue( keys.indexOf("key3") == -1 , "3 - The HashMap getKeys method failed.") ;
        }         

        public function testGetValues():void
        {
            var values:Array = map.getValues() ;
            assertTrue( values.indexOf("value1") >  -1 , "1 - The HashMap getValues method failed.") ;
            assertTrue( values.indexOf("value2") >  -1 , "2 - The HashMap getValues method failed.") ;
            assertTrue( values.indexOf("value3") == -1 , "3 - The HashMap getValues method failed.") ;
        }
        
        public function testIsEmpty():void
        {
            var m:HashMap = new HashMap() ;
            
            assertTrue( m.isEmpty() , "1 - The HashMap isEmpty method failed." )  ;
            assertFalse( map.isEmpty() , "2 - The HashMap isEmpty method failed." )  ;
        }        
        
        public function testIterator():void
        {
            var it:Iterator = map.iterator() ;
            assertNotNull(it, "1 - The HashMap iterator method failed." ) ;
            assertTrue(it is MapIterator, "2 - The HashMap iterator method failed, the iterator must be a MapIterator." ) ;
            assertTrue(it.hasNext(), "3 - The HashMap iterator method failed, the iterator must has a next value." ) ;
        }
        
        public function testKeyIterator():void
        {
            var it:Iterator = map.keyIterator() ;
            assertNotNull(it, "1 - The HashMap keysIterator method failed." ) ;
            assertTrue(it is ArrayIterator, "2 - The HashMap keysIterator method failed, the iterator must be a ArrayIterator." ) ;
            assertTrue(it.hasNext(), "3 - The HashMap keysIterator method failed, the iterator must has a next value." ) ;
        }
        
        public function testPut():void
        {
            assertNull(map.put("key3","value3"), "1 - The HashMap put method failed, with a new key must return null.") ;
            assertEquals(map["key3"] , "value3", "2 - The HashMap put method failed the key and the value must exist in the map.") ;
            
            assertEquals(map.put("key3","value4"), "value3", "3 - The HashMap put method failed, with a key who already exist in the map, must return a value.") ;
            assertEquals(map["key3"] , "value4", "4 - The HashMap put method failed the key and the value must exist in the map.") ;
            
            delete map["key3"] ;
            
        }        
        
        public function testPutAll():void
        {
            var m1:HashMap = new HashMap(["key1", "key2"],["value1", "value2"]) ;
            var m2:HashMap = new HashMap(["key3", "key4"],["value3", "value4"]) ;
            
            m1.putAll(m2) ;
            
            assertTrue( m1.containsKey("key4")     , "1 - The HashMap putAll method failed.") ;
            assertTrue( m1.containsKey("key3")     , "2 - The HashMap putAll method failed.") ;
            assertTrue( m1.containsValue("value4") , "3 - The HashMap putAll method failed.") ;
            assertTrue( m1.containsValue("value3") , "4 - The HashMap putAll method failed.") ;
            
        }
        
        public function testRemove():void
        {
        	map.put("key3", "value3") ;
            assertEquals( map.remove("key3"), "value3", "1 - The HashMap remove method failed.") ;
            assertNull( map.remove("key4"), "2 - The HashMap remove method failed.") ;
        }        
       
        public function testSize():void
        {
            assertEquals(map.size() , 2, "The HashMap size method failed.") ;
        }       
        
        public function testToSource():void
        {
            assertTrue
            ( 
                map.toSource() == 'new system.data.map.HashMap(["key1","key2"],["value1","value2"])' || 'new system.data.map.HashMap(["key2","key1"],["value2","value1"])' , // the dictionnary stack isn't ordered. 
                "The HashMap toSource method failed."
            ) ;
        } 
        
        public function testToString():void
        {
            assertTrue
            (
                map.toString() == "{key1:value1,key2:value2}" || "{key2:value2,key1:value1}" , // the dictionnary stack isn't ordered.
                "The HashMap toString method failed."
            ) ;
        }
                
    }
}
