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

package system.process 
{
    import buRRRn.ASTUce.framework.TestCase;        import system.Reflection;    import system.events.ActionEvent;    import system.events.CoreEventDispatcher;    import system.process.mocks.MockTaskListener;
        public class TaskTest extends TestCase
    {
        public function TaskTest(name:String = "")
        {
            super(name);
        }
        
        public var action:Task ;
        
        public var mockListener:MockTaskListener ;
        
        public function setUp():void
        {
            action       = new Task() ;
            mockListener = new MockTaskListener(action) ;
        }
        
        public function tearDown():void
        {
            mockListener.unregister() ;
            mockListener = undefined  ;
            action       = undefined  ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( action , "Task constructor failed, the instance not must be null." ) ;
        }
        
        public function testInherit():void
        {
            assertTrue( action is CoreEventDispatcher , "Action inherit CoreEventDispatcher failed.") ;
        }
        
        public function testInterface():void
        {
            assertTrue( action is Action , "Task implements the Action interface" ) ;
        }
        
        public function testIsDynamic():void
        {
            var action:Task = new Task() ;
            assertTrue( Reflection.getClassInfo(action).isDynamic() , "Task is dynamic.") ;
        }
        
        public function testParent():void
        {
            var t1:Task = new Task() ;
            var t2:Task = new Task() ;
            assertNull( t1.parent , "01 - Task parent failed." ) ;
            t2.parent = t1 ;
            assertEquals( t2.parent , t1 , "02 - Task parent failed." ) ;
        }
        
        public function testClone():void
        {
            var clone:Task = action.clone() as Task ;
            assertNotNull( clone , "01 - Task clone() failed." ) ;
            assertFalse( clone == action  , "02 - Task clone() failed." ) ;
            assertEquals( clone.isGlobal() , action.isGlobal() , "03 - Task clone() failed.") ;
        }
        
        public function testRunning():void
        {
            assertFalse( action.running  , "Action running failed, default property value must be false." ) ;
        }
        
        public function testNotifyFinished():void
        {
            action.notifyFinished() ;
            assertTrue( mockListener.finishCalled , "Action notifyFinished failed, the ActionEvent.FINISH event isn't notify" ) ;
            assertEquals( mockListener.finishType , ActionEvent.FINISH  , "Action notifyStarted failed, bad type found." );
        }
        
        public function testNotifyStarted():void
        {
            action.notifyStarted() ;
            assertTrue( mockListener.startCalled , "Action notifyStarted failed, the ActionEvent.START event isn't notify" ) ;
            assertEquals( mockListener.startType , ActionEvent.START  , "Action notifyStarted failed, bad type found." );
        }
        
        public function testRun():void
        {
            assertTrue( "run" in action , "Action run 01 method exist." ) ;
        }
        
        public function testFinishIt():void
        {
            var test:Boolean ;
            action.finishIt = function():void
            {
                test = true ;
            };
            action.notifyFinished() ;
            assertTrue(test , "The dynamic Action.finishIt method failed.") ;
            action.finishIt = null ;
            assertNull( action.finishIt , "The Action.finishIt member must be null.") ;
        }
        
        public function testStartIt():void
        {
            var test:Boolean ;
            action.startIt = function():void
            {
                test = true ;
            };
            action.notifyStarted() ;
            assertTrue(test , "The dynamic Action.startIt method failed.") ;
            action.startIt = null ;
            assertNull( action.startIt , "The Action.startIt member must be null.") ;
        }
    }
}
