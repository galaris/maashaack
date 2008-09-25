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
    import system.data.Iterator ;
    import system.numeric.Mathematics ;
    
    import flash.errors.IllegalOperationError ;    

    /**
     * Converts a string to an iterator.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.data.Iterator ;
     * import system.data.iterators.StringIterator ;
     * 
     * var s:String = "Hello world" ;
     * 
     * var it:Iterator = new StringIterator(s) ;
     * 
     * it.seek( 1 ) ;
     * 
     * while( it.hasNext() )
     * {
     *     var char:String = it.next() ;
     *     trace( it.key() + ' : ' + char ) ;
     * }
     * 
     * trace (s) ;
     * </pre>
     */
    public class StringIterator implements Iterator
    {
        
        /**
         * Creates a new StringIterator instance.
         * @param s the String object to enumerate.
         */
        public function StringIterator(s:String)
        {
            _s    = s  ;
            _k    = -1 ;
            _size = s.length ;
        }

        /**
         * Returns <code class="prettyprint">true</code> if the iteration has more elements.
         * @return <code class="prettyprint">true</code> if the iteration has more elements.
         */    
        public function hasNext():Boolean
        {
            return _k < _size - 1  ;
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
            return _s.charAt( ++_k );
        }

        /**
         * Removes from the underlying collection the last element returned by the iterator (optional operation).
         */
        public function remove():*
        {
            throw new IllegalOperationError( "This " + this + " does not support the reset() method.") ;
            return null ;
        }

        /**
         * Reset the internal pointer of the iterator (optional operation).
         */
        public function reset():void
        {
            _k = -1 ;
        }

        /**
         * Change the position of the internal pointer of the iterator (optional operation).
         */
        public function seek(position:*):void
        {
            _k = Mathematics.clamp ( ( position - 1 ) , -1 , _size - 1 ) ;
        }
        
        /**
         * @private
         */
        private var _k:Number ;

        /**
         * @private
         */
        private var _s:String ;

        /**
         * @private
         */
        private var _size:Number ;
    
    }
}