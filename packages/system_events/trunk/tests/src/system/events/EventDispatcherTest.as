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
    import buRRRn.ASTUce.framework.ArrayAssert;    import buRRRn.ASTUce.framework.TestCase;                    

    public class EventDispatcherTest extends TestCase 
    {

        public function EventDispatcherTest(name:String = "")
        {
            super( name );
        }
        
        public function setUp():void
        {
            EventDispatcher.flush() ;
        }
        
        public function tearDown():void
        {
            EventDispatcher.flush() ;
        }
        
        public function testConstructor():void
        {
            var dispatcher:EventDispatcher = new EventDispatcher() ;
            assertNotNull( dispatcher , "EventDispatcher constructor failed") ;
        }
        
        public function testInherit():void
        {
            var dispatcher:EventDispatcher = new EventDispatcher() ;
            assertTrue( dispatcher is InternalDispatcher , "EventDispatcher must inherit the InternalDispatcher class.") ;
        }    
        
        public function testInterface():void
        {
            var dispatcher:EventDispatcher = new EventDispatcher() ;
            assertTrue( dispatcher is IEventDispatcher , "EventDispatcher must implements the IEventDispatcher class.") ;
        }       

        public function testChannel():void
        {
            var dispatcher:EventDispatcher = new EventDispatcher(null, "my_channel") ;
            
            assertEquals( dispatcher.channel , "my_channel" , "01 - EventDispatcher channel failed.") ;
        
            dispatcher.channel = null ;
            
            assertNull( dispatcher.channel , "02 - EventDispatcher channel failed.") ;
        
            dispatcher.channel = "my_channel" ;
        
            assertEquals( dispatcher.channel , "my_channel" , "03 - EventDispatcher channel failed.") ;
        }
          
        public function testContainsInstance():void
        {
            assertFalse( EventDispatcher.containsInstance("my_channel") , "01 - EventDispatcher containsInstance failed." );
            
            EventDispatcher.getInstance("my_channel1") ;
            assertTrue( EventDispatcher.containsInstance("my_channel1") , "02 - EventDispatcher containsInstance failed." );
            
            EventDispatcher.getInstance("my_channel2") ;
            assertTrue( EventDispatcher.containsInstance("my_channel2") , "03 - EventDispatcher containsInstance failed." );
            
            EventDispatcher.flush() ;
        }
        
        public function testFlush():void
        {
            EventDispatcher.getInstance("my_channel1") ;
            EventDispatcher.getInstance("my_channel2") ;
            
            EventDispatcher.flush() ;

            assertFalse( EventDispatcher.containsInstance("my_channel") , "01 - EventDispatcher flush failed." );
            assertFalse( EventDispatcher.containsInstance("my_channe2") , "02 - EventDispatcher flush failed." );
        }
        
        public function testGetChannels():void
        {
            EventDispatcher.flush() ;
            assertNull( EventDispatcher.getChannels() , "01 - EventDispatcher getChannels failed if no singletons are registered in the factory." ) ;
            EventDispatcher.getInstance("my_channel1") ;
            EventDispatcher.getInstance("my_channel2") ;
            ArrayAssert.assertEquals( EventDispatcher.getChannels() , ["my_channel1", "my_channel2"] , "02 - EventDispatcher getChannels failed." ) ;
            EventDispatcher.flush() ;
        }

        public function testGetInstanceWithANullArgument():void
        {
            EventDispatcher.flush() ;
            var d1:EventDispatcher = EventDispatcher.getInstance() ;
            assertEquals( d1.channel , EventDispatcher.DEFAULT_SINGLETON_CHANNEL , "01 - EventDispatcher getInstance() failed with 0 argument.") ;
            var d2:EventDispatcher = EventDispatcher.getInstance() ;
            assertEquals( d1 , d2 , "02 - EventDispatcher getInstance() failed with 0 argument.") ;
            EventDispatcher.flush() ;
        }

        public function testGetInstance():void
        {
            var d1:EventDispatcher = EventDispatcher.getInstance("channel1") ;
            assertEquals( d1.channel , "channel1" , "01 - EventDispatcher getInstance('channel1') failed.") ;
            var d2:EventDispatcher = EventDispatcher.getInstance("channel1") ;
            assertEquals( d1 , d2 , "02 - EventDispatcher getInstance('channel1') failed.") ;
            var d3:EventDispatcher = EventDispatcher.getInstance("channel2") ;
            assertFalse( d1 == d3 , "03 - EventDispatcher getInstance('channel1') failed.") ;
            EventDispatcher.flush() ;
        }
        
        public function testRemoveInstance():void
        {
            
            assertFalse(  EventDispatcher.removeInstance() , "01-01 - EventDispatcher removeInstance failed." );
            EventDispatcher.getInstance() ;
            assertTrue(  EventDispatcher.removeInstance() , "01-02 - EventDispatcher removeInstance failed." );
            
            assertFalse( EventDispatcher.removeInstance("channel1") , "02-01 - EventDispatcher removeInstance failed." );
            EventDispatcher.getInstance("channel1") ;
            assertTrue(  EventDispatcher.removeInstance("channel1") , "02-02 - EventDispatcher removeInstance failed." );

            EventDispatcher.flush() ;
        }
        
    }

}
