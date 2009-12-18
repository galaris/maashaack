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
    
    import system.events.ActionEvent;
    import system.process.mocks.MockTask;
    import system.process.mocks.MockTaskListener;    

    public class BatchProcessTest extends TestCase 
    {
        
        public function BatchProcessTest(name:String = "")
        {
            super(name);
        }
        
        public var batch:BatchProcess ;        
        
        public var mockListener:MockTaskListener ;
        
        public function setUp():void
        {
            batch = new BatchProcess() ;
            
            batch.addAction(new MockTask()) ;
            batch.addAction(new MockTask()) ;
            batch.addAction(new MockTask()) ;
            batch.addAction(new MockTask()) ;
            
            mockListener = new MockTaskListener( batch ) ;
        }
        
        public function tearDown():void
        {
            mockListener.unregister() ;
            mockListener = undefined ;
            batch        = undefined ; 
            MockTask.reset() ;       
        }        
        
        public function testConstructor():void
        {
            var p:BatchProcess = new BatchProcess() ;
            assertNotNull( p  , "BatchProcess constructor failed." ) ;
        }
        
        public function testInterface():void
        {
            var p:BatchProcess = new BatchProcess() ;
            assertTrue( p is Stoppable , "BatchProcess must implement the Stoppable interface." ) ;
        }
        
        public function testAutoClear():void
        {
            var p:BatchProcess = new BatchProcess() ;
            assertFalse(p.autoClear , "01 - BatchProcess autoClear failed." ) ;
            p.autoClear = true ;
            assertTrue(p.autoClear , "02 - BatchProcess autoClear failed." ) ;
            p.autoClear = false ;
            assertFalse(p.autoClear , "03 - BatchProcess autoClear failed." ) ;
        }
        
        public function testAddAction():void
        {
            var p:BatchProcess = new BatchProcess() ;
            assertTrue( p.addAction( new Task() ) , "01 - BatchProcess addAction failed." ) ;
            assertTrue( p.addAction( new Task() ) , "02 - BatchProcess addAction failed." ) ;
            assertFalse( p.addAction( null ) , "03 - BatchProcess addAction failed with a null object." ) ;
            assertEquals( p.size() , 2 , "04 - BatchProcess addAction failed." ) ;
        }
        
        public function testClear():void
        {
            var p:BatchProcess = new BatchProcess() ;
            p.addAction( new Task() ) ;
            p.addAction( new Task() ) ;
            p.clear() ;
            assertEquals( p.size() , 0 , "BatchProcess clear failed." ) ;
        }
        
        public function testClone():void
        {
            var clone:BatchProcess = batch.clone() ;
            assertNotNull( clone  , "clone method failed, with a null shallow copy object." ) ;
            assertNotSame( clone  , batch  , "clone method failed, the shallow copy isn't the same with the BatchProcess object." ) ;
        }
        
        public function testGetBatch():void
        {
            var p:BatchProcess = new BatchProcess() ;
            assertNotNull( p.getBatch() , "BatchProcess getBatch failed." ) ;
        }
        
        public function testIterator():void
        {
            var p:BatchProcess = new BatchProcess() ;
            assertNotNull( p.iterator() , "BatchProcess iterator failed." ) ;
        }
        
        public function testRemoveAction():void
        {
            var a1:Action = new Task() ;
            var a2:Action = new Task() ;
            
            var p:BatchProcess = new BatchProcess() ;
            
            p.addAction( a1 ) ;
            p.addAction( a2 ) ;
            
            assertTrue( p.removeAction( a1 ) , "01-01 - BatchProcess removeAction failed." ) ;
            assertFalse( p.removeAction( a1 ) , "01-02 - BatchProcess removeAction failed." ) ;
            
            assertEquals( p.size() , 1 , "01-03 - BatchProcess removeAction failed." ) ;
            
            assertTrue( p.removeAction( a2 ) , "02-01 - BatchProcess removeAction failed." ) ;
            assertFalse( p.removeAction( a2 ) , "02-02 - BatchProcess removeAction failed." ) ;
            
            assertEquals( p.size() , 0 , "02-03 - BatchProcess removeAction failed." ) ;
        }
        
        public function testRun():void
        {
            MockTask.reset() ;
            batch.run() ;
            assertTrue( mockListener.isRunning , "The MockSimpleActionListener.isRunning property failed, must be true." ) ;
            assertEquals( MockTask.COUNT , batch.size() , "run method failed, the batch must launch " + batch.size + " Runnable objects." ) ;
            assertFalse( batch.running , "The running property of the BatchProcess must be false after the process." ) ;
        }
        
        public function testEvents():void
        {
            batch.run() ;
            assertTrue( mockListener.startCalled  , "run method failed, the ActionEvent.START event isn't notify" ) ;
            assertEquals( mockListener.startType  , ActionEvent.START   , "run method failed, bad type found when the process is started." );
            assertTrue( mockListener.finishCalled  , "run method failed, the ActionEvent.START event isn't notify" ) ;
            assertEquals( mockListener.finishType , ActionEvent.FINISH  , "run method failed, bad type found when the process is finished." );
        }
        
        public function testSize():void
        {
            var p:BatchProcess = new BatchProcess() ;
            p.addAction( new Task() ) ;
            p.addAction( new Task() ) ;
            assertEquals( p.size() , 2 , "BatchProcess size failed." ) ;
        }
    }
}
