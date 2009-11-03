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

package graphics.numeric 
{
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.Reflection;
    
    public class TrigoTest extends TestCase 
    {
        public function TrigoTest(name:String = "")
        {
            super(name);
        }
        
        public function testIsFinal():void
        {
            assertTrue( Reflection.getClassInfo(Hyperbolic).isFinal() ) ;
        }
        
        public function testDEG2RAD():void
        {
            assertEquals( Trigo.DEG2RAD , Math.PI / 180 , "The Trigo.DEG2RAD constant failed." ) ;
        }
                
        public function testEPSILON():void
        {
        	assertEquals( Trigo.EPSILON , 0.000000001 , "The Trigo.EPSILON constant failed." ) ;
        }
        
        public function testRAD2DEG():void
        {
            assertEquals( Trigo.RAD2DEG , 180 / Math.PI , "The Trigo.RAD2DEG constant failed." ) ;
        }
        
        public function testPHI():void
        {
            assertEquals( Trigo.PHI , 1.61803398874989 , "The Trigo.PHI constant failed." ) ;
        }
        
        public function testLAMBDA():void
        {
            assertEquals( Trigo.LAMBDA , 0.57721566490143 , "The Trigo.LAMBDA constant failed." ) ;
        }
    }
}
