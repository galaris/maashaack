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
  Portions created by the Initial Developers are Copyright (C) 2006-2012
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
    import graphics.Direction;
    import graphics.FillGradientStyle;
    import graphics.FillStyle;
    import graphics.LineStyle;
    import graphics.display.Background;
    
    import flash.display.GradientType;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;

    /**
     * Example with the vegas.display.Background class.
     */
    public class BackgroundExample extends Sprite 
    {
        public function BackgroundExample()
        {
            stage.align     = StageAlign.TOP_LEFT ;
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            
            stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown) ;
            
            background      = new Background() ;
            background.fill = new FillStyle(0xD97BD0, 1) ;
            background.w    = 400 ;
            background.h    = 300 ;
            
            ///////
            
            /*
            background.borderMode  = Background.DASHED ;
            background.line        = new LineStyle(2, 0xFFFFFF, 1) ;            
            background.dashLength  = 6 ;
            background.dashSpacing = 6 ;            
            */
            
            ///////
            
            /*
            background.borderMode        = Background.ROUNDED ;
            background.bottomLeftRadius  = 12 ;
            background.bottomRightRadius = 12 ;
            background.topLeftRadius     = 12 ;
            background.topLeftRadius     = 12 ;
            background.topRightRadius    = 12 ;
            */
            
            ///////
                        
            addChild( background ) ;
            
            // little tests
            // background.minWidth = 600 ;
            // background.maxWidth = 250 ;

        }
        
        protected var background:Background ;
        
        protected function keyDown( e:KeyboardEvent ):void
        {
            var code:uint = e.keyCode ;
            switch( code )
            {
                case Keyboard.SPACE :
                {
                    if( background.fullscreen )
                    {
                        background.autoSize   = false ;
                        background.direction  = null ;
                        background.fullscreen = false ;
                        background.fill       = new FillStyle(0xD97BD0) ;
                    }
                    else
                    {
                        background.autoSize         = true ;
                        background.fullscreen       = true ;
                        background.direction        = null ;
                        background.gradientRotation = 90 ;
                        background.useGradientBox   = true ;
                        background.fill             = new FillGradientStyle
                        (
                            GradientType.LINEAR , // type 
                            [0x071E2C,0x81C2ED] , // colors
                            [1,1]               , // alphas
                            [0,0xFF]              // ratios
                        ) ;
                    }
                    break ;
                }
                case Keyboard.UP :
                {
                    background.autoSize   = true ;
                    background.fill       = new FillStyle(0x000000) ;
                    background.fullscreen = true ;
                    background.direction  = Direction.HORIZONTAL ;
                    break ;
                }
                case Keyboard.DOWN :
                {
                    background.autoSize   = true ;
                    background.fill       = new FillStyle(0xFFFFFF) ;
                    background.fullscreen = true ;
                    background.direction  = Direction.VERTICAL ;
                    break ;
                }
            }
        }
    }
}
