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

    /**
     * Plane representation is a two-dimensional doubly ruled surface in a 3D space. 
     * Used maily to represent the frustrum planes of the camera.
     */
    public class Plane implements Geometry
    {
        /**
         * Creates a new <code class="prettyprint">Plane</code> instance.
         * @param a the first plane coordinate.
         * @param b the second plane coordinate.
         * @param c the third plane coordinate.
         * @param d the forth plane coordinate.
          */ 
        public function Plane( a:Number=0 , b:Number=0 , c:Number=0 , d:Number=0 )
        {
            this.a = isNaN(a) ? 0 : a ;
            this.b = isNaN(a) ? 0 : b ;
            this.c = isNaN(a) ? 0 : c ;
            this.d = isNaN(a) ? 0 : d ;
        }
        
        /**
         * Defined the first plane coordinate.
         */
        public var a:Number ;
        
        /**
         * Defined the second plane coordinate.
         */
        public var b:Number ;
        
        /**
         * Defined the third plane coordinate.
         */
        public var c:Number ;
        
        /**
         * Defined the forth plane coordinate.
         */
        public var d:Number ;
        
        /**
         * Returns a shallow copy of this instance.
         * @return a shallow copy of this instance.
         */
        public function clone():*
        {
            return new Plane(a, b, c, d) ;
        }
        
        /**
         * Compares the specified object with this object for equality.
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
         */
        public function equals(o:*):Boolean
        {
            if ( o is Plane)
            {
                return (o.a == a) && (o.b == b) && (o.c == c) && (o.d == d) ;
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
            return { a:a, b:b, c:c, d:d } ;
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource( indent:int = 0 ):String  
        {
            return "new " + getClassPath(this, true) + "(" + a + "," + b + "," + c + "," + d + ")" ;
        }
        
        /**
         * Returns the string representation of the object.
         * @return the string representation of the object.
         */     
        public function toString():String
        {
            return "[" + getClassName(this) + ":{" + a + "," + b + "," + c + "," + d + "}]" ;
        }
    }
}
