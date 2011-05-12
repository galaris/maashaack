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

package system.ioc 
{
    import system.data.Iterator;
    import system.data.Map;
    import system.data.maps.HashMap;
    
    /**
     * This object is an helper who contains type aliases. 
     * <p>This helper is used in a ioc container (<code class="prettyprint">ObjectFactory</code>) to map the type class of an object.</p>
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.data.Iterator ;
     * import system.ioc.TypeAliases ;
     * 
     * var aliases:TypeAliases = new TypeAliases() ;
     * 
     * aliases.put( "DropShadowFilter" , "flash.filters.DropShadowFilter" ) ;
     * aliases.put( "ObjectFactory"    , "system.ioc.ObjectFactory" ) ;
     * aliases.put( "HashMap"          , "system.data.maps.HashMap" ) ;
     * 
     * trace("-------- aliases.containsAlias('DropShadowFilter')") ;
     * 
     * trace( aliases.containsAlias('DropShadowFilter') ) ;
     * trace( aliases.containsAlias('noAlias') ) ;
     * 
     * trace("-------- aliases.containsValue()") ;
     * 
     * trace( aliases.containsValue('system.ioc.ObjectFactory') ) ;
     * trace( aliases.containsValue('unknow') ) ;
     * 
     * trace("-------- aliases.getAliases()") ;
     * 
     * trace( aliases.getAliases() ) ;
     * 
     * trace("-------- aliases.getValue('ObjectFactory')") ;
     * 
     * trace( aliases.getValue("ObjectFactory") ) ;
     * 
     * trace("-------- aliases.getValues()") ;
     * 
     * trace( aliases.getValues() ) ;
     * 
     * trace("-------- iterator") ;
     * 
     * var it:Iterator = aliases.iterator() ;
     * while( it.hasNext() )
     * {
     *     var next:String = it.next() as String ;
     *     var key:String  = it.key()  as String ;
     *     trace( aliases + " alias : '" + key + "' -> value : '" + next + "'" ) ;
     * }
     * 
     * trace("-------- clear and isEmpty") ;
     * 
     * trace( aliases.isEmpty() ) ;
     * aliases.clear() ;
     * trace( aliases.isEmpty() ) ;
     * </pre>
     */
    public class TypeAliases
    {
        /**
         * Creates a new TypeAliases instance.
         */
        public function TypeAliases()
        {
            _map = new HashMap() ;
        }
        
        /**
         * Indicates the number of alias registered in the collector.
         */
        public function get length():uint
        {
            return _map.size() ;
        }
        
        /**
         * Clear all alias in the internal map of this object.
         */
        public function clear():void
        {
            _map.clear() ;
        }
        
        /**
         * Indicates if the collector contains the passed-in alias expression.
         * @return <code class="prettyprint">true</code> if the collector contains the passed-in alias expression.
         */
        public function containsAlias( alias:String ):Boolean
        {
            if ( alias == null || alias.length == 0)
            {
                return false ;
            }
            return _map.containsKey( alias ) ;
        }
        
        /**
         * Indicates if the collector contains the passed-in type value expression.
         * @return <code class="prettyprint">true</code> if the collector contains the passed-in type value expression.
         */
        public function containsValue( value:String ):Boolean
        {
            if ( value == null || value.length == 0)
            {
                return false ;
            }
            return _map.containsValue( value ) ;
        }
        
        /**
         * Returns the Array representation of all aliases registered in this collector.
         * <pre class="prettyprint">
         * import system.ioc.TypeAliases ;
         * 
         * var aliases:TypeAliases = new TypeAliases() ;
         * 
         * aliases.put( "DropShadowFilter" , "flash.filters.DropShadowFilter" ) ;
         * aliases.put( "BlurFilter"       , "flash.filters.BlurFilter" ) ;
         * 
         * trace( aliases.getAliases() ) ;
         * </pre>
         * @return the Array representation of all aliases registered in this collector.
         */
        public function getAliases():Array 
        {
            return _map.getKeys() ;
        }
        
        /**
         * Returns the internal Map reference of this collector.
         * @return the internal Map reference of this collector.
         */
        public function getMap():Map
        {
            return _map ;
        }
        
        /**
         * Returns the value of the specified alias.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.ioc.TypeAliases ;
         * 
         * var aliases:TypeAliases = new TypeAliases() ;
         * aliases.put( "ObjectFactory" , "system.ioc.ObjectFactory" ) ;
         * 
         * trace( aliases.getValue("ObjectFactory") ) ; // system.ioc.ObjectFactory
         * </pre>
         * @return the value of the specified alias.
         */
        public function getValue( alias:String ):String 
        {
            return _map.get( alias ) ;
        }
        
        /**
         * Returns the <code class="prettyprint">Array</code> representation of all type values registered in this collector.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.ioc.TypeAliases ;
         * 
         * var aliases:TypeAliases = new TypeAliases() ;
         * 
         * aliases.put( "DropShadowFilter" , "flash.filters.DropShadowFilter" ) ;
         * aliases.put( "BlurFilter"       , "flash.filters.BlurFilter" ) ;
         * 
         * trace( aliases.getValues() ) ; // flash.filters.DropShadowFilter,flash.filters.BlurFilter
         * </pre>
         * @return the <code class="prettyprint">Array</code> representation of all type values registered in this collector.
         */
        public function getValues():Array 
        {
            return _map.getValues() ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the collector is empty.
         * @return <code class="prettyprint">true</code> if the collector is empty.
         */
        public function isEmpty():Boolean
        {
            return _map.isEmpty() ;
        }
        
        /**
         * Returns the <code class="prettyprint">Iterator</code> of the object.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.data.Iterator ;
         * import system.ioc.TypeAliases ;
         * 
         * var aliases:TypeAliases = new TypeAliases() ;
         * 
         * aliases.put( "DropShadowFilter" , "flash.filters.DropShadowFilter" ) ;
         * aliases.put( "ObjectFactory"    , "system.ioc.ObjectFactory" ) ;
         * aliases.put( "HashMap"          , "system.data.maps.HashMap" ) ;
         * 
         * var it:Iterator = aliases.iterator() ;
         * while( it.hasNext() )
         * {
         *     var next:String = it.next() as String ;
         *     var key:String  = it.key()  as String ;
         *     trace( aliases + " alias : '" + key + "' -> value : '" + next + "'" ) ;
         * }
         * </pre>
         * @return the <code class="prettyprint">Iterator</code> of the object.
         */
        public function iterator():Iterator
        {
            return _map.iterator() ;
        }
        
        /**
         * Inserts an alias in the collector. If the alias already exist the value in the collector is replaced.
         * <p><b>Example</b></p>
         * <pre class="prettyprint">
         * import system.ioc.TypeAliases ;
         * 
         * var aliases:TypeAliases = new TypeAliases() ;
         * 
         * aliases.put( "DropShadowFilter" , "flash.filters.DropShadowFilter" ) ;
         * aliases.put( "BlurFilter"       , "flash.filters.BlurFilter" ) ;
         * </pre>
         * @param alias The alias name, this expression not must be null and not empty or the method return <code class="prettyprint">false</code>.
         * @param value The value of the alias type, this expression not must be null and not empty or the method return <code class="prettyprint">false</code>.
         * @return <code class="prettyprint">true</code> if the alias can be registered.
         */
        public function put( alias:String, value:String ):Boolean
        {
            if ( alias == null || value == null || alias.length == 0  || value.length == 0 )
            {
                return false ;
            }
            _map.put( alias , value ) ;
            return true ;
        }
        
        /**
         * @private
         */
        private var _map:HashMap ;
    }
}
