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
    import system.eden;

    import flash.display.Graphics;

    /**
     * Defines the line style of the vector shapes. See the flash.display.graphics.lineStyle method.
     */
    public class LineStyle implements ILineStyle
    {
        /**
         * Creates a new LineStyle instance.
         * @param thickness An integer that indicates the thickness of the line in points; valid values are 0 to 255. If a number is not specified, or if the parameter is NaN, a line is not drawn. If a value of less than 0 is passed, the default is 0. The value 0 indicates hairline thickness; the maximum thickness is 255. If a value greater than 255 is passed, the default is 255.
         * @param color (default = 0) A hexadecimal color value of the line; for example, red is 0xFF0000, blue is 0x0000FF, and so on. If a value is not indicated, the default is 0x000000 (black). Optional. 
         * @param alpha (default = 1.0) A number that indicates the alpha value of the color of the line; valid values are 0 to 1. If a value is not indicated, the default is 1 (solid). If the value is less than 0, the default is 0. If the value is greater than 1, the default is 1. 
         * @param pixelHinting (default = false) A Boolean value that specifies whether to hint strokes to full pixels. This affects both the position of anchors of a curve and the line stroke size itself. With pixelHinting set to true, Flash Player hints line widths to full pixel widths. With pixelHinting set to false, disjoints can appear for curves and straight lines. 
         * @param scaleMode (default = "normal")  A value from the LineScaleMode class that specifies which scale mode to use :
         * <li>LineScaleMode.NORMAL—Always scale the line thickness when the object is scaled (the default).</li>
         * <li>LineScaleMode.NONE—Never scale the line thickness.</li>
         * <li>LineScaleMode.VERTICAL—Do not scale the line thickness if the object is scaled vertically only.</li>
         * @param caps (default = null) — A value from the CapsStyle class that specifies the type of caps at the end of lines. Valid values are: CapsStyle.NONE, CapsStyle.ROUND, and CapsStyle.SQUARE. If a value is not indicated, Flash uses round caps. 
         * @param joints (default = null) — A value from the JointStyle class that specifies the type of joint appearance used at angles. Valid values are: JointStyle.BEVEL, JointStyle.MITER, and JointStyle.ROUND. If a value is not indicated, Flash uses round joints. 
         * @param miterLimit (default = 3) — A number that indicates the limit at which a miter is cut off. Valid values range from 1 to 255 (and values outside of that range are rounded to 1 or 255). This value is only used if the jointStyle is set to "miter". The miterLimit value represents the length that a miter can extend beyond the point at which the lines meet to form a joint. The value expresses a factor of the line thickness. For example, with a miterLimit factor of 2.5 and a thickness of 10 pixels, the miter is cut off at 25 pixels. 
         */
        public function LineStyle( thickness:Number = NaN , color:uint = 0, alpha:Number = 1.0, pixelHinting:Boolean = false, scaleMode:String = "normal", caps:String = null, joints:String = null, miterLimit:Number = 3 )
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
        
        /**
         * The empty LineStyle singleton.
         */
        public static const EMPTY:LineStyle = new LineStyle() ;
        
        /**
         * A number that indicates the alpha value of the color of the line; valid values are 0 to 1. 
         * If a value is not indicated, the default is 1 (solid). If the value is less than 0, the default is 0. If the value is greater than 1, the default is 1. 
         */
        public var alpha:Number;
        
        /**
         * A value from the CapsStyle class that specifies the type of caps at the end of lines. 
         * Valid values are : CapsStyle.NONE, CapsStyle.ROUND, and CapsStyle.SQUARE. 
         * If a value is not indicated, Flash uses round caps.
         */
        public var caps:String;
        
        /**
         * A hexadecimal color value of the line; for example, red is 0xFF0000, blue is 0x0000FF, and so on. 
         * If a value is not indicated, the default is 0x000000 (black).
         */
        public var color:uint;
        
        /**
         * A value from the JointStyle class that specifies the type of joint appearance used at angles. 
         * Valid values are: JointStyle.BEVEL, JointStyle.MITER, and JointStyle.ROUND. If a value is not indicated, Flash uses round joints.
         */
        public var joints:String;
        
        /**
         * A number that indicates the limit at which a miter is cut off. 
         * Valid values range from 1 to 255 (and values outside of that range are rounded to 1 or 255). 
         * This value is only used if the jointStyle is set to "miter". 
         * The miterLimit value represents the length that a miter can extend beyond the point at which the lines meet to form a joint. The value expresses a factor of the line thickness. 
         * For example, with a miterLimit factor of 2.5 and a thickness of 10 pixels, the miter is cut off at 25 pixels.
         */
        public var miterLimit:Number;
        
        /**
         * A Boolean value that specifies whether to hint strokes to full pixels. 
         * This affects both the position of anchors of a curve and the line stroke size itself. 
         * With pixelHinting set to true, Flash Player hints line widths to full pixel widths. 
         * With pixelHinting set to false, disjoints can appear for curves and straight lines. 
         */
        public var pixelHinting:Boolean;
        
        /**
         *  A value from the LineScaleMode class that specifies which scale mode to use :
         * <li>LineScaleMode.NORMAL—Always scale the line thickness when the object is scaled (the default).</li>
         * <li>LineScaleMode.NONE—Never scale the line thickness.</li>
         */
        public var scaleMode:String;
        
        /**
         * An integer that indicates the thickness of the line in points ; valid values are 0 to 255. 
         * If a number is not specified, or if the parameter is undefined, a line is not drawn.
         * If a value of less than 0 is passed, the default is 0. 
         * The value 0 indicates hairline thickness ; the maximum thickness is 255. 
         * If a value greater than 255 is passed, the default is 255.
         */
        public var thickness:Number;
        
        /**
         * Initialize the line settings of the specified Graphics reference.
         */
        public function apply( graphic:Graphics ):void
        {
            graphic.lineStyle( thickness, color, alpha, pixelHinting, scaleMode, caps, joints, miterLimit ) ;
        }
       
        /**
         * Creates and returns a shallow copy of the object.
         * @return A new object that is a shallow copy of this instance.
         */
        public function clone():* 
        {
            return new LineStyle( thickness, color, alpha, pixelHinting, scaleMode, caps, joints, miterLimit ) ;
        }
        
        /**
         * Compares the specified object with this object for equality.
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
         */
        public function equals( o:* ):Boolean
        {
            var s:LineStyle = o as LineStyle ;
            if ( s )
            {
                return isNaN(thickness) ? isNaN(s.thickness) : ( thickness == s.thickness ) 
                    && color        == s.color
                    && alpha        == s.alpha
                    && pixelHinting == s.pixelHinting
                    && scaleMode    == s.scaleMode
                    && caps         == s.caps
                    && joints       == s.joints
                    && miterLimit   == s.miterLimit ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource(indent:int = 0):String
        {
            var source:String = "new graphics.LineStyle("
                              + eden.serialize( thickness )    + "," 
                              + eden.serialize( color )        + "," 
                              + eden.serialize( alpha )        + "," 
                              + eden.serialize( pixelHinting ) + "," 
                              + eden.serialize( scaleMode )    + "," 
                              + eden.serialize( caps )         + ","
                              + eden.serialize( joints )       + ","
                              + eden.serialize( miterLimit )   
                              + ")" ;
            return source ;
        }
    }
}
