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
    import graphics.display.CropBitmapData;
    
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.display.StageScaleMode;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;
    
    [SWF(width="200", height="200", frameRate="24", backgroundColor="#333333")]
    
    /**
     * Example with the graphics.display.CropBitmapData class.
     */
    public dynamic class CropBitmapDataExample extends Sprite 
    {
        public function CropBitmapDataExample()
        {
            //////////
            
            stage.align      = "" ;
            stage.scaleMode  = StageScaleMode.NO_SCALE ;
            
            /////////
            
            var matrix:Matrix ;
            
            // matrix = new Matrix(0.5,0,0,0.5,15,15.5) ;
            
            var picture:BitmapData = new Picture(0,0) as BitmapData ; // Picture a symbol in the library
            
            var crop:BitmapData    = new CropBitmapData( picture , new Rectangle( 18 , 31, 120 , 120 ) , true , true , 0x55A2A2A2 , matrix ) ; 
            
            var bitmap:Bitmap      = new Bitmap( crop ) ;
            
            trace( "picture : " + picture.width + " :: " + picture.height ) ;
            trace( "crop    : " + crop.width    + " :: " + crop.height    ) ;
            
            bitmap.x = 35 ;
            bitmap.y = 35 ;
            
            addChild( bitmap ) ;
        }
    }
}
