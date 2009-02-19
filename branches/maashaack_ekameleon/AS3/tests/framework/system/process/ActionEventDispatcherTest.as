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
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.events.ActionEvent;
    import system.events.BasicEvent;
    import system.events.FrontController;
    import system.process.mocks.MockTaskListener;
    
    import flash.events.Event;    

    public class ActionEventDispatcherTest extends TestCase 
	{

		public function ActionEventDispatcherTest(name:String = "")
		{
			super(name);
		}
		
        public var action:ActionEventDispatcher ;		
		
		public var mockListener:MockTaskListener ;			
		
        public function setUp():void
        {
        	FrontController.getInstance("myChannel").add("test" , _testHandleEvent ) ;
            action       = new ActionEventDispatcher("test", true , "myChannel" ) ;
            mockListener = new MockTaskListener( action ) ;
        }
        
        public function tearDown():void
        {
        	FrontController.getInstance("myChannel").remove("test") ;
            mockListener.unregister() ;
            mockListener = undefined  ;
            action       = undefined  ;
        }		
		
		public function testConstructor():void
		{
		
			var p:ActionEventDispatcher ;
			
			p = new ActionEventDispatcher("test") ;			
			
			assertNotNull ( p , "01 - ActionEventDispatcher constructor failed.") ;
			assertTrue    ( p is Task , "02 - ActionEventDispatcher constructor failed.") ;
			assertNotNull ( p.event   , "03 - ActionEventDispatcher constructor failed.") ;
			
		}
		
		public function testEvent():void
		{
			assertTrue( action.event is Event, "The event property failed, must inherit Event class.") ;
			assertTrue( action.event is BasicEvent , "The event property failed, must inherit BasicEvent class.") ;
		}	
		
		public function testClone():void
        {
        	var clone:ActionEventDispatcher = action.clone() as  ActionEventDispatcher;
        	assertNotNull ( clone  , "01 - clone method failed, with a null shallow copy object." ) ;
        	assertNotSame ( clone  , ActionEventDispatcher  , "02 - clone method failed, the shallow copy isn't the same with the ActionEventDispatcher object." ) ;
		}
        
        public function testRun():void
        {
        	action.run() ;
        	
        	assertTrue   ( mockListener.isRunning     , "The MockSimpleActionListener.isRunning property failed, must be true." ) ;
        	assertFalse  ( action.running             , "The running property of the BatchProcess must be false after the process." ) ;        
			
			assertTrue   ( mockListener.startCalled   , "run method failed, the ActionEvent.START event isn't notify" ) ;
            assertEquals ( mockListener.startType     , ActionEvent.START   , "run method failed, bad type found when the process is started." );
            
            assertTrue   ( mockListener.finishCalled  , "run method failed, the ActionEvent.FINISH event isn't notify" ) ;
            assertEquals ( mockListener.finishType    , ActionEvent.FINISH  , "run method failed, bad type found when the process is finished." );
            
            assertTrue    ( _testHandleEventCalled , "The global event isn't dispatched in the global event flow with the FrontController") ;
            
        }

		private var _testHandleEventCalled:Boolean ;
        		
		private function _testHandleEvent(e:Event):void
		{
			_testHandleEventCalled = true ;
		}
	
	}

}