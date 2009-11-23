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
    import graphics.ArcType;
    import graphics.FillStyle;
    import graphics.LineStyle;
    import graphics.drawing.ArcPen;
    
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    
    public class ArcPenExample extends Sprite 
    {
        public function ArcPenExample()
        {
            canvas = new Shape() ;
            
            canvas.x = 740/2 ;
            canvas.y = 200 ;
            
            addChild( canvas ) ;
            pen       = new ArcPen( canvas.graphics , 299 ) ;
            pen.fill  = new FillStyle( 0xF0DE42 ) ;
            pen.line  = new LineStyle( 2, 0xFFFFFF ) ;
            pen.type  = ArcType.CHORD ;
            pen.draw() ;
            stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
        }
        
        public var canvas:Shape ;
        public var pen:ArcPen ;
        
        public function keyDown( e:KeyboardEvent ):void
        {
            var code:uint = e.keyCode ;
            switch( code )
            {
                case Keyboard.LEFT :
                {
                    pen.fill = new FillStyle( 0xFF0000 ) ;
                    pen.draw(290, 100, 0, 0, null, null, ArcType.PIE, Align.LEFT) ;
                    break ;
                }
                case Keyboard.RIGHT :
                {
                    pen.fill = new FillStyle( 0xFF0000 ) ;
                    pen.draw(290, 100, 0, 0, null, 80, ArcType.CHORD, Align.RIGHT) ;
                    break ;
                }
                case Keyboard.UP :
                {
                    pen.fill = new FillStyle( 0xFF0000 ) ;
                    pen.draw(90, 150, 0, 0, null, 80, ArcType.PIE, Align.BOTTOM) ;
                    break ;
                }
                case Keyboard.DOWN :
                {
                    pen.fill = new FillStyle( 0x550000 ) ;
                    pen.draw(150, 150, 0, 0, null, 80, ArcType.PIE, Align.TOP) ;
                    break ;
                }
                case Keyboard.SPACE :
                {
                    pen.x          = -100 ;
                    pen.y          = -100 ;
                    pen.yRadius    = 80 ;
                    pen.radius     = 100 ;
                    pen.angle      = 320 ;
                    pen.useEndFill = false ;
                    pen.fill       = new FillStyle( 0xFF0000 ) ;
                    pen.align      = Align.TOP_RIGHT ;
                    pen.type       = ArcType.NONE ;
                    pen.draw() ;
                    break ;
                }
            }
        }
    }
}
