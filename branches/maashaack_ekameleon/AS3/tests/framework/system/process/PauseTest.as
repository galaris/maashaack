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

package system.process 
{
    import buRRRn.ASTUce.framework.TestCase;    			

    public class PauseTest extends TestCase 
	{

		public function PauseTest(name:String = "")
		{
			super(name);
		}
		
		public var pause:Pause ;
		
        public function setUp():void
        {
            pause = new Pause() ;
        }
        
        public function tearDown():void
        {
            pause = undefined ;      
        }
        
        public function testConstructor():void
        {
            assertNotNull( pause , "Pause constructor failed, the instance not must be null." ) ;
            assertTrue( pause is Pause , "Pause constructor failed, bad type." ) ;
        }
        
        public function testDelay():void
        {
        	assertEquals( pause.delay, 0  , "Pause default delay failed." ) ;
        }
        
        public function testDuration():void
        {
        	assertEquals( pause.duration, 0  , "Pause default duration failed." ) ;
        }
        
        public function testUseSeconds():void
        {
        	assertFalse( pause.useSeconds , "Pause default useSeconds failed." ) ;
        }
                
        public function testClone():void
        {
            var clone:Pause = pause.clone() as Pause ;
            assertNotNull( clone , "Pause clone 01 method failed." ) ;
            assertFalse( clone == pause  , "Pause clone 02 method failed." ) ;
            assertEquals( clone.delay    , pause.delay  , "Pause clone 03 method failed." ) ;
            assertEquals( clone.duration , pause.duration  , "Pause clone 04 method failed." ) ;
            assertEquals( clone.useSeconds , pause.useSeconds  , "Pause clone 05 method failed." ) ;
        }
                
		
	}
}
