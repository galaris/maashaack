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
    import library.ASTUce.framework.TestCase;
    
    import system.process.Task;

    public class ActionEventTest extends TestCase 
    {

        public function ActionEventTest(name:String = "")
        {
            super(name);
        }
        
        public function testConstructorBasic():void
        {
            var t:Task = new Task() ;
            var e:ActionEvent = new ActionEvent( "type" , t ) ;
            assertNotNull( e , "01 - ActionEvent constructor failed.") ;
            assertEquals( e.type   , "type" , "02 - ActionEvent constructor failed.") ;
            assertEquals( e.target , t      , "03 - ActionEvent constructor failed.") ;
        }
        
        public function testInherit():void
        {
            var e:ActionEvent = new ActionEvent( "type" ) ;
            assertTrue( e is BasicEvent, "01 - ActionEvent must extends the BasicEvent class.") ;
        } 

        public function testInfo():void
        {
            var e:ActionEvent = new ActionEvent( "type" ) ;
            assertNull( e.info , "01 - ActionEvent info failed.") ;
            e.info = "hello world" ;
            assertEquals( e.info , "hello world" , "02 - ActionEvent info failed.") ;
        }

        public function testClone():void
        {
            var e:ActionEvent = new ActionEvent( "type" , new Task() , "info" , "context") ;
            var c:ActionEvent = e.clone() as ActionEvent ;
            assertNotNull( c , "01 - ActionEvent clone() failed.") ;
            assertEquals( e.info , c.info, "02 - ActionEvent clone() failed.") ;
            assertEquals( e.context , c.context, "03 - ActionEvent clone() failed.") ;               
        }  
        
        public function testCHANGE():void
        {
            assertEquals( ActionEvent.CHANGE , "change" , "ActionEvent.CHANGE constant failed.") ;     
        }

        public function testCLEAR():void
        {
            assertEquals( ActionEvent.CLEAR , "clear" , "ActionEvent.CLEAR constant failed.") ;     
        }

        public function testFINISH():void
        {
            assertEquals( ActionEvent.FINISH , "finish" , "ActionEvent.FINISH constant failed.") ;     
        }        

        public function testINFO():void
        {
            assertEquals( ActionEvent.INFO , "info" , "ActionEvent.INFO constant failed.") ;     
        }     
        
        public function testLOOP():void
        {
            assertEquals( ActionEvent.LOOP , "loop" , "ActionEvent.LOOP constant failed.") ;     
        }   
        
        public function testPAUSE():void
        {
            assertEquals( ActionEvent.PAUSE , "pause" , "ActionEvent.PAUSE constant failed.") ;     
        }
        
        public function testPROGRESS():void
        {
            assertEquals( ActionEvent.PROGRESS , "progress" , "ActionEvent.PROGRESS constant failed.") ;     
        }
        
        public function testRESUME():void
        {
            assertEquals( ActionEvent.RESUME , "resume" , "ActionEvent.RESUME constant failed.") ;     
        }

        public function testSTART():void
        {
            assertEquals( ActionEvent.START , "start" , "ActionEvent.START constant failed.") ;     
        }
        
        public function testSTOP():void
        {
            assertEquals( ActionEvent.STOP , "stop" , "ActionEvent.STOP constant failed.") ;     
        }
        
        public function testTIMEOUT():void
        {
            assertEquals( ActionEvent.TIMEOUT , "timeout" , "ActionEvent.TIMEOUT constant failed.") ;     
        }
    }
}
