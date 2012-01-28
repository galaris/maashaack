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
    import core.dump;
    import core.maths.clamp;
    import core.reflect.getClassName;
    import core.reflect.getClassPath;
    import graphics.Geometry;

    /**
     * Matrix with 4 rows and 4 columns.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import graphics.geom.Matrix4 ;
     * var m:Matrix4 = new Matrix4() ;
     * // 1 0 0 0
     * // 0 1 0 0
     * // 0 0 1 0
     * // 0 0 0 1
     * </pre>
     */
    public class Matrix4 implements Geometry 
    {
        /**
         * Creates a new <code class="prettyprint">Matrix4</code> instance.
         * <p>If 16 arguments are passed to the constructor, it will create a <code class="prettyprint">Matrix4</code> with the values.</p> 
         * <p>In the other case, a identity <code class="prettyprint">Matrix4</code> is created.</p>
         * <p><b>Example 1 - <code class="prettyprint">Matrix4</code> identity :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Matrix4 ;
         * var m:Matrix4 = new Matrix4() ;
         * // 1 0 0 0
         * // 0 1 0 0
         * // 0 0 1 0
         * // 0 0 0 1
         * </pre>
         * <p><b>Example 2 - <code class="prettyprint">Matrix4</code> with 16 arguments :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.Matrix4 ;
         * var m:Matrix4 = new Matrix4(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16) ;
         * //  1  2  3  4
         * //  5  6  7  8
         * //  9 10 11 12
         * // 13 14 15 16
         * </pre>
         */
        public function Matrix4( ...arguments:Array )
        {
            if (arguments.length == 16)
            {
                _fill( arguments[0] ) ;
            }
            else if ( arguments.length == 1 )
            {
                if ( arguments[0] is Array )
                {
                    _fill(arguments[0] as Array) ;
                }
                else if ( arguments[0] is Matrix4)
                {
                    Matrixs4.setByMatrix(this, arguments[0] as Matrix4) ;
                }
                else if (arguments[0] is Quaternion)
                {
                    Matrixs4.setByQuaternion(arguments[0] as Quaternion , this) ;
                }
            }
            else
            {
                identity() ;
            }
        }
        
        /**
         * Defines a <code class="prettyprint">Matrix4</code> cell.
         * <pre class="prettyprint">
         * 1 0 0 0
         * 0 0 0 0
         * 0 0 0 0
         * 0 0 0 0 
         * </pre>
         */
        public var n11:Number;
        
        /**
         * Defines a <code class="prettyprint">Matrix4</code> cell.
         * <pre class="prettyprint">
         * 0 1 0 0
         * 0 0 0 0
         * 0 0 0 0
         * 0 0 0 0
         * </pre> 
         */
        public var n12:Number;
        
        /**
         * Defines a <code class="prettyprint">Matrix4</code> cell.
         * <pre class="prettyprint">
         * 0 0 1 0
         * 0 0 0 0
         * 0 0 0 0
         * 0 0 0 0
         * </pre>
         */
        public var n13:Number;
            
        /**
         * Defines a <code class="prettyprint">Matrix4</code> cell.
         * <pre class="prettyprint">
         * 0 0 0 1
         * 0 0 0 0
         * 0 0 0 0
         * 0 0 0 0
         * </pre> 
         */
        public var n14:Number;
        
        /**
         * Defines a <code class="prettyprint">Matrix4</code> cell.
         * <pre class="prettyprint">
         * 0 0 0 0
         * 1 0 0 0
         * 0 0 0 0
         * 0 0 0 0
         * </pre> 
         */
        public var n21:Number;
        
        /**
         * Defines a <code class="prettyprint">Matrix4</code> cell.
         * <pre class="prettyprint">
         * 0 0 0 0
         * 0 1 0 0
         * 0 0 0 0
         * 0 0 0 0
         * </pre> 
         */
        public var n22:Number;
            
        /**
         * Defines a <code class="prettyprint">Matrix4</code> cell.
         * <pre class="prettyprint">
         * 0 0 0 0
         * 0 0 1 0
         * 0 0 0 0
         * 0 0 0 0
         * </pre> 
         */
        public var n23:Number;
        
        /**
         * Defines a <code class="prettyprint">Matrix4</code> cell.
         * <pre class="prettyprint">
         * 0 0 0 0
         * 0 0 0 1
         * 0 0 0 0
         * 0 0 0 0
         * </pre> 
         */
        public var n24:Number;
        
        /**
         * Defines a <code class="prettyprint">Matrix4</code> cell.
         * <pre class="prettyprint">
         * 0 0 0 0
         * 0 0 0 0
         * 1 0 0 0
         * 0 0 0 0
         * </pre> 
         */
        public var n31:Number;
        
        /**
         * Defines a <code class="prettyprint">Matrix4</code> cell.
         * <pre class="prettyprint">
         * 0 0 0 0
         * 0 0 0 0
         * 0 1 0 0
         * 0 0 0 0
         * </pre> 
         */
        public var n32:Number;
        
        /**
         * Defines a <code class="prettyprint">Matrix4</code> cell.
         * <pre class="prettyprint">
         * 0 0 0 0
         * 0 0 0 0
         * 0 0 1 0
         * 0 0 0 0
         * </pre> 
         */
        public var n33:Number;
        
        /**
         * Defines a <code class="prettyprint">Matrix4</code> cell.
         * <pre class="prettyprint">
         * 0 0 0 0
         * 0 0 0 0
         * 0 0 0 1
           * 0 0 0 0
         * </pre> 
          */
        public var n34:Number;
            
        /**
         * Defines a <code class="prettyprint">Matrix4</code> cell.
         * <pre class="prettyprint">
         * 0 0 0 0
         * 0 0 0 0
         * 0 0 0 0
         * 1 0 0 0
         * </pre> 
         */
        public var n41:Number;
            
        /**
         * Defines a <code class="prettyprint">Matrix4</code> cell.
         * <pre class="prettyprint">
         * 0 0 0 0
         * 0 0 0 0
         * 0 0 0 0
         * 0 1 0 0
         * </pre> 
         */
        public var n42:Number;
        
        /**
         * Defines a <code class="prettyprint">Matrix4</code> cell.
         * <pre class="prettyprint">
         * 0 0 0 0
         * 0 0 0 0
         * 0 0 0 0
         * 0 0 1 0
         * </pre> 
         */
        public var n43:Number;
            
        /**
         * Defines a <code class="prettyprint">Matrix4</code> cell.
         * <pre class="prettyprint">
         * 0 0 0 0
         * 0 0 0 0
         * 0 0 0 0
         * 0 0 0 1
         * </pre> 
         */
        public var n44:Number;
        
        /**
         * Returns a shallow copy of this instance.
         * @return a shallow copy of this instance.
         */    
        public function clone():*
        {
            return new Matrix4( this ) ;
        }
        
        /**
         * Compares the specified object with this object for equality.
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
         */
        public function equals( o:* ):Boolean
        {
            if ( o is Matrix4 )
            {
                return  o.n11 == this.n11 && o.n12 == this.n12 && o.n13 == this.n13 && o.n14 == this.n14 
                    &&  o.n21 == this.n21 && o.n22 == this.n22 && o.n23 == this.n23 && o.n24 == this.n24 
                    &&  o.n31 == this.n31 && o.n32 == this.n32 && o.n33 == this.n33 && o.n34 == this.n34 
                    &&  o.n41 == this.n41 && o.n42 == this.n42 && o.n43 == this.n43 && o.n44 == this.n44 ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Returns the matrix[x][y] value.
         * @return the matrix[x][y] value.
         */
        public function getEntry( x:Number, y:Number ):*
        {
            var m:Array = toArray() ;
            return m[x][y] ;
        }
        
        /**
         * Sets matrix[x][y] with the specified value.
         */
        public function setEntry( x:Number , y:Number , value:* ):void
        {
            x = clamp(x, 0, 3) ;
            y = clamp(y, 0, 3) ;
            var m:Array = toArray() ;
            m[x][y] = value ;
        }
        
        /**
         * Transforms the specified Matrix4 in argument in the identity Matrix4.
         */
        public function identity():void
        {
            n11 = 1 ; n12 = 0 ; n13 = 0 ; n14 = 0 ;
            n21 = 0 ; n22 = 1 ; n23 = 0 ; n24 = 0 ;
            n31 = 0 ; n32 = 0 ; n33 = 1 ; n34 = 0 ;
            n41 = 0 ; n42 = 0 ; n43 = 0 ; n44 = 1 ;
        }
        
        /**
         * Returns the Array representation of this instance.
         * @return the Array representation of this instance.
         */
        public function toArray():Array
        {
            var m:Array = 
            [
                [n11, n12, n13, n14] ,
                [n21, n22, n23, n24] ,
                [n31, n32, n33, n34] ,
                [n41, n42, n43, n44]
            ] ;
            return m ;
        }
        
        /**
         * Returns the Object representation of this object.
         * @return the Object representation of this object.
         */
        public function toObject():Object 
        {
            var o:Object = {} ;
            o.n11 = this.n11 ; o.n12 = this.n12 ; o.n13 = this.n13 ; o.n14 = this.n14 ;
            o.n21 = this.n21 ; o.n22 = this.n22 ; o.n23 = this.n23 ; o.n24 = this.n24 ;
            o.n31 = this.n31 ; o.n32 = this.n32 ; o.n33 = this.n33 ; o.n34 = this.n34 ;
            o.n41 = this.n41 ; o.n42 = this.n42 ; o.n43 = this.n43 ; o.n44 = this.n44 ;
            return o ;
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource( indent:int = 0 ):String 
        {
            var p:Array  = [n11,n12,n13,n14,n21,n22,n23,n24,n31,n32,n33,n34,n41,n42,n43,n44] ;
            var l:int    = p.length ;
            var source:String = "new " + getClassPath(this, true) + "(" ;
            for( var i:int ; i<l ; i++)
            {
                p[i] = core.dump( p[i] ) ;
            }
            source += p.join(",") ;
            source += ")" ;
            return source ;
        }
        
        /**
         * Returns the string representation of the object.
         * @return the string representation of the object.
         */     
        public function toString():String
        {
            var s:String = "[" + getClassName(this) + ":" ;
            s += "[" + n11 + "," + n12 + "," + n13 + "," + n14 + "]" ;
            s += "," ;
            s += "[" + n21 + "," + n22 + "," + n23 + "," + n24 + "]" ;
            s += "," ;
            s += "[" + n31 + "," + n32 + "," + n33 + "," + n34 + "]" ;
            s += "," ;
            s += "[" + n41 + "," + n42 + "," + n43 + "," + n44 + "]" ;
            s += "]" ;
            return s ;
        }
        
        /**
         * @private
         */
        private function _fill( ar:Array ):void
        {
            n11 = ar[0]  ; n12 = ar[1]  ; n13 = ar[2]  ; n14 = ar[3]  ;
            n21 = ar[4]  ; n22 = ar[5]  ; n23 = ar[6]  ; n24 = ar[7]  ;
            n31 = ar[8]  ; n32 = ar[9]  ; n33 = ar[10] ; n34 = ar[11] ;
            n41 = ar[12] ; n42 = ar[13] ; n43 = ar[14] ; n44 = ar[15] ;
        }
    }
}
