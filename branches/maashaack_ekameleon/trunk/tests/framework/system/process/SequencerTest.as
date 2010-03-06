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
    
    import system.process.mocks.MockTask;
    import system.process.mocks.MockTaskListener;
    
    public class SequencerTest extends TestCase 
    {
        
        public function SequencerTest(name:String = "")
        {
            super(name);
        }
        
        public var seq:Sequencer ;
        
        public var mockListener:MockTaskListener ;
        
        public function setUp():void
        {
            seq = new Sequencer() ;
            
            seq.addAction(new MockTask()) ;
            seq.addAction(new MockTask()) ;
            seq.addAction(new MockTask()) ;
            seq.addAction(new MockTask()) ;
        }
        
        public function tearDown():void
        {
            seq = null ; 
            MockTask.reset() ; 
        }
        
        public function testInherit():void
        {
            assertTrue( seq is Chain , "inherit Action failed.");
        }
        
        public function testLength():void
        {
            assertEquals( seq.length , 4 , "size method failed.") ;
        }
        
//        public function testAddAction():void
//        {
//            var s:Sequencer = new Sequencer() ;
//            assertFalse( s.addAction( null ) , "addAction failed, must return false when a null object is passed-in." ) ;
//            assertTrue( s.addAction( new MockTask() ) , "addAction failed, must return true when a IAction object is passed-in." ) ;
//        }
        
        public function testClone():void
        {
            var clone:Sequencer = seq.clone() as Sequencer ;
            assertNotNull( clone  , "clone method failed, with a null shallow copy object." ) ;
        }
//        
//        public function testElement():void
//        {
//            var s:Sequencer = new Sequencer() ;
//            
//            assertNull( s.element() , "01 - Sequencer element() failed.") ;
//            
//            var t1:Task = new MockTask("testElement_1") ;
//            var t2:Task = new MockTask("testElement_2") ;
//            
//            s.addAction(t1) ;
//            s.addAction(t2) ;
//            assertEquals( s.element() , t1 , "02 - Sequencer element() failed.") ;
//            
//            s.run() ;
//            assertNull( s.element() , "03 - Sequencer element() failed.") ;
//        }
//        
//        public function testEvents():void
//        {
//            var s:Sequencer = new Sequencer() ;
//            mockListener = new MockTaskListener(s) ;
//            
//            s.addAction( new MockTask("testEvents_1") ) ;
//            s.addAction( new MockTask("testEvents_2") ) ;
//            s.addAction( new MockTask("testEvents_3") ) ;
//            s.addAction( new MockTask("testEvents_4") ) ;
//            
//            s.run() ;
//            
//            assertTrue( mockListener.isRunning , "The MockSimpleActionListener.isRunning property failed, must be true." ) ;
//            assertFalse( s.running , "The running property of the Sequencer must be false after the process." ) ;
//            
//            assertTrue   ( mockListener.startCalled  , "run method failed, the ActionEvent.START event isn't notify" ) ;
//            assertEquals ( mockListener.startType  , ActionEvent.START   , "run method failed, bad type found when the process is started." );
//            assertTrue   ( mockListener.finishCalled  , "run method failed, the ActionEvent.START event isn't notify" ) ;
//            assertEquals ( mockListener.finishType , ActionEvent.FINISH  , "run method failed, bad type found when the process is finished." );
//            
//            mockListener.unregister() ;
//            mockListener = null ;
//        }
//        
//        public function testRun():void
//        {
//            seq = new Sequencer() ;
//            
//            seq.addAction( new MockTask("testRun_1") ) ;
//            seq.addAction( new MockTask("testRun_2") ) ;
//            seq.addAction( new MockTask("testRun_3") ) ;
//            
//            var size:int = seq.length;
//            
//            seq.run() ;
//            
//            assertEquals( MockTask.COUNT , size , "run method failed, the sequencer must launch " + seq.length + " Runnable objects." ) ;
//            assertEquals( seq.length              ,    0 , "run method failed, the sequencer must be empty after the run process." ) ;
//            
//            MockTask.reset() ;
//        }
//        
//        public function testRunClone():void
//        {
//            var s:Sequencer = new Sequencer() ;
//            
//            s.addAction( new MockTask( "testRunClone_1" , true ) ) ;
//            s.addAction( new MockTask( "testRunClone_2" , true ) ) ;
//            s.addAction( new MockTask( "testRunClone_3" , true ) ) ;
//            
//            var c:Sequencer = s.clone() ; // don't forget overrides or implement the clone method in the IAction object ... 
//            //the clone method use a "deep copy" (like copy method) and not a "shallow copy" (Important to use addEventListener !!).
//            
//            var size:uint = c.length ;
//            
//            c.run() ;
//            
//            assertEquals( MockTask.COUNT , size , "run method failed, the sequencer must launch " + s.length + " Runnable objects." ) ;
//            assertEquals( c.length   ,    0 , "run method failed, the sequencer must be empty after the run process." ) ;
//            
//            MockTask.reset() ;
//        }

    }
}
