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

package graphics.display 
{
    import flash.display.BitmapData;
    import flash.display.IBitmapDrawable;
    import flash.geom.ColorTransform;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.geom.Rectangle;

    /**
     * Creates a new BitmapData with a crop of an original IBitmapDrawable object.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * package examples 
     * {
     *     import graphics.display.CropBitmapData;
     *     
     *     import flash.display.Bitmap;
     *     import flash.display.BitmapData;
     *     import flash.display.Sprite;
     *     import flash.display.StageScaleMode;
     *     import flash.geom.Rectangle;
     *     
     *     [SWF(width="200", height="200", frameRate="24", backgroundColor="#333333")]
     *     
     *     public dynamic class CropBitmapDataExample extends Sprite 
     *     {
     *         public function CropBitmapDataExample()
     *         {
     *             //////////
     *             
     *             stage.align      = "" ;
     *             stage.scaleMode  = StageScaleMode.NO_SCALE ;
     *             
     *             /////////
     *             
     *             var picture:BitmapData = new Picture(0,0) as BitmapData ; // Picture a symbol in the library
     *             var crop:BitmapData    = new CropBitmapData( picture , new Rectangle( 18 , 31, 120, 120 ) , true , true , 0x55A2A2A2 ) ; 
     *             var bitmap:Bitmap      = new Bitmap( crop ) ;
     *             
     *             bitmap.x = 35 ;
     *             bitmap.y = 35 ;
     *             
     *             trace( bitmap.width + " / " + bitmap.height ) ;
     *             
     *             addChild( bitmap ) ;
     *         }
     *     }
     * }
     * </pre>
     */
    public class CropBitmapData extends BitmapData 
    {
        /**
         * Creates a new CropBitmapData instance.
         * @param bitmap The IBitmapDrawable object to transform (DisplayObject or BitmapData).
         * @param area The area to crop the original IBitmapDrawable object. If this Rectangle is null the BitmapData is a simple copy of the original view.
         * @param smoothing A Boolean value that determines whether a BitmapData object is smoothed when scaled or rotated, due to a scaling or rotation in the matrix  parameter. The smoothing parameter only applies if the source  parameter is a BitmapData object. 
         * @param transparent  Specifies whether the bitmap image supports per-pixel transparency. The default value is true (transparent). To create a fully transparent bitmap, set the value of the transparent parameter to true and the value of the fillColor parameter to 0x00000000 (or to 0). Setting the transparent property to false can result in minor improvements in rendering performance.
         * @param fillColor A 32-bit ARGB color value that you use to fill the bitmap image area. The default value is 0 (black transparent).
         * @param matrix A Matrix object used to scale, rotate, or translate the coordinates of the bitmap. If you do not want to apply a matrix transformation to the image, set this parameter to an identity matrix, created with the default new Matrix() constructor, or pass a null value.
         * @param colorTransform A ColorTransform object that you use to adjust the color values of the bitmap. If no object is supplied, the bitmap image's colors are not transformed. If you must pass this parameter but you do not want to transform the image, set this parameter to a ColorTransform object created with the default new ColorTransform() constructor.
         * @param blendMode A string value, from the flash.display.BlendMode class, specifying the blend mode to be applied to the resulting bitmap.
         * @param clipRect A Rectangle object that defines the area of the source object to draw. If you do not supply this value, no clipping occurs and the entire source object is drawn.
         * @param strict Indicates if the crop use the minimal size of the bitmap to crop or only the passed-in area Rectangle.
         */
        public function CropBitmapData( bitmap:IBitmapDrawable , area:Rectangle = null , smoothing:Boolean = true , transparent:Boolean = true, fillColor:uint = 0 , matrix:Matrix = null, colorTransform:ColorTransform = null, blendMode:String = null, clipRect:Rectangle = null , strict:Boolean = true )
        {
            var w:Number = ("width"  in bitmap) ? ( bitmap["width"]  as Number ) : 0 ;
            var h:Number = ("height" in bitmap) ? ( bitmap["height"] as Number ) : 0 ;
            if ( matrix )
            {
                w *= matrix.a ;
                h *= matrix.d ;
            }
            _area.x      = area ? area.x      : 0 ;
            _area.y      = area ? area.y      : 0 ;
            _area.width  = area ? area.width  : w ;
            _area.height = area ? area.height : h ;
            var b:BitmapData = new BitmapData( w , h , transparent , fillColor ) ;
            b.draw( bitmap , matrix , colorTransform , blendMode , clipRect , smoothing ) ;
            if( strict )
            {
                _area.width  = Math.min( _area.width  , w ) ;
                _area.height = Math.min( _area.height , h ) ;
            }
            super( _area.width , _area.height , transparent , fillColor ) ;
            copyPixels( b , _area , _origine );
            b.dispose() ;
        }
        
        /**
         * @private
         */
        private static const _area:Rectangle = new Rectangle() ;
        
        /**
         * @private
         */
        private static const _origine:Point = new Point(0,0);
    }
}
