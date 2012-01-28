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

package system.data.sets 
{
    import core.reflect.getClassName;

    import system.data.Iterable;
    import system.data.Iterator;
    import system.data.Map;
    import system.data.Set;
    import system.data.collections.ArrayCollection;
    import system.data.iterators.ArrayIterator;
    
    /**
     * The basic implementation of the Set interface. 
     */
    public class CoreSet extends ArrayCollection implements Set
    {
        /**
         * Creates a new CoreSet instance.
         * <p>You can use an optional parameter in this constructor with different type : an Array or a Collection instance to fill the Set object.</p>
         * @param map The Map reference use in the Set. The class can't be initialize i
         * @param init An optional Array or Collection or Iterable object to fill the collection.
         */
        public function CoreSet( map:Map , init:* = null )
        {
            if ( map == null )
            {
                throw new ArgumentError( getClassName(this) + " constructor failed, the internal Map not must be null.") ;
            }
            _map = map ;
            if ( init == null )
            {
                return ;
            }
            var it:Iterator = null ;
            if (init is Array) 
            {
                it = new ArrayIterator( init as Array ) ;
            }
            else if (init is Iterable) 
            {
                it = (init as Iterable).iterator() ;
            }
            if (it != null) 
            {
                while (it.hasNext())
                {
                    add(it.next()) ;
                } 
            }
        }
        
        /**
         * Adds the specified element to this set if it is not already present.
         */
        public override function add(o:*):Boolean 
        {
            if ( o === undefined )
            {
                return false ;
            }
            return _map.put(o, PRESENT) == null ;
        }
        
        /**
         * Removes all of the elements from this Set (optional operation).
         */
        public override function clear():void
        {
            _map.clear() ;
        }
        
        /**
         * Returns a shallow copy of this Set (optional operation).
         * @return a shallow copy of this Set (optional operation).
         */
        public override function clone():*
        {
            return new CoreSet( _map.clone() , toArray() ) ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if this Set contains the specified element.
         * @return <code class="prettyprint">true</code> if this Set contains the specified element.
         */ 
        public override function contains(o:*):Boolean 
        {
            return _map.containsKey(o) ;
        }
        
        /**
         * Returns the element from this collection at the passed key index.
         * @return the element from this collection at the passed key index.
         */        
        public override function get( key:* ):*
        {
            return _map.getKeys()[key] ;
        }
        
        /**
         * Returns the index of an element in the collection.
         * @return the index of an element in the collection.
         */
        public override function indexOf( o:* , fromIndex:uint = 0 ):int
        {
            return _map.getKeys().indexOf(o, fromIndex) ;
        }
        
        /**
         * Returns true if this set contains no elements.
         * @return true if this set contains no elements.
         */
        public override function isEmpty():Boolean 
        {
            return _map.isEmpty() ;
        }

        /**
         * Returns an iterator over the elements in this Set.
         * @return an iterator over the elements in this Set.
         */
        public override function iterator():Iterator 
        {
            return _map.keyIterator() ;
        }
        
        /**
         * Removes the specified element from this set if it is present.
         */
        public override function remove(o:*):* 
        {
            return _map.remove(o) == PRESENT ;
        }
        
        /**
         * Returns the number of elements in this set (its cardinality).
         * @return the number of elements in this set (its cardinality).
         */
        public override function size():uint 
        {
            return _map.size() ;
        }
        
        /**
         * Returns the array representation of all the elements of this Set.
         * @return the array representation of all the elements of this Set.
         */
        public override function toArray():Array 
        {
            return _map.getKeys() ;
        }
        
        /**
         * @private
         */
        private var _map:Map ;
        
        /**
         * @private
         */
        private static const PRESENT:Boolean = true ;
    }
}
