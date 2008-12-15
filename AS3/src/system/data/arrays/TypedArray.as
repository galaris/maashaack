/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package system.data.arrays
{
    import system.Reflection;
    import system.data.Typeable;
    import system.data.Validator;
    import system.data.arrays.ProxyArray;
    import system.serializers.eden.BuiltinSerializer;    

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
    public class TypedArray extends ProxyArray implements Typeable, Validator
    {
        
        /**
         * Creates a new TypedArray instance.
         * @param type the type of this Typeable object (a Class or a Function).
         * @param ...args All values to insert in the Array if the value is valid.
         * @throw TypeError if the 'type' argument is not a valid Class object (not must be 'null' or 'undefined').
         */
        public function TypedArray( type:* , ...args:Array )
        {
            this.type = type ;
            if (args != null && args.length > 0 )
            {
                var l:int = args.length ;
                if (l > 0) 
                {
                    for (var i:int = 0 ; i<l ; i++) 
                    {
                        var value:* = args[i] ;
                        if ( supports(value) ) 
                        {
                        	_ar[i] = value ;
                        }
                    }
                }
            }
        }
        
        /**
         * Indicates the type of the Typeable object.
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
            _type = type is Class ? type as Class : ( ( type is Function ) ? type as Function : null ) ;
        }
        
        /**
         * Creates and returns a shallow copy of the object.
         */    
        public override function clone():*
        {
            return new TypedArray(_type, _ar.slice()) ;
        }
        
        /**
         * Concatenates the elements specified in the parameter list with the elements of this array and returns a new array containing these element.
         * @return a new array that contains the elements of this array as well as the passed-in elements.
         */
        public function concat( ...arguments:Array ):TypedArray 
        {
            var r:TypedArray = new TypedArray(_type) ;
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
                        _ar.push( cur[k] );
                    }
                } 
                else 
                {
                    _ar.push(cur);
                }
            }
            return r ;
        }
        
        /**
         * Adds one or more elements to the end of this array and returns the new length of this array.
         * @return the new length of this array
         * @throws TypeError 
         */
        public function push( ...arguments:Array ):uint 
        {
            if (arguments.length > 1) 
            {
                var l:uint = arguments.length;
                var i:uint = 0 ;
                while (++i < l)
                {
                    validate( arguments[i] ) ;
                }
            }
            else
            {
                validate(arguments[0]) ;
            }
            return Number( _ar.push.apply(_ar, arguments) ) ;
        }
            
        /**
         * Returns <code class="prettyprint">true</code> if the specific value is valid.
         * @return <code class="prettyprint">true</code> if the specific value is valid.
         */
        public function supports( value:* ):Boolean
        {
            return type == null || value is _type ;
        }
        
        /**
         * Returns a eden String representation of the object.
         * @return a string representation the source code of the object.
         */
        public override function toSource( indent:int = 0 ):String 
        {
            return "new " + Reflection.getClassPath(this) + "(" + Reflection.getClassPath(_type) + "," + BuiltinSerializer.emitArray( _ar ) + ")" ;
        }        
        
        /**
         * Adds one or more elements to the beginning of an array and returns the new length of the array. 
         * The other elements in the array are moved from their original position, i, to i+1. 
         */
        public function unshift( ...arguments:Array ):uint
        {
            if (arguments.length > 1) {
                
                var l:uint = arguments.length ;
                var i:int = -1 ;
                while (++i < l ) 
                {
                    validate(arguments[i]);
                }
            }
            else 
            {
                validate(arguments[0]) ;
            }
            return _ar.unshift.apply(_ar, arguments) as uint ;
        }
  
        /**
         * Evaluates the condition it checks and updates the IsValid property.
         * @throws TypeMismatchError if the value isn't valid.
         */
        public function validate(value:*):void
        {
            if (!supports(value)) 
            {
                throw new TypeError( Reflection.getClassPath(this) + ".validate("+ value + ") is mismatch") ;
            }
        }
                
        /**
         * @private
         */
        private var _type:* ;
        
    }
}

