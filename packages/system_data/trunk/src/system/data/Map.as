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

package system.data
{
    import system.Cloneable;
    import system.Serializable;
    
    /**
     * An object that maps keys to values. A map cannot contain duplicate keys. Each key can map to at most one value.
     */
    public interface Map extends Cloneable, Iterable, Serializable
    {
        /**
         * Removes all mappings from this map (optional operation).
         */
        function clear():void ;
        
        /**
         * Returns <code class="prettyprint">true</code> if this map contains a mapping for the specified key.
         * @return <code class="prettyprint">true</code> if this map contains a mapping for the specified key.
         */
        function containsKey( key:* ):Boolean ;
        
        /**
         * Returns <code class="prettyprint">true</code> if this map maps one or more keys to the specified value.
         * @return <code class="prettyprint">true</code> if this map maps one or more keys to the specified value.
         */
        function containsValue( value:* ):Boolean ;
        
        /**
         * Returns the value to which this map maps the specified key.
         * @return the value to which this map maps the specified key.
         */
        function get( key:* ):* ;
        
        /**
         * Returns an Array of all the keys in the map.
         * @return an Array of all the keys in the map.
         */
        function getKeys():Array ;
        
        /**
         * Returns an Array of all the values in the map.
         * @return an Array of all the values in the map.
         */
        function getValues():Array ;
        
        /**
         * Returns <code class="prettyprint">true</code> if this map contains no key-value mappings.
         * @return <code class="prettyprint">true</code> if this map contains no key-value mappings.
         */
        function isEmpty():Boolean ;
        
        /**
         * Returns the keys iterator of this map.
         * @return the keys iterator of this map.
         */
        function keyIterator():Iterator ;
        
        /**
         * Associates the specified value with the specified key in this map (optional operation).
         */
        function put( key:* , value:* ):* ;
        
        /**
         * Copies all of the mappings from the specified map to this one.
         */
        function putAll( m:Map ):void ;
        
        /**
         * Removes the mapping for this key from this map if it is present (optional operation).
         */
        function remove(o:*):*  ;
        
        /**
         * Returns the number of key-value mappings in this map.
         * @return the number of key-value mappings in this map.
         */
        function size():uint ;
    }
}