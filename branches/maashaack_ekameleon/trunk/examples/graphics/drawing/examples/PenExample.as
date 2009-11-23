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
  Nicolas Surian (aka NairuS) <nicolas.surian@gmail.com> 
*/

package examples 
{
    import graphics.drawing.Pen;

    import flash.display.Shape;
    import flash.display.Sprite;

    public class PenExample extends Sprite 
    {
        public function PenExample()
        {
            var shape:Shape = new Shape() ;
            shape.x = 25 ;
            shape.y = 25 ;
            
            // var pen:Pen = new Pen( shape.graphics ) ;
            var pen:Pen = new Pen( shape ) ;
            
            pen.beginFill( 0xFF0000 , 1 ) ;
            pen.drawRect( 0, 0, 150, 150 ) ;
            
            pen.beginFill( 0x660000 , 1 ) ;
            pen.drawRect( 160, 0, 150, 150 ) ;
            
            pen.beginFill( 0x000000 , 1 ) ;
            pen.drawCircle( 320 + 75 , 75, 75 ) ;
            
            addChild( shape ) ;
            
            trace(pen) ;
        }
    }
}
