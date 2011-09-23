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

package graphics.geom 
{
    import core.maths.round;

    import library.ASTUce.framework.TestCase;

    public class RegularPolygonTest extends TestCase
    {
        public function RegularPolygonTest(name:String = "")
        {
            super(name);
        }
        
        public function testApothemByRadius():void
        {
            assertEquals( RegularPolygon.apothemByRadius(0,2) , 0 ) ;            assertEquals( RegularPolygon.apothemByRadius(2,0) , 0 ) ;
            assertEquals
            ( 
                round( RegularPolygon.apothemByRadius(100,6) , 3 ) , 
                86.603
            ) ;
        }
        
        public function testApothemBySide():void
        {
            assertEquals( RegularPolygon.apothemBySide(0,2) , 0 ) ;
            assertEquals( RegularPolygon.apothemBySide(2,0) , 0 ) ;
            assertEquals
            ( 
                round( RegularPolygon.apothemBySide(100,6) , 3 ) , 
                86.603
            ) ;
        }
        
        public function testAreaByApothem():void
        {
            assertEquals( RegularPolygon.areaByApothem(0,2) , 0 ) ;
            assertEquals( RegularPolygon.areaByApothem(2,0) , 0 ) ;
            assertEquals
            ( 
                round( RegularPolygon.areaByApothem(5.5,5) , 0 ) , 
                110
            ) ;
            assertEquals
            ( 
                round( RegularPolygon.areaByApothem(6,6) , 0 ) , 
                125 
            ) ;
        }
        
        public function testAreaByApothemAndPerimeter():void
        {
            assertEquals( RegularPolygon.areaByApothem(0,2) , 0 ) ;
            assertEquals( RegularPolygon.areaByApothem(2,0) , 0 ) ;
            assertEquals
            ( 
                round( RegularPolygon.areaByApothemAndPerimeter(6,7*6) , 2 ) , 
                126
            ) ;
            assertEquals
            ( 
                round( RegularPolygon.areaByApothemAndPerimeter(6,8.8*5) , 0 ) , 
                132
            ) ;
        }
        
        public function testAreaByRadius():void
        {
            assertEquals( RegularPolygon.areaByRadius(0,2) , 0 ) ;
            assertEquals( RegularPolygon.areaByRadius(2,0) , 0 ) ;
            assertEquals
            ( 
                round( RegularPolygon.areaByRadius(7,5) , 2 ) , 
                116.5 
            ) ;
            assertEquals
            ( 
                round( RegularPolygon.areaByRadius(7,6) , 2 ) , 
                127.31 
            ) ;
        }
        
        public function testAreaBySide():void
        {
            assertEquals( RegularPolygon.areaBySide(0,2) , 0 ) ;
            assertEquals( RegularPolygon.areaBySide(2,0) , 0 ) ;
            assertEquals
            ( 
                round( RegularPolygon.areaBySide(8,5) , 0 ) , 
                110
            ) ;
            assertEquals
            ( 
                round( RegularPolygon.areaBySide(7,6) , 0 ) , 
                127 
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
        
        public function testRadiusByApothem():void
        {
            assertEquals( RegularPolygon.radiusByApothem(0,2) , 0 ) ;
            assertEquals( RegularPolygon.radiusByApothem(2,0) , 0 ) ;
            assertEquals
            ( 
                round( RegularPolygon.radiusByApothem(86.603,6) , 1 ) , 
                100
            ) ;
        }
        
        public function testRadiusBySide():void
        {
            assertEquals( RegularPolygon.radiusBySide(0,2) , 0 ) ;
            assertEquals( RegularPolygon.radiusBySide(2,0) , 0 ) ;
            assertEquals
            ( 
                round( RegularPolygon.radiusBySide(8.7,3) , 1 ) , 
                5
            ) ;
            assertEquals
            ( 
                round( RegularPolygon.radiusBySide(5.9,5) , 1 ) , 
                5
            ) ;
            assertEquals
            ( 
                round( RegularPolygon.radiusBySide(5,6) , 1 ) , 
                5
            ) ;
        }
    }
}
