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
    import core.reflect.getClassName;
    import core.reflect.getClassPath;
    import graphics.Geometry;
    
    /**
     * The EdgeMetrics class specifies the thickness, in pixels, of the four edge regions around a visual component.
     */
    public class EdgeMetrics implements Geometry
    {
        /**
         * Creates a new EdgeMetrics instance.
         * @param left The width, in pixels, of the left edge region.
         * @param top The height, in pixels, of the top edge region.
         * @param right The width, in pixels, of the right edge region.
         * @param bottom The height, in pixels, of the bottom edge region.
         */
        public function EdgeMetrics( left:Number = 0, top:Number = 0, right:Number = 0, bottom:Number = 0 )
        {
            this.bottom = bottom ;
            this.left   = left ;
            this.right  = right ;
            this.top    = top ;
        }
        
        /**
         * An EdgeMetrics object with a value of zero for its
         * <code class="prettyprint">left</code>, <code class="prettyprint">top</code>, <code class="prettyprint">right</code>,
         * and <code class="prettyprint">bottom</code> properties.
         */
        public static const EMPTY:EdgeMetrics = new EdgeMetrics( 0 , 0 , 0 , 0 ) ;
        
        /**
         * The height, in pixels, of the bottom edge region.
         */
        public var bottom:Number ;
        
        /**
         * The horizontal, in pixels, of the sum of left and right region.
         */
        public function get horizontal():int
        {
            return left + right;
        }
        
        /**
         *  The width, in pixels, of the left edge region.
         */
        public var left:Number ;
        
        /**
         *  The width, in pixels, of the right edge region.
         */
        public var right:Number ;
        
        /**
         *  The height, in pixels, of the top edge region.
         */
        public var top:Number ;
        
        /**
         * The vertical, in pixels, of the sum of top and vertical region.
         */
        public function get vertical():int
        {
            return top + bottom ;
        }
        
        /**
         * Returns a shallow copy of this instance.
         * @return a shallow copy of this instance.
         */
        public function clone():*
        {
            return new EdgeMetrics( left , top , right , bottom ) ;
        }
        
        /**
         * Compares the specified object with this object for equality.
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
         */
        public function equals( o:* ):Boolean
        {
            if ( o is EdgeMetrics )
            {
                return o.top == top && o.left == left && o.right == right && o.bottom == bottom ;
            }
            else 
            {
                return false ;
            }
        }
        
        /**
         * Returns the Object representation of this object.
         * @return the Object representation of this object.
         */
        public function toObject():Object 
        {
            return { left:left  , top:top , right:right , bottom:bottom } ;
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource( indent:int = 0 ):String 
        {
            return "new " + getClassPath(this, true) + "(" + left.toString() + "," + top.toString() + "," + right.toString() + "," + bottom.toString() + ")" ;
        }
        
        /**
         * Returns the string representation of the object.
         * @return the string representation of the object.
         */     
        public function toString():String
        {
            return "[" + getClassName(this) + " left:" + left + " top:" + top + " right:" + right + " bottom:" + bottom + "]" ;
        }
    }
}
