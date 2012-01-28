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
    import flash.geom.Point;

    /**
     * This BitmapData is an helper to creates perlin noise effects.
     * <p>The Perlin noise generation algorithm interpolates and combines individual random noise functions (called octaves) 
     * into a single function that generates more natural-seeming random noise. 
     * Like musical octaves, each octave function is twice the frequency of the one before it. 
     * Perlin noise has been described as a "fractal sum of noise" because it combines multiple sets of noise data with different levels of detail.</p>
     */
    public class PerlinNoiseBitmapData extends BitmapData 
    {
        /**
         * Creates a new PerlinNoiseBitmapData instance.
         * @param width The width of the bitmap image in pixels.
         * @param height The height of the bitmap image in pixels.
         * @param transparent Specifies whether the bitmap image supports per-pixel transparency. The default value is true (transparent). To create a fully transparent bitmap, set the value of the transparent parameter to true and the value of the fillColor parameter to 0x00000000 (or to 0). Setting the transparent property to false can result in minor improvements in rendering performance.
         * @param fillColor A 32-bit ARGB color value that you use to fill the bitmap image area. The default value is 0xFFFFFFFF (solid white).
         * @throws ArgumentError width and/or height exceed the maximum dimensions.
         */
        public function PerlinNoiseBitmapData( width:int , height:int , transparent:Boolean = true , fillColor:uint = 0xFFFFFFFF ) 
        {
            super( width , height , transparent , fillColor );
            baseX   = width  ;
            baseY   = height ;
            octaves = 1 ;
            seed    = Math.random() * 10000 ;
            move(0, 0) ;
        }
        
        /**
         * Frequency to use in the x direction. For example, to generate a noise that is sized for a 64 x 128 image, pass 64 for the baseX value.
         */
        public var baseX:Number;
        
        /**
         * Frequency to use in the y direction. For example, to generate a noise that is sized for a 64 x 128 image, pass 128 for the baseY value.
         */
        public var baseY:Number;
        
        /**
         * A number that can be a combination of any of the four color channel values ( BitmapDataChannel.RED , BitmapDataChannel.BLUE , BitmapDataChannel.GREEN , and BitmapDataChannel.ALPHA ). You can use the logical OR operator ( | ) to combine channel values.
         */
        public var channels:uint = 7 ;
        
        /**
         * Set the density of the frequency to use in the x and y direction.
         */
        public function get density():Number 
        {
            return _density ;
        }
        
        /**
         * @private
         */
        public function set density( d:Number ):void 
        {
            _density = d > 0 ? d : 1 ;
            baseX    = width  / d ;
            baseY    = height / d ;
        }
        
        /**
         * A Boolean value. 
         * If the value is true , the method generates fractal noise; otherwise, it generates turbulence. An image with turbulence has visible discontinuities in the gradient that can make it better approximate sharper visual effects like flames and ocean waves.
         */
        public var fractal:Boolean = true ;
        
        /**
         * A Boolean value. If the value is true, a grayscale image is created by setting each of the red, green, and blue color channels to identical values. The alpha channel value is not affected if this value is set to true .
         */
        public var greyScale:Boolean;
        
        /**
         * Number of octaves or individual noise functions to combine to create this noise. 
         * <p>Larger numbers of octaves create images with greater detail. Larger numbers of octaves also require more processing time.</p>
         */
        public function get octaves():uint 
        {
            return _octaves;
        }
        
        /**
         * @private
         */
        public function set octaves( o:uint ):void 
        {
            _octaves = o ;
            for ( var i:int ; i < _octaves ; i++ )
            {
                _offsets.push( new Point() );
            }
        }
        
        /**
         * The random seed number to use. 
         * If you keep all other parameters the same, you can generate different pseudo-random results by varying the random seed value. The Perlin noise function is a mapping function, not a true random-number generation function, so it creates the same results each time from the same random seed.
         */
        public var seed:int ;
        
        /**
         * A Boolean value. If the value is true , the method attempts to smooth the transition edges of the image to create seamless textures for tiling as a bitmap fill.
         */
        public var stitch:Boolean;
        
        /**
         * Move the frequency of all octaves.
         */
        public function move( x:Number , y:Number , octave:int = -1 ):void 
        {
            if( octave == -1 ) 
            {
                for ( var i:int ; i < _octaves ; i++ )
                {
                    _moveOctave( i, x, y ) ;
                }
            }
            else if( octave > -1 && octave < _octaves ) 
            {
                _moveOctave( octave, x, y );
            } 
            render() ;
        }
        
        /**
         * Render the perlin noise effect.
         */
        public function render():void 
        {
            perlinNoise( baseX, baseY, _octaves, seed, stitch, fractal, channels, greyScale, _offsets ) ;
        }
        
        /**
         * @private
         */
        private function _moveOctave( oc:int , x:Number, y:Number ):void 
        {
            var p:Point = (_offsets[oc] as Point) ;
            if ( p != null ) 
            {
                _pos.x = x ;
                _pos.y = y ;
                _offsets[oc] = p.add( _pos ) ;
            }
        }
        
        /**
         * @private
         */
        private var _density:Number = 1 ;
        
        /**
         * @private
         */
        private var _octaves:uint = 1 ;
        
        /**
         * @private
         */
        private var _offsets:Array = [];
        
        /**
         * @private
         */
        private var _pos:Point = new Point() ;
    }
}
