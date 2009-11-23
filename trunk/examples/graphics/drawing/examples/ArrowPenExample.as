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
    import graphics.FillStyle;
    import graphics.LineStyle;
    import graphics.drawing.ArrowPen;
    import graphics.geom.Vector2;

    import flash.display.CapsStyle;
    import flash.display.JointStyle;
    import flash.display.LineScaleMode;
    import flash.display.Sprite;
    import flash.events.MouseEvent;

    public class ArrowPenExample extends Sprite 
    {
        public function ArrowPenExample()
        {
            shape    = new Sprite() ;
            start    = new Vector2( 740 / 2, 420 / 2) ;
            end      = new Vector2( start.x + 100, start.y + 100) ;
            pen      = new ArrowPen( shape , start , end ) ;
        	pen.fill = new FillStyle( 0xFAFA74 ) ;
            pen.line = new LineStyle( 2, 0xFAFA74 , 1 , true, LineScaleMode.NORMAL , CapsStyle.SQUARE, JointStyle.MITER ) ;
            
            pen.setPen( null, null, { headSize:20 , headWidth:8 } ) ;
            
            pen.draw() ;
            
            addChild( shape ) ;
        	stage.addEventListener( MouseEvent.MOUSE_MOVE , refresh ) ;
        }
        
        public var shape :Sprite ;
        public var start :Vector2 ;
        public var end   :Vector2 ;
        public var pen   :ArrowPen ;
        
        public function refresh( e:MouseEvent ):void
        {
            pen.end.x = e.localX ;
            pen.end.y = e.localY ;
            pen.draw() ;
        }
    }
}
