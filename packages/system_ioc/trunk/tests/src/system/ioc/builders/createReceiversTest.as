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

package system.ioc.builders
{
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.ioc.ObjectOrder;
    import system.ioc.ObjectReceiver;
    
    public class createReceiversTest extends TestCase
    {
        public function createReceiversTest(name:String = "")
        {
            super(name);
        }
        
        public var receivers:Array ;
        
        public function setUp():void
        {
            receivers = 
            [
                { signal:"signal1" , slot:"slot1" , priority:3 , autoDisconnect:true , order:ObjectOrder.BEFORE } ,
                { unknow:"test"    , slot:"slot2" } , 
                { signal:"signal2" }
            ];
            receivers = createReceivers( receivers ) ;
        }
        
        public function tearDown():void
        {
            receivers = null ;
        }
        
        public function testCreateReceiversLength():void
        {
            assertEquals( 2 , receivers.length , "#0") ;
        }
        
        public function testCreateReceivers():void
        {
            var receiver:ObjectReceiver = receivers[0] as ObjectReceiver ;
            assertNotNull( receiver, "#1") ;
            assertEquals( "signal1", receiver.signal , "#2" ) ;
            assertEquals( "slot1"  , receiver.slot , "#3" ) ;
            assertEquals( 3, receiver.priority , "#4" ) ;
            assertTrue( receiver.autoDisconnect , "#5" ) ;
            assertEquals( "before", receiver.order , "#6" ) ;
        }
        
        public function testCreateReceiversMinimalDef():void
        {
            var receiver:ObjectReceiver = receivers[1] as ObjectReceiver ;
            assertNotNull( receiver, "#1") ;
            assertEquals( "signal2", receiver.signal , "#2" ) ;
            assertNull( receiver.slot , "#3" ) ;
            assertEquals( 0, receiver.priority , "#4" ) ;
            assertFalse( receiver.autoDisconnect , "#5" ) ;
            assertEquals( "after", receiver.order , "#6" ) ;
        }
    }
}
