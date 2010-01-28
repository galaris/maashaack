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

    import system.data.Iterable;
    import system.data.Iterator;
    import system.events.samples.ReceiverClass;

    public class InternalSignalTest extends TestCase 
    {
        public function InternalSignalTest(name:String = "")
        {
            super(name);
        }
        
        public var signal:InternalSignal ;
        
        public var listener1:Function ;
        
        public var listener2:Receiver ;
        
        public function setUp():void
        {
            signal = new InternalSignal() ;
            listener1  = function( message:String ):void 
            { 
                throw message ;
            };
            listener2  = new ReceiverClass() ;
        }
        
        public function tearDown():void
        {
            signal    = null ;
            listener1 = null ;
            listener2 = null ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( signal , "The constructor failed.") ;
        }
        
        public function testInterfaces():void
        {
            assertTrue( signal is Signal , "The InternalSignal class must implements the Broadcaster interface.") ;
            assertTrue( signal is Iterable , "The InternalSignal class must implements the Iterable interface.") ;
        }
        
        public function testLength():void
        {
            assertEquals( signal.length , 0 , "01 - length failed.") ;
            signal.connect( listener1 ) ;
            assertEquals( signal.length , 1 , "02 - length failed.") ;
            signal.connect( listener2 ) ;
            assertEquals( signal.length , 2 , "03 - length failed.") ;
            signal.connect( listener2 ) ;
            assertEquals( signal.length , 2 , "04 - length failed.") ;
        }
        
        public function testConnect():void
        {
            assertTrue( signal.connect( listener1 ) , "01 - The connect method failed.") ;
            assertFalse( signal.connect( listener1 ) , "02 - The connect method failed.") ;
        }
        
        public function testConnectReceiver():void
        {
            assertTrue( signal.connect( listener2 ) , "01 - The connect method failed.") ;
            assertFalse( signal.connect( listener2 ) , "02 - The connect method failed.") ;
        }
        
        public function testConnectWithWeakReference():void
        {
            assertTrue( signal.connect( listener1 , true ) , "01 - The connect method failed.") ;
            assertFalse( signal.connect( listener1 , true ) , "02 - The connect method failed.") ;
            assertFalse( signal.connect( listener1 ) , "03 - The connect method failed.") ;
        }
        
        public function testDisconnect():void
        {
            signal.connect( listener1 ) ;
            assertTrue( signal.disconnect( listener1 ) , "01 - The disconnect method failed.") ;
            assertFalse( signal.disconnect( listener1 ) , "02 - The disconnect method failed.") ;
        }
        
        public function testDisconnectWK():void
        {
            signal.connect( listener1 , true ) ;
            assertTrue( signal.disconnect( listener1 ) , "01 - The disconnect method failed.") ;
            assertFalse( signal.disconnect( listener1 ) , "02 - The disconnect method failed.") ;
        }
        
        public function testDisconnectReceiver():void
        {
            signal.connect( listener2 ) ;
            assertTrue( signal.disconnect( listener2 ) , "01 - The disconnect method failed.") ;
            assertFalse( signal.disconnect( listener2 ) , "02 - The disconnect method failed.") ;
        }
        
        public function testDisconnectReceiverWK():void
        {
            signal.connect( listener2 , true ) ;
            assertTrue( signal.disconnect( listener2 ) , "01 - The disconnect method failed.") ;
            assertFalse( signal.disconnect( listener2 ) , "02 - The disconnect method failed.") ;
        }
        
        public function testHas():void
        {
            assertFalse( signal.has( listener1 ) , "01 - The has method failed.") ;
            signal.connect( listener1 ) ;
            assertTrue( signal.has( listener1 ) , "02 - The connect method failed.") ;
            signal.disconnectAll() ;
            assertFalse( signal.has( listener1 ) , "03 - The has method failed.") ;
            signal.connect( listener1 , true ) ;
            assertTrue( signal.has( listener1 ) , "04 - The connect method failed.") ;
            signal.disconnect( listener1 ) ;
            assertFalse( signal.has( listener1 ) , "05 - The has method failed.") ;
        }
        
        public function testhasReceiver():void
        {
            assertFalse( signal.has( listener2 ) , "01-01 - The has method failed.") ;
            signal.connect( listener2 ) ;
            assertTrue( signal.has( listener2 ) , "01-02 - The connect method failed.") ;
            signal.disconnectAll() ;
            assertFalse( signal.has( listener2 ) , "01-01 - The has method failed.") ;
        }
        
        public function testIsEmpty():void
        {
            assertTrue( signal.isEmpty() ) ;
            signal.connect( listener1 ) ;
            assertFalse( signal.isEmpty() ) ;
        }
        
        public function testIterator():void
        {
            signal.connect( listener1 ) ;
            signal.connect( listener2 ) ;
            var it:Iterator = signal.iterator() ;
            assertNotNull( it , "01 - iterator failed.") ;
            assertTrue( it.hasNext() , "02 - iterator failed.") ;
            assertEquals( it.next() , listener1 , "02-02 - iterator failed.") ;
            assertTrue( it.hasNext() , "03 - iterator failed.") ;
            assertEquals( it.next() , listener2.receive , "03-02 - iterator failed.") ;
            assertFalse( it.hasNext() , "04 - iterator failed.") ;
        }
        
        public function testToArray():void
        {
            signal.connect( listener1 ) ;
            signal.connect( listener2 ) ;
            ArrayAssert.assertEquals([listener1,listener2.receive], signal.toArray() ) ;
        }
    }
}
