
/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [ES4a: ECMAScript 4 MaasHaack framework].
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
*/

package system.drawing
    {
    import flash.display.InterpolationMethod;
    import flash.display.SpreadMethod;
    import flash.geom.Matrix;
    
    public class Gradient
        {
        
        public var type:String;
        public var colors:Array;
        public var alphas:Array;
        public var ratios:Array;
        public var matrix:Matrix;
        public var spreadMethod:String;
        public var interpolationMethod:String;
        public var focalPointRatio:Number;        
        
        public function Gradient( type:String, colors:Array, alphas:Array, ratios:Array,
                                  matrix:Matrix = null,
                                  spreadMethod:String = "PAD"/*SpreadMethod.PAD*/,
                                  interpolationMethod:String = "RGB" /*InterpolationMethod.RGB*/,
                                  focalPointRatio:Number = 0 )
            {
            
            this.type                = type;
            this.colors              = colors;
            this.alphas              = alphas;
            this.ratios              = ratios;
            this.matrix              = matrix;
            this.spreadMethod        = spreadMethod;
            this.interpolationMethod = interpolationMethod;
            this.focalPointRatio     = focalPointRatio;
            
            }
        
        }
    
    }
