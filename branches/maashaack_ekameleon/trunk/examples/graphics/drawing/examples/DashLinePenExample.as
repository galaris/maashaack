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
    import graphics.LineStyle;
    import graphics.drawing.DashLinePen;
    import graphics.geom.Vector2;

    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.display.StageScaleMode;

    public class DashLinePenExample extends Sprite 
    {
        public function DashLinePenExample()
        {
        	stage.scaleMode = StageScaleMode.NO_SCALE ;
            stage.align     = "" ;
            
            var shape:Shape = new Shape() ;
            
            shape.x = 740 / 2 ;
            shape.y = 420 / 2 ;
            
            var start:Vector2 = new Vector2(0,0) ;
            var end:Vector2   = new Vector2(100, 100) ;
            
            var pen:DashLinePen = new DashLinePen( shape , start , end , 4, 6) ;
            pen.line            = new LineStyle( 2, 0xFFFFFF , 1 , true ) ;
            pen.draw() ;
            
            addChild( shape ) ;
        }
    }
}
