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

package system.signals 
{
    import buRRRn.ASTUce.framework.ArrayAssert;
    import buRRRn.ASTUce.framework.TestCase;

    import system.signals.samples.ReceiverClass;

    public class InternalSignalTest extends TestCase 
    {
        public function InternalSignalTest(name:String = "")
        {
            super(name);
        }
        
        public var signal:InternalSignal ;
        
        public var receiver1:Function ;
        
        public var receiver2:Receiver ;
        
        public function setUp():void
        {
            signal = new InternalSignal() ;
            receiver1  = function( message:String ):void 
            { 
                throw message ;
            };
            receiver2  = new ReceiverClass() ;
        }
        
        public function tearDown():void
        {
            signal    = null ;
            receiver1 = null ;
            receiver2 = null ;
        }
        
        public function testInterfaces():void
        {
            assertTrue( signal is Signaler , "The InternalSignal class must implements the Broadcaster interface.") ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( signal , "The constructor failed.") ;
        }
        
        public function testConstructorWithTypes():void
        {
            signal = new InternalSignal() ;
            assertNull( signal.types , "01" ) ;
            
            signal = new InternalSignal([]) ;
            ArrayAssert.assertEquals( [] , signal.types , "02" ) ;
            
            signal = new InternalSignal([String,uint,Number]) ;
            ArrayAssert.assertEquals( [String,uint,Number] , signal.types , "02" ) ;
        }
        
        public function testConstructorWithBadTypes():void
        {
            try
            {
                signal = new InternalSignal([String,"hello",Number]) ;
                fail( "The constructor must notify an error with a no valid Class reference in the types Array") ;
            }
            catch( e:Error )
            {
                assertTrue( e is ArgumentError ) ;
                assertEquals( "Invalid types representation, the Array of types failed at index 3 should be a Class but was:\"hello\"." , e.message ) ;
            }
        }
        
        public function testLength():void
        {
            assertEquals( signal.length , 0 , "01 - length failed.") ;
            signal.connect( receiver1 ) ;
            assertEquals( signal.length , 1 , "02 - length failed.") ;
            signal.connect( receiver2 ) ;
            assertEquals( signal.length , 2 , "03 - length failed.") ;
            signal.connect( receiver2 ) ;
            assertEquals( signal.length , 2 , "04 - length failed.") ;
        }
        
        public function testTypes():void
        {
            signal.types = null ;
            assertNull( signal.types , "01" ) ;
            
            signal.types = [] ;
            ArrayAssert.assertEquals( [] , signal.types , "02" ) ;
            
            signal.types = [String,uint,Number] ;
            ArrayAssert.assertEquals( [String,uint,Number] , signal.types , "03" ) ;
        }
        
        public function testBadTypes():void
        {
            try
            {
                signal.types = [String,"hello",Number] ;
                fail( "The constructor must notify an error with a no valid Class reference in the types Array") ;
            }
            catch( e:Error )
            {
                assertTrue( e is ArgumentError ) ;
                assertEquals( "Invalid types representation, the Array of types failed at index 3 should be a Class but was:\"hello\"." , e.message ) ;
            }
        }
        
        public function testConnect():void
        {
            assertTrue( signal.connect( receiver1 ) , "01 - The connect method failed.") ;
            assertFalse( signal.connect( receiver1 ) , "02 - The connect method failed.") ;
        }
        
        public function testConnectReceiver():void
        {
            assertTrue( signal.connect( receiver2 ) , "01 - The connect method failed.") ;
            assertFalse( signal.connect( receiver2 ) , "02 - The connect method failed.") ;
        }
        
        public function testConnectWithPriority():void
        {
            var receiver1:ReceiverClass = new ReceiverClass() ;            var receiver2:ReceiverClass = new ReceiverClass() ;            var receiver3:ReceiverClass = new ReceiverClass() ;            var receiver4:ReceiverClass = new ReceiverClass() ;            signal.connect( receiver1 , 400 ) ;
            signal.connect( receiver2 , 499 ) ;
            signal.connect( receiver3 , 1 ) ;
            signal.connect( receiver4 , 4 ) ;
            ArrayAssert.assertEquals([receiver2.receive, receiver1.receive, receiver4.receive , receiver3.receive ], signal.toArray() ) ;
        }
        
        public function testConnected():void
        {
            assertFalse( signal.connected() ) ;
            signal.connect( receiver1 ) ;
            assertTrue( signal.connected() ) ;
        }
        
        public function testDisconnect():void
        {
            signal.connect( receiver1 ) ;
            assertTrue( signal.disconnect( receiver1 ) , "01 - The disconnect method failed.") ;
            assertFalse( signal.disconnect( receiver1 ) , "02 - The disconnect method failed.") ;
        }
        
        public function testDisconnectReceiver():void
        {
            signal.connect( receiver2 ) ;
            assertTrue( signal.disconnect( receiver2 ) , "01 - The disconnect method failed.") ;
            assertFalse( signal.disconnect( receiver2 ) , "02 - The disconnect method failed.") ;
        }
        
        public function testHasReceiver():void
        {
            assertFalse( signal.hasReceiver( receiver1 ) , "01 - The hasReceiver method failed.") ;
            signal.connect( receiver1 ) ;
            assertTrue( signal.hasReceiver( receiver1 ) , "02 - The connect method failed.") ;
            signal.disconnect() ;
            assertFalse( signal.hasReceiver( receiver1 ) , "03 - The hasReceiver method failed.") ;
        }
        
        public function testHasReceiverWithReceiver():void
        {
            assertFalse( signal.hasReceiver( receiver2 ) , "01-01 - The hasReceiver method failed.") ;
            signal.connect( receiver2 ) ;
            assertTrue( signal.hasReceiver( receiver2 ) , "01-02 - The connect method failed.") ;
            signal.disconnect() ;
            assertFalse( signal.hasReceiver( receiver2 ) , "01-01 - The hasReceiver method failed.") ;
        }
        
        public function testToArray():void
        {
            signal.connect( receiver1 ) ;
            signal.connect( receiver2 ) ;
            ArrayAssert.assertEquals([receiver1,receiver2.receive], signal.toArray() ) ;
        }
        
        public function testToVector():void
        {
            signal.connect( receiver1 ) ;
            signal.connect( receiver2 ) ;
            var v:Vector.<Function> = signal.toVector() ;
            assertEquals( v[0] , receiver1 ) ;
            assertEquals( v[1] , receiver2.receive ) ;
        }
    }
}
