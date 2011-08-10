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
    import graphics.FillStyle;
    import graphics.drawing.RoughEdgedRectanglePen;
    
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.display.StageScaleMode;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    
    public class RoughEdgedRectanglePenExample extends Sprite 
    {
        public function RoughEdgedRectanglePenExample()
        {
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            stage.align = "" ;
            
            var shape:Shape = new Shape() ;
            
            shape.x = 740 / 2 ;
            shape.y = 420 / 2 ;
            
            pen      = new RoughEdgedRectanglePen( shape , 0, 0, 320, 200, 4, 50,  Align.CENTER ) ;
            
            pen.fill = new FillStyle( 0xFF0000 , 0.5 ) ;
            // pen.line = new LineStyle( 2 , 0xFFFFFFFF , 1 ) ;
            
            pen.draw() ;
            
            addChild( shape ) ;
            stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
        }
        public var pen:RoughEdgedRectanglePen ;
        
        public function keyDown( e:KeyboardEvent ):void
        {
            var code:uint = e.keyCode ;
            switch( code )
            {
                case Keyboard.LEFT :
                {
                    pen.draw( 0, 0, 320, 200, 2, 60,  Align.BOTTOM_LEFT ) ;
                    break ;
                }
                case Keyboard.RIGHT :
                {
                    pen.draw( 0, 0, 320, 200, 10, 50,  Align.RIGHT ) ;
                    break ;
                }
                case Keyboard.UP :
                {
                    pen.draw( 0, 0, 320, 200, 15, 60,  Align.TOP ) ;
                    break ;
                }
                case Keyboard.DOWN :
                {
                    pen.draw( 0, 0, 320, 200, 4, 40,  Align.BOTTOM ) ;
                    break ;
                }
                case Keyboard.SPACE :
                {
                    pen.x          = -10 ;
                    pen.y          =  10 ;
                    pen.width      = 300 ;
                    pen.height     = 150 ;
                    pen.density    =  50 ;
                    pen.distortion =   4 ;
                    pen.align      = Align.TOP_LEFT ;
                    pen.draw() ;
                    break ;
                }
            }
        }
    }
}
