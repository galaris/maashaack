
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
Portions created by the Initial Developers are Copyright (C) 2006-2009
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
         */
        public function CropBitmapData( bitmap:IBitmapDrawable , area:Rectangle , smoothing:Boolean = true , transparent:Boolean = true, fillColor:uint = 0 )
        {
            var w:Number = ("width" in bitmap)  ? ( bitmap["width"] as Number )  : 0 ;
            var h:Number = ("height" in bitmap) ? ( bitmap["height"] as Number ) : 0 ;
            if ( area == null )
            {
                area = new Rectangle(0,0,w,h) ;
            }
            var b:BitmapData = new BitmapData( w , h , transparent , fillColor ) ;
            b.draw( bitmap , null , null , null , null , smoothing ) ;
            super( area.width , area.height , transparent , fillColor ) ;
            copyPixels( b , area , _origine );
            b.dispose() ;
        }
        
        /**
         * @private
         */
        private static const _origine:Point = new Point(0,0);
    }
}
