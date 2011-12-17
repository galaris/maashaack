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
    import graphics.display.MirrorBitmapData;
    
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.display.StageScaleMode;
    import flash.events.KeyboardEvent ;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;
    import flash.ui.Keyboard ;
        
    [SWF(width="150", height="300", frameRate="24", backgroundColor="#666666")]
    
    /**
     * Example with the graphics.display.MirrorBitmapData class.
     */
    public dynamic class MirrorBitmapDataExample extends Sprite 
    {
        public function MirrorBitmapDataExample()
        {
            //////////
            
            stage.align      = "" ;
            stage.scaleMode  = StageScaleMode.NO_SCALE ;
            stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
            
            /////////
            
            picture = new Picture(0,0) as BitmapData ; // Picture a symbol in the library
            
            mirror = new MirrorBitmapData( picture , true , true , true , 0x00000000 ) ; 
            
            bitmap = new Bitmap( mirror ) ;
            
            addChild( bitmap ) ;
        }
        
        public var bitmap:Bitmap ;
        
        public var mirror:BitmapData ;
        
        public var picture:BitmapData ;
        
        public var horizontal:Boolean ;
        
        public var vertical:Boolean ;        
        
        public function keyDown( e:KeyboardEvent ):void
        {
            mirror.dispose() ;
            var code:uint = e.keyCode ;
            switch( code )
            {
                case Keyboard.UP :
                {
                    vertical = true ;
                    break ; 
                }
                case Keyboard.DOWN :
                {
                    vertical = false ;
                    break ; 
                }
                case Keyboard.LEFT :
                {
                    horizontal = false ;
                    break ; 
                }
                case Keyboard.RIGHT :
                {
                    horizontal = true ;
                    break ; 
                }
            }  
            mirror = new MirrorBitmapData( picture , horizontal , vertical , true , 0x00000000 ) ; 
            bitmap.bitmapData = mirror ;  
        }
    }
}
