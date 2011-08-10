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

package examples 
{
    import graphics.Align;
    import graphics.ArcType;
    import graphics.FillStyle;
    import graphics.LineStyle;
    import graphics.drawing.ArcPen;

    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.display.StageScaleMode;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;

    public class ArcPenExample extends Sprite 
    {
        public function ArcPenExample()
        {
            ///// 
            
            canvas = new Shape() ;
            
            canvas.x = 740/2 ;
            canvas.y = 200 ;
            
            addChild( canvas ) ;
            
            ///// 
            
            pen       = new ArcPen( canvas.graphics , 299 ) ;
            
            pen.fill  = new FillStyle( 0xF0DE42 ) ;
            pen.line  = new LineStyle( 2, 0xFFFFFF ) ;
            pen.type  = ArcType.CHORD ;
            pen.draw() ;
            
            ///// 
            
            stage.scaleMode = StageScaleMode.NO_SCALE ;
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
