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
package system.remoting  
{
    import library.ASTUce.framework.TestCase;

    public class RemotingConnectionsTest extends TestCase 
    {
        public function RemotingConnectionsTest(name:String = "")
        {
            super( name );
        }
        
        public var collector:RemotingConnections ;
        
        public var connection1:RemotingConnection ;
        public var connection2:RemotingConnection ;
        
        public function setUp():void
        {
            collector   = new RemotingConnections() ;
            connection1 = new RemotingConnection() ;
            connection2 = new RemotingConnection() ; 
        }
        
        public function tearDown():void
        {
            collector   = null ;
            connection1 = null ;
            connection2 = null ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( collector ) ;
        }
        
        public function testNumConnections():void
        {
            assertEquals( 0 , collector.numConnections ) ;
            collector.addConnection("test1", connection1);
            assertEquals( 1 , collector.numConnections ) ;
            collector.addConnection("test1", connection1);
            assertEquals( 1 , collector.numConnections ) ;
            collector.addConnection("test2", connection2);
            assertEquals( 2 , collector.numConnections ) ;
            collector.removeConnection() ;
            assertEquals( 0 , collector.numConnections ) ;
        }
        
        public function testAddConnection():void
        {
            assertTrue( collector.addConnection("test1", connection1) , "#1" ) ;
            assertTrue( collector.addConnection("test2", connection2) , "#2" ) ;
            assertFalse( collector.addConnection("test1", connection1) , "#3" ) ;
            assertFalse( collector.addConnection("test1", connection2) , "#4" ) ;
        }
        
        public function testAddConnectionNotValidNullArguments():void
        {
            assertFalse( collector.addConnection( null     , null ) , "#1" ) ;
            assertFalse( collector.addConnection( "unknow" , null ) , "#2" ) ;
        }
        
        public function testContainsConnection():void
        {
            collector.addConnection("test", connection1);
            assertTrue( collector.containsConnection("test") , "#1" ) ;
            assertFalse( collector.containsConnection("unknow") , "#2" ) ;
        }
        
        public function testGetConnection():void
        {
            collector.addConnection("test", connection1);
            assertEquals( collector.getConnection("test") , connection1 , "#1" ) ;
            assertNull( collector.getConnection( "unknow") , "#2" ) ; 
        }
        
        public function testRemoveConnection():void
        {
            collector.addConnection("test", connection1) ;
            assertTrue( collector.removeConnection( "test") , "#1" ) ;
            assertFalse( collector.removeConnection( "test") , "#1" ) ;
        }
    }
}
