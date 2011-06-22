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

package system.process 
{
    import buRRRn.ASTUce.framework.ArrayAssert;
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.process.mocks.MockTask;
    import system.process.mocks.MockTaskReceiver;
    
    public class ChainTest extends TestCase 
    {
        public function ChainTest(name:String = "")
        {
            super(name);
        }
        
        public var chain:Chain ;
        
        public var mockReceiver:MockTaskReceiver ;
        
        public var task1:MockTask ;
        public var task2:MockTask ;
        public var task3:MockTask ;
        public var task4:MockTask ;
        
        public function setUp():void
        {
            chain = new Chain() ;
            
            task1 = new MockTask() ;            task2 = new MockTask() ;            task3 = new MockTask() ;            task4 = new MockTask() ;
            
            chain.addAction( task1 ) ;            chain.addAction( task2 ) ;            chain.addAction( task3 ) ;            chain.addAction( task4 ) ;
        }
        
        public function tearDown():void
        {
            chain = null ; 
            task1 = null ; 
            task2 = null ; 
            task3 = null ; 
            task4 = null ; 
            MockTask.reset() ; 
        }
        
        public function testEVERLASTING():void
        {
            assertEquals( Chain.EVERLASTING , "everlasting" ) ;
        }
        
        public function testNORMAL():void
        {
            assertEquals( Chain.NORMAL , "normal" ) ; 
        }
        
        public function testTRANSIENT():void
        {
            assertEquals( Chain.TRANSIENT , "transient" ) ;
        }
        
        public function testInherit():void
        {
            assertTrue( chain is CoreAction , "inherit Action failed.");
        }
        
        public function testInterface():void
        {
            assertTrue( chain is Resumable , "#1 - Must implements the Resumable interface.");
            assertTrue( chain is Startable , "#2 - Must implements the Startable interface.");
            assertTrue( chain is Stoppable , "#3 - Must implements the Stoppable interface.");
        }
        
        public function testConstructorEmptyArgument():void
        {
             chain = new Chain() ;
             assertEquals( 0, chain.length) ;
             assertFalse( chain.fixed ) ;
             assertFalse( chain.looping ) ;
             assertEquals( 0, chain.numLoop) ;
             assertEquals( Chain.NORMAL, chain.mode) ;
        }
          
        public function testConstructorWithArguments():void
        {
             chain = new Chain(5,true,true,10, Chain.TRANSIENT) ;
             assertEquals( 5, chain.length) ;
             assertTrue( chain.fixed ) ;             assertTrue( chain.looping ) ;
             assertEquals( 10, chain.numLoop) ;
             assertEquals( Chain.TRANSIENT, chain.mode) ;
        }
        
        public function testLength():void
        {
            assertEquals( 4 , chain.length ) ;
            chain.length = 10 ;
            assertEquals( 10 , chain.length ) ;
            chain.length = 2 ;
            assertEquals( 2 , chain.length ) ; 
            chain.length = 0 ;
            assertEquals( 0 , chain.length ) ; 
        }
        
        public function testMode():void
        {
            assertEquals( Chain.NORMAL , chain.mode ) ; 
            chain.mode = null ;
            assertEquals( Chain.NORMAL , chain.mode ) ; 
            chain.mode = "hello" ;
            assertEquals( Chain.NORMAL , chain.mode ) ; 
            chain.mode = "normal" ;
            assertEquals( Chain.NORMAL , chain.mode ) ;
            chain.mode = Chain.TRANSIENT ;
            assertEquals( Chain.TRANSIENT , chain.mode ) ;
            chain.mode = Chain.EVERLASTING ;
            assertEquals( Chain.EVERLASTING , chain.mode ) ;
        }
        
        public function testPosition():void
        {
            assertEquals( 0 , chain.position ) ;
            chain.run() ;
            assertEquals( 0 , chain.position ) ;
        }
        
        public function testAddAction():void
        {
            chain = new Chain() ;
            assertFalse( chain.addAction( null ) ) ;
            assertTrue( chain.addAction( task1 ) ) ;
            assertTrue( chain.addAction( task1 ) ) ;
        }
        
        public function testElement():void
        {
            assertEquals( task1 , chain.element() ) ;
        }
        
        public function testGetActionAt():void
        {
            assertEquals( task1 , chain.getActionAt( 0 ) ) ;
            assertEquals( task2 , chain.getActionAt( 1 ) ) ;
            assertEquals( task3 , chain.getActionAt( 2 ) ) ;
            assertEquals( task4 , chain.getActionAt( 3 ) ) ;
            assertNull( chain.getActionAt( 4 ) ) ;
        }
        
        public function testHasAction():void
        {
            assertTrue( chain.hasAction( task1 ) ) ;
            chain.removeAction(task1) ;
            assertFalse( chain.hasAction( task1 ) ) ;
        }
        
        public function testHasNext():void
        {
            assertTrue( chain.hasNext() ) ;
            chain.run() ;
            assertTrue( chain.hasNext() ) ;
            chain.mode = Chain.TRANSIENT ;
            chain.run() ;
            assertFalse( chain.hasNext() ) ;
        }
        
        public function testIsEmpty():void
        {
            assertFalse( chain.isEmpty() ) ;
            chain.removeAction() ;
            assertTrue( chain.isEmpty() ) ;
        }
        
        public function testRemoveAction():void
        {
            assertTrue( chain.hasAction( task2 ) ) ;
            assertTrue( chain.removeAction(task2) ) ;            assertFalse( chain.hasAction( task2 ) ) ;
            assertFalse( chain.removeAction(task2) ) ;
            assertEquals( 3 , chain.length ) ;
        }
        
        public function testRemoveActionClear():void
        {
            assertTrue( chain.removeAction() ) ;
            assertEquals( 0 , chain.length ) ;
            assertFalse( chain.removeAction() ) ;
        }
        
        public function testToArray():void
        {
            var ar:Array ;
            
            ar = chain.toArray() ;
            ArrayAssert.assertEquals([task1,task2,task3,task4], ar ) ;
            
            chain.length = 10 ;
            
            ar = chain.toArray() ;
            ArrayAssert.assertEquals([task1,task2,task3,task4], ar ) ;
        }
        
        public function testToString():void
        {
            assertEquals( chain.toString() , "[Chain]" ) ;
            chain.verbose = true ;
            assertEquals( chain.toString() , "[Chain<[MockTask],[MockTask],[MockTask],[MockTask]>]" ) ;
            chain.length = 6 ;
            assertEquals( chain.toString() , "[Chain<[MockTask],[MockTask],[MockTask],[MockTask],null,null>]" ) ;
            chain.length = 2 ;
            assertEquals( chain.toString() , "[Chain<[MockTask],[MockTask]>]" ) ;
            chain.verbose = false ;
        }
        
        public function testToVector():void
        {
            var v:Vector.<Action> = chain.toVector() ;
            assertEquals( v.toString() , "[MockTask],[MockTask],[MockTask],[MockTask]" ) ;
            assertEquals( v.length , chain.length ) ;
            assertEquals( v[0] , chain.getActionAt(0) ) ;
            assertEquals( v[1] , chain.getActionAt(1) ) ;
            assertEquals( v[2] , chain.getActionAt(2) ) ;
            assertEquals( v[3] , chain.getActionAt(3) ) ;
        }
        
        public function testEvents():void
        {
            var c:Chain = new Chain() ;
            mockReceiver = new MockTaskReceiver( c ) ;
            
            c.addAction( new MockTask("testEvents_1") ) ;
            c.addAction( new MockTask("testEvents_2") ) ;
            c.addAction( new MockTask("testEvents_3") ) ;
            c.addAction( new MockTask("testEvents_4") ) ;
            
            c.run() ;
            
            assertTrue( mockReceiver.isWasRunning , "#1" ) ;
            
            assertTrue   ( mockReceiver.startCalled   , "#2" ) ;
            assertTrue   ( mockReceiver.finishCalled  , "#3" ) ;
            
            mockReceiver.unregister() ;
            mockReceiver = null ;
        }
    }
}
