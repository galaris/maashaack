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

package core.maths 
{
    import library.ASTUce.framework.TestCase;

    public class clerpTest extends TestCase 
    {
        public function clerpTest(name:String = "")
        {
            super(name);
        }
        
        public function testClerp():void
        {
            assertEquals(   0 , clerp( 0.0 , 0 , 180 ) , "#1" ) ;
            assertEquals(  90 , clerp( 0.5 , 0 , 180 ) , "#2" ) ;
            assertEquals( 180 , clerp( 1.0 , 0 , 180 ) , "#3" ) ;
        }
        
        public function testClerpFixed():void
        {
            assertEquals(    1 , clerp( 1 , 0 ,   1 ) , "#1" ) ;
            assertEquals(    2 , clerp( 1 , 0 ,   2 ) , "#2" ) ;
            assertEquals(  179 , clerp( 1 , 0 , 179 ) , "#3" ) ;
            assertEquals(  180 , clerp( 1 , 0 , 180 ) , "#4" ) ;
            assertEquals( -179 , clerp( 1 , 0 , 181 ) , "#5" ) ;
            assertEquals( -178 , clerp( 1 , 0 , 182 ) , "#6" ) ;
            assertEquals(   -1 , clerp( 1 , 0 , 359 ) , "#7" ) ;
            assertEquals(    0 , clerp( 1 , 0 , 360 ) , "#8" ) ;
        }
    }
}