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

package graphics.geom
{
    import core.reflect.getClassName;
    import core.reflect.getClassPath;
    import flash.geom.Rectangle;
    import graphics.Geometry;
    
    /**
     * The <code class="prettyprint">Dimension</code> class encapsulates the width and height of an object.
     */
    public class Dimension implements Geometry
    {
        /**
         * Creates a new <code class="prettyprint">Dimension</code> instance.
         */
        public function Dimension( ...arguments:Array )
        {
            this.width  = 0 ;
            this.height = 0 ;
            var size:int = arguments.length ;
            if ( size > 0 )
            {
                if ( ( size == 1 ) && ( arguments[0] is Dimension ) )
                {
                    var d:Dimension = arguments[0] as Dimension ;
                    this.width  = d.width  ;
                    this.height = d.height ;
                }
                else if ( ( size > 0 ) && (arguments[0] is Number) && (arguments[1] is Number) )
                {
                    this.width  = arguments[0] as Number ;
                    this.height = arguments[1] as Number ;
                }
            }
        }
        
        /**
         * Defines the Dimension object with the width and height properties set to zero.
         */
        public static var ZERO:Dimension = new Dimension() ;
        
        /**
         * Determinates the height value of this instance.
         */
        public function get height():Number
        {
            return _h ;
        }
        
        /**
         * @private
         */
        public function set height( n:Number ):void
        {
            _h = n ;
        }
        
        /**
         * Determinates the width value of this instance.
         */
        public function get width():Number
        {
            return _w ;
        }
        
        /**
         * @private
         */
        public function set width( n:Number ):void
        {
            _w = n ;
        }
        
        /**
         * Returns a shallow copy of this instance.
         * @return a shallow copy of this instance.
         */
        public function clone():*
        {
            return new Dimension(width, height) ;
        }
        
        /**
         * Decreases the size by s and return its self(this).
         * @param s an other Dimension reference to decreases the current Dimension.
         * @return the current reference of this object.
         */
        public function decreaseSize( s:Dimension ):Dimension
        {
            width  -= s.width ;
            height -= s.height ;
            return this ;
        }
        
        /**
         * Compares the specified object with this object for equality.
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
         */
        public function equals( o:* ):Boolean
        {
            if ( o is Dimension )
            {
                return (o as Dimension).width == width && (o as Dimension).height ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Returns a new bounds with this size with a pos.
         * @return a new bounds with this size with a pos.
         */
        public function getBounds(x:Number, y:Number):Rectangle
        {
            x = isNaN(x) ? 0 : x ;
            y = isNaN(y) ? 0 : y ;
            return new Rectangle(x, y, width, height) ;
        }
        
        /**
         * Increases the size by s and return its self(this).
         * @param s an other Dimension reference to increase the current Dimension.
         * @return the current reference of this object.
         */
        public function increaseSize( s:Dimension ):Dimension
        {
            width  += s.width  ;
            height += s.height ;
            return this ;
        }
        
        /**
         * Sets the size of this instance.
         */
        public function setSize( w:Number, h:Number ):void
        {
            width  = w ;
            height = h ;
        }
        
        /**
         * Returns the Object representation of this object.
          * @return the Object representation of this object.
         */
        public function toObject():Object 
        {
            return { width:width , height:height } ;
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource( indent:int = 0 ):String  
        {
            return "new " + getClassPath(this, true) + "(" + width.toString() + "," + height.toString() + ")" ;
        }
        
        /**
         * Returns the string representation of this instance.
         * @return the string representation of this instance.
         */
        public function toString():String 
        {
            return "[" + getClassName(this) + " width:" + width + " height:" + height + "]" ;
        }
        
        /**
         * @private
         */
        protected var _h:Number ;
        
        /**
         * @private
         */
        protected var _w:Number ;
    }
}