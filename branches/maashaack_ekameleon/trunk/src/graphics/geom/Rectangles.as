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

package graphics.geom 
{
    import flash.geom.Point;
    import flash.geom.Rectangle;
    
    /**
     * The <code class="prettyprint">Rectangle</code> class is used to create and modify Rectangle objects. 
     * <p>A Rectangle object is an area defined by its position, as indicated by its top-left corner point (x, y), and by its width and its height.</p>
     * <p>The x, y, width, and height properties of the Rectangle class are independent of each other; changing the value of one property has no effect on the others.</p>
     * <p>To used this class with a FP8 and > with flash.display.BitmapData class and other flash.* classes you can use the method toFlash() to return a compatible reference of this object.</p> 
     */
    public class Rectangles
    {
        /**
         * Compares its two arguments for order.
         * @param o1 the first Rectangle to compare.
         * @param o2 the second Rectangle to compare.
         * @return <p>
         * <li>-1 if o1 is "lower" than (less than, before, etc.) o2 ;</li>
         * <li> 1 if o1 is "higher" than (greater than, after, etc.) o2 ;</li>
         * <li> 0 if o1 and o2 are equal.</li>
         * </p>
         * @throws ClassCastError the arguments of the method must be Rectangle reference.
         */
        public static function compare( rectangle1:Rectangle , rectangle2:Rectangle ):int 
        {
            if ( rectangle1 == null || rectangle2 == null )
            {
                throw new TypeError( "Rectangle.compare failed, the arguments of the method must be Rectangle reference.") ;
            }
            
            var s1:Point = rectangle1.size ;
            var s2:Point = rectangle2.size ;
            var a1:Number  = s1.x * s1.y ;
            var a2:Number  = s2.x * s2.y ;
            if (a1 == a2) 
            {
                return 0 ;
            }
            else if(a1 > a2) 
            {
                return 1 ;
            }
            else 
            {
                return -1 ;
            }
        }
        
        /**
         * Compares the specified Rectangle objects for equality.
         * @return <code class="prettyprint">true</code> if the the specified Rectangle objects are equals.
         */
        public static function equals( rectangle1:Rectangle , rectangle2:Rectangle ):Boolean 
        {
            if ( rectangle1 && rectangle1 == rectangle2 )
            {
                return true ;
            }
            else if ( rectangle1 && rectangle2 ) 
            {
                return (rectangle1.x == rectangle2.x) && (rectangle1.y == rectangle2.y) && (rectangle1.width == rectangle2.width) && (rectangle1.height == rectangle2.height) ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Returns the location of the Rectangle object's bottom-left corner, determined by the values of the x and y properties.
         * @return the location of the Rectangle object's bottom-left corner, determined by the values of the x and y properties.
         */
        public static function getBottomLeft( rectangle:Rectangle ):Point 
        {
            return new Point( rectangle.x , rectangle.y + rectangle.height ) ;
        }
        
        /**
         * Returns the location of the Rectangle object's center, determined by the values of the x and y properties.
         * @return the location of the Rectangle object's center, determined by the values of the x and y properties.
          */
        public static function getCenter( rectangle:Rectangle ):Point 
        {
            return new Point( rectangle.x + (rectangle.width/2) , rectangle.y + (rectangle.height/2) ) ;
        }
        
        /**
         * Returns the location of the Rectangle object's top-right corner determined by the x and y values of the point.
         * @return the location of the Rectangle object's top-right corner determined by the x and y values of the point.
         */
        public static function getTopRight( rectangle:Rectangle ):Point 
        {
            return new Point( rectangle.x + rectangle.width , rectangle.y ) ;
        }
        
        /**
         * Sets the location of the Rectangle object's bottom-left corner, determined by the values of the x and y properties.
         */
        public static function setBottomLeft( rectangle:Rectangle , point:Point ):void 
        {
            rectangle.width  = rectangle.width + (rectangle.x - point.x) ;
            rectangle.height = point.y - rectangle.y ;
            rectangle.x      = point.x ;
        }
        
        /**
         * Sets the x and y coordinates of the top-left corner of the rectangle if the specified value in argument is the middle of the Rectangle.
         */
        public static function setCenter( rectangle:Rectangle , point:Point ):void 
        {
            rectangle.x = point.x - ( rectangle.width / 2 )  ;
            rectangle.y = point.y - ( rectangle.height / 2 ) ;
        }
        /**
         * Sets the location of the Rectangle object's top-right corner determined by the x and y values of the point.
         */
        public static function setTopRight( rectangle:Rectangle , point:Point ):void 
        {
            rectangle.width  = point.x - rectangle.x ;
            rectangle.height = rectangle.height + ( rectangle.y - point.y ) ;
            rectangle.y      = point.y ;
        }
        
        /**
         * Returns the Object representation of this object.
         * @return the Object representation of this object.
         */
        public static function toObject( rectangle:Rectangle ):Object 
        {
            return { x:rectangle.x , y:rectangle.y , width:rectangle.width , height:rectangle.height } ;
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public static function toSource( rectangle:Rectangle ):String 
        {
            return "new graphics.geom.Rectangle(" + rectangle.x + "," + rectangle.y + "," + rectangle.width + "," + rectangle.height + ")" ;
        }
    }
}
