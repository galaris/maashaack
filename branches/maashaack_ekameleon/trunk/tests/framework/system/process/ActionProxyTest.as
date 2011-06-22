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
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.process.mocks.MockTaskReceiver;
        public class ActionProxyTest extends TestCase 
    {
        public function ActionProxyTest(name:String = "")
        {
            super(name);
        }
        
        public var action:ActionProxy ;
        
        public var mockReceiver:MockTaskReceiver ;
        
        public var scope:Object ;
        
        public function setUp():void
        {
            scope = {} ;
            scope.methodCalled = false ;
            scope.toString = function():String
            {
               return "[scope]" ;
            };
            
            var method:Function = function( ...args:Array ):void
            {
                this.methodCalled = true ;
            };
            
            action = new ActionProxy(scope, method, ["hello world", "hello city", "hello actionscript"] ) ;
            mockReceiver = new MockTaskReceiver(action) ;
        }
        
        public function tearDown():void
        {
            mockReceiver.unregister() ;
            mockReceiver = undefined  ;
            action       = undefined  ;
        }
        
        public function testInherit():void
        {
            assertTrue ( action is Task ) ;
        }
        
        public function testArgs():void
        {
            var args:Array = action.args ;
            assertNotNull ( args        , "args property not must be null." ) ;
            assertEquals  ( args.length , 3                    , "args property length isn't valid." ) ;
            assertEquals  ( args[0]     , "hello world"        , "args[0] isn't valid." ) ;    
            assertEquals  ( args[1]     , "hello city"         , "args[1] isn't valid." ) ;
            assertEquals  ( args[2]     , "hello actionscript" , "args[2] isn't valid." ) ;
        }
        
        public function testMethod():void
        {
            assertNotNull ( action.method ) ;
        }
        
        public function testScope():void
        {
            assertNotNull ( action.scope , "#1" ) ;
            assertEquals  ( action.scope , scope ,  "#2" ) ;
        }
        
        public function testClone():void
        {
            var clone:ActionProxy = action.clone() as ActionProxy ;
            
            assertNotNull( clone                      , "#1" ) ;
            assertNotSame( clone       , action       , "#2" ) ;
            assertEquals ( clone.scope , action.scope , "#3" ) ;
            assertEquals ( clone.args  , action.args  , "#4" ) ;
        }
        
        public function testRun():void
        {
            action.run() ;
            assertTrue( scope.methodCalled , "run method failed, the method isn't called." ) ;
            assertTrue( mockReceiver.startCalled  , "run method failed, the ActionEvent.START event isn't notify" ) ;
            assertTrue( mockReceiver.finishCalled  , "run method failed, the ActionEvent.START event isn't notify" ) ;
        }
        
        public function testEvents():void
        {
            action.run() ;
            assertTrue( mockReceiver.startCalled  , "run method failed, the ActionEvent.START event isn't notify" ) ;
            assertTrue( mockReceiver.finishCalled  , "run method failed, the ActionEvent.START event isn't notify" ) ;
        }
    }
}
