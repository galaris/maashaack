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

package system.data 
{
    import flash.utils.Proxy;
    import flash.utils.flash_proxy;
    
    /**
     * A proxy reference is a reference that redirect all methods, properties, etc. over the internal target reference (value). 
     */
    public dynamic class ProxyReference extends Proxy 
    {
        /**
         * Creates a new ProxyReference instance.
         * @param value The target value of the proxy reference.
         */
        public function ProxyReference( value:* = null ) 
        {
            _value = value;
        }
        
        /**
         * The target value of the proxy reference.
         */
        public function get value():* 
        {
            return _value;
        }
        /**
         * @private
         */
        public function set value(v:*):void 
        {
            _value = v;
        }
        
        /**
         * Overrides the behavior of an object property that can be called as a function. 
         * When a method of the object is invoked, this method is called. 
         * While some objects can be called as functions, some object properties can also be called as functions. 
         */
        flash_proxy override function callProperty(name:*, ...rest):* 
        {
            if ( _value && name in _value )
            {
                if( _value[name] is Function )
                {
                    return _value[name].apply( _value , rest ) ;
                }
                else
                {
                    return _value[name] ;
                }
            }
            return null ;
        }
        
        /**
         * Overrides the request to delete a property. When a property is deleted with the delete operator, this method is called to perform the deletion. 
         * @param name The name of the property to delete.
         */
        flash_proxy override function deleteProperty(name:*):Boolean 
        {
            return _value ? ( delete _value[name] ) : false ;
        }
        
        /**
         * Overrides the use of the descendant operator. When the descendant operator is used, this method is invoked.
         * @param name The name of the property to descend into the object and search for. 
         */
        flash_proxy override function getDescendants( name:* ):* 
        {
            return _value ? _value.descendants(name) : null ;
        }
        
        /**
         * Overrides any request for a property's value. 
         * If the property can't be found, the method returns undefined. 
         * For more information on this behavior, see the ECMA-262 Language Specification, 3rd Edition. 
         */
        flash_proxy override function getProperty(name:*):* 
        {
            return _value ? _value[name] : null ;
        }
        
        /**
         * Overrides a request to check whether an object has a particular property by name.
         * @param name The name of the property to check for.
         * @return If the property exists, <code class="prettyprint">true</code>; otherwise <code class="prettyprint">false</code>.
         */
        flash_proxy override function hasProperty(name:*):Boolean 
        {
            return _value ? ( name in _value ) : false ;
        }
        
        /**
         * Overrides a call to change a property's value. 
         * If the property can't be found, this method creates a property with the specified name and value.
         * @param name The name of the property to modify.
         * @param value The value to set the property to.
         */
        flash_proxy override function setProperty( name:*, value:* ):void 
        {
            if ( _value )
            {
                _value[name] = value ;
            }
        }
        
        /**
         * @private
         */
        private var _value:*;
    }
}
