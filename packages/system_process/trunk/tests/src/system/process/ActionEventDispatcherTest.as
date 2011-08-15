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
    import library.ASTUce.framework.TestCase;

    import flash.events.Event;
    import flash.events.EventDispatcher;
    
    public class ActionEventDispatcherTest extends TestCase 
    {
        public function ActionEventDispatcherTest(name:String = "")
        {
            super(name);
        }
        
        public var action:EventDispatcherTask ;
        
        public function setUp():void
        {
            action = new EventDispatcherTask() ;
        }
        
        public function tearDown():void
        {
            action = undefined  ;
        }
        
        // constructor and inherit
        
        public function testConstructorEmpty():void
        {
            assertNotNull( action          , "#01") ;
            assertNull ( action.dispatcher , "#02") ;
            assertNull ( action.event      , "#03") ;
        }
        
        public function testConstructor():void
        {
            var d:EventDispatcher = new EventDispatcher() ;
            var e:Event           = new Event("test") ;
            action                = new EventDispatcherTask( d , e ) ;
            assertNotNull ( action                , "#01" ) ;
            assertEquals  ( d , action.dispatcher , "#02" ) ;
            assertEquals  ( e , action.event      , "#03" ) ;
        }
        
        public function testInherit():void
        {
            action = new EventDispatcherTask() ;
            assertTrue ( action is Task , "ActionEventDispatcher must extends the Task class.") ;
        }
        
        // methods
        
        public function testClone():void
        {
            var clone:EventDispatcherTask = action.clone() as  EventDispatcherTask;
            assertNotNull ( clone  , "#01" ) ;
        }
        
        public function testRun():void
        {
            action.dispatcher = new EventDispatcher() ;
            action.event      = new Event("test") ;
            
            action.dispatcher.addEventListener( "test" , _testHandleEvent ) ;
            
            action.run() ;
            
            assertTrue ( _testHandleEventCalled , "#01") ;
        }
        
        // private
        
        private var _testHandleEventCalled:Boolean ;
        
        private function _testHandleEvent(e:Event):void
        {
            _testHandleEventCalled = true ;
        }
    }
}