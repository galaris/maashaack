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
    
    public class CoreEventDispatcherTest extends TestCase 
    {
        public function CoreEventDispatcherTest(name:String = "")
        {
            super( name );
        }
        
        public function testConstructorEmptyArgument():void
        {
            var dispatcher:CoreEventDispatcher = new CoreEventDispatcher() ;
            assertNotNull( dispatcher          , "01 - CoreEventDispatcher constructor failed.") ;
            assertFalse( dispatcher.isGlobal() , "02 - CoreEventDispatcher constructor failed.") ;
            assertNull( dispatcher.channel     , "03 - CoreEventDispatcher constructor failed.") ;
        }
        
        public function testConstructorWithArguments():void
        {
            var dispatcher:CoreEventDispatcher = new CoreEventDispatcher(true, "channel") ;
            
            assertNotNull( dispatcher , "01 - CoreEventDispatcher constructor failed.") ;
            assertTrue( dispatcher.isGlobal() , "02 - CoreEventDispatcher constructor failed.") ;
            assertEquals( dispatcher.channel, "channel" , "03 - CoreEventDispatcher constructor failed.") ;
            
            EventDispatcher.flush() ;
        }
        
        public function testChannelProperty():void
        {
            var dispatcher:CoreEventDispatcher ;
            
            dispatcher = new CoreEventDispatcher(true, "channel") ;
            assertEquals( dispatcher.channel, "channel" , "02-03 - CoreEventDispatcher constructor failed.") ;
            
            dispatcher = new CoreEventDispatcher(true) ;
            assertEquals( dispatcher.channel, EventDispatcher.DEFAULT_SINGLETON_CHANNEL, "02-03 - CoreEventDispatcher constructor failed.") ;
            
            EventDispatcher.flush() ;
            
            dispatcher = new CoreEventDispatcher() ;
            assertNull(dispatcher.channel, "CoreEventDispatcher channel property failed.") ;
        }
        
        public function testAddEventListener():void
        {
            var listener:MockEventListener     = new MockEventListener() ;
            var dispatcher:CoreEventDispatcher = new CoreEventDispatcher() ;
            
            dispatcher.addEventListener("fire", listener.handleEvent ) ; // function
            
            var event:Event = new Event("fire") ;
            dispatcher.dispatchEvent( event ) ;
            
            assertNotNull( listener.event , "01 - CoreEventDispatcher addEventListener failed." ) ;
            assertEquals( listener.count , 1  , "02 - CoreEventDispatcher addEventListener failed." ) ;
        }
        
        public function testDispatchEvent():void
        {
            var listener:MockEventListener = new MockEventListener() ;
            
            var dispatcher:CoreEventDispatcher = new CoreEventDispatcher() ;
            
            dispatcher.addEventListener("fire", listener.handleEvent ) ; // function
            
            var event:Event = new Event("fire") ;
            assertTrue(dispatcher.dispatchEvent( event ), "01 - CoreEventDispatcher dispatchEvent failed." ) ;
            
            assertNotNull( listener.event , "02 - CoreEventDispatcher dispatchEvent failed." ) ;
            assertEquals( listener.count , 1  , "03 - CoreEventDispatcher dispatchEvent failed." ) ;
        }
        
        public function testGetEventDispatcher():void
        {
            var dispatcher:CoreEventDispatcher = new CoreEventDispatcher() ;
            
            var d:EventDispatcher ;
            
            d = dispatcher.getEventDispatcher() ;
            assertNotNull(d, "01-02 - CoreEventDispatcher getEventDispatcher() failed.") ;
            assertFalse(d == EventDispatcher.getInstance(), "01-01 - CoreEventDispatcher getEventDispatcher() failed.") ;
            
            dispatcher.setGlobal(true) ;
            d = dispatcher.getEventDispatcher() ;
            assertNotNull(d, "02-01 - CoreEventDispatcher getEventDispatcher() failed.") ;
            assertTrue(d == EventDispatcher.getInstance(), "02-02 - CoreEventDispatcher getEventDispatcher() failed.") ;
            
            EventDispatcher.flush() ;
        }
        
        public function testHasEventListener():void
        {
            var listener:MockEventListener = new MockEventListener() ;
            var dispatcher:CoreEventDispatcher = new CoreEventDispatcher() ;
            assertFalse( dispatcher.hasEventListener("type"), "01 - CoreEventDispatcher hasEventListener failed.") ;
            dispatcher.addEventListener("type", listener.handleEvent) ;
            assertTrue( dispatcher.hasEventListener("type"), "01 - CoreEventDispatcher hasEventListener failed.") ;
        }
        
        public function testIsGlobal():void
        {
            var dispatcher:CoreEventDispatcher = new CoreEventDispatcher() ;
            assertFalse( dispatcher.isGlobal(), "01 - CoreEventDispatcher isGlobal() failed.") ;
            dispatcher.setGlobal(true) ;
            assertTrue( dispatcher.isGlobal(), "02 - CoreEventDispatcher isGlobal() failed.") ;
            dispatcher.setGlobal(false) ;
            assertFalse( dispatcher.isGlobal(), "03 - CoreEventDispatcher isGlobal() failed.") ;
        }
        
        public function testIsLocked():void
        {
            var dispatcher:CoreEventDispatcher = new CoreEventDispatcher() ;
            assertFalse(dispatcher.isLocked(), "01 - CoreEventDispatcher isLocked() failed." ) ;
            dispatcher.lock() ;
            assertTrue(dispatcher.isLocked(), "02 - CoreEventDispatcher isLocked() failed." ) ;
            dispatcher.unlock() ;
            assertFalse(dispatcher.isLocked(), "03 - CoreEventDispatcher isLocked() failed." ) ;
        }
        
        public function testLock():void
        {
            var dispatcher:CoreEventDispatcher = new CoreEventDispatcher() ;
            dispatcher.lock() ;
            assertTrue(dispatcher.isLocked(), "CoreEventDispatcher lock() failed." ) ;
            dispatcher.unlock() ;
        }
        
        public function testRegisterEventListener():void
        {
            var listener:MockEventListener = new MockEventListener() ;
            
            var dispatcher:CoreEventDispatcher = new CoreEventDispatcher() ;
            
            var test:Boolean ;
            var fListener:Function = function( e:Event ):void
            {
                test = true ;
            };
            
            dispatcher.registerEventListener("fire", fListener ) ; // function
            dispatcher.registerEventListener("fire", listener ) ; // EventListener
            
            var event:Event = new Event("fire") ;
            dispatcher.dispatchEvent( event ) ;
            assertNotNull( listener.event , "01-01 - CoreEventDispatcher registerEventListener failed." ) ;
            assertEquals( listener.count , 1  , "01-02 - CoreEventDispatcher registerEventListener failed." ) ;
            
            dispatcher.dispatchEvent( event ) ;
            
            assertNotNull( listener.event , "02-01 - CoreEventDispatcher registerEventListener failed." ) ;
            assertEquals( listener.count , 2  , "02-02 - CoreEventDispatcher registerEventListener failed." ) ; 
            
            assertTrue( test , "03 - CoreEventDispatcher registerEventListener failed." ) ;
        }
        
        public function testRemoveEventListener():void
        {
            var listener:MockEventListener = new MockEventListener() ;
            
            var dispatcher:CoreEventDispatcher = new CoreEventDispatcher() ;
            
            dispatcher.registerEventListener("fire", listener.handleEvent ) ;
            
            dispatcher.removeEventListener("fire", listener.handleEvent ) ;
            
            var event:Event = new Event("fire") ;
            
            dispatcher.dispatchEvent( event ) ;
            
            assertNull( listener.event , "01 - CoreEventDispatcher registerEventListener() failed." ) ;
            assertEquals( listener.count , 0  , "02 - CoreEventDispatcher registerEventListener() failed." ) ;
        }
        
        public function testSetEventDispatcher():void
        {
            var dispatcher:CoreEventDispatcher = new CoreEventDispatcher() ;
            
            var d:EventDispatcher = new EventDispatcher() ;
            
            dispatcher.setEventDispatcher(d) ;
            
            assertEquals( d , dispatcher.getEventDispatcher(), "01 - CoreEventDispatcher getEventDispatcher() failed.") ;
            
            dispatcher.setEventDispatcher(null) ;
            
            assertNotNull( dispatcher.getEventDispatcher(), "02 - CoreEventDispatcher getEventDispatcher() failed.") ;
        }
        
        public function testSetGlobal():void
        {
            var dispatcher:CoreEventDispatcher = new CoreEventDispatcher() ;
            
            dispatcher.setGlobal(true) ;
            assertTrue( dispatcher.isGlobal(), "01-01 - CoreEventDispatcher setGlobal() failed.") ;
            assertEquals( dispatcher.channel, EventDispatcher.DEFAULT_SINGLETON_CHANNEL, "01-02 - CoreEventDispatcher setGlobal() failed.") ;
            
            dispatcher.setGlobal(false) ;
            assertFalse( dispatcher.isGlobal(), "02-01 - CoreEventDispatcher setGlobal() failed.") ;
            assertNull( dispatcher.channel, "02-02 - CoreEventDispatcher setGlobal() failed.") ;
            
            dispatcher.setGlobal(true, "channel") ;
            assertTrue( dispatcher.isGlobal(), "03-01 - CoreEventDispatcher setGlobal() failed.") ;
            assertEquals( dispatcher.channel, "channel", "03-02 - CoreEventDispatcher setGlobal() failed.") ;
        }
        
        public function testUnlock():void
        {
            var dispatcher:CoreEventDispatcher = new CoreEventDispatcher() ;
            dispatcher.lock() ;
            dispatcher.unlock() ;
            assertFalse(dispatcher.isLocked(), "CoreEventDispatcher unlock() failed." ) ;
        }
        
        public function testUnregisterEventListener():void
        {
            var listener:MockEventListener = new MockEventListener() ;
            
            var dispatcher:CoreEventDispatcher = new CoreEventDispatcher() ;
            
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
            
            dispatcher.dispatchEvent( event ) ;
            
            assertNull( listener.event , "01-01 - CoreEventDispatcher registerEventListener failed." ) ;
            assertEquals( listener.count , 0  , "01-02 - CoreEventDispatcher registerEventListener failed." ) ;
            
            assertFalse( test , "02 - CoreEventDispatcher registerEventListener failed." ) ;
        }
        
        public function testWillTrigger():void
        {
            var listener:MockEventListener = new MockEventListener() ;
            var dispatcher:CoreEventDispatcher = new CoreEventDispatcher() ;
            assertFalse( dispatcher.willTrigger("type"), "01 - CoreEventDispatcher willTrigger() failed.") ;
            dispatcher.addEventListener("type", listener.handleEvent) ;
            assertTrue( dispatcher.willTrigger("type"), "01 - CoreEventDispatcher willTrigger() failed.") ;
        }
    }
}
