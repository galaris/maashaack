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
    import graphics.drawing.AntPen;
    
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.display.StageScaleMode;
    import flash.events.KeyboardEvent;
    import flash.geom.Point;
    import flash.ui.Keyboard;
    
    public class AntPenExample extends Sprite 
    {
        public function AntPenExample()
        {
            /////
            
            canvas = new Shape() ;
            
            canvas.x = 740/2 ;
            canvas.y = 200 ;
            
            addChild( canvas ) ;
            
            /////
            
            var colors:Array ;
            var patterns:Array ;
            
            colors   = [ 0xFFF7E233 , 0x00000000 , 0xFFF7E233 , 0x00000000 ] ;
            patterns = [ 2          , 2          , 2          , 2          ] ;
            
            pen = new AntPen( canvas.graphics ) ;
            
            pen.setup( colors , patterns ) ;
            
            pen.draw( [ new Point(0,0) ,new Point(100,0) ,new Point(100,100) , new Point(0,100) ] ) ;
            
            pen.start() ;
            
            ///// 
            
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
        }
        
        public var canvas:Shape ;
        public var pen:AntPen ;
        
        public function keyDown( e:KeyboardEvent ):void
        {
            var colors:Array ;
            var patterns:Array ;
            var code:uint = e.keyCode ;
            switch( code )
            {
                case Keyboard.LEFT :
                {
                    colors   = [ 0xFFAAE233 , 0x00000000 , 0xFF8ECAF0 , 0x00000000 ] ;
                    patterns = [ 2          , 5          , 2          , 5          ] ;
                    pen.setup( colors , patterns ) ;
                    pen.closePath = true ;
                    pen.draw(  [ new Point(-50,-50) ,new Point(50,-50) ,new Point(50,50) , new Point(-50,50) ] ) ;
                    break ;
                }
                case Keyboard.RIGHT :
                {
                    colors   = [ 0xFFF03C0F , 0x00000000 , 0xFFE489E4 , 0x00000000 ] ;
                    patterns = [ 5          , 5          , 5          , 5          ] ;
                    pen.closePath = true ;
                    pen.setup( colors , patterns ) ;
                    pen.draw(  [ new Point(-50,-50) ,new Point(50,-50) ,new Point(50,50) , new Point(-50,50) ] ) ;
                    break ;
                }
                case Keyboard.UP :
                {
                    pen.setup() ;
                    pen.closePath = false ;
                    pen.draw(  [ new Point(-50,-50) ,new Point(50,-50) ,new Point(50,50) , new Point(-50,50) ] ) ;
                    break ;
                }
                case Keyboard.SPACE :
                {
                    if ( pen.running )
                    {
                        pen.stop() ;
                    }
                    else
                    {
                        pen.start() ;
                    }
                    break ;
                }
            }
        }
    }
}
