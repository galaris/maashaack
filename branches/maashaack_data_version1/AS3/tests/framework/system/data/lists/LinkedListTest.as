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

package system.data.lists 
{
    import buRRRn.ASTUce.framework.ArrayAssert;
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.Equatable;
    import system.data.List;
    import system.data.Queue;
    import system.data.collections.ArrayCollection;
    import system.data.maps.ArrayMap;
    import system.data.sets.HashSet;    

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
            ArrayAssert.assertEquals( l.toArray(), [ "item0" , "item1" ], "LinkedList addBefore method failed.") ;
        }
        
        public function testAddFirst():void
        {
            var l:LinkedList = new LinkedList([ "item1" ] ) ;
            l.addFirst( "item0" ) ;  
            ArrayAssert.assertEquals( l.toArray(), [ "item0" , "item1" ], "LinkedList addFirst method failed.") ;
        } 
        
        public function testAddLast():void
        {
            var l:LinkedList = new LinkedList([ "item1" , "item2" ] ) ;
            l.addLast( "item3" ) ;  
            ArrayAssert.assertEquals( l.toArray(), [ "item1" , "item2" , "item3"], "LinkedList addLast method failed.") ;
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
        
    }
}
