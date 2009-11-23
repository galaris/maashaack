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
    import graphics.Align;
    import graphics.Corner;
    import graphics.FillStyle;
    import graphics.LineStyle;
    import graphics.drawing.BubblePen;

    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.display.StageScaleMode;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;

    public class BubblePenExample extends Sprite 
    {
        public function BubblePenExample()
        {
            /////////
            
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            stage.align = "" ;
            
            stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
            
            /////////
            
            var shape:Shape = new Shape() ;
            
            shape.x = 740 / 2 ;
            shape.y = 420 / 2 ;
            
            addChild( shape ) ;
            
            /////////
            
            pen = new BubblePen( shape , 0 , 0, 200, 150, 14, 20, 8 , 12 ) ;
            
            pen.arrowHeight = 15 ;
            pen.arrowWidth  = 15 ;
            pen.arrowMargin = 20 ; // only when a corner radius is 0
            
            pen.align = Align.TOP_RIGHT ;
            
            pen.fill  = new FillStyle( 0xFF0000 , 0.5 ) ;
            pen.line  = new LineStyle( 2, 0xFFFFFF ) ;
            
            pen.draw() ;
        }
        
        public var pen:BubblePen ;
        
        public function keyDown( e:KeyboardEvent ):void
        {
            var code:uint = e.keyCode ;
            switch( code )
            {
                case Keyboard.LEFT :
                case Keyboard.NUMPAD_6 :
                {
                    pen.align = Align.LEFT ;
                    break ;
                }
                case Keyboard.RIGHT :
                case Keyboard.NUMPAD_4 :
                {
                    pen.align = Align.RIGHT ;
                    break ;
                }
                case Keyboard.UP :
                case Keyboard.NUMPAD_2 :
                {
                    pen.align = Align.TOP ;
                    break ;
                }
                case Keyboard.DOWN :
                case Keyboard.NUMPAD_8 :
                {
                    pen.align = Align.BOTTOM ;
                    break ;
                }
                case Keyboard.SPACE :
                {
                    pen.corner = new Corner(false,false,false,false);                	
                    pen.align  = Align.TOP_LEFT ;
                    break ;
                }
                case Keyboard.NUMPAD_7 :
                {
                    pen.corner = new Corner();
                    pen.align = Align.BOTTOM_RIGHT ;
                    break ;
                }
                case Keyboard.NUMPAD_9 :
                {
                	pen.align = Align.BOTTOM_LEFT ;
                    break ;
                }
                case Keyboard.NUMPAD_1 :
                {
                    pen.align = Align.TOP_RIGHT ;
                    break ;
                }
                case Keyboard.NUMPAD_3 :
                {
                	pen.align = Align.TOP_LEFT ;
                    break ;
                }
            }
            pen.draw() ;
            trace( "rectangle area : " + pen.rectangle ) ;
        }
    }
}
