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

package graphics.colors
{
    import core.dumpArray;
    import core.maths.clamp;
    import core.maths.floor;
    import core.maths.round;
    
    import system.Cloneable;
    import system.Serializable;
    
    /**
     * The 5x4 matrix for transforming the color and alpha components of a display. 
     * The matrix is stored in a single array, and its treated as follows:
     * [ a, b, c, d, e,
     *   f, g, h, i, j,
     *   k, l, m, n, o,
     *   p, q, r, s, t 
     * ]
     *
     * When applied to a color [r, g, b, a], the resulting color is computed as (after clamping)
     *  R' = a*R + b*G + c*B + d*A + e;
     *  G' = f*R + g*G + h*B + i*A + j;
     *  B' = k*R + l*G + m*B + n*A + o;
     *  A' = p*R + q*G + r*B + s*A + t;
     */
    public class ColorMatrix implements Cloneable, Serializable
    {
        /**
         * Creates a new ColorMatrix instance.
         * @param factory The Array or ColorMatrix optional argument to initialize the new ColorMatrix instance. 
         * If this argument is null the matrix is the identity 5x4 matrix.
         */
        public function ColorMatrix( factory:* = null )
        {
            if ( factory is Array )
            {
                matrix = (factory as Array).concat() ;
            }
            else if( factory is ColorMatrix )
            {
                matrix = (factory as ColorMatrix).matrix.concat() ;
            }
            else
            {
                matrix = IDENTITY.concat() ;
            }
        }
        
        /**
         * Defines the red axis value in the rotate method (0). 
         */
        public static const R_AXIS:uint = 0 ;
        
        /**
         * Defines the green axis value in the rotate method (1). 
         */
        public static const G_AXIS:uint = 1 ;
        
        /**
         * Defines the blue axis value in the rotate method (2). 
         */
        public static const B_AXIS:uint = 2 ;
        
        /**
         * The greyscale matrix representation to initialize the ColorMatrix.
         */
        public static const GRAYSCALE:Array =
        [ 
            0.33 , 0.33 , 0.33 , 0 , 0 ,
            0.33 , 0.33 , 0.33 , 0 , 0 ,
            0.33 , 0.33 , 0.33 , 0 , 0 ,
            0    , 0    , 0    , 1 , 0 
        ];
        
        /**
         * The identity matrix representation to initialize the ColorMatrix.
         */
        public static const IDENTITY:Array =
        [ 
            1 , 0 , 0 , 0 , 0 ,
            0 , 1 , 0 , 0 , 0 ,
            0 , 0 , 1 , 0 , 0 ,
            0 , 0 , 0 , 1 , 0 
        ];
        
        /**
         * The invert matrix representation to initialize the ColorMatrix.
         */
        public static const INVERT:Array =
        [ 
            -1 ,  0 ,  0 , 0 , 255,
             0 , -1 ,  0 , 0 , 255,
             0 ,  0 , -1 , 0 , 255,
             0 ,  0 ,  0 , 1 ,   0 
        ];
        
        /**
         * Determinates the brightness component of the color matrix.
         */
        public function get brightness():Number
        {
            return clamp( floor( ( matrix[4] + matrix[9] + matrix[14] ) / 255 / 3 , 2 ) , -1 , 1 ) ;
        }
        
        /**
         * @private
         */
        public function set brightness( value:Number ):void
        {
            value = clamp( value , -1 , 1 ) * 255 ;
            matrix = concat
            ([
                1 , 0 , 0 , 0 , value ,
                0 , 1 , 0 , 0 , value ,
                0 , 0 , 1 , 0 , value ,
                0 , 0 , 0 , 1 , 0
            ]) ;
        }
        
        /**
         * Determinates the contrast component of the color matrix.
         */
        public function get contrast():Number
        {
            return clamp( round( ( ( matrix[0] + matrix[6] + matrix[12] ) / 3 ) - 1 , 2 ) , -1 , 1 ) ;
        }
        
        /**
         * @private
         */
        public function set contrast( value:Number ):void
        {
            var c:Number = clamp( value , -1 , 1 ) ; // contrast
            var s:Number = c + 1 ; // scale
            var o:Number = 128 * ( 1 - s ) ; // offset
            matrix = concat
            ([
                s , 0 , 0 , 0 , o ,
                0 , s , 0 , 0 , o ,
                0 , 0 , s , 0 , o ,
                0 , 0 , 0 , 1 , 0
            ]) ;
        }
        
        /**
         * Determinates the saturation component of the color matrix.
         * Info : The luminance vector where the red value is 0.3086, the green value is 0.6094, and the blue value is 0.0820. 
         * Notice here that we do not use the standard NTSC weights of 0.299, 0.587, and 0.114. 
         * The NTSC weights are only applicable to RGB colors in a gamma 2.2 color space. For linear RGB colors the values above are better.
         * @see Matrix Operations for Image Processing : http://www.graficaobscura.com/matrix/index.html
         * @see YUV to RGB Conversion : http://www.fourcc.org/fccyvrgb.php
         */
        public function get saturation():Number
        {
            var s1:Number = 1 - matrix[1] / 0.6094 ;
            var s2:Number = 1 - matrix[2] / 0.0820 ;
            var s5:Number = 1 - matrix[5] / 0.3086 ;
            return round( (s1 + s2 + s5) / 3 , 2 ) ;
        }
        
        /**
         * @private
         */
        public function set saturation( value:Number ):void
        {
            var s:Number = clamp( value , -3 , 3 ) ; // saturation
            var i:Number = 1 - s ;
            
            var r:Number = i * 0.3086 ;
            var g:Number = i * 0.6094 ;
            var b:Number = i * 0.0820 ;
            
            matrix = concat
            ([
                r + s , g     , b     , 0 , 0 ,
                r     , g + s , b     , 0 , 0 ,
                r     , g     , b + s , 0 , 0 ,
                0     , 0     , 0     , 1 , 0
            ]) ;
        }
        
        /**
         * The matrix representation of all color components values.
         */
        public var matrix:Array ;
        
        /**
         * Returns the shallow copy of the object.
         * @return the shallow copy of the object.
         */
        public function clone():*
        {
            return new ColorMatrix( matrix );
        }
        
        /**
         * Concatenates the elements of a matrix specified in the parameter with the elements in an array and creates a new matrix
         * @param Array The altered Matrix
         */ 
        public function concat( mat:Array ):Array
        {
            var i:int ;
            var result:Array = [] ;
            for (var y:int ; y < 4 ; y++ )
            {
                for (var x:int ; x < 5 ; x++ )
                {
                    result[i + x] = mat[i]   * matrix[ x      ] + 
                                    mat[i+1] * matrix[ x +  5 ] + 
                                    mat[i+2] * matrix[ x + 10 ] + 
                                    mat[i+3] * matrix[ x + 15 ] +
                                    ( x == 4 ? mat[i+4] : 0 ) ;
                }
                i += 5 ;
            }
            return result;
        }
        
        /**
         * Reset and sets this colormatrix to identity:
         * <pre>
         * [ 
         *  1 , 0 , 0 , 0 , 0 ,
         *  0 , 1 , 0 , 0 , 0 ,
         *  0 , 0 , 1 , 0 , 0 ,
         *  0 , 0 , 0 , 1 , 0 
         * ];
         * </pre>
         */
        public function reset( init:Array = null ):void
        {
            if ( init == null )
            {
                init = IDENTITY ; 
            }
            matrix = init.concat() ;
        }
        
        /**
         * Sets the rotation on a color axis by the specified values. 
         * @param axis The axis (red, green or blue axis) to rotate.
         * @param degrees The angle in degree of the rotation.
         * <li>axis=0 correspond to a rotation around the RED color</li> 
         * <li>axis=1 correspond to a rotation around the GREEN color</li>
         * <li>axis=2 correspond to a rotation around the BLUE color</li>
         * @throws ArgumentError if the axis argument is not valid with the value 0, 1 or 2.
         */
        public function rotate( axis:int , degrees:Number ):void 
        {
            reset() ;
            var rad:Number = degrees * RAD ;
            var cos:Number = Math.cos( rad ) ;
            var sin:Number = Math.sin( rad ) ;
            switch (axis) 
            {
                case 0 :
                {
                    matrix[6]  = matrix[12] = cos ;
                    matrix[7]  = sin ;
                    matrix[11] = -sin;
                    break ;
                }
                case 1 :
                {
                    matrix[0]  = matrix[17] = cos;
                    matrix[2]  = sin;
                    matrix[15] = -sin;
                    break ;
                }
                case 2:
                {
                    matrix[0] = matrix[6] = cos;
                    matrix[1] = sin;
                    matrix[5] = -sin;
                    break;
                }
                default:
                {
                    throw new ArgumentError( "ColorMatrix.rotate failed, the axis argument is not valid with the value " + axis );
                }
            }
        }
        
        /**
         * Set this colormatrix to scale by the specified values.
         * @param r The scale value to change the red component of the color.
         * @param g The scale value to change the green component of the color.
         * @param b The scale value to change the blue component of the color.
         * @param a The scale value to change the alpha component of the color.
         */
        public function scale( r:Number, g:Number, b:Number, a:Number):void 
        {
            for ( var i:int = 19 ; i > 0 ; --i ) 
            {
                matrix[i] = 0 ;
            }
            matrix[0]  = r ;
            matrix[6]  = g ;
            matrix[12] = b ;
            matrix[18] = a ;
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource (indent:int = 0 ):String
        {
            return "new graphics.colors.ColorMatrix(" + dumpArray(matrix) + ")";
        }
        
        /**
         * Returns the String representation of the object.
         * @return the String representation of the object.
         */
        public function toString():String 
        {
            return "[ColorMatrix "+ matrix.join(",") + "]";
        }
        
        /**
         * Value to convert a degree value in radian (Math.PI / 180).
         */
        protected static const RAD:Number = Math.PI / 180 ;
    }
}
