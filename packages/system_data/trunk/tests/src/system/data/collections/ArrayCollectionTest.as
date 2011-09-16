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

package system.data.collections 
{
    import library.ASTUce.framework.ArrayAssert;
    import library.ASTUce.framework.TestCase;
    
    import system.Cloneable;
    import system.Equatable;
    import system.Serializable;
    import system.data.Collection;
    import system.data.Iterable;
    import system.data.Iterator;
    import system.data.iterators.ArrayIterator;
    import system.data.sets.HashSet;
    
    public class ArrayCollectionTest extends TestCase
    {
        public function ArrayCollectionTest( name:String = "" )
        {
            super( name );
        }
        
        public function testConstructor():void
        {
            var c:ArrayCollection = new ArrayCollection() ;
            
            assertNotNull( c, "01-01 - ArrayCollection constructor failed.") ;
            ArrayAssert.assertEquals( c.toArray(), [], "01-02 - ArrayCollection constructor failed.") ;
            
            // initialize with an Array
            
            var co1:ArrayCollection = new ArrayCollection([2,3,4]) ; 
            assertNotNull(co1, "02-01 - ArrayCollection constructor failed.") ;
            ArrayAssert.assertEquals( co1.toArray(), [2,3,4], "02-02 - ArrayCollection constructor failed.") ;
            
            // initialize with a Collection
            
            var co2:ArrayCollection = new ArrayCollection(co1) ; 
            assertNotNull(co2, "03-01 - ArrayCollection constructor failed.") ;
            ArrayAssert.assertEquals( co2.toArray(), [2,3,4], "03-02 - ArrayCollection constructor failed.") ;
        }
        
        public function testInterface():void
        {
            var c:ArrayCollection = new ArrayCollection() ;
            assertTrue( c is Collection   , "01 - ArrayCollection implements the Collection interface.") ;
            assertTrue( c is Cloneable    , "02 - ArrayCollection implements the Cloneable interface.") ;
            assertTrue( c is Equatable    , "03 - ArrayCollection implements the Equatable interface.") ;
            assertTrue( c is Iterable     , "04 - ArrayCollection implements the Iterable interface.") ;
            assertTrue( c is Serializable , "05 - ArrayCollection implements the Serializable interface.") ;
        }
        
        public function testAdd():void
        {
            var c:ArrayCollection = new ArrayCollection() ;
            assertTrue( c.add(2)          , "01 - ArrayCollection add method failed." ) ;
            assertTrue( c.add(null)       , "02 - ArrayCollection add method failed." ) ;
            assertFalse( c.add(undefined) , "03 - ArrayCollection add method failed." ) ;
        }
        
        public function testAddAll():void
        {
            var co1:ArrayCollection = new ArrayCollection([2,3,4]) ; 
            var co2:ArrayCollection = new ArrayCollection() ;
            
            var co:ArrayCollection = new ArrayCollection() ;
            
            assertTrue( co.addAll(co1) , "01-01 - ArrayCollection addAll method failed." ) ;
            ArrayAssert.assertEquals( co.toArray(), [2,3,4], "01-02 - ArrayCollection addAll method failed.") ;
             
            assertFalse( co.addAll(co2), "02-01 - ArrayCollection addAll method failed." ) ;
        }
        
        public function testClear():void
        {
            
            var co:ArrayCollection = new ArrayCollection([2,3,4]) ;
            var old:int = co.size() ;
            co.clear() ; 
            assertTrue( old > co.size(), "01 - ArrayCollection clear failed.") ;
            ArrayAssert.assertEquals( co.toArray(), [], "02 - ArrayCollection clear failed.") ;
            assertTrue( co.isEmpty(), "03 - ArrayCollection clear failed.") ;
        }
        
        public function testClone():void
        {
            var co:ArrayCollection = new ArrayCollection([2,3,4]) ;
            var cl:ArrayCollection = co.clone() as ArrayCollection ;
            assertNotNull( cl, "01 - ArrayCollection clone failed.") ;
            assertFalse( cl == co, "02 - ArrayCollection clone failed.") ;  
            ArrayAssert.assertEquals( cl.toArray(), co.toArray(), "03 - ArrayCollection clone failed.") ;
        }
        
        public function testContains():void
        {
            var co:ArrayCollection = new ArrayCollection() ;
            
            co.add("item") ;
            
            assertTrue( co.contains("item") ,  "01 - ArrayCollection contains failed.") ;
            assertFalse( co.contains("unknow") ,  "02 - ArrayCollection contains failed.") ;
        }
        
        public function testContainsAll():void
        {
            var c1:ArrayCollection = new ArrayCollection([1,2,3,4]) ;
            var c2:ArrayCollection = new ArrayCollection([2,3]) ;
            var c3:ArrayCollection = new ArrayCollection() ;
            
            assertTrue( c1.containsAll(c2) , "01") ;
            assertTrue( c1.containsAll(c3) , "02") ;
            
            assertFalse( c2.containsAll(c1) , "03") ;
        }
        
        public function testEquals():void
        {
            var c1:ArrayCollection = new ArrayCollection([1,2,3,4]) ;
            var c2:ArrayCollection = new ArrayCollection([1,2,3,4]) ;
            var c3:ArrayCollection = new ArrayCollection([2,3]) ;
            var c4:ArrayCollection = new ArrayCollection([5,6,7,8]) ;
            
            assertTrue  ( c1.equals(c1) , "#01-01" ) ;
            assertTrue  ( c1.equals(c2) , "#01-02" ) ;
            assertFalse ( c1.equals(c3) , "#01-03" ) ;
            assertFalse ( c1.equals(c4) , "#01-04" ) ; // same size
            
            assertTrue  ( c2.equals(c1) , "#02-01" ) ;
            assertTrue  ( c2.equals(c2) , "#02-02" ) ;
            assertFalse ( c2.equals(c3) , "#02-03" ) ;
            
            assertFalse ( c3.equals(c1) , "#03-01" ) ;
            assertFalse ( c3.equals(c2) , "#03-02" ) ;
            assertTrue  ( c3.equals(c3) , "#03-03" ) ;
            
            var s:HashSet = new HashSet([1,2,3,4]) ;
            assertFalse( c1.equals(s) , "#04" ) ;
        }
        
        public function testGet():void
        {
            var co:ArrayCollection = new ArrayCollection() ;
            co.add("test") ;
            assertEquals( co.get(0) , "test" ,  "#01") ;
            assertUndefined( co.get(1)       ,  "#02" ) ;
        }
        
        public function testIndexOf():void
        {
            var co:ArrayCollection = new ArrayCollection() ;
            
            co.add("item1") ;
            co.add("item2") ;
            co.add("item3") ;
            
            assertEquals( co.indexOf("item4") , -1 ,  "#01") ;
            assertEquals( co.indexOf("item1") , 0  ,  "#02") ;
            assertEquals( co.indexOf("item3") , 2  ,  "#03") ;
            
            assertEquals( co.indexOf("item3", 1) , 2  , "#04") ;
        }
        
        public function testIsEmpty():void
        {
            var co:ArrayCollection = new ArrayCollection() ;
            
            assertTrue( co.isEmpty() , "#01") ;
            
            co.add("test") ;
            
            assertFalse( co.isEmpty() , "#02") ;
            
            co.remove("test") ;
            
            assertTrue( co.isEmpty() , "#03") ;
        }
        
        public function testIterator():void
        {
            var co:ArrayCollection = new ArrayCollection() ;
            var it:Iterator         = co.iterator() ;
            assertTrue  ( it is ArrayIterator , "01 - ArrayCollection iterator failed." ) ;
        }
        
        public function testRemove():void
        {
            var co:ArrayCollection = new ArrayCollection() ;
            
            co.add("item1") ;
            co.add("item2") ;
            
            assertTrue  ( co.remove("item1") , "01 - ArrayCollection remove failed." ) ;
            assertFalse ( co.remove("item5") , "02 - ArrayCollection remove failed." ) ;
        }
        
        public function testRemoveAll():void
        {
            var c1:ArrayCollection = new ArrayCollection([1,2,3,4]) ;
            var c2:ArrayCollection = new ArrayCollection([2,3]) ;
            var c3:ArrayCollection = new ArrayCollection() ;
            assertTrue( c1.removeAll( c2 ) , "01 - ArrayCollection removeAll failed.") ;
            ArrayAssert.assertEquals( c1.toArray() , [1,4], "02 - ArrayCollection removeAll failed.") ;
            assertFalse( c1.removeAll(c3) , "03 - ArrayCollection removeAll failed.") ;
        }
        
        public function testRetainAll():void
        {
            var c1:ArrayCollection = new ArrayCollection([1,2,3,4]) ;
            var c2:ArrayCollection = new ArrayCollection([2,3]) ;
            var c3:ArrayCollection = new ArrayCollection() ;
            var c4:ArrayCollection = new ArrayCollection([5,6]) ;
            
            assertTrue( c1.retainAll(c2) , "01 - ArrayCollection retainAll failed.") ;
            ArrayAssert.assertEquals( c1.toArray() , [2,3], "02 - retainAll removeAll failed.") ;
            
            assertTrue( c1.retainAll(c3) , "03 - ArrayCollection retainAll failed.") ;
            assertEquals( c1.toString(), "{}" , "04 - ArrayCollection retainAll failed.") ;
            
            assertFalse( c1.retainAll(c4) , "05 - ArrayCollection retainAll failed.") ;
        } 
        
        public function testSize():void
        {
            var co:ArrayCollection = new ArrayCollection() ;
            assertEquals( co.size() , 0 ,  "01 - ArrayCollection size failed.") ;
            co.add("test") ;
            assertEquals( co.size() , 1 ,  "02 - ArrayCollection size failed.") ;
        }
        
        public function testToArray():void
        {
            var c:ArrayCollection ;
            var a:Array ;
            
            // empty collection
            
            // initialize with an Array
            
            c = new ArrayCollection() ;
            a = c.toArray() ;
            
            assertNotNull( a , "#01-02") ;
            ArrayAssert.assertEquals( a , [], "#01-02") ;
            
            c.add(2) ;
            c.add(3) ;
            c.add(4) ; 
            
            a = c.toArray() ;
            
            assertNotNull( a , "#02-02") ;
            ArrayAssert.assertEquals( a , [2,3,4], "#02-02") ;
        }
        
        public function testToSource():void
        {
            var co:ArrayCollection ;
            var ar:Array = ["item1", "item2"] ;
            
            co = new ArrayCollection() ;
            assertEquals(co.toSource() , "new system.data.collections.ArrayCollection()" , "#01") ;
            
            co = new ArrayCollection( ar ) ;
            assertEquals(co.toSource() , "new system.data.collections.ArrayCollection([\"item1\",\"item2\"])" , "#02") ;
        }
        
        public function testToString():void
        {
            var ar:Array = ["item1", "item2", "item3", "item4"] ;
            var co:ArrayCollection = new ArrayCollection( ar ) ;
            assertEquals(co.toString() , "{item1,item2,item3,item4}") ;
        }
    }
}
