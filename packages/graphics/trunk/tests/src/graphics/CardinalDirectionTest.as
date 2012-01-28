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
  Portions created by the Initial Developers are Copyright (C) 2006-2012
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

package graphics 
{
    import library.ASTUce.framework.ArrayAssert;
    import library.ASTUce.framework.TestCase;

    public class CardinalDirectionTest extends TestCase 
    {
        public function CardinalDirectionTest(name:String = "")
        {
            super(name);
        }
        
        public function testE():void
        {
            assertEquals( 90                             , CardinalDirection.E.azimut()   ) ;
            assertEquals( Math.PI / 2                    , CardinalDirection.E.valueOf()  ) ;
            assertEquals( "E"                            , CardinalDirection.E.toString() ) ;
            assertEquals( "graphics.CardinalDirection.E" , CardinalDirection.E.toSource() ) ;
        }
        
        public function testENE():void
        {
            assertEquals( 67.5                             , CardinalDirection.ENE.azimut()   ) ;
            assertEquals( 3 * Math.PI / 8                  , CardinalDirection.ENE.valueOf()  ) ;
            assertEquals( "ENE"                            , CardinalDirection.ENE.toString() ) ;
            assertEquals( "graphics.CardinalDirection.ENE" , CardinalDirection.ENE.toSource() ) ;
        }
        
        public function testESE():void
        {
            assertEquals( 112.5                            , CardinalDirection.ESE.azimut()   ) ;
            assertEquals( 5 * Math.PI / 8                  , CardinalDirection.ESE.valueOf()  ) ;
            assertEquals( "ESE"                            , CardinalDirection.ESE.toString() ) ;
            assertEquals( "graphics.CardinalDirection.ESE" , CardinalDirection.ESE.toSource() ) ;
        }
        
        public function testN():void
        {
            assertEquals( 0                              , CardinalDirection.N.azimut()   ) ;
            assertEquals( 0                              , CardinalDirection.N.valueOf()  ) ;
            assertEquals( "N"                            , CardinalDirection.N.toString() ) ;
            assertEquals( "graphics.CardinalDirection.N" , CardinalDirection.N.toSource() ) ;
        }
        
        public function testNE():void
        {
            assertEquals( 45                              , CardinalDirection.NE.azimut()   ) ;
            assertEquals( Math.PI / 4                     , CardinalDirection.NE.valueOf()  ) ;
            assertEquals( "NE"                            , CardinalDirection.NE.toString() ) ;
            assertEquals( "graphics.CardinalDirection.NE" , CardinalDirection.NE.toSource() ) ;
        }
        
        public function testNNE():void
        {
            assertEquals( 22.5                             , CardinalDirection.NNE.azimut()   ) ;
            assertEquals( Math.PI / 8                      , CardinalDirection.NNE.valueOf()  ) ;
            assertEquals( "NNE"                            , CardinalDirection.NNE.toString() ) ;
            assertEquals( "graphics.CardinalDirection.NNE" , CardinalDirection.NNE.toSource() ) ;
        }
        
        public function testNW():void
        {
            assertEquals( 315                             , CardinalDirection.NW.azimut()   ) ;
            assertEquals( 7 * Math.PI / 4                 , CardinalDirection.NW.valueOf()  ) ;
            assertEquals( "NW"                            , CardinalDirection.NW.toString() ) ;
            assertEquals( "graphics.CardinalDirection.NW" , CardinalDirection.NW.toSource() ) ;
        }
        
        public function testNNW():void
        {
            assertEquals( 337.5                            , CardinalDirection.NNW.azimut()   ) ;
            assertEquals( 15 * Math.PI / 8                 , CardinalDirection.NNW.valueOf()  ) ;
            assertEquals( "NNW"                            , CardinalDirection.NNW.toString() ) ;
            assertEquals( "graphics.CardinalDirection.NNW" , CardinalDirection.NNW.toSource() ) ;
        }
        
        public function testS():void
        {
            assertEquals( 180                            , CardinalDirection.S.azimut()   ) ;
            assertEquals( Math.PI                        , CardinalDirection.S.valueOf()  ) ;
            assertEquals( "S"                            , CardinalDirection.S.toString() ) ;
            assertEquals( "graphics.CardinalDirection.S" , CardinalDirection.S.toSource() ) ;
        }
        
        public function testSE():void
        {
            assertEquals( 135                             , CardinalDirection.SE.azimut()   ) ;
            assertEquals( 3 * Math.PI / 4                 , CardinalDirection.SE.valueOf()  ) ;
            assertEquals( "SE"                            , CardinalDirection.SE.toString() ) ;
            assertEquals( "graphics.CardinalDirection.SE" , CardinalDirection.SE.toSource() ) ;
        }
        
        public function testSSE():void
        {
            assertEquals( 157.5                            , CardinalDirection.SSE.azimut()   ) ;
            assertEquals( 7 * Math.PI / 8                  , CardinalDirection.SSE.valueOf()  ) ;
            assertEquals( "SSE"                            , CardinalDirection.SSE.toString() ) ;
            assertEquals( "graphics.CardinalDirection.SSE" , CardinalDirection.SSE.toSource() ) ;
        }
        
        public function testSSW():void
        {
            assertEquals( 202.5                            , CardinalDirection.SSW.azimut()   ) ;
            assertEquals( 9 * Math.PI / 8                  , CardinalDirection.SSW.valueOf()  ) ;
            assertEquals( "SSW"                            , CardinalDirection.SSW.toString() ) ;
            assertEquals( "graphics.CardinalDirection.SSW" , CardinalDirection.SSW.toSource() ) ;
        }
        
        public function testSW():void
        {
            assertEquals( 225                             , CardinalDirection.SW.azimut()   ) ;
            assertEquals( 5 * Math.PI / 4                 , CardinalDirection.SW.valueOf()  ) ;
            assertEquals( "SW"                            , CardinalDirection.SW.toString() ) ;
            assertEquals( "graphics.CardinalDirection.SW" , CardinalDirection.SW.toSource() ) ;
        }
        
        public function testW():void
        {
            assertEquals( 270                            , CardinalDirection.W.azimut()   ) ;
            assertEquals( 3 * Math.PI / 2                , CardinalDirection.W.valueOf()  ) ;
            assertEquals( "W"                            , CardinalDirection.W.toString() ) ;
            assertEquals( "graphics.CardinalDirection.W" , CardinalDirection.W.toSource() ) ;
        }
        
        public function testWNW():void
        {
            assertEquals( 292.5                            , CardinalDirection.WNW.azimut()   ) ;
            assertEquals( 13 * Math.PI / 8                 , CardinalDirection.WNW.valueOf()  ) ;
            assertEquals( "WNW"                            , CardinalDirection.WNW.toString() ) ;
            assertEquals( "graphics.CardinalDirection.WNW" , CardinalDirection.WNW.toSource() ) ;
        }
        
        public function testWSW():void
        {
            assertEquals( 247.5                            , CardinalDirection.WSW.azimut()   ) ;
            assertEquals( 11 * Math.PI / 8                 , CardinalDirection.WSW.valueOf()  ) ;
            assertEquals( "WSW"                            , CardinalDirection.WSW.toString() ) ;
            assertEquals( "graphics.CardinalDirection.WSW" , CardinalDirection.WSW.toSource() ) ;
        }
        
        public function testALL():void
        {
            assertEquals( 16 , CardinalDirection.ALL.length ) ;
            var ALL:Array = 
            [
                CardinalDirection.N,
                CardinalDirection.E,
                CardinalDirection.S,
                CardinalDirection.W,
                CardinalDirection.NE,
                CardinalDirection.SE,
                CardinalDirection.NW,
                CardinalDirection.SW,
                CardinalDirection.NNE,
                CardinalDirection.NNW,
                CardinalDirection.SSE,
                CardinalDirection.SSW,
                CardinalDirection.ENE,
                CardinalDirection.ESE,
                CardinalDirection.WNW,
                CardinalDirection.WSW
            ];
            ArrayAssert.assertEquals( ALL , CardinalDirection.ALL ) ;
        }
        
        public function testDIAGONALS():void
        {
            assertEquals( 4 , CardinalDirection.DIAGONALS.length ) ;
            var DIAGONALS:Array = 
            [
                CardinalDirection.NE,
                CardinalDirection.SE,
                CardinalDirection.NW,
                CardinalDirection.SW
            ];
            ArrayAssert.assertEquals( DIAGONALS , CardinalDirection.DIAGONALS ) ;
        }
        
        public function testORTHOGONALS():void
        {
            assertEquals( 4 , CardinalDirection.ORTHOGONALS.length ) ;
            var DIAGONALS:Array = 
            [
                CardinalDirection.N ,
                CardinalDirection.E ,
                CardinalDirection.S ,
                CardinalDirection.W
            ];
            ArrayAssert.assertEquals( DIAGONALS , CardinalDirection.ORTHOGONALS ) ;
        }
        
        public function testisDiagonal():void
        {
            assertTrue( CardinalDirection.isDiagonal(CardinalDirection.NE) ) ;
            assertTrue( CardinalDirection.isDiagonal(CardinalDirection.SE) ) ;
            assertTrue( CardinalDirection.isDiagonal(CardinalDirection.NW) ) ;
            assertTrue( CardinalDirection.isDiagonal(CardinalDirection.SW) ) ;
            
            assertFalse( CardinalDirection.isDiagonal(CardinalDirection.N) ) ;
            assertFalse( CardinalDirection.isDiagonal(CardinalDirection.S) ) ;
            assertFalse( CardinalDirection.isDiagonal(CardinalDirection.W) ) ;
            assertFalse( CardinalDirection.isDiagonal(CardinalDirection.E) ) ;
            
            var OTHERS:Array = 
            [
                CardinalDirection.NNE,
                CardinalDirection.NNW,
                CardinalDirection.SSE,
                CardinalDirection.SSW,
                CardinalDirection.ENE,
                CardinalDirection.ESE,
                CardinalDirection.WNW,
                CardinalDirection.WSW
            ];
            
            for( var i:int ; i < OTHERS.lenght ; i++)
            {
                assertFalse( CardinalDirection.isDiagonal( OTHERS[i] ) ) ;
            }
        }
        
        public function testisOrthogonal():void
        {
            assertTrue( CardinalDirection.isOrthogonal(CardinalDirection.N) ) ;
            assertTrue( CardinalDirection.isOrthogonal(CardinalDirection.S) ) ;
            assertTrue( CardinalDirection.isOrthogonal(CardinalDirection.W) ) ;
            assertTrue( CardinalDirection.isOrthogonal(CardinalDirection.E) ) ;
            
            assertFalse( CardinalDirection.isOrthogonal(CardinalDirection.NE) ) ;
            assertFalse( CardinalDirection.isOrthogonal(CardinalDirection.SE) ) ;
            assertFalse( CardinalDirection.isOrthogonal(CardinalDirection.NW) ) ;
            assertFalse( CardinalDirection.isOrthogonal(CardinalDirection.SW) ) ;
            
            var OTHERS:Array = 
            [
                CardinalDirection.NNE,
                CardinalDirection.NNW,
                CardinalDirection.SSE,
                CardinalDirection.SSW,
                CardinalDirection.ENE,
                CardinalDirection.ESE,
                CardinalDirection.WNW,
                CardinalDirection.WSW
            ];
            
            for( var i:int ; i < OTHERS.lenght ; i++)
            {
                assertFalse( CardinalDirection.isOrthogonal( OTHERS[i] ) ) ;
            }
        }
    }
}
