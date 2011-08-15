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
    import library.ASTUce.framework.ArrayAssert;
    import library.ASTUce.framework.TestCase;
    
    import system.events.mocks.MockCallback;
    import system.process.Lockable;

    public class CoreBroadcasterTest extends TestCase 
    {
        public function CoreBroadcasterTest(name:String = "")
        {
            super(name);
        }
        
        public var broadcaster:CoreBroadcaster ;
        
        public var listener:MockCallback ;
        
        public function setUp():void
        {
            broadcaster = new CoreBroadcaster() ;
            listener    = new MockCallback() ;
        }
        
        public function tearDown():void
        {
            broadcaster = null ;
            listener  = null ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( broadcaster , "Constructor failed.") ;
        }
        
        public function testInterface():void
        {
            assertTrue( broadcaster is Broadcaster , "Must implements the Broadcaster interface.") ;
            assertTrue( broadcaster is Lockable    , "Must implements the Lockable interface.") ;
        }
        
        public function testBroadcaster():void
        {
            assertNotNull( broadcaster.broadcaster , "broadcaster property not must be null.") ;
            assertNotNull( broadcaster.broadcaster is MessageBroadcaster, "broadcaster property must be a MessageBroadcaster reference.") ;
        }
        
        public function testAddListener():void
        {
            assertTrue( broadcaster.addListener( listener ) , "01 - The addListener method failed.") ;
            assertFalse( broadcaster.addListener( listener ) , "02 - The addListener method failed.") ;
        }
        
        public function testBroadcastMessage():void
        {
            broadcaster.addListener( listener ) ;
            broadcaster.broadcastMessage( "message" , "test1" , "test2" ) ;
            ArrayAssert.assertEquals(["test1" , "test2"], listener.arguments , "broadcastMessage failed.") ;
        }
        
        public function testIsEmpty():void
        {
            assertTrue( broadcaster.isEmpty() ) ;
            broadcaster.addListener( listener ) ;
            assertFalse( broadcaster.isEmpty() ) ;
            broadcaster.removeListener() ;
            assertTrue( broadcaster.isEmpty() ) ;
        }
        
        public function testHasListener():void
        {
            assertFalse( broadcaster.hasListener(listener) ) ;
            broadcaster.addListener( listener ) ;
            assertTrue( broadcaster.hasListener(listener) ) ;
        }
        
        public function testLockable():void
        {
            assertFalse( broadcaster.isLocked() ) ;
            broadcaster.lock() ;
            assertTrue( broadcaster.isLocked() ) ;
            broadcaster.unlock() ;
            assertFalse( broadcaster.isLocked() ) ;
        }
        
        public function testRemoveListenerWithNullArgument():void
        {
            broadcaster.addListener( listener ) ;
            broadcaster.removeListener() ;
            assertTrue( broadcaster.isEmpty() ) ;
        }
        
        public function testRemoveListener():void
        {
            broadcaster.addListener( listener ) ;
            assertTrue( broadcaster.removeListener( listener ) , "01 - removeListener failed." ) ;
            assertFalse( broadcaster.removeListener( listener ) , "02 - removeListener failed." ) ;
        }
        
        public function testSetBroadcaster():void
        {
            var b:Broadcaster = new FastDispatcher() ;
            
            broadcaster.setBroadcaster( b ) ;
            assertEquals( broadcaster.broadcaster , b , "01 - setBroadcaster method failed.") ;
            
            broadcaster.setBroadcaster() ; // default internal MessageBroadcaster instance with the initBroadcaster protected method.
            assertTrue( broadcaster.broadcaster is MessageBroadcaster , "02 - setBroadcaster method failed.") ;
        }
    }
}
