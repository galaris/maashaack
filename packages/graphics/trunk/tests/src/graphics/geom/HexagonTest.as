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
    import buRRRn.ASTUce.framework.TestCase;

    import core.maths.round;

    public class HexagonTest extends TestCase
    {
        public function HexagonTest(name:String = "")
        {
            super(name);
        }
        
        /////// initialize
        
        public var hexa:Hexagon ;
        
        public function setUp():void
        {
            hexa = new Hexagon(25) ;
        }
        
        public function tearDown():void
        {
            hexa = null ;
        }
        
        /////// static constants
        
        public function testCentralAngle():void
        {
            assertEquals( Hexagon.centralAngle , 60 ) ;
        }
        
        public function testCentralAngleRadians():void
        {
            assertEquals( Hexagon.centralAngleRadians , 60 * Math.PI / 180 ) ;
        }
        
        public function testExteriorAngle():void
        {
            assertEquals( Hexagon.exteriorAngle , 60 ) ;
        }
        
        public function testExteriorAngleRadians():void
        {
            assertEquals( Hexagon.exteriorAngleRadians , 60 * Math.PI / 180 ) ;
        }
        
        public function testInteriorAngle():void
        {
            assertEquals( Hexagon.interiorAngle , 120 ) ;
        }
        
        public function testNumDiagonals():void
        {
            assertEquals( Hexagon.numDiagonals , 9 ) ;
        }
        
        public function testNumSides():void
        {
            assertEquals( Hexagon.numSides , 6 ) ;
        }
        
        public function testNumTriangles():void
        {
            assertEquals( Hexagon.numTriangles , 4 ) ;
        }
        
        public function testSumInteriorAngle():void
        {
            assertEquals( Hexagon.sumInteriorAngle , 720) ;
        }
        
        /////// inherit and interfaces
        
        public function testInterface():void
        {
            assertTrue( hexa is Geometry , "must implements the interface Geometry.") ;
        }
        
        /////// basic methods
        
        public function testClone():void
        {
            var clone:Hexagon = hexa.clone() as Hexagon ;
            assertNotNull( clone ) ;
            assertEquals( hexa.apothem , clone.apothem ) ;
            assertEquals( hexa.radius  , clone.radius ) ;
        }
        
        public function testEquals():void
        {
            assertTrue( hexa.equals( hexa )  ) ;
            var clone:Hexagon = hexa.clone() as Hexagon ;
            assertTrue( hexa.equals( clone )  ) ;
            var other:Hexagon = new Hexagon( 10 ) ;
            assertFalse( hexa.equals( other )  ) ;
        }
        
        public function testReset():void
        {
            hexa.reset() ;
            assertEquals( hexa.side      , 0 ) ;
            assertEquals( hexa.radius    , 0 ) ;
            assertEquals( hexa.apothem   , 0 ) ;
            assertEquals( hexa.perimeter , 0 ) ;
            assertEquals( hexa.height    , 0 ) ;
            assertEquals( hexa.width     , 0 ) ;
        }
        
        public function testToSource():void
        {
            assertEquals( "new graphics.geom.Hexagon(25)" , hexa.toSource() ) ;
            hexa.radius = 0 ;
            assertEquals( "new graphics.geom.Hexagon(0)" , hexa.toSource() ) ;
        }
        
        public function testToString():void
        {
            assertEquals( "[Hexagon radius:25 apothem:21.65]" , hexa.toString() ) ;
        }
        
        /////// attributes
        
        public function testApothem():void
        {
            assertEquals( round(hexa.apothem,2) , 21.65 ) ;
            hexa.apothem = 20 ;
            assertEquals( hexa.apothem , 20 ) ;
        }
        
        public function testHeight():void
        {
            assertEquals( round(hexa.height,2) , 43.3 ) ;
            hexa.height = 20 ;
            assertEquals( hexa.height , 20 ) ;
            assertEquals( hexa.apothem , 10 ) ;
        }
        
        public function testPerimeter():void
        {
            assertEquals( hexa.perimeter , 25 * 6 ) ;
            hexa.perimeter = 60 ;
            assertEquals( hexa.side , 10 ) ;
        }
        
        public function testRadius():void
        {
            assertEquals( hexa.radius , 25 ) ;
            hexa.radius = 2 ;
            assertEquals( hexa.radius , 2 ) ;
        }
        
        public function testSide():void
        {
            assertEquals( hexa.side , 25 ) ;
            hexa.side = 2 ;
            assertEquals( hexa.side , 2 ) ;
            assertEquals( hexa.side , hexa.radius ) ;
        }
        
        public function testWidth():void
        {
            assertEquals( hexa.width , 50 ) ;
            hexa.width = 20 ;
            assertEquals( hexa.width , 20 ) ;
            assertEquals( hexa.radius , 10 ) ;
        }
    }
}
