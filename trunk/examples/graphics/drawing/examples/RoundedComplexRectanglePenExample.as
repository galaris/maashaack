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
    import graphics.Corner;
    import graphics.FillStyle;
    import graphics.LineStyle;
    import graphics.drawing.RoundedComplexRectanglePen;

    import flash.display.CapsStyle;
    import flash.display.JointStyle;
    import flash.display.LineScaleMode;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.display.StageScaleMode;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;

    public class RoundedComplexRectanglePenExample extends Sprite 
    {
        public function RoundedComplexRectanglePenExample()
        {
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            stage.align     = "" ;
            
            var shape:Shape = new Shape() ;
            
            shape.x = 740 / 2 ;
            shape.y = 420 / 2 ;
            
            addChild( shape ) ;
            
            pen      = new RoundedComplexRectanglePen( shape , 0, 0, 200, 180, 12, 0, 0, 24, Align.CENTER ) ;
            pen.fill = new FillStyle( 0xFF0000 , 0.5 ) ;
            pen.line = new LineStyle( 2, 0xFFFFFF , 1 , true, LineScaleMode.NORMAL , CapsStyle.SQUARE, JointStyle.MITER ) ;
            
            pen.draw() ;
            
            stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
        }
        public var pen:RoundedComplexRectanglePen ;
        
        public function keyDown( e:KeyboardEvent ):void
        {
            var code:uint = e.keyCode ;
            switch( code )
            {
                case Keyboard.LEFT :
                {
                    pen.draw( 0, 0, 200, 180, 12, 12, 32, 32, Align.LEFT ) ;
                    break ;
                }
                case Keyboard.RIGHT :
                {
                    pen.draw( 0, 0, 200, 180, 32, 12, 32, 32, Align.RIGHT ) ;
                    break ;
                }
                case Keyboard.UP :
                {
                    pen.draw( 0, 0, 200, 180, 32, 12, 0, 0, Align.TOP ) ;
                    break ;
                }
                case Keyboard.DOWN :
                {
                    pen.draw( 0, 0, 200, 180, 0, 0, 24, 24, Align.BOTTOM ) ;
                    break ;
                }
                case Keyboard.SPACE :
                {
                    pen.x = -10 ;
                    pen.y = 10 ;
                    pen.bottomLeftRadius  = 0 ;
                    pen.bottomRightRadius = 0 ;
                    pen.topLeftRadius     = 0 ;
                    pen.topRightRadius    = 0 ;
                    pen.align  = Align.TOP_RIGHT ;
                    pen.draw() ;
                    break ;
                }
                case Keyboard.NUMPAD_7 :
                {
                    pen.cornerRadius = 10 ;
                    pen.draw( 0, 0, 200, 180 ) ;
                    break ;
                }
                case Keyboard.NUMPAD_8 :
                {
                    pen.cornerRadius = NaN ;
                    pen.draw( 0, 0, 200, 180 ) ;
                    break ;
                }
                case Keyboard.NUMPAD_9 :
                {
                    pen.corner = new Corner(false, false, false, false) ;
                    pen.draw( 0, 0, 200, 180 ) ;
                    break ;
                }
                case Keyboard.NUMPAD_6 :
                {
                    pen.corner = new Corner() ;
                    pen.draw( 0, 0, 200, 180 ) ;
                    break ;
                }
            }
        }
    }
}
