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
    import flash.display.DisplayObject;
    import flash.display.IBitmapDrawable;
    import flash.geom.ColorTransform;
    import flash.geom.Matrix;
    import flash.geom.Rectangle;
    
    /**
     * Creates a mirror of a specific IBitmapDrawable object. This mirror effect can be horizontal, vertical or both.
     */
    public class MirrorBitmapData extends BitmapData
    {
        /**
         * Creates a new MirrorBitmapData instance.
         * @param bitmap The BitmapData or DisplayObject to transform.
         * @param horizontal Indicates if the mirror effect transform the horizontal view of the bitmap.
         * @param vertical  Indicates if the mirror effect transform the vertical view of the bitmap.
         * @param transparent Specifies whether the bitmap image supports per-pixel transparency. The default value is true (transparent). To create a fully transparent bitmap, set the value of the transparent parameter to true and the value of the fillColor parameter to 0x00000000 (or to 0). Setting the transparent property to false can result in minor improvements in rendering performance.
         * @param fillColor A 32-bit ARGB color value that you use to fill the bitmap image area. The default value is 0xFFFFFFFF (solid white).
         * @param colorTransform (default = null) — A ColorTransform object that you use to adjust the color values of the bitmap. If no object is supplied, the bitmap image's colors are not transformed. If you must pass this parameter but you do not want to transform the image, set this parameter to a ColorTransform object created with the default new ColorTransform() constructor.
         * @param blendMode (default = null) — A string value, from the flash.display.BlendMode class, specifying the blend mode to be applied to the resulting bitmap.
         * @param clipRect (default = null) — A Rectangle object that defines the area of the source object to draw. If you do not supply this value, no clipping occurs and the entire source object is drawn.
         * @param smoothing (default = false) — A Boolean value that determines whether a BitmapData object is smoothed when scaled or rotated, due to a scaling or rotation in the matrix parameter. The smoothing parameter only applies if the source parameter is a BitmapData object. With smoothing set to false, the rotated or scaled BitmapData image can appear pixelated or jagged. For example, the following two images use the same BitmapData object for the source parameter, but the smoothing parameter is set to true on the left and false on the right:
         */
        public function MirrorBitmapData( bitmap:IBitmapDrawable , horizontal:Boolean = true , vertical:Boolean = true , transparent:Boolean = true, fillColor:uint = 4.294967295E9 , colorTransform:ColorTransform = null, blendMode:String = null, clipRect:Rectangle = null, smoothing:Boolean = false )
        {
            const w:Number =  bitmap["width"]  ;
            const h:Number =  bitmap["height"] ;
            
            super( w, h, transparent, fillColor );
            
            const scaleX:Number = bitmap is DisplayObject ? (bitmap as DisplayObject).scaleX : 1 ;
            const scaleY:Number = bitmap is DisplayObject ? (bitmap as DisplayObject).scaleY : 1 ;
            
            draw
            ( 
                bitmap, 
                new Matrix
                ( 
                    horizontal ? -scaleX : scaleX , 
                    0, 
                    0, 
                    vertical   ? -scaleY : scaleY , 
                    horizontal ? w : 0 , 
                    vertical   ? h : 0 
                )
                ,
                colorTransform, blendMode , clipRect , smoothing
            ) ;
        }
    }
}
