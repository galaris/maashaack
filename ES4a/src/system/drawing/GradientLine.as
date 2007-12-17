
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
    import flash.display.Graphics;
    
    /* Class: Line
       Define a gradient Line Style structure to be used with flash.display.graphics.lineGradientStyle
    */
    public class GradientLine extends Line
        {
        
        public var gradient:Gradient;
        
        public function GradientLine( thickness:Number, gradient:Gradient,
                                      pixelHinting:Boolean = false,
                                      scaleMode:String = "normal", caps:String = null, joints:String = null,
                                      miterLimit:Number = 3 )
            {
            super( thickness, 0, 1.0, pixelHinting, scaleMode, caps, joints, miterLimit );
            this.gradient = gradient;
            }
        
        override public function isPlain():Boolean
            {
            return false;
            }
        
        override public function isGradient():Boolean
            {
            return true;
            }
        
        override public function applyTo( graphic:Graphics ):void
            {
            super.applyTo( graphic );
            /*graphic.lineStyle( thickness,
                               color,
                               alpha,
                               pixelHinting,
                               scaleMode,
                               caps,
                               joints,
                               miterLimit );*/
            
            graphic.lineGradientStyle( gradient.type,
                                       gradient.colors,
                                       gradient.alphas,
                                       gradient.ratios,
                                       gradient.matrix,
                                       gradient.spreadMethod,
                                       gradient.interpolationMethod,
                                       gradient.focalPointRatio );
            }
        
        }
    
    }
