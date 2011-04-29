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

package system.process 
{
    import buRRRn.ASTUce.framework.ArrayAssert;
    import buRRRn.ASTUce.framework.TestCase;

    import system.data.Collection;
    import system.data.Iterator;
    import system.data.iterators.VectorIterator;
    import system.process.mocks.MockCommand;

    public class BatchTest extends TestCase 
    {
        public function BatchTest(name:String = "")
        {
            super(name);
        }
        
        public var batch:Batch ;
        
        public var command1:MockCommand ;
        public var command2:MockCommand ;
        public var command3:MockCommand ;
        public var command4:MockCommand ;
        
        public function setUp():void
        {
            command1 = new MockCommand() ;
            command2 = new MockCommand() ;
            command3 = new MockCommand() ;
            command4 = new MockCommand() ;
            
            batch = new Batch() ;
            
            batch.add( command1 ) ;
            batch.add( command2 ) ;
            batch.add( command3 ) ;
            batch.add( command4 ) ;
        }
        
        public function tearDown():void
        {
            batch    = undefined ;
            command1 = undefined ;
            command2 = undefined ;
            command3 = undefined ;
            command4 = undefined ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( batch , "Batch constructor failed, the instance not must be null." ) ;
        }
        
        public function testInterface():void
        {
            assertTrue( batch is Collection , "batch implements the Collection interface." ) ;
            assertTrue( batch is Runnable  , "batch implements the Runnable interface."  ) ;
            assertTrue( batch is Stoppable , "batch implements the Stoppable interface." ) ;
        }
        
        public function testAdd():void
        {
            assertTrue( batch.add( new MockCommand() ) ) ;
            assertFalse( batch.add( 2 ) ) ;
            assertFalse( batch.add( "hello world" ) ) ;
        }
        
        public function testClear():void
        {
            batch.clear() ;
            assertEquals( batch.size() , 0 ) ;
        }
        
        public function testClone():void
        {
            var clone:Batch = batch.clone() as Batch ;
            assertNotNull( clone , "clone method failed, with a null shallow copy object." ) ;
            assertNotSame( clone , batch , "clone method failed, the shallow copy isn't the same with the action object." ) ;
            assertEquals( clone.size() , batch.size() ) ;
        }
        
        public function testContains():void
        {
            assertTrue( batch.contains( command1 ) ) ;
            assertTrue( batch.contains( command2 ) ) ;
            assertTrue( batch.contains( command3 ) ) ;
            assertTrue( batch.contains( command4 ) ) ;
            
            assertFalse( batch.contains( null ) ) ;
            assertFalse( batch.contains( "hello" ) ) ;
            assertFalse( batch.contains( new MockCommand() ) ) ;
        }
        
        public function testGet():void
        {
            var command:Runnable = new MockCommand() ;
            batch.clear() ;
            batch.add( command ) ;
            assertEquals( batch.get( 0 ) , command ) ;
        }
        
        public function testIndexOf():void
        {
            var command:Runnable = new MockCommand() ;
            batch.clear() ;
            batch.add( command ) ;
            assertEquals( batch.indexOf( command ) , 0 ) ;
        }
        
        public function testIsEmpty():void
        {
            assertFalse( batch.isEmpty() ) ;
            batch.clear() ;
            assertTrue( batch.isEmpty() ) ;
        }
        
        public function testIterator():void
        {
           var it:Iterator = batch.iterator() ;
           assertTrue( it is VectorIterator ) ;
        }
        
        public function testRemove():void
        {
            var command:Runnable = new MockCommand() ;
            batch.clear() ;
            batch.add( command ) ;
            assertTrue( batch.remove( command ) ) ;
            assertFalse( batch.remove( command ) ) ;
        }
        
        public function testRun():void
        {
            MockCommand.reset() ;
            batch.run() ;
            assertEquals( MockCommand.COUNT , batch.size() , "run method failed, the batch must launch " + batch.size() + " Runnable objects." ) ;
        }
        
        public function testSize():void
        {
            assertEquals( batch.size() , 4 ) ;
            batch.clear() ;
            assertEquals( batch.size() , 0 ) ;
        }
        
        public function testToArray():void
        {
            var ar:Array = batch.toArray() ;
            ArrayAssert.assertEquals( ar , [command1,command2,command3,command4] ) ;
        }
        
        public function testToSource():void
        {
            assertEquals( "new system.process.Batch([new system.process.mocks.MockCommand(),new system.process.mocks.MockCommand(),new system.process.mocks.MockCommand(),new system.process.mocks.MockCommand()])" , batch.toSource() ) ;
        }
        
        public function testToString():void
        {
            assertEquals( "{[object MockCommand],[object MockCommand],[object MockCommand],[object MockCommand]}" , batch.toString() ) ;
        }
    }
}
