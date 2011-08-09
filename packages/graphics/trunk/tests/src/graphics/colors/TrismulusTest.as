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

package graphics.colors 
{
    import buRRRn.ASTUce.framework.TestCase;

    public class TrismulusTest extends TestCase 
    {
        public function TrismulusTest(name:String = "")
        {
            super(name);
        }
        
        public function testA():void
        {
            assertEquals(Trismulus.A_2  , new XYZ(109.85, 100, 35.585) , "Trismulus.A_2 failed."  ) ;
            assertEquals(Trismulus.A_10 , new XYZ(111.144, 100, 35.2)  , "Trismulus.A_10 failed." ) ;
        }
        
        public function testC():void
        {
            assertEquals(Trismulus.C_2  , new XYZ(98.074, 100, 118.232) , "Trismulus.C_2 failed."  ) ;
            assertEquals(Trismulus.C_10 , new XYZ(97.285, 100, 116.145) , "Trismulus.C_10 failed." ) ;
        }
        
        public function testD50():void
        {
            assertEquals(Trismulus.D50_2  , new XYZ(96.422, 100, 82.521) , "Trismulus.D50_2 failed."  ) ;
            assertEquals(Trismulus.D50_10 , new XYZ(96.720, 100, 81.427) , "Trismulus.D50_10 failed." ) ;
        }
        
        public function testD55():void
        {
            assertEquals(Trismulus.D55_2  , new XYZ(95.682, 100, 92.149) , "Trismulus.D55_2 failed."  ) ;
            assertEquals(Trismulus.D55_10 , new XYZ(95.799, 100, 90.926) , "Trismulus.D55_10 failed." ) ;
        }
        
        public function testD65():void
        {
            assertEquals(Trismulus.D65_2  , new XYZ(95.047, 100, 108.883) , "Trismulus.D65_2 failed."  ) ;
            assertEquals(Trismulus.D65_10 , new XYZ(94.811, 100, 107.304) , "Trismulus.D65_10 failed." ) ;
        }
        
        public function testD75():void
        {
            assertEquals(Trismulus.D75_2  , new XYZ(94.972, 100, 122.638) , "Trismulus.D75_2 failed."  ) ;
            assertEquals(Trismulus.D75_10 , new XYZ(94.416, 100, 120.641) , "Trismulus.D75_10 failed." ) ;
        }
        
        public function testF2():void
        {
            assertEquals(Trismulus.F2_2  , new XYZ(99.187, 100, 67.395)  , "Trismulus.F2_2 failed."  ) ;
            assertEquals(Trismulus.F2_10 , new XYZ(103.280, 100, 69.026) , "Trismulus.F2_10 failed." ) ;
        }
        
        public function testF7():void
        {
            assertEquals(Trismulus.F7_2  , new XYZ(95.044, 100, 108.755)  , "Trismulus.F7_2 failed."  ) ;
            assertEquals(Trismulus.F7_10 , new XYZ(95.792, 100, 107.687) , "Trismulus.F7_10 failed." ) ;
        }
        
        public function testF11():void
        {
            assertEquals(Trismulus.F11_2  , new XYZ(100.966, 100, 64.370) , "Trismulus.F11_2 failed."  ) ;
            assertEquals(Trismulus.F11_10 , new XYZ(103.866, 100, 65.627) , "Trismulus.F11_10 failed." ) ;
        }
    }
}
