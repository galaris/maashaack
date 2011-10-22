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
    import core.maths.clamp;
    import graphics.Geometry;

    /**
     * Matrix with 4 rows and 4 columns.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import graphics.geom.Matrix2 ;
     * var m:Matrix2 = new Matrix2() ;
     * // 1 0
     * // 0 1
     * </pre>
     */
    public class Matrix2 implements Geometry 
    {
        /**
         * Creates a new <code class="prettyprint">Matrix2</code> instance.
         */
        public function Matrix2( ...arguments:Array )
        {
            if (arguments.length == 4)
            {
                n11 = arguments[0] as Number ; n12 = arguments[1] as Number ; 
                n21 = arguments[2] as Number ; n22 = arguments[3] as Number ; 
            }
            else if ( arguments.length == 2 && arguments[0] is Vector2 && arguments[1] is Vector2 )
            {
                setByVector( arguments[0] as Vector2 , arguments[1] as Vector2 ) ;
            }
            else if ( arguments[0] is Matrix2 )
            {
                setByMatrix( arguments[0] as Matrix2 ) ;
            }
            else if ( arguments[0] is Number )
            {
                setByAngle( arguments[0] as Number ) ;
            }
            else
            {
                identity() ;
            }
        }
        
        /**
         * Indicates the angle value of the specified Matrix2 object.
         */
        public function angle():Number
        {
            return Math.atan2( n21 ,n11 ) ;
        }
        
        /**
         * Defines a <code class="prettyprint">Matrix2</code> cell.
         * <pre class="prettyprint">
         * 1 0
         * 0 0
         * </pre>
         */
        public var n11:Number;
        
        /**
         * Defines a <code class="prettyprint">Matrix2</code> cell.
         * <pre class="prettyprint">
         * 0 1
         * 0 0
         * </pre>
         */
        public var n12:Number;
        
        /**
         * Defines a <code class="prettyprint">Matrix2</code> cell.
         * <pre class="prettyprint">
         * 0 0
         * 1 0
         * </pre>
         */
        public var n21:Number;
        
        /**
         * Defines a <code class="prettyprint">Matrix2</code> cell.
         * <pre class="prettyprint">
         * 0 0
         * 0 1
         * </pre>
         */
        public var n22:Number;
        
        /**
         * Returns a shallow copy of this instance.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Matrix2 ;
         * 
         * var m:Matrix2 = new Matrix2( 1, 2, 3, 4 ) ;
         * trace( m + " clone() : " + m.clone() ) ;
         * </pre>
         * @return a shallow copy of this instance.
         */
        public function clone():*
        {
            return new Matrix2( this ) ;
        }
        
        /**
         * Compares the specified object with this object for equality.
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
         */
        public function equals( o:* ):Boolean
        {
            if (o is Matrix2)
            {
                var m:Matrix2 = o as Matrix2 ;
                return m.n11 == n11 && m.n12 == n12 && m.n21 == n21 && m.n22 == n22 ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Returns the matrix[x][y] value.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Matrix2 ;
         * var m:Matrix2 = new Matrix2( 1, 2, 3, 4 ) ;
         * trace( m + " getEntry(1,0) : " + m.getEntry(1,0) ) ; // [Matrix2:[1,2],[3,4]] getEntry(1,0) : 3
         * </pre>
         * @return the matrix[x][y] value.
         */
        public function getEntry( x:Number, y:Number ):*
        {
            var m:Array = toArray() ;
            return m[x][y] ;
        }
        
        /**
         * Creates and returns a new Matrix2 with all this elements are 0.
         * <p><b>Example :</b></p>
         * <code class="prettyprint">
         * import graphics.geom.Matrix2 ;
         * var m:Matrix2 = Matrix2.getZero() ;
         * // 0 0
         * // 0 0
         * </code>
         * @return a new zero Matrix4 object.
         */
        public static function getZero():Matrix2
        {
            return new Matrix2(0,0,0,0) ;
        }
        
        /**
         * Transforms the matrix in this identity representation.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Matrix2 ;
         * var m:Matrix2 = new Matrix2( 1, 2, 3, 4 ) ;
         * m.identity() ;
         * trace( m + " identity : " + m ) ;
         * </pre>
         */
        public function identity():void
        {
            n11 = 1 ; n12 = 0 ; 
            n21 = 0 ; n22 = 1 ; 
        }
        
        /**
         * Creates and returns a new identity Matrix2.
         * <p><b>Example :</b></p>
         * <code class="prettyprint">
         * import graphics.geom.Matrix2 ;
         * var m:Matrix2 = Matrix2.identity() ;
         * // 1 0
         * // 0 1
         * </code>
         * @return a new identity Matrix2 object.
         */
        public static function identity():Matrix2
        {
            return new Matrix2(1,0,0,1) ;
        }
        
        /**
         * Invert the Matrix2 object.
         * @param out The optional Matrix2 reference to return. If this argument is null a new identity Matrix is created.
         */
        public function invert( out:Matrix2 = null ):Matrix2
        {
            if ( out == null )
            {
                out = Matrix2.identity() ;
            }
            var a:Number = n11 ;
            var b:Number = n21 ;
            var c:Number = n12 ;
            var d:Number = n22 ;
            var det:Number = a * d - b * c ;
            det = 1 / det ;
            out.n11 =  det * d ;
            out.n21 = -det * b ;
            out.n12 = -det * c ;
            out.n22 =  det * a ;
            return out;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the Matrix2 is the identity.
         * <p><b>Example :</b></p>
         * <code class="prettyprint">
         * import graphics.geom.Matrix2 ;
         * 
         * var m:Matrix2 ;
         * 
         * m = new Matrix2() ;
         * trace( m.isIdentify() ) ; // true
         * 
         * m = new Matrix2(1,2,3,4) ;
         * trace( m.isIdentify() ) ; // false
         * </code>
         * @return <code class="prettyprint">true</code> if the Matrix2 is the identity.
         */
        public function isIdentity():Boolean
        {
            var a:Array = toArray() ;
            for( var i:int = 0 ; i < 2 ; i++ )
            {
                for( var j:int = 0; j < 2 ; j++ )
                {
                    if( i == j ) 
                    {
                        if( a[i][j] != 1 )
                        {
                            return false ;
                        }
                    }
                    else 
                    {
                        if( a[i][j] != 0 ) 
                        {
                            return false ;
                        }
                    }
                }
            }
            return true ;
        }
        
        /**
         * Sets the specified matrix with the passed-in angle value.
         */
        public function setByAngle( angle:Number):void
        {
            var c:Number = Math.cos(angle);
            var s:Number = Math.sin(angle);
            n11 = c ; n12 = -s ;
            n21 = s ; n22 = c  ;
        }
        
        /**
         * Sets the specified matrix with the Matrix2 reference passed in argument.
         * @param matrix The matrix to fill the current matrix.
         */
        public function setByMatrix( matrix:Matrix2 ):void
        {
            n11 = matrix.n11 ; n12 = matrix.n12 ;
            n21 = matrix.n21 ; n22 = matrix.n22 ;
        }
        
        /**
         * Sets the specified matrix with the two passed-in Vector2 objects. 
         * The first vector is the first column of the matrix and the second the other.
         */
        public function setByVector( v1:Vector2 , v2:Vector2 ):void
        {
            n11 = v1.x ; n12 = v2.x ;
            n21 = v1.y ; n22 = v2.y ;
        }
        
        /**
         * Sets matrix[x][y] with the specified value.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Matrix2 ;
         * var m:Matrix2 = new Matrix2( 1, 2, 3, 4 ) ;
         * m.setEntry( 1 , 0 , 5 ) ; // [Matrix2:[1,2],[5,4]]
         * trace( m ) ;
         * </pre>
         */
        public function setEntry( x:Number , y:Number , value:* ):void
        {
            x = clamp(x, 0, 1) ;
            y = clamp(y, 0, 1) ;
            if ( x == 0 )
            {
                if ( y == 0 )
                {
                    n11 = value ;
                }
                else if ( y == 1 )
                {
                    n21 = value ;
                }
            }
            else if ( x == 1 ) 
            {
                if ( y == 0 )
                {
                    n21 = value ;
                }
                else if ( y == 1 )
                {
                    n22 = value ;
                }
            }
        }
        
        /**
         * Returns the Array representation of this instance.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Matrix2 ;
         * var m:Matrix2 = new Matrix2( 1, 2, 3, 4 ) ;
         * var a:Array = m.toArray() ;
         * trace( m + " toArray() : [" + a.join(",") + "]" ) ;
         * </pre>
         * @return the Array representation of this instance.
         */
        public function toArray():Array
        {
            var m:Array = 
            [
                [n11, n12] ,
                [n21, n22] 
            ] ;
            return m ;
        }
        
        /**
         * Returns the Object representation of this object.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import core.dump ;
         * import graphics.geom.Matrix2 ;
         * var m:Matrix2 = new Matrix2( 1, 2, 3, 4 ) ;
         * var o:Object = m.toObject() ;
         * trace( m + " toObject() : " + dump(o) ) ;
         * </pre>
         * @return the Object representation of this object.
         */
        public function toObject():Object 
        {
            var o:Object = {} ;
            o.n11 = this.n11 ; o.n12 = this.n12 ;
            o.n21 = this.n21 ; o.n22 = this.n22 ;
            return o ;
        }
        
        /**
         * Returns the source code string representation of the object.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Matrix2 ;
         * var m:Matrix2 = new Matrix2( 1, 2, 3, 4 ) ;
         * trace( m + " toSource() : " + m.toSource() ) ; // new graphics.geom.Matrix2(1,2,3,4)
         * </pre>
         * @return the source code string representation of the object.
         */
        public function toSource( indent:int = 0 ):String 
        {
            return "new graphics.geom.Matrix2(" + n11 + "," + n12 + "," + n21 + "," + n22 + ")"  ;
        }
        
        /**
         * Returns the string representation of the object.
         * @return the string representation of the object.
         */     
        public function toString():String
        {
            var s:String = "[Matrix2:" ;
            s += "[" + n11 + "," + n12 + "]" ;
            s += "," ;
            s += "[" + n21 + "," + n22 + "]" ;
            s += "]" ;
            return s ;
        }
    }
}
