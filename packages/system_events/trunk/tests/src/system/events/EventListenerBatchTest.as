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

package system.events 
{
    import library.ASTUce.framework.ArrayAssert;
    import library.ASTUce.framework.TestCase;

    import system.data.Collection;
    import system.data.Iterator;
    import system.data.iterators.VectorIterator;
    import system.events.samples.EventListenerClass;

    public class EventListenerBatchTest extends TestCase 
    {
        public function EventListenerBatchTest(name:String = "")
        {
            super( name );
        }
        
        public var batch:EventListenerBatch ;
        
        public var listener1:EventListenerClass ;
        public var listener2:EventListenerClass ;
        public var listener3:EventListenerClass ;
        public var listener4:EventListenerClass ;
        
        public function setUp():void
        {
            listener1 = new EventListenerClass() ;
            listener2 = new EventListenerClass() ;
            listener3 = new EventListenerClass() ;
            listener4 = new EventListenerClass() ;
            
            batch = new EventListenerBatch() ;
            
            batch.add( listener1 ) ;
            batch.add( listener2 ) ;
            batch.add( listener3 ) ;
            batch.add( listener4 ) ;
        }
        
        public function tearDown():void
        {
            batch     = undefined ;
            listener1 = undefined ;
            listener2 = undefined ;
            listener3 = undefined ;
            listener4 = undefined ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( batch , "EventListenerBatch constructor failed." ) ;
        }
        
        public function testInterface():void
        {
            assertTrue( batch is Collection , "EventListenerBatch must implement the Collection interface." ) ;
            assertTrue( batch is EventListener , "EventListenerBatch must implement the EventListener interface." ) ;
        }
        
        public function testAdd():void
        {
            assertTrue( batch.add( new EventListenerBatch() ) ) ;
            assertFalse( batch.add( 2 ) ) ;
            assertFalse( batch.add( "hello world" ) ) ;
        }
        
        public function testClear():void
        {
            batch.clear() ;
            assertEquals( batch.size() , 0 ) ;
        }
        
        public function testClone():void
        {
            var clone:EventListenerBatch = batch.clone() as EventListenerBatch ;
            
            assertNotNull( clone , "01 - EventListenerBatch clone method failed." ) ;
            assertEquals( clone.size() , batch.size(),  "02 - EventListenerBatch clone method failed." ) ;
        }
        
        public function testContains():void
        {
            assertTrue( batch.contains( listener1 ) ) ;
            assertTrue( batch.contains( listener2 ) ) ;
            assertTrue( batch.contains( listener3 ) ) ;
            assertTrue( batch.contains( listener4 ) ) ;
            
            assertFalse( batch.contains( null ) ) ;
            assertFalse( batch.contains( "hello" ) ) ;
            assertFalse( batch.contains( new EventListenerClass() ) ) ;
        }
        
        public function testGet():void
        {
            var listener:EventListener = new EventListenerClass() ;
            batch.clear() ;
            batch.add( listener ) ;
            assertEquals( batch.get( 0 ) , listener ) ;
        }
        
        public function testIndexOf():void
        {
            var listener:EventListener = new EventListenerClass() ;
            batch.clear() ;
            batch.add( listener ) ;
            assertEquals( batch.indexOf( listener ) , 0 ) ;
        }
        
        public function testIsEmpty():void
        {
            assertFalse( batch.isEmpty() ) ;
            batch.clear() ;
            assertTrue( batch.isEmpty() ) ;
        }
        
        public function testIterator():void
        {
           var it:Iterator = batch.iterator() ;
           assertTrue( it is VectorIterator ) ;
           assertTrue( it.hasNext() ) ;
           assertEquals( listener1 , it.next() ) ;
           assertEquals( listener2 , it.next() ) ;
           assertEquals( listener3 , it.next() ) ;
           assertEquals( listener4 , it.next() ) ;
           assertFalse( it.hasNext() ) ;
        }
        
        public function testSize():void
        {
            assertEquals( batch.size() , 4 ) ;
            batch.clear() ;
            assertEquals( batch.size() , 0 ) ;
        }
        
        public function testToArray():void
        {
            var ar:Array = batch.toArray() ;
            ArrayAssert.assertEquals( ar , [listener1,listener2,listener3,listener4] ) ;
        }
        
        public function testToSource():void
        {
            assertEquals( "new system.events.EventListenerBatch([new system.events.samples.EventListenerClass(),new system.events.samples.EventListenerClass(),new system.events.samples.EventListenerClass(),new system.events.samples.EventListenerClass()])" , batch.toSource() ) ;
        }
        
        public function testToString():void
        {
            assertEquals( "{[object EventListenerClass],[object EventListenerClass],[object EventListenerClass],[object EventListenerClass]}" , batch.toString() ) ;
        }
    }
}
