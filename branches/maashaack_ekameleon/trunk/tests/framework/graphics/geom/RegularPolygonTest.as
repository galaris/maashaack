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

package graphics.geom 
{
    import buRRRn.ASTUce.framework.TestCase;

    import system.numeric.Mathematics;

    public class RegularPolygonTest extends TestCase
    {
        public function RegularPolygonTest(name:String = "")
        {
            super(name);
        }
        
        public function testApothemeByRadius():void
        {
            assertEquals( RegularPolygon.apothemeByRadius(0,2) , 0 ) ;            assertEquals( RegularPolygon.apothemeByRadius(2,0) , 0 ) ;
            assertEquals
            ( 
                Mathematics.round( RegularPolygon.apothemeByRadius(100,6) , 3 ) , 
                86.603
            ) ;
        }
        
        public function testApothemeBySide():void
        {
            assertEquals( RegularPolygon.apothemeBySide(0,2) , 0 ) ;
            assertEquals( RegularPolygon.apothemeBySide(2,0) , 0 ) ;
            assertEquals
            ( 
                Mathematics.round( RegularPolygon.apothemeBySide(100,6) , 3 ) , 
                86.603
            ) ;
        }
        
        public function testCentralAngleInDegrees():void
        {
            assertEquals( RegularPolygon.centralAngle(0,true) , Infinity ) ;
            assertEquals( RegularPolygon.centralAngle(1,true) , 360 ) ;
            assertEquals( RegularPolygon.centralAngle(5,true) ,  72 ) ;
            assertEquals( RegularPolygon.centralAngle(6,true) ,  60 ) ;
        }
        
        public function testCentralAngleInRadians():void
        {
            assertEquals( RegularPolygon.centralAngle(0) , Infinity ) ;
            assertEquals( RegularPolygon.centralAngle(1,false) , 360 * Math.PI / 180 ) ;
            assertEquals( RegularPolygon.centralAngle(5,false) ,  72 * Math.PI / 180 ) ;
            assertEquals( RegularPolygon.centralAngle(6,false) ,  60 * Math.PI / 180 ) ;
        }
        
        public function testPerimeter():void
        {
            assertEquals( RegularPolygon.perimeter( 10 , 6 ) , 60 ) ;
        }
        
        public function testRadiusByApotheme():void
        {
            assertEquals( RegularPolygon.radiusByApotheme(0,2) , 0 ) ;
            assertEquals( RegularPolygon.radiusByApotheme(2,0) , 0 ) ;
            assertEquals
            ( 
                Mathematics.round( RegularPolygon.radiusByApotheme(86.603,6) , 1 ) , 
                100
            ) ;
        }
        
        public function testRadiusBySide():void
        {
            assertEquals( RegularPolygon.radiusBySide(0,2) , 0 ) ;
            assertEquals( RegularPolygon.radiusBySide(2,0) , 0 ) ;
            assertEquals
            ( 
                Mathematics.round( RegularPolygon.radiusBySide(8.7,3) , 1 ) , 
                5
            ) ;
            assertEquals
            ( 
                Mathematics.round( RegularPolygon.radiusBySide(5.9,5) , 1 ) , 
                5
            ) ;
            assertEquals
            ( 
                Mathematics.round( RegularPolygon.radiusBySide(5,6) , 1 ) , 
                5
            ) ;
        }
    }
}
