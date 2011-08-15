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
    
    import system.Cloneable;
    import system.Equatable;
    import system.Serializable;
    import system.data.Collection;
    import system.data.Iterable;
    import system.data.Iterator;
    import system.data.Map;
    import system.data.Set;
    import system.data.collections.ArrayCollection;
    import system.data.iterators.ArrayIterator;
    import system.data.maps.ArrayMap;    

    public class CoreSetTest extends TestCase 
    {

        public function CoreSetTest(name:String = "")
        {
            super( name );
        }
        
        public var map:Map ;
        
        public function setUp():void
        {
            map = new ArrayMap() ;
        }

        public function tearDown():void
        {
            map = null ;
        }           
        
        public function testConstructor():void
        {
                       
            var s:CoreSet ;
            
            try
            {
                s = new CoreSet( null ) ;
                fail( "00-01 - CoreSet constructor failed." ) ;
            }
            catch( e:Error )
            {
                assertTrue( e is ArgumentError , "01-01 - CoreSet constructor failed." ) ;
                assertEquals( e.message , "CoreSet constructor failed, the internal Map not must be null." , "01-01 - CoreSet constructor failed." ) ;
            }
            
            s = new CoreSet( map.clone() ) ;
            
            assertNotNull(s, "01-01 - CoreSet constructor failed.") ;
            ArrayAssert.assertEquals( s.toArray(), [], "01-02 - CoreSet constructor failed.") ;
            
            // initialize with an Array
                        
            var s1:CoreSet = new CoreSet( map.clone() , [2,3,4]) ; 
            assertNotNull(s1, "02-01 - CoreSet constructor failed.") ;
            ArrayAssert.assertEquals( s1.toArray(), [2,3,4], "02-02 - CoreSet constructor failed.") ;
            
            // initialize with a Collection
            
            var s2:CoreSet ;
            
            s2 = new CoreSet( map.clone() , s1) ; 
            assertNotNull(s2, "03-01 - CoreSet constructor failed.") ;
            ArrayAssert.assertEquals( s2.toArray(), [2,3,4], "03-02 - CoreSet constructor failed.") ;
            
            // initialize with an Iterable object
            
            s2 = new CoreSet( map.clone() , new ArrayMap(["key1","key2"], ["value1","value2"]) as Iterable ) ; 
            assertNotNull(s2, "04-01 - CoreSet constructor failed.") ;
            ArrayAssert.assertEquals( s2.toArray(), ["value1","value2"], "04-02 - CoreSet constructor failed.") ;
                        
            
            // duplicate entries
            
            var co3:CoreSet = new CoreSet( map.clone() , [1,1,2,3,4,4,5,5,5]) ; 
            assertNotNull(co3, "05-01 - CoreSet constructor failed.") ;
            ArrayAssert.assertEquals( co3.toArray(), [1,2,3,4,5], "05-02 - CoreSet constructor failed.") ;
        }
        
        public function testInterface():void
        {
            var s:CoreSet = new CoreSet( new ArrayMap() ) ;
            assertTrue( s is Set          , "01 - CoreSet implements the Set interface.") ;
            assertTrue( s is Collection   , "02 - CoreSet implements the Collection interface.") ;
            assertTrue( s is Cloneable    , "03 - CoreSet implements the Cloneable interface.") ;
            assertTrue( s is Equatable    , "04 - CoreSet implements the Equatable interface.") ;
            assertTrue( s is Iterable     , "05 - CoreSet implements the Iterable interface.") ;
            assertTrue( s is Serializable , "06 - CoreSet implements the Serializable interface.") ; 
        }
        
        public function testAdd():void 
        {
            var s:CoreSet = new CoreSet( map.clone() ) ;
            assertTrue  ( s.add(2)         , "01 - CoreSet add method failed." ) ;
            assertFalse ( s.add(2)         , "02 - CoreSet add method failed." ) ;
            assertTrue  ( s.add(null)      , "03 - CoreSet add method failed." ) ;
            assertFalse ( s.add(undefined) , "04 - CoreSet add method failed." ) ;
        }        
        
        public function testClear():void
        {
            var s:CoreSet = new CoreSet( map.clone() , [2,3,4] ) ;
            var old:int = s.size() ;
            s.clear() ; 
            assertTrue( old > s.size(), "01 - CoreSet clear failed.") ;
            ArrayAssert.assertEquals( s.toArray(), [], "02 - CoreSet clear failed.") ;
            assertTrue( s.isEmpty(), "03 - CoreSet clear failed.") ;
        }

        public function testClone():void
        {
            var s:CoreSet = new CoreSet(map.clone(), [2,3,4]) ;
            var clone:CoreSet = s.clone() as CoreSet ;
            assertNotNull( clone, "01 - CoreSet clone failed.") ;
            assertFalse( clone == s, "02 - CoreSet clone failed.") ;  
            ArrayAssert.assertEquals( clone.toArray(), s.toArray(), "03 - CoreSet clone failed.") ;       
        }
    
        public function testContains():void 
        {
            var s:CoreSet = new CoreSet( map.clone() ) ;
            s.add("item") ;
            assertTrue( s.contains("item") ,  "01 - CoreSet contains failed.") ;
            assertFalse( s.contains("test") ,  "02 - CoreSet contains failed.") ;
        }
        
        public function testEquals():void
        {
            
            var s1:CoreSet = new CoreSet( map.clone(), [1,2,3,4]) ;
            var s2:CoreSet = new CoreSet( map.clone(), [1,2,3,4]) ;
            var s3:CoreSet = new CoreSet( map.clone(), [2,3]) ;
            var s4:CoreSet = new CoreSet( map.clone(), [5,6,7,8]) ;
            
            assertTrue  ( s1.equals(s1) , "01-01 - CoreSet equals failed." ) ;
            assertTrue  ( s1.equals(s2) , "01-02 - CoreSet equals failed." ) ;
            assertFalse ( s1.equals(s3) , "01-03 - CoreSet equals failed." ) ;
            assertFalse ( s1.equals(s4) , "01-04 - CoreSet equals failed." ) ; // same size
            
            assertTrue  ( s2.equals(s1) , "02-01 - CoreSet equals failed." ) ;
            assertTrue  ( s2.equals(s2) , "02-02 - CoreSet equals failed." ) ;
            assertFalse ( s2.equals(s3) , "02-03 - CoreSet equals failed." ) ;
            assertFalse ( s3.equals(s4) , "02-04 - CoreSet equals failed." ) ;
            
            assertFalse ( s3.equals(s1) , "03-01 - CoreSet equals failed." ) ;
            assertFalse ( s3.equals(s2) , "03-02 - CoreSet equals failed." ) ;
            assertTrue  ( s3.equals(s3) , "03-03 - CoreSet equals failed." ) ;
            assertFalse ( s3.equals(s4) , "03-04 - CoreSet equals failed." ) ;
            
            var c:ArrayCollection = new ArrayCollection([1,2,3,4]) ;
            assertFalse ( s1.equals(c) , "04 - CoreSet equals failed." ) ;
            
        }
        
        public function testGet():void
        {
            var s:CoreSet = new CoreSet( map.clone() ) ;
            s.add("test") ;
            assertEquals( s.get(0) , "test" ,  "01 - CoreSet get failed.") ;
            assertUndefined( s.get(1)       ,  "02 - CoreSet get failed." ) ;
        }        
        
        public function testIndexOf():void
        {
            var s:CoreSet = new CoreSet( map.clone() ) ;
            s.add("item1") ;
            s.add("item2") ;
            s.add("item3") ;
            
            assertEquals( s.indexOf("item4") , -1 ,  "01 - CoreSet indexOf failed.") ;
            assertEquals( s.indexOf("item1") , 0  ,  "02 - CoreSet indexOf failed.") ;   
            assertEquals( s.indexOf("item3") , 2  ,  "03 - CoreSet indexOf failed.") ;
            
            assertEquals( s.indexOf("item3", 1) , 2  ,  "04 - CoreSet indexOf failed.") ;
                    
        }        
        
        public function testIsEmpty():void 
        {
            var s:CoreSet = new CoreSet( map.clone() ) ;
            assertTrue( s.isEmpty() , "01 - CoreSet isEmpty failed.") ;
            s.add("test") ;
            assertFalse( s.isEmpty() , "02 - CoreSet isEmpty failed.") ;
            s.remove("test") ;
            assertTrue( s.isEmpty() , "03 - CoreSet isEmpty failed.") ;
        }

        public function testIterator():void 
        {
            var s:CoreSet   = new CoreSet( map.clone() ) ;
            var it:Iterator = s.iterator() ;
            assertTrue  ( it is Iterator      , "01 - CoreSet iterator failed." ) ;
            assertTrue  ( it is ArrayIterator , "02 - CoreSet iterator failed." ) ;
        }

        public function testRemove():void 
        {
            var s:CoreSet = new CoreSet( map.clone() ) ;
            
            s.add("item1") ;
            s.add("item2") ;
            
            assertTrue  ( s.remove("item1") , "01 - CoreSet remove failed." ) ;
            assertFalse ( s.remove("item5") , "02 - CoreSet remove failed." ) ;
        }

        public function testSize():void 
        {
            var s:CoreSet = new CoreSet( map.clone() ) ;
            assertEquals( s.size() , 0 ,  "01 - CoreSet size failed.") ;                    
            s.add("test") ;
            assertEquals( s.size() , 1 ,  "02 - CoreSet size failed.") ;      
        }
    
        public function testToArray():void 
        {
            
            var s:CoreSet ;
            var a:Array ;
            
            // initialize with an Array
            
            s = new CoreSet( map.clone() ) ;
            a = s.toArray() ;
            
            assertNotNull( a , "01-02 - CoreSet toArray failed.") ;
            ArrayAssert.assertEquals( a , [], "01-02 - CoreSet toArray failed.") ;            
            
            s.add(2) ;
            s.add(3) ;
            s.add(4) ; 
            
            a = s.toArray() ;
            
            assertNotNull( a , "02-02 - CoreSet constructor failed.") ;
            ArrayAssert.assertEquals( a , [2,3,4], "02-02 - CoreSet constructor failed.") ;            
            
        }

        public function testToSource():void
        {
            var s:CoreSet ;
            var ar:Array = ["item1", "item2"] ;
            
            s = new CoreSet( map.clone() ) ;
            assertEquals(s.toSource() , "new system.data.sets.CoreSet()" , "01 - CoreSet toSource failed" ) ;
            
            s = new CoreSet( map.clone(), ar ) ;
            assertEquals(s.toSource() , "new system.data.sets.CoreSet([\"item1\",\"item2\"])" , "02 - CoreSet toSource failed" ) ;
        }
        
        public function testToString():void
        {
            var a:Array = ["item1", "item2", "item3", "item4"] ;
            var s:CoreSet = new CoreSet( map.clone(), a ) ;
            assertEquals(s.toString() , "{item1,item2,item3,item4}", "CoreSet toString failed") ;
        }           
        
    }
}
