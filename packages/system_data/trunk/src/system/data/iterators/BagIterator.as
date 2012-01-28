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

package system.data.iterators
{
    import system.data.Iterator;
    import system.data.bags.CoreMapBag;
    import system.errors.ConcurrencyError;
    
    import flash.errors.IllegalOperationError;
    
    /**
     * Converts an Bag to an iterator.
     */
    public class BagIterator implements Iterator
    {
        
        /**
         * Creates a new BagIterator instance.
         * @param parent the bag <code class="prettyprint">CoreMapBag</code> used in this iterator.
         * @param support the iterator to support this iterator.
         */
        public function BagIterator( parent:CoreMapBag , support:Iterator  )
        {
            if ( parent == null )
            {
                throw new ArgumentError( this + " constructor failed, the passed-in Bag argument not must be 'null'.") ;
            }
            if ( support == null )
            {
                throw new ArgumentError( this + " constructor failed, the passed-in Iterator argument not must be 'null'.") ;
            }
            _parent           = parent;
            _support          = support ;
            _expectedModCount = _parent.modCount ;
        }
        
        /**
         * The default comodification message.
         */
        public static var DEFAULT_COMODIFICATION_MESSAGE:String = "BagIterator check for comodification failed with a Bag." ;
        
        /**
         * This method check the comodification of the Bag and test if the iterator is valid and can continue to process.
         */
        public function checkForComodification( message:String = null ):void 
        {
            if ( _parent.modCount != _expectedModCount )
            {
                throw new ConcurrencyError( message || DEFAULT_COMODIFICATION_MESSAGE ) ;
            }
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the iteration has more elements.
         * @return <code class="prettyprint">true</code> if the iteration has more elements.
         */    
        public function hasNext():Boolean
        {
            return _support.hasNext() ;
        }
        
        /**
         * Unsupported method in all BagIterator.
         * @throws IllegalOperationError <code class="prettyprint">key</code> method in unsupported.
         */
        public function key():*
        {
            throw new IllegalOperationError( this + " 'key' method is unsupported.") ;
        }
        
        /**
         * Returns the next element in the iteration.
         * @return the next element in the iteration.
         * @throws ConcurrentModificationError the next method failed with an internal concurrent modification.
         */
        public function next():*
        {
            checkForComodification( this + " concurrent modification impossible in 'next' method.");
            _current = _support.next() ;
            return _current;
        }
        
        /**
         * Removes from the underlying collection the last element returned by the iterator (optional operation).
         */
        public function remove():*
        {
            checkForComodification(this + " concurrent modification impossible in 'remove' method.");
            _support.remove() ;
            var r:* = _parent.removeCopies(_current, 1);
            _expectedModCount = _parent.modCount ;
            return r ;
        }
        
        /**
         * Unsupported method in all BagIterator.
         * @throws IllegalOperationError <code class="prettyprint">reset</code> method in unsupported.
         */
        public function reset():void
        {
            throw new IllegalOperationError(this + " 'reset' method is unsupported.") ;
        }
        
        /**
         * Unsupported method in all BagIterator.
         * @throws IllegalOperationError <code class="prettyprint">seek</code> method in unsupported.
         */
        public function seek(position:*):void
        {
            throw new IllegalOperationError(this + " 'seek' method is unsupported.") ;
        }
        
        /**
         * @private
         */
        private var _current:* ;
        
        /**
         * @private
         */
        private var _expectedModCount:uint ;
        
        /**
         * @private
         */
        private var _parent:CoreMapBag ;
        
        /**
         * @private
         */
        private var _support:Iterator ;
    }
}