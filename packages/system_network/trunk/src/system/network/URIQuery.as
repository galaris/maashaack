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

package system.network
{
    /**
     * The URIScheme class.
     * <p><b>See:</b></p>
     * <ul>
     * <li><a href="http://en.wikipedia.org/wiki/URI_scheme">http://en.wikipedia.org/wiki/URI_scheme</a></li>
     * <li><a href="http://esw.w3.org/topic/UriSchemes/">http://esw.w3.org/topic/UriSchemes/</a></li>
     * </ul>
     * <p><b>generic syntax :</b></p>
     * <pre>
     * &lt;scheme>://[&lt;username>[:&lt;password>]&#64;]&lt;host>[:&lt;port>]/&lt;path>[?&lt;query>][#&lt;fragment>]
     * </pre>
     */
    public class URIQuery
    {
        /**
         * Creates a new URIScheme instance.
         * @param scheme The String representation of the uri scheme.
         * @param delimiter The delimiter value.
         * @param defaultPort The default port of the scheme.
         */
        public function URIQuery( query:String = null )
        {
            parse( query ) ;
        }
        
        /**
         * Indicates the number of queries mapping in the map.
         */
        public function get length():uint
        {
            return _keys.length ;
        }
        
        /**
         * Determinates the encoded URI query, not including the ?.
         * You can set a query with a string who not including the ? character, ex : "a=1&#38;b=2".
         */
        public function get query():String
        {
            if ( _change )
            {
                resolve() ;
            }
            return _query ;
        }
        
        /**
         * @private
         */
        public function set query( source:String ):void
        {
            parse( source ) ;
        }
        
        /**
         * Returns true if this map contains a mapping for the specified key.
         * @return true if this map contains a mapping for the specified key.
         */
        public function containsKey(key:*):Boolean
        {
            return indexOfKey(key) > -1 ;
        }
        
        /**
         * Returns true if this map maps one or more keys to the specified value.
         * @return true if this map maps one or more keys to the specified value.
         */
        public function containsValue(value:*):Boolean
        {
            return indexOfValue(value) > -1 ;
        }
        
        /**
         * Returns the value to which this map maps the specified key.
         * @return the value to which this map maps the specified key.
         */
        public function get( key:* ):* 
        {
            return _values[ indexOfKey(key) ] ;
        }
        
        /**
         * Indicates if the map contains queries.
         */
        public function hasQuery():Boolean
        {
            return _keys.length > 0 ;
        }
        
        /**
         * Parse the query string.
         */
        public function parse( query:String ):void
        {
            _keys   = [] ;
            _values = [] ;
            _query  = "" ;
            _change = true ;
            if( query && query != "" )
            {
                var p:Array ;
                var q:Array = query.split( "&" ) ;
                for each( var param:String in q )
                {
                    p = param.split( "=" ) ;
                    if ( p.length == 2 )
                    {
                        _keys.push( p[0] as String ) ;
                        _values.push( p[1] as String ) ;
                    }
                }
            }
            resolve() ;
        }
        
        /**
         * Associates the specified value with the specified key in this query map.
         * @param key the key to register the value.
         * @param value the value to be mapped in the query map.
         * @return The old value register in the query map with a specific key or null if the key is new.
         */
        public function put( key:String , value:* ):*
        {
            _change = true ;
            var r:* ;
            var i:int = indexOfKey( key ) ;
            if ( i < 0 ) 
            {
                _keys.push( key ) ;
                _values.push( value ) ;
                return null ;
            }
            else 
            {
                r = _values[i] ;
                _values[i] = value ;
                return r ;
            }
        }
        
        /**
         * Removes the mapping for this key from this map if present or all queries if the key is null.
         * @param o The key whose mapping is to be removed from the map.
         * @return previous value associated with specified key, or null if there was no mapping for key. A null return can also indicate that the map previously associated null with the specified key.
         */
        public function remove( key:String = null ):*
        {
            _change = true ;
            if ( key == null )
            {
                _keys   = [] ;
                _query  = "" ;
                _values = [] ;
                return null ;
            }
            else
            {
                var v:* = null ;
                var i:int = indexOfKey( key ) ;
                if ( i > -1 ) 
                {
                    v = _values[i] ;
                    _values.splice(i, 1) ;
                    _keys.splice(i, 1) ;
                }
                return v ;
            }
        }
        
        /**
         * Returns the String representation of this map.
         * @return the String representation of this map.
         */
        public function toString():String
        {
            if ( _change )
            {
                resolve() ;
            }
            return _query ;
        }
        
        /**
         * @private
         */
        protected var _change:Boolean ;
        
        /**
         * @private
         */
        protected var _keys:Array ;
        
        /**
         * @private
         */
        protected var _query:String ;
        
        /**
         * @private
         */
        protected var _values:Array ;
        
        
        /**
         * Returns the index position in the ArrayMap of the specified key.
         * @return the index position in the ArrayMap of the specified key.
         */
        protected function indexOfKey( key:* ):int 
        {
            return _keys.indexOf( key ) ;
        }
        
        /**
         * Returns the index position in the ArrayMap of the specified value.
         * @return the index position in the ArrayMap of the specified value.
         */
        protected function indexOfValue( value:* ):int
        {
            return _values.indexOf(value) ;
        }
        
        /**
         * Returns the String representation of this map.
         * @return the String representation of this map.
         */
        protected function resolve():void
        {
            _change = false ;
            _query  = "" ;
            var l:int = _keys.length ;
            if ( l > 0 )
            {
                for ( var i:int ; i<l ; i++ )
                {
                    _query += _keys[i] + "=" + _values[i] ;
                    if( i < l-1 )
                    {
                        _query += "&";
                    } 
                }
            }
        }
    }
}