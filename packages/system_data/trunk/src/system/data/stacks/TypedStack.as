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

package system.data.stacks 
{
    import core.dump;
    import core.reflect.getClassName;
    import core.reflect.getClassPath;

    import system.data.Iterator;
    import system.data.Stack;
    import system.data.Typeable;
    import system.data.Validator;

    /**
     * TypedStack is a wrapper for Stack instances that ensures that only values of a specific type can be added to the wrapped stack.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.data.stacks.ArrayStack ;
     * import system.data.stacks.TypedStack ;
     * 
     * var s:ArrayStack = new ArrayStack() ;
     * var t:TypedStack = new TypedStack( String , s  ) ;
     * 
     * t.push("item1") ;
     * t.push("item2") ;
     * 
     * trace( t ) ; // {item1,item2}
     * 
     * try
     * {
     *     t.push( 1 ) ;
     * }
     * catch( e:TypeError )
     * {
     *     trace( e.message ) ; // TypedStack.validate(1) is mismatch.
     * }
     * </pre>
     */
    public class TypedStack implements Stack, Typeable, Validator 
    {
        /**
         * Creates a new TypedStack instance.
         * @param stack the type of this Typeable object (a Class or a Function).
         * @param stack The Stack reference of this wrapper.
         * @throws ArgumentError if the type is null or undefined.
         * @throws TypeError if a value in the passed-in Stack object isn't valid.
         */ 
        public function TypedStack( type:* , stack:Stack )
        {
            if (stack == null) 
            {
                throw new ArgumentError("The passed-in 'stack' argument not must be 'null' or 'undefined'.") ;
            }
            this.type = type ;
            if ( stack.size() > 0 ) 
            {
                var it:Iterator = stack.iterator() ;
                while ( it.hasNext() ) 
                {
                    validate( it.next() ) ;
                }
            }
            _s = stack ;
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
            if ( _s != null && _s.size() > 0 )
            {
                _s.clear() ;
            }
            _type = type is Class ? type as Class : ( ( type is Function ) ? type as Function : null ) ;
        }
        
        /**
         * Removes all of the elements from this stack (optional operation).
         */ 
        public function clear():void
        {
            _s.clear() ;
        }
        
        /**
         * Creates and returns a shallow copy of the object.
         * @return A new object that is a shallow copy of this instance.
         */ 
        public function clone():*
        {
            return new TypedStack( type , _s ) ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if this stack contains no elements.
         * @return <code class="prettyprint">true</code> if this stack is empty else <code class="prettyprint">false</code>.
         */
        public function isEmpty():Boolean
        {
            return _s.isEmpty() ;
        }
        
        /**
         * Returns the iterator reference of the object.
         * @return the iterator reference of the object.
         */
        public function iterator():Iterator
        {
            return _s.iterator() ;
        }
        
        /**
         * Returns the lastly pushed value without removing it.
         * @throws the lastly pushed value.
         */
        public function peek():*
        {
            return _s.peek() ;
        }
        
        /**
         * Removes and returns the lastly pushed value.
         * @return the lastly pushed value
         */
        public function pop():*
        {
            return _s.pop() ;
        }
        
        /**
         * Pushes the passed-in value to this stack.
         */
        public function push(o:*):void
        {
            validate( o ) ;
            _s.push(o) ;
        }
        
        /**
         * Search a value in the stack.
         * @return the index position of a value in the stack.
         */
        public function search(o:*):int
        {
            return _s.search(o) ;
        }
        
        /**
         * Returns the number of elements in this collection.
         * @return the number of elements in this collection.
         */
        public function size():uint
        {
            return _s.size() ;
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
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource(indent:int = 0):String
        {
            var s:String = "new " + getClassPath(this , true) + "(" ;
            s += getClassPath( type , true ) ;
            if ( size() >  0 )
            {
                s += "," + dump(_s) ;
            }
            s += ")" ;
            return s ;
        }
        
        /**
         * Returns the String representation of the object.
         * @return the String representation of the object.
         */
        public function toString():String
        {
             return (_s as Object).toString() ;
        }
        
        
        /**
         * Evaluates the specified value and throw a <code class="prettyprint">TypeError</code> object if the value is not valid.
         * @throws TypeError if the value is not valid.
         */
        public function validate(value:*):void
        {
            if (!supports(value)) 
            {
                throw new TypeError( getClassName(this) + ".validate(" + value + ") is mismatch.") ;
            }
        }
        
        /**
         * @private
         */
        protected var _s:Stack ;
        
        /**
         * @private
         */
        private var _type:* ;
    }
}
