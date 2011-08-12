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

package system.data.arrays {
	import core.dump;
	import core.reflect.getClassName;
	import core.reflect.getClassPath;

	import system.data.Typeable;
	import system.data.Validator;

    /**
     * <code class="prettyprint">TypedArray</code> acts like a normal array but assures that only objects of a specific type are added to the array.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.data.arrays.TypedArray ;
     * 
     * var ta:TypedArray = new TypedArray(String, ["item1", "item2", "item3"]) ;
     * trace ("ta : " + ta) ; // output : ta : item1,item2,item3
     * 
     * try
     * {
     *     ta.push(2) ;
     * }
     * catch( e:Error )
     * {
     *     trace( e.message ) ; // TypedArray.validate('value':2) is mismatch
     * }
     * </pre>
     */
    public dynamic class TypedArray extends ProxyArray implements Typeable, Validator
    {
        /**
         * Creates a new TypedArray instance.
         * @param type the type of this Typeable object (a Class or a Function).
         * @param ...values All values to insert in the Array, all invalid values are ignored.
         */
        public function TypedArray( type:* = null , ...values:Array )
        {
            this.type = type ;
            if (values != null && values.length > 0 )
            {
                var l:int = values.length ;
                if (l > 0) 
                {
                    var cpt:int ;
                    for (var i:int = 0 ; i<l ; i++) 
                    {
                        var value:* = values[i] ;
                        if ( supports(value) ) 
                        {
                            _ar[cpt++] = value ;
                        }
                    }
                }
            }
        }
        
        /**
         * Indicates the type of the Typeable object. 
         * <p>If the type change the clear() method is invoked.</p>
         */
        public function get type():*
        {
            return _type ;
        }
        
        /**
         * @private
         */
        public function set type( type:* ):void
        {
            if ( _type != type )
            {
                if( _ar.length > 0 )
                {
                    _ar = [] ;
                }
                _type = type is Class ? type as Class : ( ( type is Function ) ? type as Function : null ) ;
            }
        }
        
        /**
         * Creates and returns a shallow copy of the object.
         */    
        public override function clone():*
        {
            var c:TypedArray = new TypedArray(_type) ;
            if ( _ar.length > 0 )
            {
                var l:int = _ar.length ;
                for (var i:int ; i<l ; i++) 
                {
                   c[i] = _ar[i] ;
                }
            }
            return c ;
        }
        
        /**
         * Concatenates the elements specified in the parameter list with the elements of this array and returns a new array containing these element.
         * @return a new array that contains the elements of this array as well as the passed-in elements.
         */
        public function concat( ...arguments:Array ):TypedArray 
        {
            var r:TypedArray = new TypedArray( _type ) ;
            var i:int = _ar.length ;
            while(--i>-1) 
            {
                r[i] = _ar[i];
            }
            var l2:uint ;
            var k:int ;
            var l1:uint = arguments.length ;
            var j:int = -1 ;
            while(++j < l1) 
            {
                var cur:* = arguments[j] ;
                if (cur is Array) 
                {
                    l2 = (cur as Array).length ;
                    k = -1 ;
                    while (++k < l2) 
                    {
                        r.push( cur[k] );
                    }
                } 
                else 
                {
                    r.push(cur);
                }
            }
            return r ;
        }
        
        /**
         * Adds one or more elements to the end of this array and returns the new length of this array.
         * @return the new length of this array
         * @throws TypeError If a value is invalid.
         */
        public function push( ...args:Array ):uint 
        {
            if (args.length > 0) {
                
                var l:uint = args.length ;
                var i:int = -1 ;
                while (++i < l ) 
                {
                    validate(args[i]);
                }
            }
            return _ar.push.apply( _ar, args ) ;
        }
            
        /**
         * Returns <code class="prettyprint">true</code> if the specific value is valid.
         * @return <code class="prettyprint">true</code> if the specific value is valid.
         */
        public function supports( value:* ):Boolean
        {
            return _type == null || value is _type ;
        }
        
        /**
         * Returns the source representation of the object.
         * @return the source representation of the object.
         */
        public override function toSource( indent:int = 0 ):String 
        {
            var s:String = "new " + getClassPath(this, true) + "(" ;
            s +=  _type != null ? getClassPath(_type, true) : "null" ;
            if ( _ar.length > 0 )
            {
                var l:int = _ar.length ;
                for (var i:int ; i<l ; i++ )
                {
                    s += "," + dump( _ar[i] )  ;
                }
            }
            s += ")" ;
            return s ;
        }
        
        /**
         * Adds one or more elements to the beginning of an array and returns the new length of the array. 
         * The other elements in the array are moved from their original position, i, to i+1.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.data.arrays.TypedArray ;
         * 
         * var ta:TypedArray = new TypedArray( String ) ;
         * 
         * trace( ta.unshift( "value1", "value2" ) ) ; // 2
         * trace( ta ) ; // [value1,value2]
         * 
         * try
         * {
         *     ta.unshift(1) ;
         * }
         * catch( e:Error )
         * {
         *     trace( e.message ) ; // system.data.arrays.TypedArray.validate(1) is mismatch.
         * }    
         * </pre> 
         * @throws TypeError If a value is invalid.
         */
        public function unshift( ...args:Array ):uint
        {
            if (args.length > 0) {
                
                var l:uint = args.length ;
                var i:int = -1 ;
                while (++i < l ) 
                {
                    validate(args[i]);
                }
            }
            return _ar.unshift.apply(_ar, args) as uint ;
        }
        
        /**
         * Evaluates the condition it checks and updates the IsValid property.
         * @throws TypeMismatchError if the value isn't valid.
         */
        public function validate(value:*):void
        {
            if (!supports(value)) 
            {
                throw new TypeError( getClassName(this) + ".validate("+ value + ") is mismatch.") ;
            }
        }
        
        /**
         * @private
         */
        private var _type:* ;
    }
}