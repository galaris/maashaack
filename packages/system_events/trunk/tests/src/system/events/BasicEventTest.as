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
    
    import flash.events.Event;
    import flash.utils.getTimer;    

    public class BasicEventTest extends TestCase 
    {

        public function BasicEventTest(name:String = "")
        {
            super( name );
        }
        
        public function testConstructor():void
        {
            var e:BasicEvent = new BasicEvent( "type" ) ;
            assertNotNull( e , "BasicEvent constructor failed.") ;    
        }
        
        public function testConstructorWithArguments():void
        {
            var time:uint = getTimer() ;
            var e:BasicEvent = new BasicEvent( "type" , "target", "context", true , true , time) ;

            assertNotNull( e , "00 - BasicEvent constructor failed.") ;  

            assertEquals ( e.type       , "type"    , "01 - BasicEvent constructor failed.") ;
            assertEquals ( e.target     , "target"  , "02 - BasicEvent constructor failed.") ;
            assertEquals ( e.context    , "context" , "03 - BasicEvent constructor failed.") ;
            assertTrue   ( e.bubbles    , "04 - BasicEvent constructor failed.") ;
            assertTrue   ( e.cancelable , "05 - BasicEvent constructor failed.") ;
            assertEquals ( e.timeStamp  , time , "06 - BasicEvent constructor failed.") ;

        }
                
        public function testInherit():void
        {
            var e:BasicEvent = new BasicEvent( "type" ) ;
            assertTrue( e is Event , "EventDispatcher must inherit the flash.events.Event class.") ;
        }    

        public function testContext():void
        {
            var e:BasicEvent = new BasicEvent( "type" ) ;
            e.context = "context" ;
            assertEquals ( e.context , "context" , "BasicEvent context failed.") ;
        } 
        
        public function testTarget():void
        {
            var e:BasicEvent = new BasicEvent( "type" ) ;
            assertEquals ( e.target , null , "BasicEvent target failed.") ;
            e.target = "target" ;
            assertEquals ( e.target , "target" , "BasicEvent target failed.") ;
        }
        
        public function testTimeStamp():void
        {
            var time:uint = getTimer() ;
            var e:BasicEvent = new BasicEvent( "type" , null, null, false, false, time ) ;
            assertEquals ( e.timeStamp ,  time , "BasicEvent timeStamp failed.") ;
        } 
        
        public function testType():void
        {
            var e:BasicEvent = new BasicEvent( "type" ) ;
            e.type = "otherType" ;
            assertEquals ( e.type , "type" , "BasicEvent type failed.") ;
        }
        
        public function testClone():void
        {
            var e:BasicEvent = new BasicEvent( "type" , "target" , "context" ) ;
            var c:BasicEvent = e.clone() as BasicEvent ;
            assertNotNull( c , "01 - BasicEvent clone() failed.") ;
            assertEquals( e.type    , c.type    , "02 - BasicEvent clone() failed.") ;
            assertEquals( e.context , c.context , "03 - BasicEvent clone() failed.") ;  
            assertEquals( e.target  , c.target  , "04 - BasicEvent clone() failed.") ;  
        } 
        
        public function testDispatch():void
        {
            var test:Boolean ;
            var debug:Function = function( e:Event ):void
            {
               test = true ;    
            };
            EventDispatcher.getInstance("channel").addEventListener("test",debug) ;
            var e:BasicEvent = new BasicEvent("test") ;
            e.dispatch("channel") ;
            
            EventDispatcher.flush() ;
        }
        
        public function testToString():void
        {
            var e:BasicEvent ;
            
            e = new BasicEvent( "type" ) ;
            assertEquals ( e.toString() , '[BasicEvent type="type" target=null context=null bubbles=false cancelable=false eventPhase=2]' , "01 - BasicEvent toString() failed.") ;               

            e = new BasicEvent( "type" , "target", "context" ) ;
            assertEquals ( e.toString() , '[BasicEvent type="type" target="target" context="context" bubbles=false cancelable=false eventPhase=2]' , "01 - BasicEvent toString() failed.") ;               

            e = new BasicEvent( "type" , {}, 2 ) ;
            assertEquals ( e.toString() , '[BasicEvent type="type" target=[object Object] context=2 bubbles=false cancelable=false eventPhase=2]' , "01 - BasicEvent toString() failed.") ;               

        }
    
    }
}
