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
 
package system.data.queues 
{
    import buRRRn.ASTUce.framework.ArrayAssert;
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.data.Boundable;
    import system.data.Iterator;
    import system.data.Queue;
    import system.data.iterators.ProtectedIterator;
    
    import flash.errors.IllegalOperationError;
    
    public class CircularQueueTest extends TestCase 
    {
        public function CircularQueueTest(name:String = "")
        {
            super( name );
        }
        
        public function testConstructor():void
        {
            var q:CircularQueue ;
            
            q = new CircularQueue() ;
            assertNotNull( q , "01 - The CircularQueue constructor failed.") ;
            
            assertEquals( q.maxSize(), CircularQueue.MAX_CAPACITY , "02 - The CircularQueue constructor failed." ) ;
            
            q = new CircularQueue(0) ;
            assertEquals( q.maxSize(), 0 , "03 - The CircularQueue constructor failed." ) ;
            
            q = new CircularQueue(1) ;
            assertEquals( q.maxSize(), 1 , "04 - The CircularQueue constructor failed." ) ;
            
            q = new CircularQueue(4, []) ;
            assertEquals( q.maxSize(), 4 , "05-01 - The CircularQueue constructor failed." ) ;
            assertEquals( q.size(), 0 , "05-02 - The CircularQueue constructor failed." ) ;
            
            q = new CircularQueue(4, [1,2,3,4]) ;
            assertEquals( q.maxSize(), 4 , "06-01 - The CircularQueue constructor failed." ) ;
            assertEquals( q.size(), 4 , "06-02 - The CircularQueue constructor failed." ) ;
            
            q = new CircularQueue(4, [1,2,3,4,5,6,7]) ;
            assertEquals( q.maxSize(), 4 , "07-01 - The CircularQueue constructor failed." ) ;
            assertEquals( q.size(), 4 , "07-02 - The CircularQueue constructor failed." ) ;
        }
        
        public function testAdd():void
        {
            var q:CircularQueue = new CircularQueue() ;
            try
            {
                q.add("item") ;
                fail( "01 - The CircularQueue add() method failed." ) ;
            }
            catch( e:Error )
            {
                assertTrue( e is IllegalOperationError , "02 - The CircularQueue add() method failed." ) ;
                assertEquals( e.message , "The CircularQueue class does support the add() method." , "03 - The CircularQueue add() method failed." ) ;
            }
        }
        
        public function testInterface():void
        {
            var q:CircularQueue = new CircularQueue() ;
            assertTrue( q is Boundable , "The CircularQueue must implements the Boundable interface.") ;
            assertTrue( q is Queue     , "The CircularQueue must implements the Queue interface.") ;
        }
        
        public function testMAX_CAPACITY():void
        {
            assertEquals( CircularQueue.MAX_CAPACITY, uint.MAX_VALUE , "The CircularQueue.MAX_CAPACITY constant failed.") ;
        }
        
        public function testClear():void
        {
            var q:CircularQueue = new CircularQueue(4, [1,2,3,4]) ;
            q.clear() ;
            assertTrue( q.isEmpty() , "01 - The CircularQueue clear failed." ) ;
            assertEquals( q.size()  , 0 , "02 - The CircularQueue clear failed." ) ;
        }  
        
        public function testClone():void
        {
            var q:CircularQueue = new CircularQueue(4, [1,2,3,4]) ;
            var c:CircularQueue ;
            c = q.clone() as CircularQueue ;
            assertNotNull( c , "01 - The CircularQueue clone failed." ) ;
            assertEquals( q.size()    , c.size()    , "02 - The CircularQueue clone failed." ) ;
            assertEquals( q.maxSize() , c.maxSize() , "03 - The CircularQueue clone failed." ) ;
        }
        
        public function testContains():void
        {
            var q:CircularQueue = new CircularQueue(4, [1,2,3,4]) ;
            assertTrue( q.contains(1) , "01 - The CircularQueue contains failed." ) ;
            assertFalse( q.contains(8) , "02 - The CircularQueue contains failed." ) ;
        }
        
        public function testDequeue():void
        {
            var q:CircularQueue = new CircularQueue(4, [1,2,3,4]) ;
            
            assertTrue( q.dequeue() , "01-01 - The CircularQueue dequeue failed." ) ;
            assertEquals( q.size()  , 3 , "01-02 - The CircularQueue dequeue failed." ) ;
            
            assertTrue( q.dequeue() , "02-01 - The CircularQueue dequeue failed." ) ;
            assertEquals( q.size()  , 2 , "02-02 - The CircularQueue dequeue failed." ) ;
            
            assertTrue( q.dequeue() , "03-01 - The CircularQueue dequeue failed." ) ;
            assertEquals( q.size()  , 1 , "03-02 - The CircularQueue dequeue failed." ) ;
            
            assertTrue( q.dequeue() , "04-01 - The CircularQueue dequeue failed." ) ;
            assertEquals( q.size()  , 0 , "04-02 - The CircularQueue dequeue failed." ) ;
            
            assertFalse( q.dequeue() , "05-01 - The CircularQueue dequeue failed." ) ;
            assertEquals( q.size()  , 0 , "05-02 - The CircularQueue dequeue failed." ) ;
        }
        
        public function testElement():void
        {
            var q:CircularQueue ;
            
            q = new CircularQueue(4, [1,2,3,4]) ;
            assertEquals( q.element() , 1 , "The CircularQueue element method failed." ) ;
            
            q = new CircularQueue() ;
            assertUndefined( q.element(), "The CircularQueue element method failed." ) ;
        }
        
        public function testEnqueue():void
        {
            var q:CircularQueue = new CircularQueue(2) ;
            
            assertTrue(q.enqueue(1)       , "01-01 - The CircularQueue enqueue method failed." ) ;
            assertEquals( q.size()    , 1 , "01-02 - The CircularQueue enqueue method failed." ) ;
            assertEquals( q.element() , 1 , "01-03 - The CircularQueue enqueue method failed." ) ;
            
            assertTrue(q.enqueue(2)       , "02-01 - The CircularQueue enqueue method failed." ) ;
            assertEquals( q.size()    , 2 , "02-02 - The CircularQueue enqueue method failed." ) ;
            assertEquals( q.element() , 1 , "02-03 - The CircularQueue enqueue method failed." ) ;
            
            assertFalse(q.enqueue(3)      , "03-01 - The CircularQueue enqueue method failed." ) ;
            assertEquals( q.size()    , 2 , "03-02 - The CircularQueue enqueue method failed." ) ;
            assertEquals( q.element() , 1 , "03-03 - The CircularQueue enqueue method failed." ) ;
        }
        
        public function testGet():void
        {
            var q:CircularQueue = new CircularQueue() ;
            try
            {
                q.get("item") ;
                fail( "01 - The CircularQueue get() method failed." ) ;
            }
            catch( e:Error )
            {
                assertTrue( e is IllegalOperationError , "02 - The CircularQueue get() method failed." ) ;
                assertEquals( e.message , "The CircularQueue class does support the get() method." , "03 - The CircularQueue get() method failed." ) ;
            }
        }
        
        public function testIndexOf():void
        {
            var q:CircularQueue = new CircularQueue() ;
            try
            {
                q.indexOf("item") ;
                fail( "01 - The CircularQueue indexOf() method failed." ) ;
            }
            catch( e:Error )
            {
                assertTrue( e is IllegalOperationError , "02 - The CircularQueue indexOf() method failed." ) ;
                assertEquals( e.message , "The CircularQueue class does support the indexOf() method." , "03 - The CircularQueue indexOf() method failed." ) ;
            }
        }
        
        public function testIsEmpty():void
        {
            var q:CircularQueue = new CircularQueue(4, [1,2,3,4]) ;
            assertFalse( q.isEmpty() , "01 - The CircularQueue isEmpty method failed.") ;
            q.clear() ;
            assertTrue( q.isEmpty() , "02 - The CircularQueue isEmpty method failed.") ;
        }
        
        public function testIsFull():void
        {
            var q:CircularQueue = new CircularQueue(4, [1,2,3,4]) ;
            assertTrue( q.isFull() , "01 - The CircularQueue isFull method failed.") ;
            q.clear() ;
            assertFalse( q.isFull() , "02 - The CircularQueue isFull method failed.") ;
            q.enqueue("item") ;
            assertFalse( q.isFull() , "03 - The CircularQueue isFull method failed.") ;
        }
        
        public function testIterator():void
        {
            var q:CircularQueue = new CircularQueue(4, [1,2,3,4]) ;
            var it:Iterator     = q.iterator() as Iterator ;
            assertNotNull( it , "01 - The CircularQueue iterator method failed.") ;    
            assertTrue( it is ProtectedIterator , "02 - The CircularQueue iterator method failed.") ;
        }
        
        public function testMaxSize():void
        {
            var q:CircularQueue ;
            q = new CircularQueue(4, [1,2,3,4]) ;
            assertEquals( q.maxSize() , 4, "01 - The CircularQueue maxSize method failed.") ;
            q = new CircularQueue() ;
            assertEquals( q.maxSize() , CircularQueue.MAX_CAPACITY, "02 - The CircularQueue maxSize method failed.") ;
        }
        
        public function testPeek():void
        {
            var q:CircularQueue ;
            
            q = new CircularQueue(4, [1,2,3,4]) ;
            assertEquals( q.peek() , 1 , "The CircularQueue peek method failed." ) ;
            
            q = new CircularQueue() ;
            assertNotUndefined( q.peek(), "The CircularQueue peek method failed." ) ;
            assertNull( q.peek(), "The CircularQueue peek method failed." ) ;
        }
        
        public function testPoll():void
        {
            var q:CircularQueue = new CircularQueue(4, [1,2,3,4]) ;
            
            assertEquals( q.poll() , 1 , "01-01 - The CircularQueue dequeue failed." ) ;
            assertEquals( q.size() , 3 , "01-02 - The CircularQueue dequeue failed." ) ;
            
            assertEquals( q.poll() , 2 , "02-01 - The CircularQueue dequeue failed." ) ;
            assertEquals( q.size() , 2 , "02-02 - The CircularQueue dequeue failed." ) ;
            
            assertEquals( q.poll() , 3 , "03-01 - The CircularQueue dequeue failed." ) ;
            assertEquals( q.size() , 1 , "03-02 - The CircularQueue dequeue failed." ) ;
            
            assertEquals( q.poll() , 4 , "04-01 - The CircularQueue dequeue failed." ) ;
            assertEquals( q.size() , 0 , "04-02 - The CircularQueue dequeue failed." ) ;
        }
        
        public function testRemove():void
        {
            var q:CircularQueue = new CircularQueue() ;
            try
            {
                q.remove("item") ;
                fail( "01 - The CircularQueue remove() method failed." ) ;
            }
            catch( e:Error )
            {
                assertTrue( e is IllegalOperationError , "02 - The CircularQueue remove() method failed." ) ;
                assertEquals( e.message , "The CircularQueue class does support the remove() method." , "03 - The CircularQueue remove() method failed." ) ;
            }
        }
        
        public function testSize():void
        {
            var q:CircularQueue ;
            q = new CircularQueue(4, [1,2,3,4]) ;
            assertEquals( q.size() , 4, "01 - The CircularQueue size method failed.") ;
            q = new CircularQueue() ;
            assertEquals( q.size() , 0, "02 - The CircularQueue size method failed.") ;
        }
        
        public function testToArray():void
        {
            var q:CircularQueue ;
            
            q = new CircularQueue(4, [1,2,3,4]) ;
            ArrayAssert.assertEquals( q.toArray() , [1,2,3,4], "01 - The CircularQueue toArray method failed.") ;
            
            q = new CircularQueue() ;
            ArrayAssert.assertEquals( q.toArray() , [], "02 - The CircularQueue toArray method failed.") ;
        }
        
        public function testToSource():void
        {
            var q:CircularQueue ;
            
            q = new CircularQueue() ;
            assertEquals(q.toSource() , "new system.data.queues.CircularQueue(" + uint.MAX_VALUE + ")", "01 - CircularQueue toSource failed") ;
            
            q = new CircularQueue(4, [1,2] ) ;
            assertEquals(q.toSource() , "new system.data.queues.CircularQueue(4,[1,2])" , "02 - CircularQueue toSource failed") ;
            
            q = new CircularQueue(4) ;
            assertEquals(q.toSource() , "new system.data.queues.CircularQueue(4)" , "03 - CircularQueue toSource failed") ;
        }
        
        public function testToString():void
        {
            var q:CircularQueue ;
            
            q = new CircularQueue() ;
            assertEquals( q.toString() , "{}", "01 - CircularQueue toString failed") ;
            
            q = new CircularQueue(4, ["item1", "item2", "item3", "item4"] ) ;
            assertEquals(q.toString() , "{item1,item2,item3,item4}", "02 - CircularQueue toString failed") ;
        } 
    }
}
