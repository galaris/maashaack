/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :

*/

package examples
{
    import graphics.FillBitmapStyle;
    import graphics.display.Pattern;
    import graphics.drawing.RectanglePen;

    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.geom.Matrix;

    [SWF(width="190", height="190", frameRate="24", backgroundColor="#FFFFFF")]
    
    public class PatternExample extends Sprite
    {
        public function PatternExample()
        {
            var shape:Shape = new Shape() ;
            
            shape.x = 20 ;
            shape.y = 20 ;
            
            addChild( shape ) ;
            
            var tiles:Array = 
            [
                [1, 0, 0, 0] ,
                [0, 0, 0, 0] ,
                [0, 0, 1, 0] ,
                [0, 0, 0, 0]
            ];
             
            var colors:Array = [ 0x00 , 0xFF000000 ] ;
            
            var pattern:Pattern = new Pattern(tiles, colors) ;
            
            var pen:RectanglePen = new RectanglePen( shape ) ;
            
            pen.fill = new FillBitmapStyle( pattern , new Matrix() , true ) ;
            
            pen.draw( 0, 0 , 150, 150 ) ;
        }
    }
}
