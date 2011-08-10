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

    import flash.events.KeyboardEvent;
    import core.maths.map;
    
    import examples.display.Picture;
    
    import graphics.colors.ColorMatrix;
    
    import flash.display.Sprite;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.filters.ColorMatrixFilter;
    
    [SWF(width="300", height="300", frameRate="24", backgroundColor="#666666")]
    
    public class ColorMatrixExample extends Sprite
    {
        public function ColorMatrixExample()
        {
            // stage
            
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            
            stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
            stage.addEventListener( MouseEvent.MOUSE_MOVE , update ) ;
            
            // picture
            
            picture.x = 25 ;
            picture.y = 25 ;
            
            addChild( picture ) ;
            
            // matrix
            
            color = new ColorMatrix() ;
            
            //// invert 
            
            color.reset( ColorMatrix.INVERT ) ;
            
            filter.matrix   = color.matrix ;
            picture.filters = [ filter ] ;
        }
        
        public var angle:uint ;
        
        public var color:ColorMatrix ;
        
        public var filter:ColorMatrixFilter = new ColorMatrixFilter() ;
        
        public var picture:Picture = new Picture() ;
        
        public function keyDown( e:Event = null ):void
        {
            color.rotate( ColorMatrix.R_AXIS , angle += 5 ) ; // R_AXIS or G_AXIS or B_AXIS
            
            if ( angle >= 360 )
            {
                angle = 0 ;
            }
            
            filter.matrix = color.matrix ;
            
            picture.filters = [ filter ] ;
        }
        
        public function update( e:Event = null ):void
        {
            color.reset() ;
            
            color.brightness = map( picture.mouseY , 0 , picture.height , -1 , 1 ) ;
            
            // color.contrast   = map( picture.mouseX , 0 , picture.width  , -1 , 1 ) ;
            color.saturation = map( picture.mouseX , 0 , picture.width  , -3 , 3 ) ;
            
            trace( "brightness:" + color.brightness + " :: saturation:" + color.saturation ) ;
            
            filter.matrix   = color.matrix ;
            picture.filters = [ filter ] ;
        }
    }
}
