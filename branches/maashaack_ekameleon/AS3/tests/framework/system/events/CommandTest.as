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
Portions created by the Initial Developers are Copyright (C) 2006-2009
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
    
    import system.events.mocks.MockEventListener;    

    public class CommandTest extends TestCase 
    {

        public function CommandTest(name:String = "")
        {
            super( name );
        }
        
        public function testConstructor():void
        {
            var c:Command = new Command() ;
            assertNotNull( c , "Command constructor failed.") ;  
        }        
        
        public function testCONSTRUCTOR_ERROR():void
        {
        	assertEquals( Command.CONSTRUCTOR_ERROR , "{0}, can't create this instance without a valid 'name' definition : {1}" , "Command.CONSTRUCTOR_ERROR static property failed." ) ;
        }
        
        public function testChannel():void
        {
        	var co:Command = new Command() ;
        	assertNull(co.channel , "01 - Command channel failed." ) ;
            co.channel = "myChannel" ;
            assertEquals( co.channel , "myChannel" , "02 - Command channel failed." ) ;
            
            // TODO finalize the constructor tests.
        }
        
        public function testController():void
        {
            var co:Command = new Command() ;
            
            assertEquals( co.controller , FrontController.getInstance() , "01 - Command controller failed." ) ;
            
            co.channel = "myChannel" ;
            assertEquals( co.controller , FrontController.getInstance("myChannel") , "02 - Command controller failed." ) ;
            
            var controller:FrontController = new FrontController() ;
            co.controller = controller ;
            assertEquals( co.controller , controller , "03 - Command controller failed." ) ;
            
            co.controller = null ;
            assertEquals( co.controller , FrontController.getInstance("myChannel") , "04 - Command controller failed." ) ;
        }        
   
        public function testName():void
        {
            var co:Command = new Command() ;
            assertNull(co.name , "01 - Command name failed." ) ;
            co.name = "myName" ;
            assertEquals( co.name , "myName" , "02 - Command name failed." ) ;
        }  
        
        public function testValue():void
        {
            var co:Command = new Command() ;
            assertNull(co.value , "01 - Command value failed." ) ;
            co.value = "hello world" ;
            assertEquals( co.value , "hello world" , "02 - Command value failed." ) ;
        } 
        
        public function testRun():void
        {
        	var listener:MockEventListener = new MockEventListener() ;
        	var command:Command            = new Command( "type" , "value", "channel" ) ; 
        	
        	var fc:FrontController = FrontController.getInstance( "channel" )  ;
        	
            fc.add("type", listener) ;
        	
        	command.run() ;
        	
        	assertNotNull( listener.event as BasicEvent , "01 - Command run failed.") ;
        	
        	var e:BasicEvent = listener.event as BasicEvent ;
        	assertEquals( e.type    , "type"  , "02-01 - Command run failed." ) ;
        	assertEquals( e.context , "value" , "02-02 - Command run failed." ) ;
        	
        	FrontController.getInstance("channel").remove("type") ;
        	
        	// The "type" event name isn't register in the frontcontroller
        	
        	try
        	{
        		command.run() ; 
        		fail("03-01 - Command failed, the name property isn't register in the FrontController.") ;
        	}
        	catch( er:Error )
        	{
        	   assertTrue( er is Error , "03-02 - Command failed, the name property isn't register in the FrontController.") ;
        	   //assertEquals( er.message , "" , "03-03 - Command failed, the name property isn't register in the FrontController.") ;	
        	}
        	
        }
     
        public function testObject():void
        {

            var c:Command = new Command( "type" , "value", "channel" ) ; 
            var o:Object  = c.toObject() ;
            
            assertEquals( o.name    , c.name    , "01 - Command toObject() failed with the name property." ) ;
            assertEquals( o.channel , c.channel , "02 - Command toObject() failed with the channel property." ) ;
            assertEquals( o.value   , c.value   , "03 - Command toObject() failed with the value property." ) ;
            
        }     

        public function testToString():void
        {
            var c:Command ;
            c = new Command() ; 
            assertEquals( c.toString() , "[Command]"  , "01 - Command toString() failed." ) ;

            c = new Command("name", "value", "channel") ; 
            assertEquals( c.toString() , '[Command name:"name" channel:"channel"]'  , "01 - Command toString() failed." ) ;

        }    

    }
}
