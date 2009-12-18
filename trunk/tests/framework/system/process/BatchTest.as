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
  Portions created by the Initial Developers are Copyright (C) 2006-2010
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
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.data.collections.TypedCollection;
    import system.process.Runnable;
    import system.process.mocks.MockCommand;
    
    public class BatchTest extends TestCase 
    {
        public function BatchTest(name:String = "")
        {
            super(name);
        }
        
        public var batch:Batch ;
        
        public function setUp():void
        {
            batch = new Batch() ;
            batch.add( new MockCommand() ) ;
            batch.add( new MockCommand() ) ;
            batch.add( new MockCommand() ) ;
            batch.add( new MockCommand() ) ;
        }
        
        public function tearDown():void
        {
            batch.clear() ;
            batch = undefined ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( batch , "Batch constructor failed, the instance not must be null." ) ;
            assertTrue( batch is TypedCollection , "batch must be a TypedCollection object." ) ;
        }
        
        public function testInterface():void
        {
            assertTrue( batch is Runnable  , "batch implements the Runnable interface."  ) ;
            assertTrue( batch is Stoppable , "batch implements the Stoppable interface." ) ;            
        }
        
        public function testClear():void
        {
            var clone:Batch = batch.clone() ;
            clone.clear() ;
            assertEquals( clone.size() , 0 , "clear method failed, the batch must be empty" ) ;
        }
        
        public function testClone():void
        {
            var clone:Batch = batch.clone() ;
            assertNotNull( clone , "clone method failed, with a null shallow copy object." ) ;
            assertNotSame( clone , batch , "clone method failed, the shallow copy isn't the same with the action object." ) ;
        }
        
        public function testRun():void
        {
            MockCommand.reset() ;
            batch.run() ;
            assertEquals( MockCommand.COUNT , batch.size() , "run method failed, the batch must launch " + batch.size + " Runnable objects." ) ;
        }
        
        public function testSize():void
        {
            var clone:Batch = batch.clone() ;
            clone.clear() ;
            assertEquals( clone.size() , 0 , "clear method failed, the batch must be empty" ) ;
        }
        
    }
}
