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
    import graphics.Geometry;
    
    /**
     * This means half of a line, it is infinite in one direction, but ends at a certain point in the other direction.
     * In Euclidean geometry, a ray (or half-line) given two distinct points A (the origin) and B on the ray, is the set of points C on the line containing points A and B such that A is not strictly between C and B. 
     * In geometry, a ray starts at one point, then goes on forever in one direction : <code class="prettyprint">(A) -- (B) -- ((C)) -- ></code>
     */
    public class Ray implements Geometry
    {
        /**
         * Creates a new <code class="prettyprint">Ray</code> instance.
         * <p><b>Example :</b></p>
         * <p>With a Ray object passed in the argument of the constructor :</p>
         * <pre class="prettyprint">
         * var r:Ray = new Ray( r:Ray) ;
         * </pre>
         * <p>With 2 Vector3 objects passed in the arguments of the constuctor : </p>
         * <pre class="prettyprint">
         * var r:Ray = new Ray( r:Vector3 , p:Vector3 ) ;
         * </pre>
         */
        public function Ray( ...arguments:Array )
        {
            p = new Vector3() ;
            v = new Vector3() ;
            if ( arguments[0] is Ray )
            {
                var r:Ray = arguments[0] ;
                p = r.p ;
                v = r.v ;
            }
            else if ( arguments.length == 2)
            {
                if (arguments[0] is Vector3 )
                {
                    p = arguments[0].clone() ;
                }
                if (arguments[1] is Vector3 )
                {
                    v = arguments[1].clone() ;
                }
            }
            update() ;
        }
        
        /**
         * Determinates the p <code class="prettyprint">Vector3</code> of the Ray object.
         */
        public var p:Vector3 ;
        
        /**
         * Determinates the q <code class="prettyprint">Vector3</code> of the Ray object.
         */
        public var q:Vector3 ;
        
        /**
         * Determinates the v <code class="prettyprint">Vector3</code> of the Ray object.
         */    
        public var v:Vector3 ;
        
        /**
         * Returns a shallow copy of this instance.
         * @return a shallow copy of this instance.
         */
        public function clone():*
        {
            return new Ray( this ) ;
        }
        
        /**
         * Compares the specified object with this object for equality.
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
         */
        public function equals( o:* ):Boolean 
        {
            if (o is Ray)
            {
                return p.equals(o.p) && v.equals(o.v) && q.equals(o.q) ;  
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
        public function toSource( indent:int = 0 ):String 
        {
            return "new graphics.geom.Ray(" +  p.toSource()  + "," + v.toSource() + ")" ;
        }
        
        /**
         * Returns the string representation of the object.
         * @return the string representation of the object.
         */
        public function toString():String
        {
            return "[Ray:" + p + "+t*" + v + "]" ;
        }
        
        /**
         * Updates the Ray object.
         */
        public function update():void
        {
            if (q == null)
            {
                q = Vector3.add(p, v) ;
            }
            else
            {
                q.set( p ) ;
                q.add(v) ;
            }
        }
    }
}
