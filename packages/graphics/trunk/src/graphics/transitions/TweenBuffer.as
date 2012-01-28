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
 
package graphics.transitions 
{
    import system.data.Iterable;
    import system.data.Iterator;
    import system.data.Map;
    import system.data.maps.HashMap;
    
    /**
     * The buffer of the Tween class.
     */
    public class TweenBuffer implements Iterable 
    {
        /**
         * Creates a new TweenBuffer instance.
         * @param entries The array to initialize the model with some TweenEntry objects. All no TweenEntry objects are ignored.
         */
        public function TweenBuffer( entries:Array=null )
        {
            _map = new HashMap() ;
            if ( entries == null ) 
            {
                return ;
            }
            var size:int = entries.length ;
            if (size > 0) 
            {
                var t:TweenEntry ;
                for (var i:int ; i < size ; i++ ) 
                {
                    t = entries[i] as TweenEntry ;
                    if ( t != null )
                    {
                        add( t.clone() ) ;
                    }
                }
            }
        }
        
        /**
         * Inserts a new TweenEntry in the buffer.
         */
        public function add( entry:TweenEntry ):Boolean 
        {
            if ( entry == null )
            {
               	throw new ArgumentError(this + " insert method failed, the entry parameter not must be null.") ;
            }
            var p:String = entry.prop ;
            if ( p != null ) 
            {
                _map.put( p, entry ) ;
                return true ;
            }
            else 
            {
                return false ;
            }
        }
        
        /**
         * Removes all elements register in the buffer.
         */
        public function clear():void 
        {
            _map.clear( ) ;
        }
        
        /**
         * Returns a shallow copy of this object. This method keep all Tween entries and the id of the original object.
         * <pre class="prettyprint"> 
         * var model:TweenBuffer = new TweenBuffer() ; 
         * var clone:TweenBuffer = model.clone() as TweenBuffer ;
         * </pre>
         * @return A shallow copy of this object.
         */
        public function clone():*
        {
            return new TweenBuffer( toArray() ) ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the specified property exist in this buffer.
         * @return <code class="prettyprint">true</code> if the specified property exist in this buffer.
         */
        public function contains( prop:String ):Boolean 
        {
            return _map.containsKey( prop ) ;
        }
        
        /**
         * Returns the specified TweenEntry reference.
         * @return the specified TweenEntry reference.
          */
        public function get( prop:String ):TweenEntry 
        {
            return _map.get( prop ) ;
        }
        
        /**
         * Returns the Array representation of all property names in this buffer.
         * @return the Array representation of all property names in this buffer.
         */
        public function getProperties():Array 
        {
            return _map.getKeys() ;
        }
        
        /**
         * Returns an iterator of this buffer.
         * @return an iterator of this buffer.
         */
        public function iterator():Iterator
        {
            return _map.iterator() ;
        }
        
        /**
         * Removes an entry in the model.
         */
        public function remove( entry:* ):Boolean 
        {
            var p:String ;
            if ( entry is String ) 
            {
                p = entry as String ;
            }
            else if ( entry is TweenEntry ) 
            {
                p = entry.prop ;
            }
            else 
            {
                throw new ArgumentError(this + " remove method failed with an unknow argument value : " + entry ) ;
            } 
            if ( contains(p) ) 
            {
                var t:TweenEntry = _map.remove( p ) ;
                if ( t != null )
                {
                    return true ;
                }
            } 
            return false ;
        }
        
        /**
         * Returns the number of elements in the buffer.
         * @return the number of elements in the buffer.
         */
        public function size():Number 
        {
            return _map.size( ) ;
        }
        
        /**
         * Returns the Array representation of all TweenEntry objects in this buffer.
         * @return the Array representation of all TweenEntry objects in this buffer.
         */
        public function toArray():Array 
        {
            return _map.getValues() ;
        }
        
        /**
         * Returns the Map representation of all TweenEntry objects in this buffer.
         * @return the Map representation of all TweenEntry objects in this buffer.
         */
        public function toMap():Map 
        {
            return _map.clone() ;
        }
        
        /**
         * Returns the String representation of this object.
         * @return the String representation of this object.
         */
        public function toString():String 
        {
            var s:String = "[TweenBuffer" ; 
            if ( _map.size() > 0 )
            {
                s += ":" + (_map as Object).toString() ;
            }
            s += "]" ;
            return s ;
        }
        
        /**
         * @private
         */
        private var _map:Map ;
    }
}
