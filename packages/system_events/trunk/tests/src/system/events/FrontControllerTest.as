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
    
    import system.events.mocks.MockEventListener;
    
    import flash.events.Event;
    
    public class FrontControllerTest extends TestCase 
    {
        public function FrontControllerTest(name:String = "")
        {
            super( name );
        }
        
        public function setUp():void
        {
            EventDispatcher.flush() ;
            FrontController.flush() ;
        }
        
        public function tearDown():void
        {
            EventDispatcher.flush() ;
            FrontController.flush() ;
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
            var fc:FrontController ;
            
            fc = new FrontController() ;
            try
            {
                fc.add( null , null ) ;
                fail("01-01 - The FrontController add method must throw an error.");
            }
            catch( e:Error )
            {
                assertTrue( e is ArgumentError , "01-02 - The FrontController add method must throw an error." ) ;
                assertEquals( e.message , "The FrontController add() method failed, the 'type' argument not must be null." , "01-03 - The FrontController add method must throw an error.") ;
            }
            
            fc = new FrontController() ;
            try
            {
                fc.add( "type" , null ) ;
                fail("02-01 - The FrontController add method must throw an error.");
            }
            catch( e:Error )
            {
                assertTrue( e is ArgumentError , "02-02 - The FrontController add method must throw an error." ) ;
                assertEquals( e.message , "The FrontController add() method failed, the event type 'type' failed, the 'listener' argument not must be null.", "02-03 - The FrontController add method must throw an error." ) ;
            }
        }
        
        public function testAddBatch():void
        {
            var fc:FrontController   = new FrontController() ;
            var l1:MockEventListener = new MockEventListener() ;
            var l2:MockEventListener = new MockEventListener() ;
            
            fc.addBatch("type", l1) ;
            fc.addBatch("type", l2) ;
            
            fc.fireEvent("type") ;
            
            assertEquals( fc.size() , 1 , "01 - The addBatch() method failed.") ; 
            
            assertNotNull( l1.event , "02 - The addBatch() method failed.") ;
            assertNotNull( l2.event , "03 - The addBatch() method failed.") ;
        }
        
        public function testAddBatchEmpty():void
        {
            var fc:FrontController   = new FrontController() ;
            fc.addBatch("type") ;
            var listener:EventListenerBatch = fc.getListener("type") as EventListenerBatch ;
            assertNotNull( listener , "The addBatch method must create an empty EventListenerBatch object if the second argument is forgotten" ) ;
            assertTrue( listener.isEmpty() , "The addBatch method must create an empty EventListenerBatch object if the second argument is forgotten") ;
        }
        
        public function testAddBatchException():void
        {
            var fc:FrontController   = new FrontController() ;
            try
            {
                fc.addBatch(null) ;
                fail("01 - The addBatch method must throw an error with a null type argument.") ;
            }
            catch( e:Error )
            {
                assertTrue( e is ArgumentError, "02 - The addBatch method must throw an error with a null type argument.") ;
                assertEquals( e.message, "FrontController addBatch method failed, the type argument not must be null." , "03 - The addBatch method must throw an error with a null type argument.") ;
            }
        }
        
        public function testClear():void
        {
            var fc:FrontController   = new FrontController() ;
            var l1:MockEventListener = new MockEventListener() ;
            var l2:MockEventListener = new MockEventListener() ;
            
            fc.add( "type1" , l1 ) ;
            fc.add( "type2" , l2 ) ;
            
            fc.clear() ;
            
            fc.fireEvent("type1") ;
            fc.fireEvent("type2") ;
            
            assertEquals( fc.size() , 0 , "01 - The clear() method failed.") ; 
            
            assertNull( l1.event , "02 - The clear() method failed.") ;
            assertNull( l2.event , "03 - The clear() method failed.") ;
        }
        
        public function testContains():void
        {
            var fc:FrontController = new FrontController() ;
            
            fc.add( "type" , new MockEventListener() ) ;
            
            assertTrue ( fc.contains("type") , "01 - The contains() method failed.") ;
            assertFalse( fc.contains("other") , "02 - The contains() method failed.") ;
        }
        
        public function testContainsInstance():void
        {
            assertFalse( FrontController.containsInstance("my_channel") , "01 - FrontController containsInstance failed." );
            
            FrontController.getInstance("my_channel1") ;
            assertTrue( FrontController.containsInstance("my_channel1") , "02 - FrontController containsInstance failed." );
            
            FrontController.getInstance("my_channel2") ;
            assertTrue( FrontController.containsInstance("my_channel2") , "03 - FrontController containsInstance failed." );
            
            FrontController.flush() ;
        }
        
        public function testFireEvent():void
        {
            var f:FrontController   = new FrontController() ;
            var l:MockEventListener = new MockEventListener() ;
            
            f.add( "type" , l ) ;
            
            f.fireEvent("type") ;
            f.fireEvent(new Event("type")) ;
            
            assertEquals( l.count , 2,  "The fireEvent() method failed.") ;
        }
        
        public function testFlush():void
        {
            FrontController.getInstance("my_channel1") ;
            FrontController.getInstance("my_channel2") ;
            
            FrontController.flush() ;
            
            assertFalse( FrontController.containsInstance("my_channel") , "01 - FrontController flush failed." );
            assertFalse( FrontController.containsInstance("my_channe2") , "02 - FrontController flush failed." );
        }
        
        public function testGetChannels():void
        {
            FrontController.flush() ;
            assertNull( FrontController.getChannels() , "01 - FrontController getChannels failed if no singletons are registered in the factory." ) ;
            FrontController.getInstance("channel1") ;
            FrontController.getInstance("channel2") ;
            var channels:Array = FrontController.getChannels() ;
            assertNotNull( channels , "02-01 - FrontController getChannels failed." ) ;
            assertEquals(  channels.length, 2 , "02-02 - FrontController getChannels failed." ) ;
            assertTrue(  channels.indexOf("channel1") > -1 , "02-03 - FrontController getChannels failed." ) ;
            assertTrue(  channels.indexOf("channel2") > -1 , "02-04 - FrontController getChannels failed." ) ;
            FrontController.flush() ;
        }
        
        public function testGetInstanceWithANullArgument():void
        {
            FrontController.flush() ;
            var f1:FrontController = FrontController.getInstance() ;
            assertEquals( f1.getEventDispatcher() , EventDispatcher.getInstance() , "01 - FrontController getInstance() failed with 0 argument.") ;
            var f2:FrontController = FrontController.getInstance() ;
            assertEquals( f1 , f2 , "02 - FrontController getInstance() failed with 0 argument.") ;
            FrontController.flush() ;
        }
        
        public function testGetInstance():void
        {
            var f1:FrontController = FrontController.getInstance("channel1") ;
            assertEquals( f1.getEventDispatcher() , EventDispatcher.getInstance("channel1") , "01 - FrontController getInstance() failed.") ;
            var f2:FrontController = FrontController.getInstance("channel1") ;
            assertEquals( f1 , f2 , "02 - FrontController getInstance() failed.") ;
            var f3:FrontController = FrontController.getInstance("channel2") ;
            assertFalse( f1 == f3 , "03 - FrontController getInstance() failed.") ;
            FrontController.flush() ;
        }
        
        public function testGetListener():void
        {
            var f:FrontController   = new FrontController() ;
            var l:MockEventListener = new MockEventListener() ;
            f.add( "type" , l ) ;
            assertEquals( f.getListener( "type" ) , l , "The getListener() method failed.") ; 
        }
        
        public function testIsEventListenerBatch():void
        {
            var f:FrontController   = new FrontController() ;
            f.addBatch("type") ;
            assertTrue(f.isEventListenerBatch("type"), "01 - FrontController isEventListenerBatch() failed.") ;
            assertFalse(f.isEventListenerBatch("other"), "02 - FrontController isEventListenerBatch() failed.") ;
        }
        
        public function testRemove():void
        {
            var fc:FrontController   = new FrontController() ;
            var l:MockEventListener = new MockEventListener() ;
            
            fc.add( "type" , l ) ;
            fc.remove("type") ;
            fc.fireEvent("type") ;
            
            assertEquals( fc.size() , 0 , "01 - The remove() method failed.") ; 
            assertNull( l.event , "02 - The remove() method failed.") ;
        }
        
        public function testRemoveInstance():void
        {
            assertFalse(  FrontController.removeInstance() , "01-01 - FrontController removeInstance failed." );
            FrontController.getInstance() ;
            assertTrue(  FrontController.removeInstance() , "01-02 - FrontController removeInstance failed." );
            
            assertFalse( FrontController.removeInstance("channel1") , "02-01 - FrontController removeInstance failed." );
            FrontController.getInstance("channel1") ;
            assertTrue(  FrontController.removeInstance("channel1") , "02-02 - FrontController removeInstance failed." );
            FrontController.flush() ;
        }
        
        public function testSetEventDispatcher():void
        {
            var f:FrontController = new FrontController() ;
            var d:EventDispatcher = new EventDispatcher() ;
            f.setEventDispatcher(d) ;
            assertEquals(f.getEventDispatcher(), d, "The setEventDispatcher() method failed.") ;
        }
        
        public function testSize():void
        {
            var fc:FrontController   = new FrontController() ;
            var l1:MockEventListener = new MockEventListener() ;
            var l2:MockEventListener = new MockEventListener() ;
            
            assertEquals( fc.size() , 0 , "01 - The clear() method failed.") ;
            
            fc.add( "type1" , l1  ) ;
            fc.add( "type2" , l2 ) ;
            
            assertEquals( fc.size() , 2 , "01 - The clear() method failed.") ;
            
            fc.clear() ;
            
            assertEquals( fc.size() , 0 , "01 - The clear() method failed.") ; 
        }
    }
}
