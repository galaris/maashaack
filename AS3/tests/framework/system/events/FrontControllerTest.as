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

    public class FrontControllerTest extends TestCase 
    {

        public function FrontControllerTest(name:String = "")
        {
            super( name );
        }
        
        public function testConstructor():void
        {
            var fc:FrontController ;
            
            fc = new FrontController() ;
            assertNotNull( fc , "01-01 - FrontController constructor failed.") ;
            assertEquals( fc.getEventDispatcher() , EventDispatcher.getInstance(), "01-02 - FrontController constructor failed.") ;
                        
            fc = new FrontController("channel") ;
            assertEquals( fc.getEventDispatcher() , EventDispatcher.getInstance("channel"), "02 - FrontController constructor failed.") ;

            var d:EventDispatcher = new EventDispatcher() ;

            fc = new FrontController(null, d) ;
            assertEquals( fc.getEventDispatcher() , d, "03 - FrontController constructor failed.") ;
        }       
        
        public function testAdd():void
        {
        	var listener:MockEventListener = new MockEventListener() ;
        	var fc:FrontController         = new FrontController() ;
        	
        	fc.add( "type1", listener ) ;
        	assertEquals( fc.size() , 1 , "01-01 - FrontController add() method failed." ) ;

            fc.add( "type1", listener ) ;
            assertEquals( fc.size() , 1 , "01-02 - FrontController add() method failed." ) ;        	
        	
        	////
        	
            fc.add( "type2", listener.handleEvent ) ;
            assertEquals( fc.size() , 2 , "02-01 - FrontController add() method failed." ) ;

            fc.add( "type2", listener.handleEvent ) ;
            assertEquals( fc.size() , 2 , "02-02 - FrontController add() method failed." ) ; 
                        
        }

        public function testAddExceptions():void
        {
            var fc:FrontController = new FrontController() ;
            try
            {
                fc.add( null , null ) ;
                fail("01-01 - The FrontController add method must throw an error.");
            }
            catch( e:Error )
            {
                assertTrue( e is ArgumentError , "01-02 - The FrontController add method must throw an error." ) ;
            }
        }

//        public function testAddBatch():void
//        {
//            
//        }
//        
//        public function testClear():void
//        {
//            
//        }
//
//        public function testContains():void
//        {
//            
//        }
//
//        public function testFireEvent():void
//        {
//            
//        }
//
//        public function testFlush():void
//        {
//            
//        }
//
//        public function testGetChannels():void
//        {
//            
//        }
//
//        public function testGetEventDispatcher():void
//        {
//            
//        }
//
//        public function testGetInstance():void
//        {
//            
//        }
//
//        public function testGetListener():void
//        {
//            
//        }
//
//        public function testIsEventListenerBatch():void
//        {
//            
//        }
//
//        public function testRemove():void
//        {
//            
//        }
//        
//        public function testRemoveInstance():void
//        {
//            
//        }        
//
//        public function testSetEventDispatcher():void
//        {
//            
//        }  
//
//        public function testSize():void
//        {
//            
//        }  

    }
}
