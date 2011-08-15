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
    import library.ASTUce.framework.ArrayAssert;
    import library.ASTUce.framework.TestCase;
    
    import system.process.mocks.MockTask;
    
    public class BatchTaskTest extends TestCase 
    {
        public function BatchTaskTest(name:String = "")
        {
            super(name);
        }
        
        public var batch:BatchTask ;
        
        public var task1:MockTask ;
        public var task2:MockTask ;
        public var task3:MockTask ;
        public var task4:MockTask ;
        
        public function setUp():void
        {
            batch = new BatchTask() ;
            
            task1 = new MockTask() ;
            task2 = new MockTask() ;
            task3 = new MockTask() ;
            task4 = new MockTask() ;
            
            batch.addAction( task1 ) ;
            batch.addAction( task2 ) ;
            batch.addAction( task3 ) ;
            batch.addAction( task4 ) ;
        }
        
        public function tearDown():void
        {
            batch = null ; 
            task1 = null ; 
            task2 = null ; 
            task3 = null ; 
            task4 = null ; 
            MockTask.reset() ; 
        }
        
        public function testEVERLASTING():void
        {
            assertEquals( BatchTask.EVERLASTING , "everlasting" ) ;
        }
        
        public function testNORMAL():void
        {
            assertEquals( BatchTask.NORMAL , "normal" ) ; 
        }
        
        public function testTRANSIENT():void
        {
            assertEquals( BatchTask.TRANSIENT , "transient" ) ;
        }
        
        public function testInherit():void
        {
            assertTrue( batch is CoreAction , "inherit Action failed.");
        }
        
        public function testInterface():void
        {
            assertTrue( batch is Resumable , "Must implements the Resumable interface.");
            assertTrue( batch is Startable , "Must implements the Startable interface.");
            assertTrue( batch is Stoppable , "Must implements the Stoppable interface.");
        }
        
        public function testConstructorEmptyArgument():void
        {
             batch = new BatchTask() ;
             assertEquals( 0, batch.length) ;
             assertFalse( batch.fixed ) ;
        }
        
        public function testConstructorWithArguments():void
        {
             batch = new BatchTask(5,true) ;
             assertEquals( 5, batch.length) ;
             assertTrue( batch.fixed ) ;
        }
        
        public function testLength():void
        {
            assertEquals( 4 , batch.length ) ;
            batch.length = 10 ;
            assertEquals( 10 , batch.length ) ;
            batch.length = 2 ;
            assertEquals( 2 , batch.length ) ; 
            batch.length = 0 ;
            assertEquals( 0 , batch.length ) ; 
        }
        
        public function testMode():void
        {
            assertEquals( BatchTask.NORMAL , batch.mode ) ; 
            batch.mode = null ;
            assertEquals( BatchTask.NORMAL , batch.mode ) ; 
            batch.mode = "hello" ;
            assertEquals( BatchTask.NORMAL , batch.mode ) ; 
            batch.mode = "normal" ;
            assertEquals( BatchTask.NORMAL , batch.mode ) ;
            batch.mode = BatchTask.TRANSIENT ;
            assertEquals( BatchTask.TRANSIENT , batch.mode ) ;
            batch.mode = BatchTask.EVERLASTING ;
            assertEquals( BatchTask.EVERLASTING , batch.mode ) ;
        }
        
        public function testAddAction():void
        {
            batch = new BatchTask() ;
            assertFalse( batch.addAction( null ) ) ;
            assertTrue( batch.addAction( task1 ) ) ;
            assertTrue( batch.addAction( task1 ) ) ;
        }
        
        public function testGetActionAt():void
        {
            assertEquals( task1 , batch.getActionAt( 0 ) ) ;
            assertEquals( task2 , batch.getActionAt( 1 ) ) ;
            assertEquals( task3 , batch.getActionAt( 2 ) ) ;
            assertEquals( task4 , batch.getActionAt( 3 ) ) ;
            assertNull( batch.getActionAt( 4 ) ) ;
        }
        
        public function testHasAction():void
        {
            assertTrue( batch.hasAction( task1 ) ) ;
            batch.removeAction(task1) ;
            assertFalse( batch.hasAction( task1 ) ) ;
        }
        
        public function testIsEmpty():void
        {
            assertFalse( batch.isEmpty() ) ;
            batch.removeAction() ;
            assertTrue( batch.isEmpty() ) ;
        }
        
        public function testRemoveAction():void
        {
            assertTrue( batch.hasAction( task2 ) ) ;
            assertTrue( batch.removeAction(task2) ) ;
            assertFalse( batch.hasAction( task2 ) ) ;
            assertFalse( batch.removeAction(task2) ) ;
            assertEquals( 3 , batch.length ) ;
        }
        
        public function testRemoveActionClear():void
        {
            assertTrue( batch.removeAction() ) ;
            assertEquals( 0 , batch.length ) ;
            assertFalse( batch.removeAction() ) ;
        }
        
        public function testToArray():void
        {
            var ar:Array ;
            ar = batch.toArray() ;
            ArrayAssert.assertEquals([task1,task2,task3,task4], ar ) ;
            batch.length = 10 ;
            ar = batch.toArray() ;
            ArrayAssert.assertEquals([task1,task2,task3,task4], ar ) ;
        }
        
        public function testToString():void
        {
            assertEquals( batch.toString() , "[BatchTask]" ) ;
            batch.verbose = true ;
            assertEquals( batch.toString() , "[BatchTask<[MockTask],[MockTask],[MockTask],[MockTask]>]" ) ;
            batch.length = 6 ;
            assertEquals( batch.toString() , "[BatchTask<[MockTask],[MockTask],[MockTask],[MockTask],null,null>]" ) ;
            batch.length = 2 ;
            assertEquals( batch.toString() , "[BatchTask<[MockTask],[MockTask]>]" ) ;
            batch.verbose = false ;
        }
        
        public function testToVector():void
        {
            var v:Vector.<Action> = batch.toVector() ;
            assertEquals( v.toString() , "[MockTask],[MockTask],[MockTask],[MockTask]" ) ;
            assertEquals( v.length , batch.length ) ;
            assertEquals( v[0] , batch.getActionAt(0) ) ;
            assertEquals( v[1] , batch.getActionAt(1) ) ;
            assertEquals( v[2] , batch.getActionAt(2) ) ;
            assertEquals( v[3] , batch.getActionAt(3) ) ;
        }
    }
}
