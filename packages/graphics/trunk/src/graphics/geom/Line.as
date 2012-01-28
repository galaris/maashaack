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
    import core.reflect.getClassPath;
    import graphics.Geometry;

    /**
     * Defines a linear equation of the form : <code class="prettyprint"> ax + by = c</code> with fixed real coefficients a, b and c such that a and b are not both zero.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * var l:Line = new Line(10, 20, 5) ;
     * trace(l) ; // {a:10,b:20,c:5}
     * </pre>
     */
    public class Line implements Geometry
    {
        /**
         * Creates a new Line object.
         * @param a the a component of the Line.
         * @param b the b component of the Line.
         * @param c the c component of the Line.
         */
        public function Line( a:Number = 0 , b:Number = 0 , c:Number = 0 )
        {
            this.a = a ;
            this.b = b ;
            this.c = c ;
        }
        
        /**
         * Determinates the a component of the Line.
         */
        public var a:Number ;
        
        /**
         * Determinates the b component of the Line.
         */
        public var b:Number ;
        
        /**
         * Determinates the c component of the Line.
         */
        public var c:Number ;
        
        /**
         * Returns a shallow copy of this instance.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * var l1:Line = new Line(10, 20, 30) ;
         * var l2:Line = l1.clone() ;
         * </pre>
         * @return a shallow copy of this instance.
         */
        public function clone():*
        {
            return new Line(a, b, c) ;
        }
        
        /**
         * Compares the specified object with this object for equality.
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
         */
        public function equals( o:* ):Boolean
        {
            if ( o is Line )
            {
                return ( o as Line ).a == a && ( o as Line ).b == b && ( o as Line ).c == c ;
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
            return { a:a , b:b , c:c } ;
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource( indent:int = 0 ):String 
        {
            return "new " + getClassPath(this, true) + "(" + a.toString() + "," + b.toString() + "," + c.toString() + ")" ;
        }
        
        /**
         * Returns the string representation of the object.
          * @return the string representation of the object.
          */ 
        public function toString():String 
        {
            var s:String = "[Line a:" + (isNaN(a) ? 0 : a) + ", b:" + (isNaN(b) ? 0 : b) ;
            if (!isNaN(c))
            {
                s += ", c:" + (isNaN(c) ? 0 : c) ;
            }
            s +=  "]" ;
            return s ;
        }
    }
}

