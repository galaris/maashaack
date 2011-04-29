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

package system.data.arrays 
{
    import core.dump;
    import core.reflect.getClassPath;
    
    import system.Cloneable;
    import system.Serializable;
    import system.data.Iterable;
    import system.data.Iterator;
    import system.data.iterators.ArrayIterator;
    
    import flash.utils.Proxy;
    import flash.utils.flash_proxy;
    
    /**
     * The ProxyArray class extends the flash.utils.Proxy class and use a composition with an Array to extends the Array class.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.data.arrays.ProxyArray ;
     * 
     * var a1:ProxyArray = new ProxyArray() ;
     * 
     * a1.push("item1") ;
     * a1.push("item2") ;
     * a1.push("item3") ;
     * a1.push("item4") ;
     * 
     * for (var prop:String in a1)
     * {
     *     trace( prop + " : " + a1[prop] ) ;
     * }
     * 
     * trace("----") ;
     * 
     * for each( var item:* in a1)
     * {
     *     trace(  item ) ;
     * }
     * 
     * trace("----") ;
     * 
     * trace("proxy array toString : " + a1) ;
     * trace("proxy array toSource : " + a1.toSource()) ;
     * 
     * var a2:ProxyArray = new ProxyArray( [[1, 2], [0, 4]] ) ;
     * 
     * var copy:ProxyArray = a2.copy() ;
     * copy[1][0] = 3 ;
     * copy[2] = [5,6] ;
     * copy[3] = [7,8] ;
     *
     * trace(a2 + " : " + copy) ;
     * </pre>
     */
    public dynamic class ProxyArray extends Proxy implements Cloneable, Iterable, Serializable
    {
        /**
         * Creates a new ProxyArray instance.
         */
        public function ProxyArray( datas:Array = null )
        {
            _ar = (datas == null) ? [] : [].concat(datas)  ;
        }
        
        /**
         * Overrides the behavior of an object property that can be called as a function. 
         * When a method of the object is invoked, this method is called. 
         * While some objects can be called as functions, some object properties can also be called as functions. 
         */
        flash_proxy override function callProperty( methodName:*  , ...rest:Array ):* 
        {
            var res:* ;
            switch ( methodName.toString() ) 
            {
                default :
                {
                    res = _ar[methodName].apply(_ar, rest);
                    break;
                }
            }
            return res ;
        }
        
        /**
         * Removes all elements in the array.
         */ 
        public function clear():void
        {
            _ar = [] ;
        }
           
        /**
         * Creates and returns a shallow copy of the object.
         * @return a shallow copy of the object.
         */ 
        public function clone():*
        {
            return new ProxyArray(_ar.slice()) ;
        }
        
        /**
         * Overrides any request for a property's value. 
         * If the property can't be found, the method returns undefined. 
         * For more information on this behavior, see the ECMA-262 Language Specification, 3rd Edition. 
         */
        flash_proxy override function getProperty( name:* ):* 
        {
            return _ar[name];
        }
        
        /**
         * Indicates if the array is empty or not.
         * @return <code class="prettyprint">true</code> if the array is empty.
         */
        public function isEmpty():Boolean 
        {
            return _ar.length == 0 ;
        }
        
        /**
         * Returns the iterator of the object.
         * @return the iterator of the object.
         */
        public function iterator():Iterator 
        {
            return new ArrayIterator(_ar) ;
        }
        
        /**
         * Allows enumeration of the proxied object's properties by index number to retrieve property names. 
         * However, you cannot enumerate the properties of the Proxy class themselves. 
         * This function supports implementing for...in and for each..in loops on the object to retrieve the desired names. 
         */
        flash_proxy override function nextName( index:int ):String
        {
            return _index.toString() ;
        }
        
        /**
         * Allows enumeration of the proxied object's properties by index number. 
         * However, you cannot enumerate the properties of the Proxy class themselves. 
         * This function supports implementing for...in and for each..in loops on the object to retrieve property index values.
         */ 
        flash_proxy override function nextNameIndex ( index:int ):int 
        {
            _index = index ;
            return (index < _ar.length) ? index + 1 : 0 ;
        }
        
        /**
         * Allows enumeration of the proxied object's properties by index number to retrieve property values. 
         * However, you cannot enumerate the properties of the Proxy class themselves. 
         * This function supports implementing for...in and for each..in loops on the object to retrieve the desired values. 
         */
        flash_proxy override function nextValue(index:int):* 
        {
            return _ar[index-1] ;
        } 
        
        /**
         * Overrides a call to change a property's value. 
         * If the property can't be found, this method creates a property with the specified name and value.
         * @param name The name of the property to modify.
         * @param value The value to set the property to.
         */
        flash_proxy override function setProperty( name:* , value:* ):void 
        {
            _ar[name] = value ;
        }
        
        /**
         * Returns the Array representation of the object.
         * @return the Array representation of the object.
         */
        public function toArray():Array 
        {
            return [].concat(_ar) ;
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource( indent:int = 0 ):String 
        {
            return "new " + getClassPath(this, true) + "(" + (_ar.length > 0 ? dump( _ar ) : "" ) + ")" ;
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toString():String
        {
            return "[" + _ar.join(",") + "]" ;
        }
        
        /**
         * Internal Array reference used in the proxy pattern.
         */
        protected var _ar:Array ;
        
        /**
         * @private
         */
        private var _index:int ;
    }
}
