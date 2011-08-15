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
    import library.ASTUce.framework.ArrayAssert;
    import library.ASTUce.framework.TestCase;
    
    import system.data.Collection;
    import system.data.Queue;
    import system.data.collections.ArrayCollection;
    import system.data.maps.ArrayMap;
    
    public class LinearQueueTest extends TestCase 
    {
        public function LinearQueueTest(name:String = "")
        {
            super( name );
        }
        
        public function testConstructor():void
        {
            var q:LinearQueue = new LinearQueue() ;
            
            assertNotNull(q, "01-01 - LinearQueue constructor failed.") ;
            ArrayAssert.assertEquals( q.toArray(), [], "01-02 - LinearQueue constructor failed.") ;
            
            // initialize with an Array
            
            q = new LinearQueue([2,3,4]) ; 
            assertNotNull(q, "02-01 - LinearQueue constructor failed.") ;
            ArrayAssert.assertEquals( q.toArray(), [2,3,4], "02-02 - LinearQueue constructor failed.") ;
            
            // initialize with a Collection
            
            q = new LinearQueue(new ArrayCollection([2,3,4])) ; 
            assertNotNull(q, "03-01 - LinearQueue constructor failed.") ;
            ArrayAssert.assertEquals( q.toArray(), [2,3,4], "03-02 - LinearQueue constructor failed.") ;
            
            // initialize with an Iterable object
            
            q = new LinearQueue(new ArrayMap(["key1","key2","key3"],["value1","value2","value3"])) ; 
            assertNotNull(q, "04-01 - LinearQueue constructor failed.") ;
            ArrayAssert.assertEquals( q.toArray(), ["value1","value2","value3"], "04-02 - LinearQueue constructor failed.") ;
            
        }
        
        public function testInherit():void
        {
            var q:LinearQueue = new LinearQueue() ;
            assertTrue( q is ArrayCollection , "LinearQueue must extends the ArrayCollection class.") ;
        }
        
        public function testInterface():void
        {
            var q:LinearQueue = new LinearQueue() ;
            assertTrue( q is Queue , "01 - LinearQueue must implements the Queue interface.") ;
            assertTrue( q is Collection , "02 - LinearQueue must implements the Queue interface.") ;
        }
        
        public function testClone():void
        {
            var q:LinearQueue = new LinearQueue([1,2,3,4]) ;
            var c:LinearQueue ;
            c = q.clone() as LinearQueue ;
            assertNotNull( c , "01 - The LinearQueue clone failed." ) ;
            assertEquals( q.size() , c.size() , "02 - The LinearQueue clone failed." ) ;   
            ArrayAssert.assertEquals( q.toArray() , c.toArray() , "03 - The LinearQueue clone failed." ) ;
        }
        
        public function testDequeue():void
        {
            var q:LinearQueue = new LinearQueue([1,2,3,4]) ;
            
            assertTrue( q.dequeue() , "01-01" ) ;
            assertEquals( q.size()  , 3 , "01-02" ) ;
            
            assertTrue( q.dequeue() , "02-01" ) ;
            assertEquals( q.size()  , 2 , "02-02" ) ;
            
            assertTrue( q.dequeue() , "03-01" ) ;
            assertEquals( q.size()  , 1 , "03-02" ) ;
            
            assertTrue( q.dequeue() , "04-01" ) ;
            assertEquals( q.size()  , 0 , "04-02" ) ;
            
            assertFalse( q.dequeue() , "05-01" ) ;
            assertEquals( q.size()  , 0 , "05-02" ) ;
        }
        
        public function testElement():void
        {
            var q:LinearQueue ;
            
            q = new LinearQueue([1,2,3,4]) ;
            assertEquals( q.element() , 1 , "The LinearQueue element method failed." ) ;
            
            q = new LinearQueue() ;
            assertUndefined( q.element(), "The LinearQueue element method failed." ) ;
        }
        
        public function testEnqueue():void
        {
            var q:LinearQueue = new LinearQueue() ;
            
            assertTrue(q.enqueue(1)       , "01-01" ) ;
            assertEquals( q.size()    , 1 , "01-02" ) ;
            assertEquals( q.element() , 1 , "01-03" ) ;
            
            assertTrue(q.enqueue(2)       , "02-01" ) ;
            assertEquals( q.size()    , 2 , "02-02" ) ;
            assertEquals( q.element() , 1 , "02-03" ) ;
            
            assertTrue( q.enqueue(3)     , "03-01" ) ;
            assertEquals( q.size()    , 3 , "03-02" ) ;
            assertEquals( q.element() , 1 , "03-03" ) ;
        }
        
        public function testPeek():void
        {
            var q:LinearQueue ;
            
            q = new LinearQueue([1,2,3,4]) ;
            assertEquals( q.peek() , 1 , "01" ) ;
            
            q = new LinearQueue() ;
            assertNotUndefined( q.peek(), "02" ) ;
            assertNull( q.peek(), "03" ) ;
        }
        
        public function testPoll():void
        {
            var q:LinearQueue = new LinearQueue([1,2,3,4]) ;
            
            assertEquals( q.poll() , 1 , "01-01" ) ;
            assertEquals( q.size()    , 3 , "01-02" ) ;
            
            assertEquals( q.poll() , 2 , "02-01" ) ;
            assertEquals( q.size()    , 2 , "02-02" ) ;
            
            assertEquals( q.poll() , 3 , "03-01" ) ;
            assertEquals( q.size()    , 1 , "03-02" ) ;
            
            assertEquals( q.poll() , 4 , "04-01" ) ;
            assertEquals( q.size()    , 0 , "04-02" ) ;
        }
        
        public function testToArray():void
        {
            var q:LinearQueue ;
            
            q = new LinearQueue([1,2,3,4]) ;
            ArrayAssert.assertEquals( q.toArray() , [1,2,3,4], "01 - The LinearQueue toArray method failed.") ;
            
            q = new LinearQueue() ;
            ArrayAssert.assertEquals( q.toArray() , [], "02 - The LinearQueue toArray method failed.") ;
        }
        
        public function testToSource():void
        {
            var q:LinearQueue ;
            
            q = new LinearQueue() ;
            assertEquals(q.toSource() , "new system.data.queues.LinearQueue()", "01 - LinearQueue toSource failed") ;
            
            q = new LinearQueue([1,2] ) ;
            assertEquals(q.toSource() , "new system.data.queues.LinearQueue([1,2])" , "02 - LinearQueue toSource failed") ;
        }
        
        public function testToString():void
        {
            var q:LinearQueue ;
            
            q = new LinearQueue() ;
            assertEquals( q.toString() , "{}", "01 - LinearQueue toString failed") ;
            
            q = new LinearQueue(["item1", "item2", "item3", "item4"] ) ;
            assertEquals(q.toString() , "{item1,item2,item3,item4}", "02 - LinearQueue toString failed") ;
        }
    }
}