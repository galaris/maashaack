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

package graphics.display 
{
    import flash.display.Bitmap;
    import flash.display.BitmapData;
    import flash.display.IBitmapDrawable;
    import flash.geom.ColorTransform;
    import flash.geom.Matrix;
    import flash.geom.Point;
    import flash.geom.Rectangle;
    
    /**
     * Creates a BigBitmap object with a specified width and height. This bitmap can specify a width and a height values greater than the defaults.
     */
    public class BigBitmap extends MOB
    {
        /**
         * Creates a new BigBitmap instance.
         * @param width The width of the bitmap image in pixels.
         * @param height The height of the bitmap image in pixels.
         * @param transparent Specifies whether the bitmap image supports per-pixel transparency. The default value is true (transparent). To create a fully transparent bitmap, set the value of the transparent parameter to true and the value of the fillColor parameter to 0x00000000 (or to 0). Setting the transparent property to false can result in minor improvements in rendering performance.
         * @param color A 32-bit ARGB color value that you use to fill the bitmap image area. The default value is 0xFFFFFFFF (solid white).
         */
        public function BigBitmap( width:Number = 0 , height:Number = 0 , transparent:Boolean = true , color:uint = 0xFFFFFFFF )
        {
            setBitmap( width , height , transparent , color ) ;
        }
        
        /**
         * Draws the source display object onto the bitmap image, using the Flash Player or AIR vector renderer.
         * @param source The display object or BitmapData object to draw to the BitmapData object. (The DisplayObject and BitmapData classes implement the IBitmapDrawable interface.)
         * @param matrix A Matrix object used to scale, rotate, or translate the coordinates of the bitmap. If you do not want to apply a matrix transformation to the image, set this parameter to an identity matrix, created with the default new Matrix() constructor, or pass a null value.
         * @param colorTransform A ColorTransform object that you use to adjust the color values of the bitmap. If no object is supplied, the bitmap image's colors are not transformed. If you must pass this parameter but you do not want to transform the image, set this parameter to a ColorTransform object created with the default new ColorTransform() constructor.
         * @param blendMode A string value, from the flash.display.BlendMode class, specifying the blend mode to be applied to the resulting bitmap.
         * @param clipRect A Rectangle object that defines the area of the source object to draw. If you do not supply this value, no clipping occurs and the entire source object is drawn.
         * @param smoothing A Boolean value that determines whether a BitmapData object is smoothed when scaled or rotated, due to a scaling or rotation in the matrix parameter. The smoothing parameter only applies if the source parameter is a BitmapData object. With smoothing set to false, the rotated or scaled BitmapData image can appear pixelated or jagged. For example, the following two images use the same BitmapData object for the source parameter, but the smoothing parameter is set to true on the left and false on the right:
         */
        public function draw( source:IBitmapDrawable , matrix:Matrix = null , colorTransform:ColorTransform = null, blendMode:String = null, clipRect:Rectangle = null, smoothing:Boolean = false):void
        {
            if( matrix == null ) 
            {
                matrix = new Matrix();
            }
            
            var bmp:Bitmap ;
            
            var temp:Matrix ;
            
            var l:int = _bitmaps.length ;
            
            for( var i:int ; i < l ; i++ )
            {
                bmp = _bitmaps[i] as Bitmap;
                
                temp = matrix.clone();
                
                temp.tx -= bmp.x ;
                temp.ty -= bmp.y ;
                
                var tempRect:Rectangle;
                
                if( clipRect != null )
                {
                    tempRect    = clipRect.clone();
                    tempRect.x -= bmp.x ;
                    tempRect.y -= bmp.y ;
                }
                else
                {
                    tempRect = null ;
                }
                bmp.bitmapData.draw( source , temp , colorTransform , blendMode , tempRect , smoothing) ;
            }
        }
        
        /**
         * Frees memory that is used to store the BitmapData object.
         */
        public function dispose():void
        {
            if( _bitmaps )
            {
                var bmp:Bitmap ;
                while( _bitmaps.length > 0 )
                {
                    bmp = _bitmaps.shift() as Bitmap;
                    removeChild(bmp);
                    bmp.bitmapData.dispose();
                }
            }
        }
        
        /**
         * Fills a rectangular area of pixels with a specified ARGB color.
         * @param rect The rectangular area to fill.
         * @param color The ARGB color value that fills the area. ARGB colors are often specified in hexadecimal format; for example, 0xFF336699.
         */
        public function fillRect( rect:Rectangle , color:uint ):void
        {
            var l:int = _bitmaps.length ;
            for( var i:int  ; i < l ; i++ )
            {
                var bmp:Bitmap = _bitmaps[i] as Bitmap;
                var temp:Rectangle = rect.clone();
                temp.x -= bmp.x;
                temp.y -= bmp.y;
                bmp.bitmapData.fillRect(temp, color);
            }
        }
        
        /**
         * Returns an integer that represents an RGB pixel value from a BitmapData object at a specific point (x, y). 
         * The getPixel() method returns an unmultiplied pixel value. No alpha information is returned.
         * @param x The x position of the pixel.
         * @param y The y position of the pixel.
         * @return A number that represents a RGB pixel value. If the (x, y) coordinates are outside the bounds of the image, the method returns 0.
         */
        public function getPixel( x:Number , y:Number ):uint
        {
            var l:int = _bitmaps.length ;
            for( var i:int ; i < l ; i++ )
            {
                var bmp:Bitmap = _bitmaps[i] as Bitmap;
                if( x >= bmp.x && x < bmp.x + bmp.width && y >= bmp.y && y < bmp.y + bmp.height )
                {
                    return bmp.bitmapData.getPixel( x - bmp.x , y - bmp.y );
                }
            }
            return 0;
        }
        
        /**
         * Returns an ARGB color value that contains alpha channel data and RGB data. 
         * This method is similar to the getPixel() method, which returns an RGB color without alpha channel data.
         * @param x The x position of the pixel.
         * @param y The y position of the pixel.
         * @return A number that represents an ARGB pixel value. If the (x, y) coordinates are outside the bounds of the image, the method returns 0.
         */
        public function getPixel32( x:Number , y:Number ):uint
        {
            var l:int = _bitmaps.length ;
            for( var i:int ; i < l ; i++ )
            {
                var bmp:Bitmap = _bitmaps[i] as Bitmap;
                if(x >= bmp.x && x < bmp.x + bmp.width && y >= bmp.y && y < bmp.y + bmp.height)
                {
                    return bmp.bitmapData.getPixel32( x - bmp.x , y - bmp.y );
                }
            }
            return 0;
        }
        
        /**
         * Locks an image so that any objects that reference the BitmapData object, such as Bitmap objects, are not updated when this BitmapData object changes. 
         * To improve performance, use this method along with the unlock() method before and after numerous calls to the setPixel() or setPixel32() method.
         */
        public override function lock():void
        {
            if( _locked == 0 )
            {
                for each( var bmp:Bitmap in _bitmaps )
                {
                    bmp.bitmapData.lock();
                }
            }
            super.lock() ;
        }
        
        /**
         * Fills an image with pixels representing random noise.
         * @param randomSeed The random seed number to use. If you keep all other parameters the same, you can generate different pseudo-random results by varying the random seed value. The noise function is a mapping function, not a true random-number generation function, so it creates the same results each time from the same random seed.
         * @param low The lowest value to generate for each channel (0 to 255).
         * @param high The highest value to generate for each channel (0 to 255).
         * @param channelOptions A number that can be a combination of any of the four color channel values (BitmapDataChannel.RED, BitmapDataChannel.BLUE, BitmapDataChannel.GREEN, and BitmapDataChannel.ALPHA). You can use the logical OR operator (|) to combine channel values.
         * @param grayScale A Boolean value. If the value is true, a grayscale image is created by setting all of the color channels to the same value. The alpha channel selection is not affected by setting this parameter to true.
         */
        public function noise(randomSeed:int, low:uint = 0, high:uint = 255, channelOptions:uint = 7, grayScale:Boolean = false):void
        {
            var l:int = _bitmaps.length ;
            for(var i:int = 0; i < l ; i++ )
            {
                var bmp:Bitmap = _bitmaps[i] as Bitmap;
                bmp.bitmapData.noise( randomSeed , low , high , channelOptions , grayScale ) ;
            }
        }
        
        /**
         * Generates a Perlin noise image.
         * The Perlin noise generation algorithm interpolates and combines individual random noise functions (called octaves) into a single function that generates more natural-seeming random noise. Like musical octaves, each octave function is twice the frequency of the one before it. Perlin noise has been described as a "fractal sum of noise" because it combines multiple sets of noise data with different levels of detail.
         * You can use Perlin noise functions to simulate natural phenomena and landscapes, such as wood grain, clouds, and mountain ranges. In most cases, the output of a Perlin noise function is not displayed directly but is used to enhance other images and give them pseudo-random variations.
         * <p><b>Note :</b> The Perlin noise algorithm is named for Ken Perlin, who developed it after generating computer graphics for the 1982 film Tron. Perlin received an Academy Award for Technical Achievement for the Perlin noise function in 1997.</p>
         * @param baseX Frequency to use in the x direction. For example, to generate a noise that is sized for a 64 x 128 image, pass 64 for the baseX value.
         * @param baseY Frequency to use in the y direction. For example, to generate a noise that is sized for a 64 x 128 image, pass 128 for the baseY value.
         * @param numOctaves Number of octaves or individual noise functions to combine to create this noise. Larger numbers of octaves create images with greater detail. Larger numbers of octaves also require more processing time.
         * @param randomSeed The random seed number to use. If you keep all other parameters the same, you can generate different pseudo-random results by varying the random seed value. The Perlin noise function is a mapping function, not a true random-number generation function, so it creates the same results each time from the same random seed.
         * @param stitch A Boolean value. If the value is true, the method attempts to smooth the transition edges of the image to create seamless textures for tiling as a bitmap fill.
         * @param fractalNoise A Boolean value. If the value is true, the method generates fractal noise; otherwise, it generates turbulence. An image with turbulence has visible discontinuities in the gradient that can make it better approximate sharper visual effects like flames and ocean waves.
         * @param channelOptions A number that can be a combination of any of the four color channel values (BitmapDataChannel.RED, BitmapDataChannel.BLUE, BitmapDataChannel.GREEN, and BitmapDataChannel.ALPHA). You can use the logical OR operator (|) to combine channel values.
         * @param grayScale A Boolean value. If the value is true, a grayscale image is created by setting each of the red, green, and blue color channels to identical values. The alpha channel value is not affected if this value is set to true.
         */
        public function perlinNoise(baseX:Number, baseY:Number, numOctaves:uint, randomSeed:int, stitch:Boolean = false , fractalNoise:Boolean = true , channelOptions:uint = 7, grayScale:Boolean = false):void
        {
            var i:int ;
            var j:int ;
            
            var bmp:Bitmap ;
            var tmp:Array ;
            
            var offsets:Array = new Array();
            
            for( i = 0 ; i < numOctaves; i++ )
            {
                offsets.push( new Point() ) ;
            }
            
            var l:int = _bitmaps.length ;
            
            for( i = 0 ; i < l ; i++ )
            {
                bmp = _bitmaps[i] as Bitmap;
                tmp = [] ;
                for( j = 0; j < offsets.length; j++)
                {
                    tmp[j] = new Point( offsets[j].x + bmp.x, offsets[j].y + bmp.y ) ;
                }
                bmp.bitmapData.perlinNoise(baseX, baseY, numOctaves, randomSeed, stitch, fractalNoise, channelOptions, grayScale, tmp);
            }
        }
        
        /**
         * Sets all new components of the bitmap and before dispose it.
         * @param width The width of the bitmap image in pixels.
         * @param height The height of the bitmap image in pixels.
         * @param transparent Specifies whether the bitmap image supports per-pixel transparency. The default value is true (transparent). To create a fully transparent bitmap, set the value of the transparent parameter to true and the value of the fillColor parameter to 0x00000000 (or to 0). Setting the transparent property to false can result in minor improvements in rendering performance.
         * @param color A 32-bit ARGB color value that you use to fill the bitmap image area. The default value is 0xFFFFFFFF (solid white).
         */
        public function setBitmap( width:Number , height:Number , transparent:Boolean = false , color:uint = 0xFFFFFFFF ):void
        {
            dispose() ;
            
            _bitmaps     = new Vector.<Bitmap>() ;
            _color       = color;
            _height      = height ;
            _width       = width  ;
            _transparent = transparent;
            
            var bmp:Bitmap ;
            
            var h:Number ;
            var w:Number ;
            
            var dx:Number ;
            var dy:Number ;
            
            h = _height ;
            dy = 0 ;
            
            while(h > 0)
            {
                dx = 0 ;
                w    = _width ;
                while( w > 0 )
                {
                    bmp = new Bitmap( new BitmapData( Math.min( 2880 , w ) , Math.min( 2880 , h ) , _transparent , _color ) );
                    
                    bmp.x = dx ;
                    bmp.y = dy ;
                    
                    addChild( bmp ) ;
                    
                    _bitmaps.push( bmp );
                    
                    w  -= bmp.width;
                    dx += bmp.width;
                }
                h  -= Math.min( 2880 , h ) ;
                dy += Math.min( 2880 , h ) ;
            }
        }
        
        /**
         * Sets a single pixel of a BitmapData object. The current alpha channel value of the image pixel is preserved during this operation. The value of the RGB color parameter is treated as an unmultiplied color value.
         * @param x The x position of the pixel whose value changes.
         * @param y The y position of the pixel whose value changes.
         * @param color The resulting RGB color for the pixel.
         */
        public function setPixel(x:Number, y:Number, color:uint ):void
        {
            var l:int = _bitmaps.length ;
            for( var i:int ; i < l ; i++ )
            {
                var bmp:Bitmap = _bitmaps[i] as Bitmap;
                if( x >= bmp.x && x < bmp.x + bmp.width && y >= bmp.y && y < bmp.y + bmp.height )
                {
                    bmp.bitmapData.setPixel( Math.round( x - bmp.x ) , Math.round( y - bmp.y ) , color) ;
                }
            }
        }
        
        /**
         * ets the color and alpha transparency values of a single pixel of a BitmapData object. This method is similar to the setPixel() method; the main difference is that the setPixel32() method takes an ARGB color value that contains alpha channel information.
         * @param x The x position of the pixel whose value changes.
         * @param y The y position of the pixel whose value changes.
         * @param color The resulting ARGB color for the pixel. If the bitmap is opaque (not transparent), the alpha transparency portion of this color value is ignored.
         */
        public function setPixel32(x:Number, y:Number, color:uint):void
        {
            var bmp:Bitmap ;
            var l:int = _bitmaps.length ;
            for( var i:int ; i < l ; i++ )
            {
                bmp = _bitmaps[i] as Bitmap;
                if( x >= bmp.x && x < bmp.x + bmp.width && y >= bmp.y && y < bmp.y + bmp.height )
                {
                    bmp.bitmapData.setPixel32(x - bmp.x, y - bmp.y, color);
                }
            }
        }
        
        /**
         * Unlocks an image so that any objects that reference the BitmapData object, such as Bitmap objects, are updated when this BitmapData object changes.
         */
        public override function unlock():void
        {
            super.unlock() ;
            if( _locked == 0 )
            {
                for each( var bmp:Bitmap in _bitmaps )
                {
                    bmp.bitmapData.unlock();
                }
            }
        }
        
        /**
         * @private
         */
        private var _bitmaps:Vector.<Bitmap>;
        
        /**
         * @private
         */
        private var _color:uint;
        
        /**
         * @private
         */
        private var _height:Number;
        
        /**
         * @private
         */
        private var _transparent:Boolean;
        
        /**
         * @private
         */
        private var _width:Number;
    }
}