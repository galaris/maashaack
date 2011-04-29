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

package system.broadcasters 
{
    import buRRRn.ASTUce.framework.ArrayAssert;
    import buRRRn.ASTUce.framework.TestCase;

    import system.events.BasicEvent;
    import system.events.mocks.MockListener;

    import flash.events.Event;

    public class FastDispatcherTest extends TestCase 
    {
        public function FastDispatcherTest(name:String = "")
        {
            super(name);
        }
        
        public var dispatcher:FastDispatcher ;
        
        public var listener1:MockListener ;
        
        public var listener2:MockListener ;
        
        public var listener3:MockListener ;
        
        public function setUp():void
        {
            dispatcher = new FastDispatcher() ;
            listener1  = new MockListener("listener1") ;
            listener2  = new MockListener("listener2") ;
            listener3  = new MockListener("listener3") ;
        }
        
        public function tearDown():void
        {
            dispatcher = null ;
            listener1  = null ;
            listener2  = null ;            listener3  = null ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( dispatcher , "The constructor failed.") ;
        }
        
        public function testInterfaces():void
        {
            assertTrue( dispatcher is Broadcaster , "The FastDispatcher class must implements the Broadcaster interface.") ;
        }
        
        public function testLength():void
        {
            assertEquals( dispatcher.length , 0 , "01 - length failed.") ;
            dispatcher.addListener( listener1 ) ;
            assertEquals( dispatcher.length , 1 , "02 - length failed.") ;
            dispatcher.addListener( listener2 ) ;
            assertEquals( dispatcher.length , 2 , "03 - length failed.") ;
            dispatcher.addListener( listener2 ) ;
            assertEquals( dispatcher.length , 2 , "04 - length failed.") ;
        }
        
        public function testAddListener():void
        {
            assertTrue( dispatcher.addListener( listener1 ) , "01 - The addListener method failed.") ;
            assertFalse( dispatcher.addListener( listener1 ) , "02 - The addListener method failed.") ;
            assertTrue( dispatcher.addListener( listener2 ) , "03 - The addListener method failed.") ;
        }
        
        public function testAddListenerWithPriority():void
        {
            dispatcher.addListener( listener1 , 500 ) ;
            dispatcher.addListener( listener2 , 999 ) ;
            dispatcher.addListener( listener3 , 0 ) ;
            ArrayAssert.assertEquals( [listener2, listener1, listener3] , dispatcher.toArray() ) ;
            dispatcher.removeListener() ;
            dispatcher.addListener( listener1 , 400 ) ;
            dispatcher.addListener( listener2 , 200 ) ;
            dispatcher.addListener( listener3 , 999 ) ;
            ArrayAssert.assertEquals( [listener3, listener1, listener2] , dispatcher.toArray() ) ;
        }
        
        public function testBroadcastMessage():void
        {
            dispatcher.addListener( listener1 ) ;
            var e:Event = dispatcher.broadcastMessage( "onCallback" , "test1" , "test2" ) ;
            assertEquals( listener1.event , e , "01 - broadcastMessage failed.") ;
            assertTrue( listener1.event is BasicEvent , "02 - broadcastMessage failed.") ;
            assertEquals( listener1.event.type , "onCallback" , "03 - broadcastMessage failed.") ;
            ArrayAssert.assertEquals(["test1" , "test2"], (listener1.event as BasicEvent).context , "04 - broadcastMessage failed.") ;
        }
        
        public function testDispatch():void
        {
            dispatcher.addListener( listener1 ) ;
            var e:BasicEvent = new BasicEvent("onCallback") ;
            dispatcher.dispatch( e ) ;
            assertEquals( listener1.event , e , "01 - broadcastMessage failed.") ;
        }
        
        public function testHasListener():void
        {
            dispatcher.addListener( listener1 ) ;
            assertTrue( dispatcher.hasListener(listener1) , "01 - broadcastMessage failed.") ;
            assertFalse( dispatcher.hasListener(listener2) , "02 - broadcastMessage failed.") ;
        }
        
        public function testIsEmpty():void
        {
            assertTrue( dispatcher.isEmpty() , "01 - isEmpty failed.") ;
            dispatcher.addListener( listener1 ) ;
            assertFalse( dispatcher.isEmpty() , "02 - isEmpty failed.") ;
        }
        
        public function testRemoveListenerWithNullArgument():void
        {
            dispatcher.addListener( listener1 ) ;
            dispatcher.addListener( listener2 ) ;
            dispatcher.removeListener() ;
            assertTrue( dispatcher.isEmpty() ) ;
        }
        
        public function testRemoveListener():void
        {
            dispatcher.addListener( listener1 ) ;
            dispatcher.addListener( listener2 ) ;
            
            assertTrue( dispatcher.removeListener( listener1 ) , "01-01 removeListener failed." ) ;
            assertEquals( dispatcher.length , 1 , "01-02 - removeListener() failed.") ;
            
            assertFalse( dispatcher.removeListener( listener1 ) , "02 removeListener failed." ) ;
        }
        
        public function testToArray():void
        {
            dispatcher.addListener( listener1 ) ;
            dispatcher.addListener( listener2 ) ;
            ArrayAssert.assertEquals([listener1,listener2], dispatcher.toArray() ) ;
        }
    }
}
