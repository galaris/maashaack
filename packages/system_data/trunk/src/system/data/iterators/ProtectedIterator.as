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
    
    import flash.errors.IllegalOperationError;
    
    /**
     * Protect an iterator. This class protect the remove, reset and seek method.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.data.iterators.StringIterator ;
     * import system.data.iterators.ProtectedIterator ;
     * 
     * var it:ProtectedIterator = new ProtectedIterator( new StringIterator( "hello world" ) ) ;
     * while ( it.hasNext() )
     * {
     *     trace( it.next() ) ;
     * }
     * </pre>
     */
    public class ProtectedIterator implements Iterator
    {
        /**
         * Creates a new ProtectedIterator instance.
         * @param iterator the iterator to protected.
         * @throws ArgumentError If the iterator the passed-in parameter is null or undefined.
         */
        public function ProtectedIterator( i:Iterator )
        {
            if ( i == null )
            {
               throw new ArgumentError( "ProtectedIterator constructor don't support a null iterator in argument.") ;
            }
            _i = i ;
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
            return _i.key() ;
        }
        
        /**
         * Returns the next element in the iteration.
         * @return the next element in the iteration.
         */
        public function next():*
        {
            return _i.next() ;
        }
        
        /**
         * Unsupported method in all ProtectedIterator objects.
         * @throws IllegalOperationError the remove() method is unsupported in a ProtectedIterator instance.
         */
        public function remove():*
        {
            throw new IllegalOperationError("This Iterator does not support the remove() method.") ;
        }
        
        /**
         * Unsupported method in all ProtectedIterator.
         * @throws IllegalOperationError the reset() method is unsupported in a ProtectedIterator instance.
         */
        public function reset():void
        {
            throw new IllegalOperationError("This Iterator does not support the reset() method.") ;
        }
        
        /**
         * Unsupported method in all ProtectedIterator.
         * @throws IllegalOperationError the seek() method is unsupported in a ProtectedIterator instance.
         */
        public function seek(position:*):void
        {
            throw new IllegalOperationError("This Iterator does not support the seek() method.") ;
        }
        
        /**
         * @private
         */
        private var _i:Iterator ;
    }
}