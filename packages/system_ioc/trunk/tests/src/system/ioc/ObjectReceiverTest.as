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

package system.ioc
{
    import buRRRn.ASTUce.framework.TestCase;
    
    public class ObjectReceiverTest extends TestCase
    {
        public function ObjectReceiverTest(name:String = "")
        {
            super(name);
        }
        
        public var receiver:ObjectReceiver ;
        
        public function setUp():void
        {
            receiver = new ObjectReceiver( "mySignal" , "mySlot" ) ;
        }
        
        public function tearDown():void
        {
            receiver = null ;
        }
        
        public function testAUTO_DISCONNECT():void
        {
            assertEquals( "autoDisconnect" , ObjectReceiver.AUTO_DISCONNECT ) ;
        }
        
        public function testORDER():void
        {
            assertEquals( "order" , ObjectReceiver.ORDER ) ;
        }
        
        public function testPRIORITY():void
        {
            assertEquals( "priority" , ObjectReceiver.PRIORITY ) ;
        }
        
        public function testSIGNAL():void
        {
            assertEquals( "signal" , ObjectReceiver.SIGNAL ) ;
        }
        
        public function testSLOT():void
        {
            assertEquals( "slot" , ObjectReceiver.SLOT ) ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( receiver ) ;
            assertEquals( "mySignal" , receiver.signal ) ;
            assertEquals("mySlot", receiver.slot) ;
            assertEquals(0, receiver.priority) ;
            assertFalse( receiver.autoDisconnect ) ;
            assertEquals( "after" , receiver.order ) ;
        }
        
        public function testOrder():void
        {
            assertEquals( "after" , receiver.order ) ;
            
            receiver.order = ObjectOrder.AFTER ;
            assertEquals( "after" , receiver.order ) ;
            
            receiver.order = ObjectOrder.BEFORE ;
            assertEquals( "before" , receiver.order ) ;
            
            receiver.order = "unknow" ;
            assertEquals( "after" , receiver.order ) ;
        }
        
        public function testToString():void
        {
            assertEquals("[ObjectReceiver signal:\"mySignal\" slot:\"mySlot\" order:\"after\"]" , receiver.toString() ) ;
        }
    }
}
