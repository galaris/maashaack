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
    import core.maths.clamp;

    import system.data.Iterator;

    /**
     * Converts a <code class="prettyprint">Vector</code> to an iterator.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.iterators.VectorIterator ;
     * import system.Iterator ;
     * 
     * var ve:Vector.&lt;String&gt; = new Vector.&lt;String&gt;() ;
     * 
     * ve[0] = "item1" ;
     * ve[1] = "item2" ;
     * ve[2] = "item3" ;
     * 
     * var it:VectorIterator = new VectorIterator(ve) ;
     * 
     * while (it.hasNext())
     * {
     *     trace (it.next()) ;
     * }
     * 
     * trace ("--- it reset") ;
     * 
     * it.reset() ;
     * while (it.hasNext()) 
     * {
     *     trace (it.next() + " : " + it.key()) ;
     * }
     * 
     * trace ("--- it seek 2") ;
     * 
     * it.seek(2) ;
     * while (it.hasNext())
     * {
     *     trace (it.next()) ; // item3
     * }
     * 
     * trace ("---") ;
     * </pre>
     */
    public class VectorIterator implements Iterator 
    {
        /**
         * Creates a new VectorIterator instance.
         * @param vector the Vector to enumerate with the iterator.
         * @throws ArgumentError If the the passed-in vector argument is 'null'.
         * @throws ArgumentError If the the passed-in vector argument is not a Vector.
         */
        public function VectorIterator( vector:* )
        {
            if ( vector == null )
            {
               throw new ArgumentError( this + " constructor failed, the passed-in Vector argument not must be 'null'.") ; 
            }
            if ( !( vector is Vector.<*> ) )
            {
                throw new ArgumentError( this + " constructor failed, the passed-in Vector argument must be a 'Vector' object.") ;
            }
            _v = vector  ;
            _k = 0 ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the iteration has more elements.
         * @return <code class="prettyprint">true</code> if the iteration has more elements.
         */  
        public function hasNext():Boolean
        {
             return _k < _v.length ;
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
            return _v[_k++] ;
        }
        
        /**
         * Removes from the underlying collection the last element returned by the iterator (optional operation).
         */
        public function remove():*
        {
            return _v.splice( --_k , 1 )[0] ; 
        }
        
        /**
         * Reset the internal pointer of the iterator (optional operation).
         */
        public function reset():void
        {
            _k = 0 ;
        }
        
        /**
         * Changes the position of the internal pointer of the iterator (optional operation).
         */
        public function seek( position:* ):void
        {
            _k = clamp( position , 0 , _v.length - 1) ;
        }
        
        /**
         * The current Vector reference
         */
        protected var _v:* ; 
        
        /**
         * The current iterator key.
         */
        protected var _k:int ;
    }
}
