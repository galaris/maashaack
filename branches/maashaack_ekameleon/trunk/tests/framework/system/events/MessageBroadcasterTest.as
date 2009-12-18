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
  Portions created by the Initial Developers are Copyright (C) 2006-2010
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
    import buRRRn.ASTUce.framework.ArrayAssert;
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.Cloneable;
    import system.data.Iterable;
    import system.data.Iterator;
    import system.events.mocks.MockCallback;
    
    public class MessageBroadcasterTest extends TestCase 
    {
        public function MessageBroadcasterTest(name:String = "")
        {
            super(name);
        }
        
        public var broadcaster:MessageBroadcaster ;
        
        public var listener1:MockCallback ;
        
        public var listener2:MockCallback ;
        
        public function setUp():void
        {
            broadcaster = new MessageBroadcaster() ;
            listener1  = new MockCallback() ;
            listener2  = new MockCallback() ;
        }
        
        public function tearDown():void
        {
            broadcaster = null ;
            listener1  = null ;
            listener2  = null ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( broadcaster , "The constructor failed.") ;
        }
        
        public function testInterfaces():void
        {
            assertTrue( broadcaster is Broadcaster , "The MessageBroadcaster class must implements the Broadcaster interface.") ;
            assertTrue( broadcaster is Cloneable   , "The MessageBroadcaster class must implements the Cloneable interface.") ;
            assertTrue( broadcaster is Iterable    , "The MessageBroadcaster class must implements the Iterable interface.") ;
        }
        
        public function testAddListener():void
        {
            assertTrue( broadcaster.addListener( listener1 ) , "01 - The addListener method failed.") ;
            assertFalse( broadcaster.addListener( listener1 ) , "02 - The addListener method failed.") ;
            assertTrue( broadcaster.addListener( listener2 ) , "03 - The addListener method failed.") ;
        }
        
        public function testBroadcastMessage():void
        {
            broadcaster.addListener( listener1 ) ;
            broadcaster.broadcastMessage( "message" , "test1" , "test2" ) ;
            ArrayAssert.assertEquals(["test1" , "test2"], listener1.arguments , "broadcastMessage failed.") ;
        }
        
        public function testClone():void
        {
            broadcaster.addListener( listener1 ) ;
            broadcaster.addListener( listener2 ) ;
            var clone:MessageBroadcaster = broadcaster.clone() as MessageBroadcaster ;
            assertNotNull( clone , "01 - clone method failed.") ;
            assertEquals( clone.size() , broadcaster.size(), "02 - clone method failed.") ;
            ArrayAssert.assertEquals(clone.getListeners(), broadcaster.getListeners() , "03 - clone method failed.") ;
        }
        
        public function testGetListeners():void
        {
            broadcaster.addListener( listener1 ) ;
            broadcaster.addListener( listener2 ) ;
            ArrayAssert.assertEquals([listener1,listener2], broadcaster.getListeners() , "getListeners method failed.") ;
        }
        
        public function testHasListener():void
        {
            broadcaster.addListener( listener1 ) ;
            assertTrue( broadcaster.hasListener(listener1) , "01 - broadcastMessage failed.") ;
            assertFalse( broadcaster.hasListener(listener2) , "02 - broadcastMessage failed.") ;
        }
        
        public function testIsEmpty():void
        {
            assertTrue( broadcaster.isEmpty() , "01 - isEmpty failed.") ;
            broadcaster.addListener( listener1 ) ;
            assertFalse( broadcaster.isEmpty() , "02 - isEmpty failed.") ;
        }
        
        public function testIterator():void
        {
            broadcaster.addListener( listener1 ) ;
            broadcaster.addListener( listener2 ) ;
            var it:Iterator = broadcaster.iterator() ;
            assertNotNull( it , "01 - iterator failed.") ;
            assertTrue( it.hasNext() , "02-01 - iterator failed.") ;
            assertEquals( it.next() , listener1 , "02-02 - iterator failed.") ;
            assertTrue( it.hasNext() , "03-01 - iterator failed.") ;
            assertEquals( it.next() , listener2 , "03-02 - iterator failed.") ;
            assertFalse( it.hasNext() , "04 - iterator failed.") ;
        }
        
        public function testRemoveAllListeners():void
        {
            broadcaster.addListener( listener1 ) ;
            broadcaster.addListener( listener2 ) ;
            broadcaster.removeAllListeners() ;
            assertTrue( broadcaster.isEmpty() , "removeAllListeners failed.") ;
        }
        
        public function testRemoveListener():void
        {
            broadcaster.addListener( listener1 ) ;
            broadcaster.addListener( listener2 ) ;
            
            assertTrue( broadcaster.removeListener( listener1 ) , "01-01 removeListener failed." ) ;
            assertEquals( broadcaster.size() , 1 , "01-02 - removeListener() failed.") ;
            
            assertFalse( broadcaster.removeListener( listener1 ) , "02 removeListener failed." ) ;
        }
        
        public function testSize():void
        {
            assertEquals( broadcaster.size() , 0 , "01 - size() failed.") ;
            broadcaster.addListener( listener1 ) ;
            assertEquals( broadcaster.size() , 1 , "02 - size() failed.") ;
            broadcaster.addListener( listener2 ) ;
            assertEquals( broadcaster.size() , 2 , "03 - size() failed.") ;
            broadcaster.addListener( listener2 ) ;
            assertEquals( broadcaster.size() , 2 , "04 - size() failed.") ;
        }
    }
}
