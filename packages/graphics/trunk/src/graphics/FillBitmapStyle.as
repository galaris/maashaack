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

package graphics 
{
    import graphics.geom.Matrixs;

    import system.eden;

    import flash.display.BitmapData;
    import flash.display.Graphics;
    import flash.geom.Matrix;

    /**
     * Defines the fill style of the vector shapes. See the flash.display.graphics.beginBitmapFill method.
     */
    public class FillBitmapStyle implements IFillStyle
    {
        
        /**
         * Creates a new FillBitmapStyle instance.
         * @param bitmap A transparent or opaque bitmap image that contains the bits to be displayed.
         * @param matrix A matrix object (of the flash.geom.Matrix class), which you can use to define transformations on the bitmap. 
         * @param repeat If true, the bitmap image repeats in a tiled pattern. If false, the bitmap image does not repeat, and the edges of the bitmap are used for any fill area that extends beyond the bitmap.
         * @param smooth If false, upscaled bitmap images are rendered by using a nearest-neighbor algorithm and look pixelated. If true, upscaled bitmap images are rendered by using a bilinear algorithm. Rendering by using the nearest neighbor algorithm is usually faster. 
         */
        public function FillBitmapStyle( bitmap:BitmapData = null , matrix:Matrix = null, repeat:Boolean = true, smooth:Boolean = false )
        {
            this.bitmap  = bitmap ;
            this.matrix  = matrix ;
            this.repeat  = repeat ;
            this.smooth  = smooth ;
        }
        
        /**
         * A transparent or opaque bitmap image that contains the bits to be displayed.
         */
        public var bitmap:BitmapData;
        
        /**
         * A matrix object (of the flash.geom.Matrix class), which you can use to define transformations on the bitmap.
         */
        public var matrix:Matrix;
        
        /**
         * If true, the bitmap image repeats in a tiled pattern. If false, the bitmap image does not repeat, and the edges of the bitmap are used for any fill area that extends beyond the bitmap.
         */
        public var repeat:Boolean ;
        
        /**
         * If false, upscaled bitmap images are rendered by using a nearest-neighbor algorithm and look pixelated. If true, upscaled bitmap images are rendered by using a bilinear algorithm. Rendering by using the nearest neighbor algorithm is usually faster.
         */
        public var smooth:Boolean ;
        
        /**
         * Initialize and launch the beginBitmapFill method of the specified Graphics reference.
         */
        public function apply( graphic:Graphics ):void
        {
            graphic.beginBitmapFill( bitmap , matrix , repeat , smooth );
        }
        
        /**
         * Creates and returns a shallow copy of the object.
         * @return A new object that is a shallow copy of this instance.
         */
        public function clone():* 
        {
            return new FillBitmapStyle( bitmap , matrix, repeat, smooth ) ;
        }
        
        /**
         * Compares the specified object with this object for equality.
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
         */
        public function equals( o:* ):Boolean
        {
            var s:FillBitmapStyle = o as FillBitmapStyle ;
            if ( s )
            {
                return bitmap == s.bitmap
                    && matrix == s.matrix
                    && repeat == s.repeat
                    && smooth == s.smooth ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Returns the source code string representation of the object. 
         * This method is not complete we can't serialize a BitmapData object, in the constructor of the source representation this value is always "null".
         * @return the source code string representation of the object.
         */
        public function toSource(indent:int = 0):String
        {
            var source:String = "new graphics.FillBitmapStyle(null,"
                              + Matrixs.toSource( matrix ) + ","
                              + eden.serialize( repeat ) + ","
                              + eden.serialize( smooth ) 
                              + ")" ;
            return source ;
        }
    }

}
