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
    import core.dump;
    import core.reflect.getClassPath;
    
    import flash.geom.Matrix;
    
    /**
     * Defines the basic core style to defines the LineGradientStyle and the fillGradientStyle class.
     */
    public class GradientStyle
    {
        /**
         * Creates a new GradientStyle instance.
         * @param type A value from the GradientType class that specifies which gradient type to use : GradientType.LINEAR or GradientType.RADIAL.
         * @param colors An array of RGB hexadecimal color values to be used in the gradient; for example, red is 0xFF0000, blue is 0x0000FF, and so on. You can specify up to 15 colors. For each color, be sure you specify a corresponding value in the alphas and ratios parameters.
         * @param alphas An array of alpha values for the corresponding colors in the colors array; valid values are 0 to 1. If the value is less than 0, the default is 0. If the value is greater than 1, the default is 1.
         * @param ratios An array of color distribution ratios; valid values are 0 to 255. This value defines the percentage of the width where the color is sampled at 100%. The value 0 represents the left-hand position in the gradient box, and 255 represents the right-hand position in the gradient box.
         * @param matrix A transformation matrix as defined by the flash.geom.Matrix class. The flash.geom.Matrix class includes a createGradientBox() method, which lets you conveniently set up the matrix for use with the beginGradientFill() method.
         * @param spreadMethod A value from the SpreadMethod class that specifies which spread method to use, either: SpreadMethod.PAD, SpreadMethod.REFLECT, or SpreadMethod.REPEAT.
         * @param interpolationMethod A value from the InterpolationMethod class that specifies which value to use: InterpolationMethod.linearRGB or InterpolationMethod.RGB.
         * @param focalPointRatio A number that controls the location of the focal point of the gradient. 0 means that the focal point is in the center. 1 means that the focal point is at one border of the gradient circle. -1 means that the focal point is at the other border of the gradient circle. A value less than -1 or greater than 1 is rounded to -1 or 1.
         */
        public function GradientStyle( type:String = null , colors:Array = null , alphas:Array = null , ratios:Array = null , matrix:Matrix = null, spreadMethod:String = "pad", interpolationMethod:String = "rgb", focalPointRatio:Number = 0 )
        {
            this.alphas              = alphas ;
            this.colors              = colors ;
            this.focalPointRatio     = focalPointRatio ;
            this.interpolationMethod = interpolationMethod ;
            this.matrix              = matrix ;
            this.ratios              = ratios ;
            this.spreadMethod        = spreadMethod ;
            this.type                = type   ;
        }
        
        /**
         * An array of alpha values for the corresponding colors in the colors array; valid values are 0 to 1. 
         * If the value is less than 0, the default is 0. 
         * If the value is greater than 1, the default is 1.
         */
        public var alphas:Array;
        
        /**
         * An array of RGB hexadecimal color values to be used in the gradient ; 
         * for example, red is 0xFF0000, blue is 0x0000FF, and so on. You can specify up to 15 colors. 
         * For each color, be sure you specify a corresponding value in the alphas and ratios parameters.
         */
        public var colors:Array;
        
        /**
         * A number that controls the location of the focal point of the gradient. 
         * 0 means that the focal point is in the center. 
         * 1 means that the focal point is at one border of the gradient circle. 
         * -1 means that the focal point is at the other border of the gradient circle. 
         * A value less than -1 or greater than 1 is rounded to -1 or 1.
         */
        public var focalPointRatio:Number ;
        
        /**
         * A value from the InterpolationMethod class that specifies which value to use : InterpolationMethod.linearRGB or InterpolationMethod.RGB
         */
        public var interpolationMethod:String ;
        
        /**
         * A transformation matrix as defined by the flash.geom.Matrix class. The flash.geom.Matrix class includes a createGradientBox() method, which lets you conveniently set up the matrix for use with the beginGradientFill() method.
         */
        public var matrix:Matrix ;
        
        /**
         * An array of color distribution ratios; valid values are 0 to 255. 
         * This value defines the percentage of the width where the color is sampled at 100%. 
         * The value 0 represents the left-hand position in the gradient box, and 255 represents the right-hand position in the gradient box.
         */
        public var ratios:Array ;
        
        /**
         * A value from the SpreadMethod class that specifies which spread method to use, either: SpreadMethod.PAD, SpreadMethod.REFLECT, or SpreadMethod.REPEAT.
         */
        public var spreadMethod:String ;
        
        /**
         * A value from the GradientType class that specifies which gradient type to use : GradientType.LINEAR or GradientType.RADIAL.
         */
        public var type:String ;
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource(indent:int = 0):String
        {
            var m:String = (matrix == null) ? "null" : "new flash.geom.Matrix("
                           + String( matrix.a )  + "," 
                           + String( matrix.b )  + "," 
                           + String( matrix.c )  + "," 
                           + String( matrix.d )  + "," 
                           + String( matrix.tx ) + ","
                           + String( matrix.ty ) 
                           + ")" ;
            var source:String = "new " + getClassPath(this,true) + "("
                              + dump( type )   + "," 
                              + dump( colors ) + "," 
                              + dump( alphas ) + "," 
                              + dump( ratios ) + "," 
                              + m + ","
                              + dump( spreadMethod ) + ","
                              + dump( interpolationMethod ) + ","
                              + dump( focalPointRatio )
                              + ")" ;
            return source ;
        }
    }
}
