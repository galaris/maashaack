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

package system.data.lists 
{
    import buRRRn.ASTUce.framework.ArrayAssert;
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.Equatable;
    import system.data.Iterator;
    import system.data.List;
    import system.data.ListIterator;
    import system.data.Queue;
    import system.data.collections.ArrayCollection;
    import system.data.maps.ArrayMap;
    import system.data.sets.HashSet;
    import system.errors.NoSuchElementError;    

    public class LinkedListTest extends TestCase 
    {
        public function LinkedListTest(name:String = "")
        {
            super( name );
        }
        
        public function testConstructor():void
        {
            var list:LinkedList = new LinkedList() ;
            assertNotNull( list , "LinkedList constructor failed.");
        }
        
        public function testConstructorWithArguments():void
        {   
            var list:LinkedList ;
            
            // initialize with an Array
                        
            list = new LinkedList([2,3,4]) ; 
            assertNotNull(list, "02-01 - LinkedList constructor failed.") ;
            ArrayAssert.assertEquals( list.toArray(), [2,3,4], "02-02 - LinkedList constructor failed.") ;
            
            // initialize with a Collection
            
            list = new LinkedList( new ArrayCollection([2,3,4])) ; 
            assertNotNull(list, "03-01 - LinkedList constructor failed.") ;
            ArrayAssert.assertEquals( list.toArray(), [2,3,4], "03-02 - LinkedList constructor failed.") ;
            
            // initialize with an Iterable object
            
            list = new LinkedList( new ArrayMap( ["item1", "item2", "item3"], [2,3,4]) ) ; 
            assertNotNull(list, "04-01 - LinkedList constructor failed.") ;
            ArrayAssert.assertEquals( list.toArray(), [2,3,4], "04-02 - LinkedList constructor failed.") ;
        }
        
        public function testInterface():void
        {
            var list:LinkedList = new LinkedList() ;
            assertTrue( list is Equatable , "01 - LinkedList must implement the Equatable interface.");
            assertTrue( list is List      , "02 - LinkedList must implement the List interface.");
            assertTrue( list is Queue     , "03 - LinkedList must implement the Queue interface.");
        }        
        
        public function testModcount():void
        {
            var list:LinkedList = new LinkedList() ;
            assertEquals( list.modCount , 0 , "01 - LinkedList modCount property failed."  ) ;
            list.modCount = 2 ;
            assertEquals( list.modCount , 2 , "02 - LinkedList modCount property failed."  ) ;
        }
        
        public function testAdd():void
        {
            var list:LinkedList = new LinkedList() ;
            var count:int = list.modCount ;
            assertTrue( list.add("item1") , "01 - LinkedList add method failed." ) ;
            assertEquals( list.modCount , count + 1  , "02 - LinkedList modCount property failed."  ) ;
            assertEquals( list.size() , 1 , "03 - LinkedList add method failed." ) ;
        }      

        public function testAddAll():void
        {
            var list:LinkedList = new LinkedList() ;
            var count:int = list.modCount ;
            assertTrue( list.addAll( new ArrayCollection(["item1","item2"]) ) , "01 - LinkedList addAll method failed." ) ;
            assertEquals( list.modCount , count + 1  , "02 - LinkedList addAll method failed."  ) ; // count + number of items in added in the collection + one modification == 3
            assertEquals( list.size() , 2 , "03 - LinkedList addAll method failed." ) ;
            assertFalse( list.addAll( new ArrayCollection() ) , "04 - LinkedList addAll method failed." ) ;            
            assertFalse( list.addAll(null) , "05 - LinkedList addAll method failed." ) ;
        }
        
        public function testAddAt():void
        {
            var list:LinkedList = new LinkedList([ "item1", "item2", "item3" ] ) ;
            var count:int = list.modCount ;
            list.addAt( 1 , "item4" ) ;
            assertEquals( list.modCount , count + 1  , "01 - LinkedList addAt method failed."  ) ; // count + number of items in added in the collection + one modification == 3
            assertEquals( list.size() , 4 , "02 - LinkedList addAt method failed." ) ;
            try
            {
                list.addAt(100, "value");
                fail(  "03-01 - LinkedList addAt method failed, must throw a RangeError." ) ;
            }
            catch( e:Error )
            {
                assertTrue( e is RangeError , "03-02 - LinkedList addAt method failed, must throw a RangeError.") ;
                assertEquals( e.message , "LinkedList.addAt() method failed, the specified index '100' is out of bounds.", "03-03 - LinkedList addAt method failed, must throw a RangeError.") ;
            }
        }             
        
        public function testAddBefore():void
        {
            var l:LinkedList = new LinkedList([ "item1" ] ) ;
            var e:LinkedListEntry = l.getHeader() ; 
            
            e = e.next ; // "item1"
            
            e = l.addBefore( "item0" , e ) ;  
            ArrayAssert.assertEquals( l.toArray(), [ "item0" , "item1" ] , "LinkedList addBefore method failed.") ;
        }
        
        public function testAddFirst():void
        {
            var l:LinkedList = new LinkedList([ "item1" ] ) ;
            l.addFirst( "item0" ) ;  
            ArrayAssert.assertEquals( l.toArray(), [ "item0" , "item1" ] , "LinkedList addFirst method failed.") ;
        } 
        
        public function testAddLast():void
        {
            var l:LinkedList = new LinkedList([ "item1" , "item2" ] ) ;
            l.addLast( "item3" ) ;  
            ArrayAssert.assertEquals( l.toArray(), [ "item1" , "item2" , "item3"] , "LinkedList addLast method failed.") ;
        }          
        
        public function testClear():void
        {
            var list:LinkedList = new LinkedList([ "item1", "item2", "item3" ] ) ;
            var count:int = list.modCount ;
            list.clear() ;
            assertEquals( list.modCount , count + 1  , "01 - LinkedList clear method failed."  ) ; 
            assertEquals( list.size() , 0 , "02 - LinkedList clear method failed." ) ;
        }
        
        public function testClone():void
        {
            var list:LinkedList = new LinkedList([ "item1", "item2", "item3" ] ) ;
            var clone:LinkedList = list.clone() as LinkedList ;
            assertNotNull( clone , "01 - LinkedList clone method failed." ) ;
            assertEquals( list.size() , 3 , "02 - LinkedList clone method failed." ) ;
            ArrayAssert.assertEquals( list.toArray(), clone.toArray(), "03 - LinkedList clone method failed.") ;
        } 
        
        public function testContains():void
        {
            var l:LinkedList = new LinkedList() ;
            l.add("item") ;
            assertTrue( l.contains("item") ,  "01 - LinkedList contains failed.") ;
            assertFalse( l.contains("test") ,  "02 - LinkedList contains failed.") ;
        } 
        
        public function testContainsAll():void
        {
            var l1:LinkedList = new LinkedList([1,2,3,4]) ;
            var l2:LinkedList = new LinkedList([2,3]) ;
            var l3:LinkedList = new LinkedList() ;
            assertTrue( l1.containsAll(l2) , "01 - LinkedList containsAll failed.") ;
            assertTrue( l1.containsAll(l3) , "02 - LinkedList containsAll failed.") ;
            assertFalse( l2.containsAll(l1) , "03 - LinkedList containsAll failed.") ;
        }       
        
        public function testDequeue():void
        {
            var l:LinkedList = new LinkedList([1,2]) ;
            assertTrue ( l.dequeue() , "01 - LinkedList dequeue method failed." ) ;
            ArrayAssert.assertEquals( l.toArray(), [2], "02 - LinkedList dequeue method failed.") ;
        }
        
        public function testElement():void
        {
            var l:LinkedList = new LinkedList([1,2]) ;
            assertEquals ( l.element(), 1, "LinkedList element method failed." ) ;
        }
        
        public function testEquals():void
        {
            
            var l1:LinkedList = new LinkedList([1,2,3,4]) ;
            var l2:LinkedList = new LinkedList([1,2,3,4]) ;
            var l3:LinkedList = new LinkedList([2,3]) ;
            var l4:LinkedList = new LinkedList([5,6,7,8]) ;
            
            assertTrue  ( l1.equals(l1) , "01-01 - LinkedList equals failed." ) ;
            assertTrue  ( l1.equals(l2) , "01-02 - LinkedList equals failed." ) ;
            assertFalse ( l1.equals(l3) , "01-03 - LinkedList equals failed." ) ;
            assertFalse ( l1.equals(l4) , "01-04 - LinkedList equals failed." ) ; // same size
            
            assertTrue  ( l2.equals(l1) , "02-01 - LinkedList equals failed." ) ;
            assertTrue  ( l2.equals(l2) , "02-02 - LinkedList equals failed." ) ;
            assertFalse ( l2.equals(l3) , "02-03 - LinkedList equals failed." ) ;
            
            assertFalse ( l3.equals(l1) , "03-01 - LinkedList equals failed." ) ;
            assertFalse ( l3.equals(l2) , "03-02 - LinkedList equals failed." ) ;
            assertTrue  ( l3.equals(l3) , "03-03 - LinkedList equals failed." ) ;
            
            var l:LinkedList = new LinkedList([1,2,3,4]) ;
            var s:HashSet = new HashSet([1,2,3,4]) ;
            assertFalse( l.equals(s) , "04 - LinkedList equals failed." ) ;

        } 
        
        public function testEnqueue():void
        {           
            var l:LinkedList = new LinkedList();
            assertTrue ( l.enqueue("item1"), "01 - LinkedList equals failed." ) ;
            assertTrue ( l.enqueue("item2"), "02 - LinkedList equals failed." ) ;
            assertEquals ( l.size() , 2, "03 - LinkedList equals failed." ) ;
        }
        
        public function testGet():void
        {
            var l:LinkedList = new LinkedList(["item1","item2"]) ;
            assertEquals ( l.get(0), "item1" , "01 - LinkedList get failed.") ;
            assertEquals ( l.get(1), "item2" , "02 - LinkedList get failed.") ;
            try
            {
                l.get(2) ;
                fail("03-01 - LinkedList get failed.") ;
            }
            catch( e:Error )
            {
                assertTrue( e is NoSuchElementError , "03-02 - LinkedList get failed.") ;
                assertEquals( e.message , "LinkedList.get() no value exist at 2" , "03-03 - LinkedList get failed.") ;
            }
        }
        
        public function testGetFirst():void
        {
            var l:LinkedList = new LinkedList(["item1","item2"]) ;
            assertEquals ( l.getFirst(), "item1" , "01 - LinkedList getFirst failed.") ;
            l.clear() ;
            try
            {
                l.getFirst() ;
                fail("02-01 - LinkedList getFirst failed.") ;
            }
            catch( e:Error )
            {
                assertTrue( e is NoSuchElementError , "02-02 - LinkedList getFirst failed.") ;
                assertEquals( e.message , "LinkedList.getFirst() method failed, the list is empty." , "02-03 - LinkedList getFirst failed.") ;
            }
        }
        
        public function testGetHeader():void
        {
            var l:LinkedList = new LinkedList(["item1","item2"]) ;
            var e:LinkedListEntry = l.getHeader() ;
            
            assertNotNull( e , "01 - LinkedList getHeader failed." ) ;
            
            assertNull( e.element , "02 - LinkedList getHeader failed." ) ;
            
            assertNotNull( e.previous , "03-01 - LinkedList getHeader failed." ) ;
            assertEquals( e.previous.element , "item2", "03-02 - LinkedList getHeader failed." ) ;
            
            assertNotNull( e.next     , "04-01 - LinkedList getHeader failed." ) ;
            assertEquals( e.next.element , "item1", "04-02 - LinkedList getHeader failed." ) ;
        }
        
        public function testGetLast():void
        {
            var l:LinkedList = new LinkedList(["item1","item2"]) ;
            
            assertEquals ( l.getLast(), "item2" , "01 - LinkedList getLast failed.") ;
            l.clear() ;
            
            try
            {
                l.getLast() ;
                fail("02-01 - LinkedList get failed.") ;
            }
            catch( e:Error )
            {
                assertTrue( e is NoSuchElementError , "02-02 - LinkedList getLast failed.") ;
                assertEquals( e.message , "LinkedList.getLast() method failed, the list is empty." , "02-03 - LinkedList getLast failed.") ;
            }
        }
         
        public function testIndexOf():void
        {
            var l:LinkedList = new LinkedList(["item1","item2"]) ;
            assertEquals ( l.indexOf("item2"), 1 , "01 - LinkedList indexOf failed.") ;            
            assertEquals ( l.indexOf("item4"), -1 , "02 - LinkedList indexOf failed.") ;
        }
        
        public function testIndexOfWithFromIndex():void
        {
            var l:LinkedList = new LinkedList(["item1","item2","item3","item4","item3"]) ;
            
            assertEquals ( l.indexOf("item2", 1),  1 , "01-01 - LinkedList indexOf failed.") ;         
            assertEquals ( l.indexOf("item2", 2), -1 , "01-02 - LinkedList indexOf failed.") ;
            
            assertEquals ( l.indexOf("item3", 1),  2 , "02-01 - LinkedList indexOf failed.") ;         
            assertEquals ( l.indexOf("item3", 2),  2 , "02-02 - LinkedList indexOf failed.") ;  
            assertEquals ( l.indexOf("item3", 3),  4 , "02-03 - LinkedList indexOf failed.") ;
            assertEquals ( l.indexOf("item3", 5),  2 , "02-04 - LinkedList indexOf failed.") ; // range error, index = 0
        } 
        
        public function testIsEmpty():void
        {
            var l:LinkedList = new LinkedList(["item1","item2"]) ;
            assertFalse ( l.isEmpty() , "01 - LinkedList isEmpty failed.") ;
            l.clear() ;
            assertTrue ( l.isEmpty() , "02 - LinkedList isEmpty failed.") ;
        }
        
        public function testIterator():void 
        {
            var it:Iterator ;
            
            var l:LinkedList = new LinkedList() ;
            
            it = l.iterator() ;
            assertFalse( it.hasNext() , "01 - LinkedList iterator failed.") ;
            
            l.add("item1") ;
            it = l.iterator() ;
            assertTrue( it.hasNext() , "02 - LinkedList iterator failed.") ;
            assertEquals( it.next() , "item1", "03 - LinkedList iterator failed.") ;
            assertFalse( it.hasNext() , "04 - LinkedList iterator failed.") ;
        }
        
        public function testLastIndexOf():void
        {
            var l:LinkedList = new LinkedList(["item1","item2","item3","item2","item4" ]) ;
            assertEquals ( l.lastIndexOf("item1"),  0 , "01 - LinkedList lastIndexOf failed.") ;
            assertEquals ( l.lastIndexOf("item2"),  3 , "02 - LinkedList lastIndexOf failed.") ;
            assertEquals ( l.lastIndexOf("item4"),  4 , "03 - LinkedList lastIndexOf failed.") ;
            assertEquals ( l.lastIndexOf("item5"), -1 , "04 - LinkedList lastIndexOf failed.") ;
        }  

        public function testLastIndexOfWithFromIndex():void
        {
            var l:LinkedList = new LinkedList(["item1","item2","item3","item4","item3"]) ;

            assertEquals ( l.lastIndexOf("item2", 0), -1 , "01-01 - LinkedList lastIndexOf failed.") ;            
            assertEquals ( l.lastIndexOf("item2", 1),  1 , "01-02 - LinkedList lastIndexOf failed.") ;
            assertEquals ( l.lastIndexOf("item2", 2),  1 , "01-03 - LinkedList lastIndexOf failed.") ;
            assertEquals ( l.lastIndexOf("item2", 3),  1 , "01-04 - LinkedList lastIndexOf failed.") ;
            assertEquals ( l.lastIndexOf("item2", 4),  1 , "01-05 - LinkedList lastIndexOf failed.") ;
            assertEquals ( l.lastIndexOf("item2", 5),  1 , "01-06 - LinkedList lastIndexOf failed.") ;
            
            assertEquals ( l.lastIndexOf("item3", 0), -1 , "02-01 - LinkedList lastIndexOf failed.") ;
            assertEquals ( l.lastIndexOf("item3", 1), -1 , "02-01 - LinkedList lastIndexOf failed.") ;
            assertEquals ( l.lastIndexOf("item3", 2),  2 , "02-03 - LinkedList lastIndexOf failed.") ;
            assertEquals ( l.lastIndexOf("item3", 3),  2 , "02-04 - LinkedList lastIndexOf failed.") ;
            assertEquals ( l.lastIndexOf("item3", 4),  4 , "02-05 - LinkedList lastIndexOf failed.") ;
            assertEquals ( l.lastIndexOf("item3", 5),  4 , "02-06 - LinkedList lastIndexOf failed.") ;
        } 

        public function testListIterator():void
        {
             var it:ListIterator ;
            
            var l:LinkedList = new LinkedList() ;
            
            it = l.listIterator() ;
            assertFalse( it.hasNext() , "01 - LinkedList listIterator failed.") ;
            
            l.add("item1") ;
            
            it = l.listIterator() ;
            assertTrue( it.hasNext() , "02-01 - LinkedList listIterator failed.") ;
            assertEquals( it.next() , "item1", "02-02 - LinkedList listIterator failed.") ;
            assertFalse( it.hasNext() , "02-03 - LinkedList listIterator failed.") ;
            
            assertTrue( it.hasPrevious() , "03-01 - LinkedList listIterator failed.") ;
            assertEquals( it.previous() , "item1", "03-02 - LinkedList listIterator failed.") ;
            
            l.add("item2") ;
            l.add("item3") ;
            
            it = l.listIterator(2) ;
            assertTrue( it.hasPrevious() , "04-01 - LinkedList listIterator failed.") ;
            assertEquals( it.previous() , "item2", "04-02 - LinkedList listIterator failed.") ;
        }
        
        public function testPeek():void
        {
            var l:LinkedList = new LinkedList(["item1","item2","item3"]) ;
            assertEquals( l.peek(), "item1", "01 - LinkedList peek failed." ) ;
            assertEquals( l.size(), 3, "02 - LinkedList peek failed." ) ;
        }
        
        public function testPoll():void
        {
            var l:LinkedList = new LinkedList(["item1","item2","item3"]) ;
            assertEquals( l.poll(), "item1", "01 - LinkedList poll failed." ) ;
            assertEquals( l.size(), 2, "02 - LinkedList poll failed." ) ;
        } 
        
        public function testRemove():void
        {
            var l:LinkedList = new LinkedList(["item1","item2","item3"]) ;
            assertTrue( l.remove("item2"), "01 - LinkedList remove failed." ) ;
            assertEquals( l.size(), 2, "02 - LinkedList remove failed." ) ;
            
            // TODO : test Equatable object to remove and null object
        }         
     
        public function testRemoveAll():void
        {
            var l:LinkedList = new LinkedList(["item1","item2","item3"]) ;
            assertFalse( l.removeAll( null ) , "01 - LinkedList removeAll failed." ) ;
            assertTrue( l.removeAll( new ArrayCollection(["item1", "item2"] ) ) , "02 - LinkedList removeAll failed." ) ;
            assertEquals( l.size(), 1, "03 - LinkedList removeAll failed." ) ;     
        } 
        
        public function testRemoveAt():void
        {
            
            var l:LinkedList ;
            
            l = new LinkedList(["item1","item2","item3","item4"]) ;
            ArrayAssert.assertEquals( l.removeAt(0), ["item1"] , "01-01 - LinkedList removeAt failed." ) ;
            ArrayAssert.assertEquals( l.toArray() , [ "item2" , "item3" , "item4" ] , "01-02 - LinkedList removeAt failed." ) ;
            
            l = new LinkedList(["item1","item2","item3","item4"]) ;
            ArrayAssert.assertEquals( l.removeAt(1) , [ "item2" ] , "02-01 - LinkedList removeAt failed." ) ; 
            ArrayAssert.assertEquals( l.toArray()   , ["item1" , "item3" , "item4" ] , "02-02 - LinkedList removeAt failed." ) ;
            
            l = new LinkedList(["item1","item2","item3","item4"]) ;
            ArrayAssert.assertEquals( l.removeAt(1,0) , [ "item2" ] , "03 - LinkedList removeAt failed." ) ; 
            
            l = new LinkedList(["item1","item2","item3","item4"]) ;
            ArrayAssert.assertEquals( l.removeAt(1,1) , [ "item2" ] , "04 - LinkedList removeAt failed." ) ;
            
            l = new LinkedList(["item1","item2","item3","item4"]) ;
            ArrayAssert.assertEquals( l.removeAt(1,2 ) , [ "item2" , "item3" ] , "05-01 - LinkedList removeAt failed." ) ; 
            ArrayAssert.assertEquals( l.toArray()      , [ "item1" , "item4" ] , "05-02 - LinkedList removeAt failed." ) ;            
            
        }
        
        public function testRemoveEntry():void
        {
            var l:LinkedList = new LinkedList([ "item1" , "item2" ] ) ;
            var e:LinkedListEntry = l.getHeader() ; 
            
            e = e.next ; // "item1"
            
            var count:uint = l.modCount ;
            
            assertEquals( l.removeEntry( e ) , "item1"   , "01 - LinkedList removeEntry failed." );
            assertEquals( l.modCount         , count + 1 , "02 - LinkedList removeEntry failed." ) ;
            assertEquals( l.toString()       , "{item2}" , "03 - LinkedList removeEntry failed." ) ;
        }
        
        public function testRemoveFirst():void
        {
            var l:LinkedList = new LinkedList([ "item1" , "item2" ] ) ;
            l.removeFirst() ;  
            ArrayAssert.assertEquals( l.toArray(), [ "item2" ], "LinkedList removeFirst method failed.") ;
        } 
        
        public function testRemoveLast():void
        {
            var l:LinkedList = new LinkedList([ "item1" , "item2" ] ) ;
            l.removeLast() ;  
            ArrayAssert.assertEquals( l.toArray(), [ "item1" ], "LinkedList removeLast method failed.") ;
        } 
        
        public function testRemoveRange():void
        {
            var list:LinkedList ;
            var count:int ;
            var result:* ;
            
            //// list.removeRange(0,1) :: fromIndex == toIndex
                        
            list   = new LinkedList( ["item1", "item2" , "item3" , "item4" , "item5" ] ) ; 
            count  = list.modCount ;
            
            result = list.removeRange(0,1) as Array ; 
            
            assertNotNull( result , "00-01 - LinkedList removeRange method failed." ) ;
            assertEquals( list.modCount    , count + 1 , "00-02 - LinkedList removeRange method failed."  ) ;
            assertEquals( list.size()      , 4         , "00-03 - LinkedList removeRange method failed." ) ;
            ArrayAssert.assertEquals( list.toArray()   , ["item2","item3","item4", "item5"] , "00-04 - LinkedList removeRange method failed." ) ;
            ArrayAssert.assertEquals( result           , ["item1"] , "00-05 - LinkedList removeRange method failed." ) ;
                        
            
            //// list.removeRange(1,1) :: fromIndex == toIndex
                        
            list   = new LinkedList( ["item1", "item2" , "item3" , "item4" , "item5" ] ) ; 
            count  = list.modCount ;
            
            result = list.removeRange(1,1) as Array ; 
            
            assertNotNull( result , "01-01 - LinkedList removeRange method failed." ) ;
            assertEquals( list.modCount    , count + 1 , "01-02 - LinkedList removeRange method failed."  ) ;
            assertEquals( list.size()      , 4         , "01-03 - LinkedList removeRange method failed." ) ;
            ArrayAssert.assertEquals( list.toArray()   , ["item1","item3","item4", "item5"] , "01-04 - LinkedList removeRange method failed." ) ;
            ArrayAssert.assertEquals( result           , ["item2"] , "01-05 - LinkedList removeRange method failed." ) ;
            
            //// list.removeRange(1,2) :: fromIndex < toIndex
            
            list   = new LinkedList( ["item1", "item2" , "item3" , "item4" , "item5" ] ) ; 
            
            count  = list.modCount ;
            result = list.removeRange(1,2) as Array ;
            
            assertNotNull( result , "02-01 - LinkedList removeRange method failed." ) ;
            assertEquals( list.modCount    , count + 1 , "02-02 - LinkedList removeRange method failed."  ) ;
            assertEquals( list.size()      , 4         , "02-03 - LinkedList removeRange method failed." ) ;
            ArrayAssert.assertEquals( list.toArray()   , ["item1","item3","item4", "item5"] , "02-04 - LinkedList removeRange method failed." ) ;
            ArrayAssert.assertEquals( result           , ["item2"] , "02-05 - LinkedList removeRange method failed." ) ;     
            
            //// list.removeRange(1,3)
            
            list   = new LinkedList( ["item1", "item2" , "item3" , "item4" , "item5" ] ) ; 
            
            count  = list.modCount ;
            result = list.removeRange(1,3) as Array ;
            
            assertNotNull( result , "03-01 - LinkedList removeRange method failed." ) ;
            assertEquals( list.modCount    , count + 2 , "03-02 - LinkedList removeRange method failed."  ) ; // count + number of removed items
            assertEquals( list.size()      , 3         , "03-03 - LinkedList removeRange method failed." ) ;
            ArrayAssert.assertEquals( list.toArray()   , ["item1","item4", "item5"] , "03-04 - LinkedList removeRange method failed." ) ;
            ArrayAssert.assertEquals( result           , ["item2","item3"] , "03-05 - LinkedList removeRange method failed." ) ;     
            
            //// list.removeRange(6,10)
            
            try
            {
                list.removeRange(6,10) ;
                fail("04-01 - LinkedList removeRange method failed.") ;
            }
            catch( e:Error )
            {
                assertTrue( e is RangeError , "04-02 - LinkedList removeRange method failed." ) ;
                assertEquals( e.message , "LinkedList.removeRange(6,10) failed with a fromIndex value out of bounds, fromIndex > size()." , "04-03 - LinkedList removeRange method failed." ) ;
            }
            
            //// list.removeRange(3,1)
            
            try
            {
                list.removeRange(3,1) ;
                fail("05-01 - LinkedList removeRange method failed.") ;
            }
            catch( e:Error )
            {
                assertTrue( e is RangeError , "05-02 - LinkedList removeRange method failed." ) ;
                assertEquals( e.message , "LinkedList.removeRange(3,1) failed with a fromIndex value out of bounds, fromIndex > size()." , "05-03 - LinkedList removeRange method failed." ) ;
            }            
            
        }
        
        public function testRetainAll():void
        {
            var l1:LinkedList = new LinkedList([1,2,3,4]) ;
            var l2:LinkedList = new LinkedList([2,3]) ;
            var l3:LinkedList = new LinkedList() ;
            var l4:LinkedList = new LinkedList([5,6]) ;
            
            assertTrue( l1.retainAll( l2 ) , "01 - LinkedList retainAll failed.") ;
            ArrayAssert.assertEquals( l1.toArray() , [2,3], "02 - LinkedList retainAll removeAll failed.") ;   
            
            assertTrue( l1.retainAll( l3 ) , "03 - LinkedList retainAll failed.") ;
            assertEquals( l1.toString(), "{}" , "04 - LinkedList retainAll failed.") ;
            
            assertFalse( l1.retainAll( l4 ) , "05 - LinkedList retainAll failed.") ;            
        }
        
        public function testSet():void
        {

            var count:int ; 
            var list:LinkedList = new LinkedList( [ "item1", "item2", "item3", "item4" ] ) ;
            
            count = list.modCount ;
            assertEquals( list.set(0, "hello") , "item1" , "01-01 - LinkedList set method failed." ) ;
            ArrayAssert.assertEquals( list.toArray() , ["hello","item2","item3","item4"] , "01-02 - LinkedList set method failed." ) ;
            assertEquals( list.modCount    , count + 1 , "01-03 - LinkedList set method failed."  ) ;
            
            try
            {
                list.set( 10 , "foo" ) ;
                fail("02-01 - LinkedList set method failed.") ;
            }
            catch( e:Error )
            {
                assertTrue( e is NoSuchElementError  , "02-02 - LinkedList set method failed." ) ;
                assertEquals( e.message , "LinkedList.set() method failed at:10" , "02-03 - LinkedList set method failed." ) ;
            }
        }
        
        public function testSize():void
        {
            var l:LinkedList = new LinkedList() ;

            assertEquals( l.size() , 0 , "01 - LinkedList size() failed.") ;
            
            l.add("item1") ;
            assertEquals( l.size() , 1 , "02 - LinkedList size() failed.") ;
            
            l.add("item2") ;
            assertEquals( l.size() , 2 , "03 - LinkedList size() failed.") ;
            
            l.clear() ;
            assertEquals( l.size() , 0 , "04 - LinkedList size() failed.") ;
        }
        
        public function testSubList():void
        {
            var sub:List ;
            
            var list:LinkedList = new LinkedList( [ "item1", "item2", "item3", "item4" ] ) ;
            
            sub = list.subList( 0, 0 ) as LinkedList ;
            assertNotNull(sub, "01-01 - LinkedList.subList method failed.") ;
            ArrayAssert.assertEquals( sub.toArray() , [] , "01-02 - LinkedList.subList method failed." ) ;

            sub = list.subList( 0, 1 ) as LinkedList ;
            ArrayAssert.assertEquals( sub.toArray() , ["item1"] , "02 - LinkedList.subList method failed." ) ;
            
            sub = list.subList( 0, 2 ) as LinkedList ;
            ArrayAssert.assertEquals( sub.toArray() , ["item1","item2"] , "03 - LinkedList.subList method failed." ) ;

            sub = list.subList( 0, 3 ) as LinkedList ;
            ArrayAssert.assertEquals( sub.toArray() , ["item1", "item2","item3"] , "04 - LinkedList.subList method failed." ) ;

            sub = list.subList( 0, 4 ) as LinkedList ;
            ArrayAssert.assertEquals( sub.toArray() , ["item1", "item2","item3","item4"] , "05 - LinkedList.subList method failed." ) ;

            sub = list.subList( 2, 4 ) as LinkedList ;
            ArrayAssert.assertEquals( sub.toArray() , ["item3","item4"] , "06 - LinkedList.subList method failed." ) ;

            sub = list.subList( 3, 1 ) as LinkedList ;
            ArrayAssert.assertEquals( sub.toArray() , [] , "07 - LinkedList.subList method failed." ) ;
        }
        
        public function testToArray():void
        {
            var l:LinkedList ;
            var a:Array ;
            l = new LinkedList() ;
            a = l.toArray() ;
            assertNotNull( a , "01-02 - LinkedList toArray failed.") ;
            ArrayAssert.assertEquals( a , [], "01-02 - LinkedList toArray failed.") ;            
            l.add(2) ;
            l.add(3) ;
            l.add(4) ; 
            a = l.toArray() ;
            assertNotNull( a , "02-02 - LinkedList constructor failed.") ;
            ArrayAssert.assertEquals( a , [2,3,4], "02-02 - LinkedList constructor failed.") ;
        }
        
        public function testToSource():void
        {
            var li:LinkedList ;
            var ar:Array = ["item1", "item2"] ;
            
            li = new LinkedList() ;
            assertEquals(li.toSource() , "new system.data.lists.LinkedList()" , "01 - LinkedList toSource failed") ;
            
            li = new LinkedList( ar ) ;
            assertEquals(li.toSource() , "new system.data.lists.LinkedList([\"item1\",\"item2\"])" , "02 - LinkedList toSource failed") ;
        }
        
        public function testToString():void
        {
            var li:LinkedList ;            
            var ar:Array = ["item1", "item2", "item3", "item4"] ;
            li = new LinkedList() ;
            assertEquals(li.toString() , "{}", "01 - LinkedList toString failed") ;
            li = new LinkedList( ar ) ;
            assertEquals(li.toString() , "{item1,item2,item3,item4}", "02 - LinkedList toString failed") ;
        }      
    }
}
