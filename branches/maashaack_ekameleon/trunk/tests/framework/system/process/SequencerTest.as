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
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.process.mocks.MockTask;
    import system.process.mocks.MockTaskListener;
    
    public class SequencerTest extends TestCase 
    {
        
        public function SequencerTest(name:String = "")
        {
            super(name);
        }
        
        public var sequencer:Sequencer ;
        
        public var mockListener:MockTaskListener ;
        
        public function setUp():void
        {
            sequencer = new Sequencer() ;
            
            sequencer.addAction(new MockTask()) ;
            sequencer.addAction(new MockTask()) ;
            sequencer.addAction(new MockTask()) ;
            sequencer.addAction(new MockTask()) ;
        }
        
        public function tearDown():void
        {
            sequencer = null ; 
            MockTask.reset() ; 
        }
        
        public function testInherit():void
        {
            assertTrue( sequencer is Chain , "inherit Action failed.");
        }
        
        public function testConstructorEmptyArgument():void
        {
             sequencer = new Sequencer() ;
             assertEquals( 0, sequencer.length) ;
             assertFalse( sequencer.fixed ) ;
             assertFalse( sequencer.looping ) ;
             assertEquals( 0, sequencer.numLoop) ;
             assertEquals( Sequencer.TRANSIENT, sequencer.mode) ;
        }
        
        public function testConstructorWithArguments():void
        {
             sequencer = new Sequencer(5,true,true,10, Sequencer.NORMAL) ;
             assertEquals( 5, sequencer.length) ;
             assertTrue( sequencer.fixed ) ;
             assertTrue( sequencer.looping ) ;
             assertEquals( 10, sequencer.numLoop) ;
             assertEquals( Sequencer.NORMAL, sequencer.mode) ;
        }
        
        public function testLength():void
        {
            assertEquals( 4 , sequencer.length ) ;
            sequencer.length = 10 ;
            assertEquals( 10 , sequencer.length ) ;
            sequencer.length = 2 ;
            assertEquals( 2 , sequencer.length ) ; 
            sequencer.length = 0 ;
            assertEquals( 0 , sequencer.length ) ; 
        }
        
        public function testClone():void
        {
            var clone:Sequencer = sequencer.clone() as Sequencer ;
            assertNotNull( clone  , "clone method failed, with a null shallow copy object." ) ;
        }
    }
}
