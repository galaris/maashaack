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

package system.data.trees 
{
    import core.strings.startsWith;

    import system.Comparator;
    import system.data.Iterator;
    import system.data.Map;
    import system.data.maps.HashMap;
    import system.errors.NoSuchElementError;
    import system.errors.NonUniqueKeyError;
    import system.hack;
    
    use namespace hack ;
    
    // TODO iterator(), clone(), equals() ??
    
    /**
     * The basic implementation of the Trie data structure.
     * <p><b>More informations in wikipedia :</b> <a href="http://en.wikipedia.org/wiki/Trie">Trie</a></p>
     */
    public class Trie
    {
        /**
         * Creates a new Trie instance.
         * @param parent This argument is used only inside the class.
         */
        public function Trie( parent:Trie = null ):void 
        {
            _entries  = new HashMap() ;
            _entry    = null ;
            if ( parent == null )
            {
                _position = 0 ;
                _previous = null ;
            }
            else
            {
                _previous = parent ;
                _position = parent._position + 1 ;
            }
        }
        
        /**
         * Indicates the aerage clash value of the trie.
         */
        public function get aerageClash():Number
        {
            var ta:TrieAverage = new TrieAverage() ;
            _aerageClash( ta ) ;
            return ta.average / ta.number ;
        }
        
        /**
         * Indicates the Map of entries in this trie.
         */
        public function get entries():Map
        {
            return _entries ;
        }
        
        /**
         * @private
         */
        public function set entries( m:Map ):void
        {
            _entries = m ;
        }
        
        /**
         * Indicates the trie entry of this trie.
         */
        public function get entry():TrieEntry
        {
            return _entry ;
        }
        
        /**
         * @private
         */
        public function set entry( e:TrieEntry ):void
        {
            _entry = e ;
        }
        
        /**
         * Indicates the numbers of tries in this trie.
         */
        public function get numTries():int
        {
            var n:int = 1 ;
            if ( _entries != null && _entries.size() > 0)
            {
                var value:* ;
                var it:Iterator= _entries.iterator() ;
                while( it.hasNext() )
                {
                    value = it.next() ;
                    if ( value is Trie && ( value as Trie)._previous == this )
                    {
                        n += ( value as Trie ).numTries ;
                    }
                }
            }
            return n ;
        }
        
        /**
         * Returns the character offset that this trie is off the main trie.
         */
        public function get position():int
        {
            return _position ;
        }
        
        /**
         * Indicates the previous Trie of this trie.
         */
        public function get previous():Trie
        {
            return _previous ;
        }
        
        /**
         * @private
         */
        public function set previous( t:Trie ):void
        {
            _previous = t ;
        }
        
        /**
         * Inserts the provided object into the trie with the given key.
         * @throws NonUniqueKeyError If the specified key is non unique.
         */
        public function add( key:String , value:* ):void
        {
            if ( key.length == _position )
            {
                if ( _entry != null )
                {
                    throw new NonUniqueKeyError( key ) ;
                }
                _entry = new TrieEntry( key , value ) ;
            }
            else
            {
                var positionKey:String = _getPositionKey( key ) ;
                if( _entries.containsKey( positionKey ) )
                {
                    var object:* = _entries.get( positionKey ) ;
                    if ( object is Trie && ( (object as Trie)._previous == this ) )
                    {
                        ( object as Trie ).add( key , value ) ;
                        return ;
                    }
                    else
                    {
                        var e:TrieEntry = object as TrieEntry ;
                        if ( e.key == key )
                        {
                            throw new NonUniqueKeyError( key ) ;
                        }
                        var down:Trie = new Trie( this ) ;
                        down.add( e.key , e.value ) ;
                        down.add( key , value ) ;
                        _entries.put( positionKey , down ) ;
                    }
                }
                else
                {
                    _entries.put( positionKey , new TrieEntry( key , value ) ) ;
                }
            }
        }
        
        /**
         * Take current Trie and dump output to StringBuffer
         * @param buffer
         * @return String holding content of current Trie
         */
        public function contents( str:String = "" ):String 
        {
            str = str == null ? "" : str ; 
            if (_entry != null) 
            {
                str += _entry.key ;
                str += " " ;
            }
            if( _entries != null && _entries.size() > 0) 
            {
                var it:Iterator = _entries.iterator();
                while ( it.hasNext() ) 
                {
                    var object:* = it.next() ;
                    if ( object is Trie && ((object as Trie)._previous == this)) 
                    {
                        str += (object as Trie).contents();
                    } 
                    else 
                    {
                        str += (object as TrieEntry).key ;
                        str += " " ;
                    }
                }
            }
            return str ;
        }
        
        /**
         * Returns the first element in a trie. Is generally only used when an element is erased from the trie and a trie delete a swapup is required.
         * @return the first element in a trie. Is generally only used when an element is erased from the trie and a trie delete a swapup is required.
         */
        public function firstElement():TrieEntry
        {
            if ( _entry != null )
            {
                return _entry ;
            }
            if ( _entries != null && _entries.size() > 0 )
            {
                var object:* ;
                var it:Iterator = _entries.iterator() ;
                while( it.hasNext() )
                {
                    object = it.next() ;
                    if ( !( object is Trie && ((object as Trie)._previous == this )) )
                    {
                        return object as TrieEntry ;
                    }
                }
            }
            return null ;
        }
        
        /**
         * Returns a Trie of all the elements starting with "key", or an Object which is a single exact match.
         * @return a Trie of all the elements starting with "key", or an Object which is a single exact match.
         */
        public function getTrieFor( key:String ):*
        {
            if ( key.length == _position )
            {
                return this ;
            }
            var positionKey:String = _getPositionKey( key ) ;
            if ( _entries.containsKey( positionKey ) )
            {
                var object:* = _entries.get( positionKey ) ;
                if( object is Trie )
                {
                    return ( object as Trie ).getTrieFor( key ) ;
                }
                else
                {
                    var cur:String = ( object as TrieEntry).key as String ;
                    if ( startsWith( cur , key.toLocaleLowerCase() ) )
                    {
                        return ( object as TrieEntry).value ;
                    }
                }
            }
            return null ;
        }
        
        /**
         * Indicates if the trie is empty.
         */
        public function isEmpty():Boolean
        {
            return size() == 0 ;
        }
        
        /**
         * Removes the object with the given key from the trie.
         */
        public function remove( key:String ):void
        {
            if( key.length == _position )
            {
                if ( _entry != null )
                {
                    _entry = null ;
                    return ;
                }
                else
                {
                    throw new NonUniqueKeyError(key) ;
                }
            }
            else
            {
                var t:Trie ;
                var e:TrieEntry ;
                var positionKey:String = _getPositionKey( key ) ;
                if( _entries.containsKey( positionKey ) )
                {
                    var object:* = _entries.get( positionKey ) ;
                    if ( object is Trie && ( ( object as Trie )._previous == this ) )
                    {
                        t = object as Trie ;
                        t.remove( key ) ;
                        var subTrieSize:int = t.size() ;
                        if ( subTrieSize == 1 )
                        {
                            e = t.firstElement() ;
                            if ( e == null )
                            {
                                _entries.remove( positionKey ) ;
                            }
                            else
                            {
                                _entries.put( positionKey , e ) ;
                            }
                        }
                    }
                    else
                    {
                        e = object as TrieEntry ;
                        if ( e.key == key )
                        {
                            _entries.remove( positionKey ) ;
                        }
                        return ;
                    }
                }
                else
                {
                    throw NoSuchElementError( key ) ;
                }
            }
        }
        
        /**
         * Returns a trie for multiple matches else returns null for no object matched, or returns the object matched.
         * @return a trie for multiple matches else returns null for no object matched, or returns the object matched.
         */
        public function search( key:String ):*
        {
            if ( key.length == _position )
            {
                if ( _entry == null )
                {
                    return this ;
                }
                else
                {
                    return _entry.value ;
                }
            }
            var positionKey:String = _getPositionKey(key) ;
            if ( _entries.containsKey( positionKey ) )
            {
                var object:* = _entries.get( positionKey ) ;
                if ( object is Trie )
                {
                    return ( object as Trie ).search( key ) ;
                }
                else
                {
                    var cur:String = (object as TrieEntry).key as String ;
                    if ( startsWith( cur , key ) )
                    {
                        return ( object as TrieEntry ).value ;
                    }
                    else
                    {
                        return null ;
                    }
                }
            }
            else
            {
                if (_entry == null )
                {
                    return null ;
                }
                else
                {
                    return _entry.value ;
                }
            }
        }
        
        /**
         * Returns a trie but 'not' return a Trie for 'multiple matches'.
         * @return a trie but 'not' return a Trie for 'multiple matches'.
         */
        public function searchExact( key:String ):*
        {
            if ( key.length == _position )
            {
                if ( _entry == null )
                {
                    return null ;
                }
                else
                {
                    return _entry.value ;
                }
            }
            var positionKey:String = _getPositionKey(key) ;
            if ( _entries.containsKey( positionKey ) )
            {
                var value:* = _entries.get( positionKey ) ;
                if ( value is Trie )
                {
                    return ( value as Trie ).searchExact( key ) ;
                }
                else
                {
                    if( ( _position + 1 ) < key.length )
                    {
                        if ( (key.substring( 0 , _position + 1 )).toLocaleLowerCase() == key.toLocaleLowerCase() )
                        {
                            return ( value as TrieEntry).value ;
                        }
                    }
                    
                    if ( key.toLocaleLowerCase() == (value as TrieEntry).key.toLowerCase() )
                    {
                        return ( value as TrieEntry ).value ;
                    }
                    else
                    {
                        return null ;
                    }
                }
            }
            else
            {
                if (_entry == null )
                {
                    return null ;
                }
                else
                {
                    return _entry.value ;
                }
            }
        }
        
        /**
         * Counts the number of linked objects off this trie.
         * @return The number of linked objects in this trie.
         */
        public function size():int
        {
            var count:int ;
            if( _entry != null )
            {
                count++ ;
            }
            if ( _entries != null && _entries.size() > 0 )
            {
                var value:* ;
                var it:Iterator = _entries.iterator() ;
                while( it.hasNext() )
                {
                    value = it.next() ;
                    if ( value is TrieEntry )
                    {
                        count++ ;
                    }
                    else if ( value is Trie )
                    {
                        count += ( value as Trie ).size() ;
                    }
                }
            }
            return count ;
        }
        
        /**
         * Returns the Array representation of the object.
         * @return the Array representation of the object.
         */
        public function toArray( comparator:Comparator = null ):Array
        {
            var ar:Array = [] ;
            fillArray( ar ) ;
            if ( comparator != null )
            {
                ar.sort( comparator.compare ) ;
            }
            return ar ;
        }
        
        /**
         * Returns the String representation of the object.
         * @return the String representation of the object.
         */
        public function toString():String
        {
            return contents() ;
        }
        
        /**
         * @private
         */
        hack var _entries:Map ;
        
        /**
         * @private
         */
        hack var _entry:TrieEntry ;
        
        /**
         * @private
         */
        hack var _position:int ;
        
        /**
         * @private
         */
        hack var _previous:Trie ;
        
        /**
         * @private
         */
        private function _aerageClash( average:TrieAverage = null ):void
        {
            if ( _entry != null )
            {
                average.add( _position ) ;
            }
            if ( _entries != null && _entries.size() > 0 )
            {
                var value:* ;
                var it:Iterator = _entries.iterator() ;
                while( it.hasNext() )
                {
                    value = it.next() ;
                    if ( value is Trie && ( (value as Trie)._previous == this ) )
                    {
                        (value as Trie)._aerageClash( average ) ;
                    }
                    else
                    {
                        average.add( _position ) ;
                    }
                }
            }
        }
        
        /**
         * @private
         */
        private function _getPositionKey( key:String ):String
        {
            var start:int = _position ;
            var end:int   = ( ( _position + 1 ) <= key.length ) ? _position + 1 : _position ;
            return key.substring( start , end ) ;
        }
        
        /**
         * @private
         */
        protected function fillArray( ar:Array ):void
        {
            if ( _entry != null ) 
            {
                ar.push( _entry.value );
            }
            if ( _entries != null && _entries.size() > 0) 
            {
                var object:* ;
                var it:Iterator = _entries.iterator() ;
                while ( it.hasNext() ) 
                {
                    object = it.next() ;
                    if ( object is Trie && ( (object as Trie)._previous == this) ) 
                    {
                        ( object as Trie ).fillArray(ar) ;
                    } 
                    else 
                    {
                        ar.push( ( object as TrieEntry).value );
                    }
                }
            }
        }
    }
}