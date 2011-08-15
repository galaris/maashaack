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
    import library.ASTUce.framework.ArrayAssert;
    import library.ASTUce.framework.TestCase;
    
    import system.signals.samples.ReceiverClass;
    
    public class SignalTest extends TestCase 
    {
        public function SignalTest(name:String = "")
        {
            super(name);
        }
        
        public var signal:Signal ;
        
        public var receiver1:Function ;
        
        public var receiver2:Receiver ;
        
        public function setUp():void
        {
            signal = new Signal() ;
            receiver1 = function( message:String ):void 
            { 
                throw message ;
            };
            receiver2 = new ReceiverClass() ;
        }
        
        public function tearDown():void
        {
            signal    = null ;
            receiver1 = null ;
            receiver2 = null ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( signal , "The constructor failed.") ;
        }
        
        public function testInherit():void
        {
            assertTrue( signal is InternalSignal , "The instance must extends the InternalSignal class.") ;
        }
        
        public function testInterfaces():void
        {
            assertTrue( signal is Signaler , "The Signal class must implements the Signaler interface.") ;
        }
        
        ////////////
        
        public function testConstructorWithTypes():void
        {
            signal = new Signal() ;
            assertNull( signal.types , "01" ) ;
            
            signal = new Signal([]) ;
            ArrayAssert.assertEquals( [] , signal.types , "02" ) ;
            
            signal = new Signal([String,uint,Number]) ;
            ArrayAssert.assertEquals( [String,uint,Number] , signal.types , "02" ) ;
        }
        
        public function testConstructorWithBadTypes():void
        {
            try
            {
                signal = new Signal([String,"hello",Number]) ;
                fail( "The constructor must notify an error with a no valid Class reference in the types Array") ;
            }
            catch( e:Error )
            {
                assertTrue( e is ArgumentError ) ;
                assertEquals( "Invalid types representation, the Array of types failed at index 3 should be a Class but was:\"hello\"." , e.message ) ;
            }
        }
        
        ///////////////////
        
        public function testTypes():void
        {
            signal.types = [String] ;
            signal.connect( receiver1 ) ;
            try
            {
                signal.emit( "hello world" ) ;
                fail( "The signal must emit a message." ) ;
            }
            catch( message:String )
            {
                assertEquals( "hello world" , message ) ;
            }
        }
        
        public function testConstructorOnClassTypes():void
        {
            signal = new Signal( [String] ) ;
            signal.connect( receiver1 ) ;
            try
            {
                signal.emit( "hello world" ) ;
                fail( "The signal must emit a message." ) ;
            }
            catch( message:String )
            {
                assertEquals( "hello world" , message ) ;
            }
        }
        
        ///////////////////
        
        public function testTypesEmptyArrayValid():void
        {
            var called:Boolean ;
            var slot:Function = function():void
            {
                called = true ;
            };
            
            signal = new Signal() ;
            signal.types = [] ; // no arguments must be use to call the method
            signal.connect( slot ) ;
            signal.emit() ;
            
            assertTrue( called ) ;
        }
        
        public function testTypesEmptyArrayInvalid():void
        {
            var called:Boolean ;
            var slot:Function = function():void
            {
                called = true ;
            };
            
            signal = new Signal() ;
            
            signal.types = [] ; // no arguments must be use to call the method
            
            signal.connect( slot ) ;
            
            try
            {
                signal.emit( "arg1" ) ;
                fail( "01 - With one argument the emit method must notify an error" ) ;
            }
            catch( e:Error )
            {
                assertTrue( e is ArgumentError , "02 - Must handle an ArgumentError." ) ;
                assertEquals( "The number of arguments in the emit method is not valid, must be invoked with 0 argument(s) and you call it with 1 argument(s)." , e.message , "03" ) ;
            }
        }
        
        ///////////////////
        
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
        
        public function testEmit():void
        {
            signal.connect( receiver1 ) ;
            try
            {
                signal.emit("hello world") ;
                fail( "The signal must emit a message" ) ;
            }
            catch( message:String )
            {
                assertEquals( "hello world" , message ) ;
            }
        }
        
        public function testEmitReceiver():void
        {
            signal.connect( receiver2 ) ;
            try
            {
                signal.emit("hello world") ;
                fail( "The signal must emit a message" ) ;
            }
            catch( message:String )
            {
                assertEquals( "hello world" , message ) ;
            }
        }
        
        public function testHasReceiver():void
        {
            assertFalse( signal.hasReceiver( receiver1 ) , "01 - The hasReceiver method failed.") ;
            signal.connect( receiver1 ) ;
            assertTrue( signal.hasReceiver( receiver1 ) , "02 - The connect method failed.") ;
            signal.disconnect() ; // disconnect all
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
    }
}
