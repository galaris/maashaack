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
    import flash.display.BitmapData;
    import flash.geom.Point;
    
    /**
     * A circular perlin noise effect.
     * <p>This class maps a linear perlin noise to a radial perlin noise and exposes the resulting bitmapdata for use.</p>
     */
    public class RadialPerlinBitmapData extends BitmapData
    {
        /**
         * The constructor creates a Radialperlin effect.
         * 
         * @param radius The radius of the perlin noise image
         * @param numOctaves Number of octaves or individual noise functions to combine to create this noise. Larger numbers of 
         * octaves create images with greater detail. Larger numbers of octaves also require more processing time.
         * @param randomSeed The random seed number to use. If you keep all other parameters the same, you can generate different 
         * pseudo-random results by varying the random seed value. The Perlin noise function is a mapping function, not a true 
         * random-number generation function, so it creates the same results each time from the same random seed.
         * @param fractalNoise A Boolean value. If the value is true, the method generates fractal noise; otherwise, it generates 
         * turbulence. An image with turbulence has visible discontinuities in the gradient that can make it better approximate 
         * sharper visual effects like flames and ocean waves.
         * @param channelOptions A number that can be a combination of any of the four color channel values (BitmapDataChannel.RED, 
         * BitmapDataChannel.BLUE, BitmapDataChannel.GREEN, and BitmapDataChannel.ALPHA). You can use the logical OR operator (|) 
         * to combine channel values.
         * @param greyScale A Boolean value. If the value is true, a grayscale image is created by setting each of the red, green, 
         * and blue color channels to identical values. The alpha channel value is not affected if this value is set to true.
         * @param fadeEdge Indicates whether to fade the edge of the image to transparent (true) or keep a sharpe edge on the 
         * image (false).
         */
        public function RadialPerlinBitmapData( radius:Number, numOctaves:uint, randomSeed:int, fractalNoise:Boolean, channelOptions:uint = 7, grayScale:Boolean = false, fadeEdge:Boolean = false )
        {
            _radius         = Math.ceil( radius );
            _fadeEdge       = fadeEdge ;
            _numOctaves     = numOctaves ;
            _randomSeed     = randomSeed ;
            _fractalNoise   = fractalNoise ;
            _channelOptions = channelOptions ;
            _grayScale      = grayScale ;
            _perlinWidth    = Math.ceil( radius * PI_2 ) ;
            super( 2 * radius, 2 * radius , true , 0 ) ;
            _perlin = new BitmapData( radius, _perlinWidth, true, 0 );
        }
        
        /**
         * Frees memory that is used to store the BitmapData object.
         */
        public override function dispose():void
        {
            _perlin.dispose();
            super.dispose() ;
        }
        
        /**
         * Render the radial perlin effect with the specified distance and rotation value.
         */
        public function render( distance:Number, rotation:Number ):void
        {
            
            var color:Number ;
            var dist:Number  ;
            var alpha:Number ;
            var offsets:Array = [] ;
            _offset.x = -distance ;
            rotation  = -rotation * Math.PI / 180;
            var i:uint = _numOctaves ;
            while ( --i > -1 )
            {
                offsets[i] = _offset ;
            }
            _perlin.perlinNoise( _radius, _perlinWidth, _numOctaves, _randomSeed, true, _fractalNoise, _channelOptions, _grayScale, offsets ) ;
            for ( var x:Number = -_radius + 0.5 ; x < _radius; ++x )
            {
                for ( var y:Number = -_radius + 0.5 ; y < _radius; ++y )
                {
                    dist = x * x + y * y;
                    if ( dist <= _radius * _radius )
                    {
                        dist = Math.sqrt( dist );
                        var angle:Number = Math.atan2( y, x ) + rotation ;
                        while ( angle < 0 )
                        {
                            angle += PI_2;
                        }
                        while ( angle >= PI_2 )
                        {
                            angle -= PI_2 ;
                        }
                        color = _perlin.getPixel32( dist , angle * _radius ) ;
                        if ( _fadeEdge )
                        {
                            alpha  = color >>> 24 ;
                            alpha *= (_radius - dist) / _radius ;
                            color  = ( color & 0xFFFFFF ) | ( alpha << 24 ) ;
                        }
                        setPixel32( x + _radius - 0.5, y + _radius - 0.5, color );
                    }
                }
            }
        }
        
        private var _perlin:BitmapData ; // normal perlin bitmap
        private var _radius:uint; // radius of the bitmap
        private var _offset:Point = new Point();
        private var _perlinWidth:uint; // width of the perlin bitmap
        private var _numOctaves:uint; // number of octaves in the perlin noise
        private var _randomSeed:uint; // seed for the perlin noise
        private var _fractalNoise:Boolean; // fractal noise state for the perlin noise
        private var _channelOptions:uint; // channel options for the perlin noise
        private var _grayScale:Boolean; // grayscale setting for the perlin noise
        private var _fadeEdge:Boolean; // to fade the image towards the edge or not
        
        private static const PI_2:Number = Math.PI * 2 ; // constant for speed
    }
}
