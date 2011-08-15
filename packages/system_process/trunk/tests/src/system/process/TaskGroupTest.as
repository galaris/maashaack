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
    
    public class TaskGroupTest extends TestCase 
    {
        public function TaskGroupTest(name:String = "")
        {
            super(name);
        }
        
        public var group:TaskGroup ;
        
        public var task1:MockTask ;
        public var task2:MockTask ;
        public var task3:MockTask ;
        public var task4:MockTask ;
        
        public function setUp():void
        {
            group = new TaskGroup() ;
            
            task1 = new MockTask() ;            task2 = new MockTask() ;            task3 = new MockTask() ;            task4 = new MockTask() ;
            
            group.addAction( task1 ) ;            group.addAction( task2 ) ;            group.addAction( task3 ) ;            group.addAction( task4 ) ;
        }
        
        public function tearDown():void
        {
            group = null ; 
            task1 = null ; 
            task2 = null ; 
            task3 = null ; 
            task4 = null ; 
            MockTask.reset() ; 
        }
        
        public function testEVERLASTING():void
        {
            assertEquals( TaskGroup.EVERLASTING , "everlasting" ) ;
        }
        
        public function testNORMAL():void
        {
            assertEquals( TaskGroup.NORMAL , "normal" ) ; 
        }
        
        public function testTRANSIENT():void
        {
            assertEquals( TaskGroup.TRANSIENT , "transient" ) ;
        }
        
        public function testInherit():void
        {
            assertTrue( group is CoreAction , "inherit Action failed.");
        }
        
        public function testInterface():void
        {
            assertTrue( group is Resumable , "Must implements the Resumable interface.");
            assertTrue( group is Startable , "Must implements the Startable interface.");
            assertTrue( group is Stoppable , "Must implements the Stoppable interface.");
        }
        
        public function testConstructorEmptyArgument():void
        {
             group = new TaskGroup() ;
             assertEquals( 0, group.length) ;
             assertFalse( group.fixed ) ;
        }
        
        public function testConstructorWithArguments():void
        {
             group = new TaskGroup(5,true) ;
             assertEquals( 5, group.length) ;
             assertTrue( group.fixed ) ;        }
        
        public function testLength():void
        {
            assertEquals( 4 , group.length ) ;
            group.length = 10 ;
            assertEquals( 10 , group.length ) ;
            group.length = 2 ;
            assertEquals( 2 , group.length ) ; 
            group.length = 0 ;
            assertEquals( 0 , group.length ) ; 
        }
        
        public function testMode():void
        {
            assertEquals( TaskGroup.NORMAL , group.mode ) ; 
            group.mode = null ;
            assertEquals( TaskGroup.NORMAL , group.mode ) ; 
            group.mode = "hello" ;
            assertEquals( TaskGroup.NORMAL , group.mode ) ; 
            group.mode = "normal" ;
            assertEquals( TaskGroup.NORMAL , group.mode ) ;
            group.mode = TaskGroup.TRANSIENT ;
            assertEquals( TaskGroup.TRANSIENT , group.mode ) ;
            group.mode = TaskGroup.EVERLASTING ;
            assertEquals( TaskGroup.EVERLASTING , group.mode ) ;
        }
        
        public function testAddAction():void
        {
            group = new TaskGroup() ;
            assertFalse( group.addAction( null ) ) ;
            assertTrue( group.addAction( task1 ) ) ;
            assertTrue( group.addAction( task1 ) ) ;
        }
        
        public function testGetActionAt():void
        {
            assertEquals( task1 , group.getActionAt( 0 ) ) ;
            assertEquals( task2 , group.getActionAt( 1 ) ) ;
            assertEquals( task3 , group.getActionAt( 2 ) ) ;
            assertEquals( task4 , group.getActionAt( 3 ) ) ;
            assertNull( group.getActionAt( 4 ) ) ;
        }
        
        public function testHasAction():void
        {
            assertTrue( group.hasAction( task1 ) ) ;
            group.removeAction(task1) ;
            assertFalse( group.hasAction( task1 ) ) ;
        }
        
        public function testIsEmpty():void
        {
            assertFalse( group.isEmpty() ) ;
            group.removeAction() ;
            assertTrue( group.isEmpty() ) ;
        }
        
        public function testRemoveAction():void
        {
            assertTrue( group.hasAction( task2 ) ) ;
            assertTrue( group.removeAction(task2) ) ;            assertFalse( group.hasAction( task2 ) ) ;
            assertFalse( group.removeAction(task2) ) ;
            assertEquals( 3 , group.length ) ;
        }
        
        public function testRemoveActionClear():void
        {
            assertTrue( group.removeAction() ) ;
            assertEquals( 0 , group.length ) ;
            assertFalse( group.removeAction() ) ;
        }
        
        public function testToArray():void
        {
            var ar:Array ;
            ar = group.toArray() ;
            ArrayAssert.assertEquals([task1,task2,task3,task4], ar ) ;
            group.length = 10 ;
            ar = group.toArray() ;
            ArrayAssert.assertEquals([task1,task2,task3,task4], ar ) ;
        }
        
        public function testToString():void
        {
            assertEquals( group.toString() , "[TaskGroup]" ) ;
            group.verbose = true ;
            assertEquals( group.toString() , "[TaskGroup<[MockTask],[MockTask],[MockTask],[MockTask]>]" ) ;
            group.length = 6 ;
            assertEquals( group.toString() , "[TaskGroup<[MockTask],[MockTask],[MockTask],[MockTask],null,null>]" ) ;
            group.length = 2 ;
            assertEquals( group.toString() , "[TaskGroup<[MockTask],[MockTask]>]" ) ;
            group.verbose = false ;
        }
        
        public function testToVector():void
        {
            var v:Vector.<Action> = group.toVector() ;
            assertEquals( v.toString() , "[MockTask],[MockTask],[MockTask],[MockTask]" ) ;
            assertEquals( v.length , group.length ) ;
            assertEquals( v[0] , group.getActionAt(0) ) ;
            assertEquals( v[1] , group.getActionAt(1) ) ;
            assertEquals( v[2] , group.getActionAt(2) ) ;
            assertEquals( v[3] , group.getActionAt(3) ) ;
        }
    }
}
