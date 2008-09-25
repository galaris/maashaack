/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [MaasHaack framework]
  
  The Initial Developer of the Original Code is
  Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  
*/

package system.data.iterators
{
    import system.data.Iterator;
    import system.data.Map;
    
    import flash.errors.IllegalOperationError;    

    /**
     * Converts a <code class="prettyprint">Map</code> to an iterator.
     */
    public class MapIterator implements Iterator
    {
        
       /**
        * Creates a new MapIterator instance.
        * @param m the Map reference of this iterator. 
        */
        public function MapIterator(m:Map)
        {
            _m = m ;
            _i = new ArrayIterator(m.getKeys()) ;
            _k = null ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the iteration has more elements.
         * @return <code class="prettyprint">true</code> if the iteration has more elements.
         */    
        public function hasNext():Boolean
        {
            return _i.hasNext() ;
        }

        /**
         * Returns the current key of the internal pointer of the iterator (optional operation).
         * @return the current key of the internal pointer of the iterator (optional operation).
         */
        public function key():*
        {
            return _k ;
        }
        
           /**
         * Returns the next element in the iteration.
         * @return the next element in the iteration.
         */
        public function next():*
        {
            _k = _i.next() ;
            return _m.get(_k) ;
        }

        /**
         * Removes from the underlying collection the last element returned by the iterator (optional operation).
         */
        public function remove():*
        {
            _i.remove() ;
            return _m.remove(_k) ;
        }

        /**
         * Reset the internal pointer of the iterator (optional operation).
         */
        public function reset():void
        {
            _i.reset() ;
        }        

        /**
         * Change the position of the internal pointer of the iterator (optional operation).
         */    
        public function seek(position:*):void
        {
            throw new IllegalOperationError( "This Iterator does not support the seek() method.") ;
        }
        
        /**
         * @private
         */
        private var _m:Map ; 

        /**
         * @private
         */
        private var _i:ArrayIterator ; 

        /**
         * @private
         */
        private var _k:* ;
    }
}



