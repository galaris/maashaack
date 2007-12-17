
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
       Define a plain Line Style structure to be used with flash.display.graphics.lineStyle
    */
    public class Line implements ILine
        {
        
        public var thickness:Number;
        public var color:uint;
        public var alpha:Number;
        public var pixelHinting:Boolean;
        public var scaleMode:String;
        public var caps:String;
        public var joints:String;
        public var miterLimit:Number;
        
        public function Line( thickness:Number,
                              color:uint = 0, alpha:Number = 1.0, pixelHinting:Boolean = false,
                              scaleMode:String = "normal", caps:String = null, joints:String = null,
                              miterLimit:Number = 3 )
            {
            this.thickness    = thickness;
            this.color        = color;
            this.alpha        = alpha;
            this.pixelHinting = pixelHinting;
            this.scaleMode    = scaleMode;
            this.caps         = caps;
            this.joints       = joints;
            this.miterLimit   = miterLimit;
            }
        
        public function isPlain():Boolean
            {
            return true;
            }
        
        public function isGradient():Boolean
            {
            return false;
            }
        
        public function applyTo( graphic:Graphics ):void
            {
            graphic.lineStyle( thickness,
                               color,
                               alpha,
                               pixelHinting,
                               scaleMode,
                               caps,
                               joints,
                               miterLimit );
            }
        
        public function toString():String
            {
            return "Line{ thickness:"+thickness+", color:"+color.toString(16)+" }";
            }
        
        }
    
    }
