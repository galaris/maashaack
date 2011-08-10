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
    
    import system.data.Iterator;
    import system.data.Queue;
    import system.data.Typeable;
    import system.data.Validator;
    
    public class TypedQueueTest extends TestCase 
    {
        public function TypedQueueTest(name:String = "")
        {
            super(name);
        }
        
        // test constructor
        
        public function testConstructorBasic():void
        {
            var q:Queue = new LinearQueue() ;
            var tq:TypedQueue = new TypedQueue( String , q ) ;
            assertNotNull(tq, "TypedQueue constructor failed.") ;
        }
        
        public function testConstructorTypeArgument():void
        {
            var q:Queue = new LinearQueue() ;
            var tq:TypedQueue ;
            
            tq = new TypedQueue( String , q ) ;
            assertEquals( tq.type , String , "01 - TypedQueue constructor failed with a specific type argument in this constructor.") ;
            
            tq = new TypedQueue( null , q ) ;
            assertNull( tq.type , "02 - TypedQueue constructor failed with a specific type argument in this constructor.") ;
            
            tq = new TypedQueue( [] , q ) ;
            assertNull( tq.type , "03 - TypedQueue constructor failed with a specific type argument in this constructor, other type, must use a Class or a Function value.") ;
        }
        
        public function testConstructorQueueArgument():void
        {
            var q:Queue = new LinearQueue() ;
            var tq:TypedQueue ;
            
            try
            {
                tq = new TypedQueue( String, null ) ;
                fail( "01-01 - TypedQueue constructor failed." ) ;
            }
            catch( e:Error )
            {
                assertTrue( e is ArgumentError , "01-02 - TypedQueue constructor failed." ) ;
                assertEquals( e.message , "The passed-in Queue argument not must be 'null' or 'undefined'.", "01-03 - TypedQueue constructor failed." ) ;
            }
            
            // 02 - basic test with a no empty Queue
            
            q.add("item1") ;
            q.add("item2") ;
            
            tq = new TypedQueue( String , q ) ;
            assertNotNull(tq, "02-01 - TypedQueue constructor failed with a no empty queue of String values.") ;
            assertEquals(tq.size(), q.size() , "02-02 - TypedQueue constructor failed with a no empty queue of String values.") ;
            
            // 03 - test 'queue' argument contains an invalid value
            
            q.add( 1 ) ;
            try
            {
                tq = new TypedQueue( String, q ) ;
                fail( "03-01 - TypedQueue constructor failed." ) ;
            }
            catch( e:Error )
            {
                assertTrue( e is TypeError , "03-02 - TypedQueue constructor failed." ) ;
                assertEquals( e.message , "TypedQueue.validate(1) is mismatch.", "03-03 - TypedQueue constructor failed." ) ;
            }
        }
        
        public function testInterface():void
        {
            var q:Queue = new LinearQueue() ;
            var tq:TypedQueue ;  
            
            tq = new TypedQueue( String , q ) ;
            
            assertTrue( tq is Queue      , "01 - The TypedQueue class must implement the Queue interface." ) ;
            assertTrue( tq is Typeable   , "02 - The TypedQueue class must implement the Typeable interface." ) ;
            assertTrue( tq is Validator  , "03 - The TypedQueue class must implement the Validator interface." ) ;
        }
        
        // test methods and attributes
        
        public function testType():void
        {
            var q:Queue = new LinearQueue() ;
            
            var tq:TypedQueue = new TypedQueue( String , q ) ;
            assertEquals( tq.type , String , "01 - The TypedQueue type property failed." ) ;
            
            tq.type = Number ;
            assertEquals( tq.type , Number , "02 - The TypedQueue type property failed." ) ;
            
            var clazz:Function = function():void {} ;
            tq.type = clazz ;
            assertEquals( tq.type , clazz , "03 - The TypedQueue type property failed." ) ;
            
            tq.type = null ;
            assertNull( tq.type , "04 - The TypedQueue type property failed." ) ;
            
            tq.type = 2 ;
            assertNull( tq.type , "05 - The TypedQueue type property failed." ) ;
        }
        
        public function testAdd():void
        {
            var q:Queue = new LinearQueue() ;
            
            var tq:TypedQueue = new TypedQueue( String , q ) ;
            
            assertTrue( tq.add("item1") , "01-01 - The TypedQueue add method failed." ) ;
            assertEquals( tq.size() , 1 , "01-02 - The TypedQueue add method failed." ) ;
            
            try
            {
                tq.add(3) ;
                fail("02-01 - The TypedQueue add method failed.") ;
            }
            catch( e:Error )
            {
                assertTrue( e is TypeError , "02-02 - The TypedQueue add method failed.") ;
                assertEquals( e.message, "TypedQueue.validate(3) is mismatch." , "02-03 - The TypedQueue add method failed." ) ;
            }
        }
        
        public function testClear():void
        {
            var q:Queue = new LinearQueue(["item1", "item2"]) ;
            var tq:TypedQueue = new TypedQueue( String , q ) ;
            tq.clear() ;
            assertEquals( tq.size() , 0 , "The TypedQueue clear method failed." ) ;
        }
        
        public function testClone():void
        {
            var q:Queue = new LinearQueue(["item1", "item2"]) ;
            var tq:TypedQueue = new TypedQueue( String , q ) ;
            var clone:TypedQueue = tq.clone() as TypedQueue ;
            assertNotNull( clone , "01 - The TypedQueue clone method failed." ) ;
            assertEquals( tq.size() , clone.size() , "02 - The TypedQueue clone method failed." ) ;
        } 
        
        public function testElement():void
        {
            var q:Queue = new LinearQueue(["item1", "item2"]) ;
            
            var tq:TypedQueue = new TypedQueue( String , q ) ;
            assertEquals( tq.element() , "item1" , "01 - The TypedQueue element method failed." ) ; 
            
            tq.clear() ;
            assertUndefined( tq.element() , "02 - The TypedQueue element method failed." ) ;
        }
        
        public function testEnqueue():void
        {
            var q:Queue = new LinearQueue(["item1", "item2"]) ;
            var tq:TypedQueue = new TypedQueue( String , q ) ;
            assertTrue( tq.enqueue("item3") , "01 - The TypedQueue enqueue method failed." ) ;  
            assertEquals( tq.size() , 3 , "02 - The TypedQueue enqueue method failed." ) ;  
        }
        
        public function testGet():void
        {
            var q:Queue = new LinearQueue(["item1", "item2"]) ;
            var tq:TypedQueue = new TypedQueue( String , q ) ;
            assertEquals( tq.get(0) , "item1" , "The TypedQueue get method failed." ) ;
            assertNull( tq.get(10)  , "The TypedQueue get method failed." ) ;
        }
        
        public function testIndexOf():void
        {
            var q:Queue = new LinearQueue(["item1", "item2"]) ;
            var tq:TypedQueue = new TypedQueue( String , q ) ;
            assertEquals( tq.indexOf("item2") , 1 , "01 - The TypedQueue indexOf method failed." ) ;
            assertEquals( tq.indexOf("item4") , -1 , "02 - The TypedQueue indexOf method failed." ) ;
        } 
        
        public function testIsEmpty():void
        {
            var q:Queue = new LinearQueue(["item1", "item2"]) ;
            var tq:TypedQueue = new TypedQueue( String , q ) ;
            assertFalse(tq.isEmpty() , "01 - The TypedQueue isEmpty method failed." ) ;
            tq.clear() ;
            assertTrue(tq.isEmpty() , "02 - The TypedQueue isEmpty method failed." ) ;
        } 
        
        public function testIterator():void
        {
            var q:Queue = new LinearQueue(["item1", "item2"]) ;
            var tq:TypedQueue = new TypedQueue( String , q ) ;
            var it:Iterator = tq.iterator() ;
            assertNotNull( it, "The TypedQueue iterator method failed." ) ;
        }
        
        public function testPeek():void
        {
            var q:Queue = new LinearQueue(["item1", "item2"]) ;
            
            var tq:TypedQueue = new TypedQueue( String , q ) ;
            assertEquals( tq.peek() , "item1" , "01 - The TypedQueue peek method failed." ) ; 
            
            tq.clear() ;
            assertNotUndefined( tq.peek() , "02 - The TypedQueue peek method failed." ) ;
            assertNull( tq.peek() , "03 - The TypedQueue peek method failed." ) ;
        }
        
        public function testPoll():void
        {
            var q:Queue = new LinearQueue(["item1", "item2"]) ;
            
            var tq:TypedQueue = new TypedQueue( String , q ) ;
            
            assertEquals( tq.poll() , "item1" , "01-01 - The TypedQueue poll method failed." ) ; 
            assertEquals( tq.size() , 1       , "01-02 - The TypedQueue poll method failed." ) ;
                    
            assertEquals( tq.poll() , "item2" , "02-01 - The TypedQueue poll method failed." ) ; 
            assertEquals( tq.size() , 0       , "02-02 - The TypedQueue poll method failed." ) ;
            
            assertNull( tq.poll() , "03 - The TypedQueue poll method failed." ) ;
        }
        
        public function testRemove():void
        {
            var q:Queue = new LinearQueue(["item1", "item2"]) ;
            var tq:TypedQueue = new TypedQueue( String , q ) ;
            
            assertTrue( tq.remove("item1"), "The TypedQueue remove method failed." ) ;
            assertFalse( tq.remove("item4"), "The TypedQueue remove method failed." ) ;
        } 
        
        public function testSize():void
        {
            var q:Queue = new LinearQueue(["item1", "item2"]) ;
            var tq:TypedQueue = new TypedQueue( String , q ) ;
            assertEquals( tq.size() , q.size() , "The TypedQueue size method failed." ) ;
        } 
        
        public function testSupports():void
        {
            var q:Queue = new LinearQueue(["item1", "item2"]) ;
            var tq:TypedQueue = new TypedQueue( String , q ) ;
            assertTrue( tq.supports("hello world") , "01 - Must support a String value in argument.") ;
            assertFalse( tq.supports(1) , "02 - Must support a String value in argument and not a number.") ;
        }
        
        public function testToArray():void
        {
            var q:Queue       = new LinearQueue(["item1", "item2"]) ;
            var tq:TypedQueue = new TypedQueue( String , q ) ;
            ArrayAssert.assertEquals(tq.toArray() , q.toArray(), "The TypedQueue toArray method failed.") ;
        }
        
        public function testToSource():void
        {
            var q:Queue       = new LinearQueue(["item1", "item2"]) ;
            var tq:TypedQueue = new TypedQueue( String , q ) ;
            assertEquals( tq.toSource() , 'new system.data.queues.TypedQueue(String,new system.data.queues.LinearQueue(["item1","item2"]))' , "The TypedQueue toSource method failed." ) ;     
        }
        
        public function testToString():void
        {
            var q:LinearQueue = new LinearQueue(["item1", "item2"]) ;
            var tq:TypedQueue = new TypedQueue( String , q ) ;
            assertEquals( tq.toString() , q.toString() , "The TypedQueue toString method failed." ) ;
        }
        
        public function testValidate():void
        {
            var q:Queue = new LinearQueue(["item1", "item2"]) ;
            var tq:TypedQueue = new TypedQueue( String , q ) ;
            
            try
            {
                tq.validate( "hello" ) ;
            }
            catch( e:Error )
            {
                fail("01 - the validate method must validate a String value and not throw an error") ;
            }
            
            try
            {
                tq.validate( 1 ) ;
                fail("02-01 - the validate method must throw a TypeError.") ;
            }
            catch( e:Error )
            {
                assertTrue( e is TypeError , "02-02 - the validate method must throw a TypeError.") ;   
                assertEquals( e.message , "TypedQueue.validate(1) is mismatch." , "03-02 - the validate method must throw a TypeError.") ;
            }
        }
    }
}
