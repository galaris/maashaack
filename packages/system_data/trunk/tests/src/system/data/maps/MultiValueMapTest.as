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
    import library.ASTUce.framework.TestCase;

    import system.data.Collection;
    import system.data.Iterator;
    import system.data.Map;
    import system.data.MultiMap;
    import system.data.collections.ArrayCollection;
    import system.data.iterators.ArrayIterator;
    import system.data.lists.LinkedList;
    
    public class MultiValueMapTest extends TestCase 
    {
        public function MultiValueMapTest(name:String = "")
        {
            super( name );
        }
        
        public var map:MultiValueMap ;
        
        public function setUp():void
        {
            map = new MultiValueMap () ;
        }

        public function tearDown():void
        {
            map = null ;
        }           
        
        public function testConstructor():void
        {
            
            var init:Map = new HashMap() ;
            init.put( "key1" , "value1" ) ;
            
            assertNotNull(map , "1 - The MultiValueMap constructor failed.") ;
            
            var m:MultiValueMap = new MultiValueMap( init ) ;
            
            assertEquals
            ( 
               m.toString() , 
               "{key1:{value1}}" ,
               "2 - The MultiValueMap constructor failed." 
            );
            
        }

        public function testConstructorWithFactory():void
        {
            
            var init:Map = new HashMap() ;
            init.put( "key1" , "value1" ) ;
            
            assertNotNull(map , "1 - The MultiValueMap constructor failed.") ;
            
            var m:MultiValueMap = new MultiValueMap( init , new ArrayMap() ) ;
            
            assertEquals
            ( 
               m.toSource() , 
               'new system.data.maps.MultiValueMap(new system.data.maps.ArrayMap(["key1"],[new system.data.collections.ArrayCollection(["value1"])]))' ,
               "2 - The MultiValueMap constructor failed." 
            );
            
        }

        public function testInterface():void
        {
            assertTrue( map is MultiMap , "1 - The MultiValueMap must implement the MultiMap interface." ) ;
            assertTrue( map is Map      , "2 - The MultiValueMap must implement the Map interface." ) ;
        }

        public function testinternalBuildClass():void
        {
            var map:MultiValueMap = new MultiValueMap() ;
            
            assertEquals( map.internalBuildClass , ArrayCollection , "01 - internalBuildClass failed" ) ;
            
            map.internalBuildClass = LinkedList ;
            assertEquals( map.internalBuildClass , LinkedList , "02 - internalBuildClass failed" ) ;
            
            map.internalBuildClass = null ;
            assertEquals( map.internalBuildClass , ArrayCollection , "03 - internalBuildClass failed" ) ;
            
            map.internalBuildClass = Array ;
            assertEquals( map.internalBuildClass , ArrayCollection , "04 - internalBuildClass failed" ) ;
        }

        public function testClear():void 
        {
            map.put("key1" , "value1") ;
            map.clear() ;
            assertTrue( map.isEmpty() , "The MultiValueMap clear failed.") ;
        }
        
        public function testClone():void
        {
            
            var clone:MultiValueMap = map.clone() as MultiValueMap ;
            
            assertNotNull( clone , "01 - The MultiValueMap clone method failed.") ;
            assertNotSame( map, clone , "02 - The MultiValueMap clone method failed.") ;
            
            clone.put("key1", "value1") ;
            
            clone = clone.clone() ;
            
            assertEquals( clone.size() , 1 , "03 - The MultiValueMap clone method failed.") ;
            
        }

        public function testContainsKey():void 
        {
            var o:Object = {} ;
            
            map.put("key1" , "value1") ;
            map.put(o , "value1") ;
            
            assertTrue ( map.containsKey( "key1" ) , "01 - The MultiValueMap containsKey method failed." ) ;
            assertTrue ( map.containsKey( o ) , "02 - The MultiValueMap containsKey method failed." ) ;
            
            assertFalse ( map.containsKey( "key2" ) , "03 - The MultiValueMap containsKey method failed." ) ;
            
            map.clear() ;
        }
        
        public function testContainsValue():void 
        {
            var o:Object = {} ;
            
            map.put( "key1" , "value1" ) ;
            map.put( "key2" , "value2" ) ;
            map.put( "key3" , o        ) ;
            
            assertTrue ( map.containsValue( "value1" ) , "01 - The MultiValueMap containsValue method failed." ) ;
            assertTrue ( map.containsValue( "value2" ) , "02 - The MultiValueMap containsValue method failed." ) ;
            assertTrue ( map.containsValue( o        ) , "03 - The MultiValueMap containsValue method failed." ) ;
            
            assertFalse ( map.containsValue( "value3" ) , "04 - The MultiValueMap containsValue method failed." ) ;
            
            map.clear() ;
            
        } 
        
        public function testContainsValueByKey():void 
        {
            map.put( "key1" , "hello"   ) ;
            map.put( "key2" , "bonjour" ) ;
            assertTrue  ( map.containsValueByKey( "key1" , "hello"   ) , "01 - The MultiValueMap containsValueByKey method failed." ) ;
            assertFalse ( map.containsValueByKey( "key1" , "bonjour" ) , "02 - The MultiValueMap containsValueByKey method failed." ) ;
            assertFalse ( map.containsValueByKey( "key2" , "hello"   ) , "03 - The MultiValueMap containsValueByKey method failed." ) ;
            assertTrue  ( map.containsValueByKey( "key2" , "bonjour" ) , "04 - The MultiValueMap containsValueByKey method failed." ) ;
            map.clear() ;
        }
        
        public function testCreateCollection():void
        {
            var m:MultiValueMap = new MultiValueMap() ;
            
            var c:Collection = m.createCollection() ;
            
            assertNotNull( c , "01 - The MultiValueMap createCollection method failed." ) ;
            assertTrue( c is ArrayCollection , "02 - The MultiValueMap containsValueByKey method failed." ) ;
        }

        public function testGet():void
        {
            map.put( "key1" , "hello"   ) ;
            map.put( "key2" , "bonjour" ) ;
            
            assertEquals    ( map.get( "key1" ).toString() , "{hello}"   , "01 - The MultiValueMap get method failed." ) ;
            assertEquals    ( map.get( "key2" ).toString() , "{bonjour}" , "02 - The MultiValueMap get method failed." ) ;
            assertUndefined ( map.get( "key3" )            , "03 - The MultiValueMap get method failed." ) ;
                        
            map.clear() ;  
        }
        
        public function testGetCollection():void
        {
            map.put( "key1" , "hello"   ) ;
            map.put( "key2" , "bonjour" ) ;
            
            assertEquals ( String(map.getCollection( "key1" )) , "{hello}"   , "01 - The MultiValueMap getCollection method failed." ) ;
            assertEquals ( String(map.getCollection( "key2" )) , "{bonjour}" , "02 - The MultiValueMap getCollection method failed." ) ;
            assertNull   ( map.getCollection( "key3" ) , "03 - The MultiValueMap getCollection method failed." ) ;
                        
            map.clear() ; 
        }        

        public function testGetKeys():void 
        {
            map.put( "key1" , "hello"   ) ;
            map.put( "key2" , "bonjour" ) ;
            
            var ar:Array = map.getKeys() as Array ;
            
            assertNotNull ( ar  , "01 - The MultiValueMap getKeys method failed." ) ;
            assertEquals  ( ar.length , 2  , "02 - The MultiValueMap getKeys method failed." ) ;
                        
            map.clear() ; 
        }
    
        public function testGetValues():void 
        {
            map.put( "key1" , "A1"   ) ;
            map.put( "key2" , "B1" ) ;
            map.put( "key2" , "B2" ) ;
            map.put( "key3" , "C1" ) ;
            
            var ar:Array = map.getValues() ;
            
            assertNotNull ( ar  , "01 - The MultiValueMap getValues method failed." ) ;
            assertEquals  ( ar.length , 4  , "02 - The MultiValueMap getValues method failed." ) ;

            map.clear() ; 
        }

        public function testIsEmpty():void 
        {
            map.put("key1" , "value1") ;
            map.put("key1" , "value2") ;
            map.put("key2" , "value3") ;
            assertFalse( map.isEmpty() , "1 - The MultiValueMap isEmpty failed.") ;
            map.clear() ;
            assertTrue( map.isEmpty() , "2 - The MultiValueMap isEmpty failed.") ;
        }
        
        public function testIterator():void 
        {
            map.put("key1" , "value1") ;
            
            var it:Iterator = map.iterator() ;
            
            assertNotNull( it , "1 - The MultiValueMap iterator method failed." ) ;
            
            assertTrue( it.hasNext() , "2 - The MultiValueMap iterator method failed." ) ;
            
            var r:* = it.next() ;
            
            assertTrue( r is Collection , "3 - The MultiValueMap iterator method failed." ) ;
            
            map.clear() ;
        }

        public function testIteratorByKey():void
        {
            
            map.put("key1" , "value1") ;
            map.put("key1" , "value2") ;
            map.put("key2" , "value3") ;
            
            var it:Iterator ;
            
            it = map.iteratorByKey( undefined ) ;
            assertNull( it , "1 - The MultiValueMap iteratorByKey method failed." ) ;
                        
            it = map.iteratorByKey( null ) ;
            assertNull( it , "2 - The MultiValueMap iteratorByKey method failed." ) ;

            it = map.iteratorByKey( "key3" ) ;
            assertNull( it , "3 - The MultiValueMap iteratorByKey method failed." ) ;

            it = map.iteratorByKey( "key1" ) ;
            assertNotNull( it , "4-1 - The MultiValueMap iteratorByKey method failed." ) ;            
            assertTrue( it is ArrayIterator , "4-2 - The MultiValueMap iteratorByKey method failed." ) ;
            assertTrue( it.hasNext() , "4-3 - The MultiValueMap iteratorByKey method failed." ) ;
            
            map.clear() ;            
            
        }
        
        public function testKeyIterator():void 
        {
         
            map.put("key1" , "value1") ;
            
            var it:Iterator ;
            
            it = map.keyIterator() ;
            assertNotNull( it , "1 - The MultiValueMap keyIterator method failed." ) ;            
            assertTrue( it is ArrayIterator , "2 - The MultiValueMap keyIterator method failed." ) ;
            assertTrue( it.hasNext() , "3 - The MultiValueMap keyIterator method failed." ) ;
            assertEquals( it.next() , "key1" , "4 - The MultiValueMap keyIterator method failed." ) ;
            
            map.clear() ;         
                
        }
         
        public function testPut():void
        {
            assertEquals ( map.put("key1" , "value1") , "value1" , "1-1 - The MultiValueMap size method failed." )  ;
            assertEquals ( map.size() , 1 , "1-2 - The MultiValueMap size method failed." )  ;
            
            assertEquals ( map.put("key1" , "value2") , "value2" , "2-1 - The MultiValueMap size method failed." )  ;
            assertEquals ( map.size() , 1 , "2-2 - The MultiValueMap size method failed." )  ;
            
            assertEquals ( map.put("key2" , "value3") , "value3" , "3-1 - The MultiValueMap size method failed." )  ;
            assertEquals ( map.size() , 2 , "3-2 - The MultiValueMap size method failed." )  ;
            
            map.clear() ;
        }   
        
        public function testPutAll():void
        {
         
            var am1:ArrayMap = new ArrayMap( [ "key1" , "key2" ] , ["value1" , "value2" ] ) ;
            var am2:ArrayMap = new ArrayMap( [ "key1" ]          , [ new ArrayCollection( [ "value3" ] ) ] ) ;
            
            var mm:MultiValueMap = new MultiValueMap() ;
            
            mm.putAll( am1 ) ; 
            
            assertEquals( mm.size()      , 2 , "1-1 - The MultiValueMap putAll method failed." ) ;
            assertEquals( mm.totalSize() , 2 , "1-2 - The MultiValueMap putAll method failed." ) ;
            
            mm.putAll( am2 ) ;
            
            assertEquals( mm.size()      , 2 , "2-1 - The MultiValueMap putAll method failed." ) ;
            assertEquals( mm.totalSize() , 3 , "2-2 - The MultiValueMap putAll method failed." ) ;
            
        }
        
        public function testPutCollection():void 
        {
            
            map.putCollection( "key1" , new ArrayCollection(["value1", "value2"])) ;
            map.putCollection( "key1" , new ArrayCollection(["value3", "value4"])) ;
            map.putCollection( "key2" , new ArrayCollection(["value5"])) ;
            
            assertEquals( map.size()      , 2 , "1 - The MultiValueMap putCollection method failed." ) ;
            assertEquals( map.totalSize() , 5 , "2 - The MultiValueMap putCollection method failed." ) ;            
            
            map.clear() ;
            
        }
        
        public function testRemove():void
        {
            map.put("key1" , "value1") ;
            map.put("key1" , "value2") ;
            map.put("key2" , "value3") ;
            
            var c:Collection = map.remove( "key1" ) as Collection ;
            
            assertNotNull( c , "1-1 - The MultiValueMap remove method failed." ) ;
            assertEquals( map.size() , 1 , "1-2 - The MultiValueMap remove method failed." ) ;
            
            map.clear() ;
        }
        
        public function testRemoveByKey():void
        {
            map.put("key1" , "value1") ;
            map.put("key1" , "value2") ;
            map.put("key2" , "value3") ;
            
            assertTrue  ( map.removeByKey("key1" , "value1" ) , "1 - The MultiValueMap removeByKey method failed." ) ;
            assertFalse ( map.removeByKey("key1" , "value5" ) , "2 - The MultiValueMap removeByKey method failed." ) ;
                        
            assertEquals( map.totalSize() , 2 ,  "3 - The MultiValueMap removeByKey method failed.") ;
                        
            map.clear() ;
        }

        public function testSize():void
        {
            map.put("key1" , "value1") ;
            map.put("key1" , "value2") ;
            map.put("key2" , "value3") ;
            assertEquals( map.size() , 2, "1 - The MultiValueMap size method failed.") ;
            map.clear() ;
            assertEquals( map.size() , 0 ,  "2 - The MultiValueMap size method failed.") ;
        }
        
        public function testToSource():void 
        {
            map.put("key1" , "value1") ;
            
            assertEquals
            (
                map.toSource() , 
                'new system.data.maps.MultiValueMap(new system.data.maps.HashMap(["key1"],[new system.data.collections.ArrayCollection(["value1"])]))' , 
                "The MultiValueMap toSource method failed." 
            ) ;
            
            map.clear() ;
        }
        
        public function testToString():void 
        {
            map.put("key1" , "value1") ;
            assertEquals( map.toString() , "{key1:{value1}}"  , "1 - The MultiValueMap toString method failed.") ;
            map.clear() ;    
            assertEquals( map.toString() , "{}" , "2 - The MultiValueMap toString method failed.") ;
        }
                
        public function testTotalSize():void 
        {
            map.put("key1" , "value1") ;
            map.put("key1" , "value2") ;
            map.put("key2" , "value3") ;
            assertEquals( map.totalSize() , 3, "1 - The MultiValueMap totalSize method failed.") ;
            map.clear() ;
            assertEquals( map.totalSize() , 0 ,  "2 - The MultiValueMap totalSize method failed.") ;
        }
        
        public function testValues():void 
        {
            map.put("key1" , "value1") ;      
            var c:Collection = map.values() ;
            assertNotNull( c , "1 - The MultiValueMap values method failed.") ;
            assertTrue( c is ArrayCollection , "2 - The MultiValueMap values method failed.") ;
            assertEquals( c.size() , 1 , "3 - The MultiValueMap values method failed.") ;
            assertEquals( (c as ArrayCollection).toString() , "{value1}" , "3 - The MultiValueMap values method failed.") ;
            map.clear() ;            
        }
            
        public function testValueIterator():void 
        {

            // ArrayIterator of all collections of values            
            
            map.put("key1" , "value1") ;
            map.put("key1" , "value2") ;
            map.put("key2" , "value3") ;
            
            var it:Iterator = map.valueIterator() ;
            
            assertNotNull( it , "1 - The MultiValueMap valueIterator method failed.") ;
            assertTrue( it is ArrayIterator , "2 - The MultiValueMap valueIterator method failed.") ;
            
            assertTrue( it.hasNext() , "3 - The MultiValueMap size method failed.") ;
            map.clear() ; 
        }
        
        public function testValuesIterator():void 
        {
            // ArrayIterator of all values
            
            map.put("key1" , "value1") ;
            map.put("key1" , "value2") ;
            map.put("key2" , "value3") ;
            
            var it:Iterator = map.valueIterator() ;
            
            assertNotNull( it , "1 - The MultiValueMap valueIterator method failed.") ;
            assertTrue( it is ArrayIterator , "2 - The MultiValueMap valueIterator method failed.") ;
            
            assertTrue( it.hasNext() , "3 - The MultiValueMap size method failed.") ;
            map.clear() ; 
        }        
        
    }
}
