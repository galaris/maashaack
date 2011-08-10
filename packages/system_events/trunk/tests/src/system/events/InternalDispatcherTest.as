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
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.events.mocks.MockEventListener;
    
    import flash.events.Event;
    import flash.events.EventDispatcher;
    
    public class InternalDispatcherTest extends TestCase 
    {
        public function InternalDispatcherTest(name:String = "")
        {
            super( name );
        }
        
        public function testConstructor():void
        {
            var dispatcher:InternalDispatcher ;
            
            dispatcher = new InternalDispatcher() ;
            assertNotNull( dispatcher , "InternalDispatcher constructor failed") ;
            
            dispatcher = new InternalDispatcher( new system.events.EventDispatcher() ) ;
            assertNotNull( dispatcher , "InternalDispatcher constructor failed") ;
        }
        
        public function testInherit():void
        {
            var dispatcher:InternalDispatcher = new InternalDispatcher() ;
            assertTrue( dispatcher is flash.events.EventDispatcher , "InternalDispatcher must inherit the flash.events.EventDispatcher class.") ;
        }    
        
        public function testInterface():void
        {
            var dispatcher:InternalDispatcher = new InternalDispatcher() ;
            assertTrue( dispatcher is IEventDispatcher , "EventDispatcher must implements the IEventDispatcher class.") ;
        }       
        
        public function testTarget():void
        {
            var target:IEventDispatcher = new system.events.EventDispatcher() ;
            var dispatcher:InternalDispatcher ;
            
            dispatcher = new InternalDispatcher() ;
            assertEquals( dispatcher.target, dispatcher , "01 - InternalDispatcher target failed.") ;
            
            dispatcher = new InternalDispatcher(target) ;
            assertEquals( dispatcher.target, target , "02 - InternalDispatcher target failed.") ;
        }  
        
        public function testFireEventNoCompatibleArgument():void
        {
            var dispatcher:InternalDispatcher = new InternalDispatcher() ;
            assertFalse( dispatcher.fireEvent(2) , "01 - InternalDispatcher fireEvent failed with a no valid argument value.") ;
            assertFalse( dispatcher.fireEvent(null) , "02 - InternalDispatcher fireEvent failed with a no valid argument value.") ;
        }        
        
        public function testFireEventWithStringArgument():void
        {
            var listener:MockEventListener = new MockEventListener() ;
            
            var dispatcher:InternalDispatcher = new InternalDispatcher() ;
            dispatcher.addEventListener("fire", listener.handleEvent ) ;
           
            // 01 - one argument + first is a String
            
            listener.event = null ;
            
            assertTrue( dispatcher.fireEvent("fire")  , "01 - InternalDispatcher fireEvent failed with a String event argument." ) ;
            assertNotNull( listener.event             , "02 - InternalDispatcher fireEvent failed with a String event argument." ) ;
            assertTrue( listener.event is BasicEvent  , "03 - InternalDispatcher fireEvent failed with a String event argument." ) ;            
            
        }
        
        public function testFireEventWithEventArgument():void
        {
            var listener:MockEventListener    = new MockEventListener() ;
            var dispatcher:InternalDispatcher = new InternalDispatcher() ;
            var event:Event                   = new Event("fire") ;
            
            dispatcher.addEventListener("fire", listener.handleEvent ) ;
            
            assertTrue( dispatcher.fireEvent( event ) , "01 - InternalDispatcher fireEvent failed with an Event in the first argument.") ;
            assertEquals( listener.event , event , "02 - InternalDispatcher fireEvent failed with an Event in the first argument.") ;
        }
        
        public function testRegisterEventListener():void
        {
            var listener:MockEventListener = new MockEventListener() ;
            
            var dispatcher:InternalDispatcher = new InternalDispatcher() ;
            
            var test:Boolean ;
            var fListener:Function = function( e:Event ):void
            {
                test = true ;
            };
            
            dispatcher.registerEventListener("fire", fListener ) ; // function
            dispatcher.registerEventListener("fire", listener ) ; // EventListener
            
            var event:Event = new Event("fire") ;
            dispatcher.dispatchEvent( event ) ;
            assertNotNull( listener.event , "01-01 - InternalDispatcher registerEventListener failed." ) ;
            assertEquals( listener.count , 1  , "01-02 - InternalDispatcher registerEventListener failed." ) ;
            
            dispatcher.dispatchEvent( event ) ;
            
            assertNotNull( listener.event , "02-01 - InternalDispatcher registerEventListener failed." ) ;
            assertEquals( listener.count , 2  , "02-02 - InternalDispatcher registerEventListener failed." ) ; 
            
            assertTrue( test , "03 - InternalDispatcher registerEventListener failed." ) ;
        }
        
        public function testUnregisterEventListener():void
        {
            var listener:MockEventListener = new MockEventListener() ;
            
            var dispatcher:InternalDispatcher = new InternalDispatcher() ;
            
            var test:Boolean ;
            var fListener:Function = function( e:Event ):void
            {
                test = true ;
            };
            
            dispatcher.registerEventListener("fire", fListener ) ; // function
            dispatcher.registerEventListener("fire", listener ) ; // EventListener
            
            dispatcher.unregisterEventListener("fire", fListener ) ; // function
            dispatcher.unregisterEventListener("fire", listener ) ; // EventListener
            
            var event:Event = new Event("fire") ;
            dispatcher.fireEvent( event ) ;
            assertNull( listener.event , "01-01 - InternalDispatcher registerEventListener failed." ) ;
            assertEquals( listener.count , 0  , "01-02 - InternalDispatcher registerEventListener failed." ) ;
            
            assertFalse( test , "02 - InternalDispatcher registerEventListener failed." ) ;
        }
    }
}
