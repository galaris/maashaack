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
    import graphics.Align;
    import graphics.FillStyle;
    import graphics.LineStyle;
    import graphics.drawing.BevelRectanglePen;

    import flash.display.CapsStyle;
    import flash.display.JointStyle;
    import flash.display.LineScaleMode;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.display.StageScaleMode;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;

    public class BevelRectanglePenExample extends Sprite 
    {
        public function BevelRectanglePenExample()
        {
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            stage.align = "" ;
            
            shape = new Shape() ;
            shape.x = 740 / 2 ;
            shape.y = 420 / 2 ;
            
            pen      = new BevelRectanglePen( shape , 0, 0, 100, 80, 12, 12,  Align.CENTER ) ;
            pen.fill = new FillStyle( 0xFF0000 , 0.5 ) ;
            pen.line = new LineStyle( 2, 0xFFFFFF , 1 , true, LineScaleMode.NORMAL , CapsStyle.SQUARE, JointStyle.MITER ) ;
            pen.draw() ;
            
            addChild( shape ) ;
            stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
        }
        
        public var shape:Shape ;
        public var pen  :BevelRectanglePen ;
        
        public function keyDown( e:KeyboardEvent ):void
        {
            var code:uint = e.keyCode ;
            switch( code )
            {
                case Keyboard.LEFT :
                {
                    pen.draw( 0, 0, 200, 180, 20, 20,  Align.LEFT ) ;
                    break ;
                }
                case Keyboard.RIGHT :
                {
                    pen.draw( 0, 0, 200, 180, 20, 40,  Align.RIGHT ) ;
                    break ;
                }
                case Keyboard.UP :
                {
                    pen.draw( 0, 0, 100, 80, 20, NaN,  Align.TOP ) ;
                    break ;
                }
                case Keyboard.DOWN :
                {
                    pen.draw( 0, 0, 200, 200, 30, NaN,  Align.BOTTOM ) ;
                    break ;
                }
                case Keyboard.SPACE :
                {
                    pen.x = -10 ;
                    pen.y = 10 ;
                    pen.hBevel = 0 ;
                    pen.vBevel = 0 ;
                    pen.align  = Align.TOP_RIGHT ;
                    pen.draw() ;
                    break ;
                }
            }
        }
    }
}
