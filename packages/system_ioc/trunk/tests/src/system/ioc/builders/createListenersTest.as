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
    import library.ASTUce.framework.TestCase;

    import system.ioc.ObjectListener;
    
    public class createListenersTest extends TestCase
    {
        public function createListenersTest(name:String = "")
        {
            super(name);
        }
        
        public var listeners:Array ;
        
        public function setUp():void
        {
            listeners = 
            [
                { dispatcher:"dispatcher1" , type:"change" , method:"handleEvent" , useCapture:true, priority:3 , useWeakReference:true } ,
                { unknow:"test" } ,
                { dispatcher:"dispatcher2" , type:"update" } 
            ];
            listeners = createListeners( listeners ) ;
        }
        
        public function tearDown():void
        {
            listeners = null ;
        }
        
        public function testCreateListenersLength():void
        {
            assertEquals( 2 , listeners.length , "#0") ;
        }
        
        public function testCreateListeners():void
        {
            var listener:ObjectListener = listeners[0] as ObjectListener ;
            assertNotNull(listener, "#1") ;
            assertEquals( "dispatcher1", listener.dispatcher , "#2" ) ;
            assertEquals( "change", listener.type , "#2" ) ;
            assertEquals( "handleEvent", listener.method , "#3" ) ;
            assertEquals( 3, listener.priority , "#4" ) ;
            assertTrue( listener.useCapture , "#5" ) ;
            assertTrue( listener.useWeakReference , "#6" ) ;
        }
        
        public function testCreateListenersMinimalDef():void
        {
            var listener:ObjectListener = listeners[1] as ObjectListener ;
            assertNotNull(listener, "#1") ;
            assertEquals( "dispatcher2", listener.dispatcher , "#2" ) ;
            assertEquals( "update", listener.type , "#2" ) ;
            assertNull( listener.method , "#3" ) ;
            assertEquals( 0, listener.priority , "#4" ) ;
            assertFalse( listener.useCapture , "#5" ) ;
            assertFalse( listener.useWeakReference , "#6" ) ;
        }
    }
}
