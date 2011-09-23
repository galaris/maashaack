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
    import core.maths.gcd;
    import core.reflect.getClassName;
    import core.reflect.getClassPath;
    import graphics.Geometry;
    import system.process.Lockable;

    /**
     * The <code class="prettyprint">AspectRatio</code> class encapsulates the width and height 
     * of an object and indicates this aspect ratio.
     * <p>The aspect ratio of an image is the ratio of its width to its height. 
     * For example, a standard NTSC television set uses an aspect ratio of 4:3, 
     * and an HDTV set uses an aspect ratio of 16:9. A computer monitor with 
     * a resolution of 640 by 480 pixels also has an aspect ratio of 4:3. 
     * A square has an aspect ratio of 1:1.</p>
     * <p><b>Note :</b>This class use integers to specified the aspect ratio.</p>
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import graphics.geom.AspectRatio ;
     * 
     * var ar:AspectRatio ;
     * 
     * trace("------ AspectRatio(320,240)") ;
     * 
     * ar = new AspectRatio(320,240) ;
     * trace(ar) ; // 4:3
     * 
     * ar.verbose = true ;
     * trace(ar) ; // [AspectRatio width:320, height:240, ratio:{4:3}]
     * 
     * ar.lock() ;
     * 
     * ar.width = 640 ;
     * trace(ar) ; // [AspectRatio width:640, height:480, ratio:{4:3}]
     * 
     * ar.height = 120 ;
     * trace(ar) ; // [AspectRatio width:160, height:120, ratio:{4:3}]
     * 
     * ar.unlock() ;
     * 
     * ar.width = 320 ;
     * trace(ar) ; // [AspectRatio width:320, height:120, ratio:{8:3}]
     * 
     * trace("------ AspectRatio(1680,1050)") ;
     * 
     * ar = new AspectRatio(1680,1050) ;
     * 
     * trace(ar) ; // 8:5
     * 
     * ar.verbose = true ;
     * 
     * trace(ar) ; // [AspectRatio width:1680, height:1050, ratio:{8:5}]
     * 
     * trace("------ AspectRatio(0,0)") ;
     * 
     * ar = new AspectRatio(0) ;
     * 
     * trace(ar) ; // 0:0
     * 
     * ar.verbose = true ;
     * 
     * trace(ar) ; // [AspectRatio width:0, height:0, ratio:{0:0}]
     * </pre>
     */
    public class AspectRatio extends Dimension implements Geometry, Lockable
    {
        /**
         * Creates a new <code class="prettyprint">AspectRatio</code> instance.
         * @param width The width int value use to defines the aspect ratio value.
         * @param height The height int value use to defines the aspect ratio value. 
         * @param lock This boolean flag indicates if the aspect ratio must be keeped when the width or height values changes.
         */
        public function AspectRatio( width:int=0 , height:int=0 , lock:Boolean=false )
        {
            super( width , height ) ;
            _lock = lock ;
        }
        
        /**
         * Determinates the greatest common divisor if the current object. 
         * <p>This property cast the width and the height Number in two int objects to calculate the value.</p>
         * <p>The floating values are ignored and convert in integers.</p> 
         */
        public function get gcd():int
        {
            return _gcd ;
        }
        
        /**
         * @private
         */
        public override function set height( n:Number ):void
        {
            _h = int(n) ;
            if ( _lock )
            {
                _w = int(_h * _aspW / _aspH ) ;
            }
            else
            {
                _GCD() ;
            }
        }
        
        /**
         * Indicates the verbose mode used in the toString() method.
         */
        public var verbose:Boolean ;
        
        /**
         * @private
         */
        public override function set width( n:Number ):void
        {
            _w = int(n) ;
            if ( _lock )
            {
                _h = int(_w * _aspH / _aspW ) ;
            }
            else
            {
                _GCD() ;
            } 
        }
        
        /**
         * Creates and returns a shallow copy of the object.
         * @return A new object that is a shallow copy of this instance.
         */ 
        public override function clone():*
        {
            return new AspectRatio( int(width) , int(height) ) ;
        }
        
        /**
         * Compares the specified object with this object for equality.
         * <p>Compares the toString() (ex:4:3) of the aspect ratio object and the passed-in object type.</p>
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.geom.AspectRatio ;
         * 
         * var a:* = new AspectRatio( 320 , 240 ) ;
         * var b:* = new AspectRatio( 640 , 480 ) ;
         * 
         * trace( a.equals( b ) ) ; // true 
         * </pre>
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
         */
        public override function equals(o:*):Boolean
        {
            var t:Boolean = verbose ;
            verbose = false ;
            var b:Boolean = (o is AspectRatio) && ((o as AspectRatio).toString() == toString()) ;
            verbose = t ;
            return b ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the object is locked.
         * @return <code class="prettyprint">true</code> if the object is locked.
         */
        public function isLocked():Boolean
        {
            return _lock ;
        }
        
        /**
         * Locks the object.
         */
        public function lock():void
        {
            _lock = true ;
        }
        
        /**
         * Unlocks the object.
         */
        public function unlock():void
        {
            _lock = false ;
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public override function toSource( indent:int = 0 ):String  
        {
            return "new " + getClassPath(this, true) + "(" + width.toString() + "," + height.toString() + "," + (_lock ? "true" : "false") + ")" ;
        }
        
        /**
         * Returns the string representation of this instance.
         * @return the string representation of this instance.
         */
        public override function toString():String 
        {
            var s:String = _aspW + ":" + _aspH ;  
            if ( verbose )
            {
                return "[" + getClassName(this) + " width:" + width + " height:" + height + " ratio:{" + s + "}]" ;
            }
            else
            {
                return s ;
            }
        }
        
        /**
         * @private
         */
        private var _aspW:int ;
        
        /**
         * @private
         */
        private var _aspH:int ;
        
        /**
         * @private
         */
        private var _gcd:int ;
        
        /**
         * @private
         */
        private var _lock:Boolean ;
        
        /**
         * @private
         */
        private function _GCD():void
        {
            _gcd  = core.maths.gcd( int(_w) , int(_h) ) ;
            _aspW = int(int(_w) / _gcd) ;
            _aspH = int(int(_h) / _gcd) ;
        }
    }
}
