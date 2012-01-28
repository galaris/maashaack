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
     * Converts an object to an iterator of all enumerable properties of the Object.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.data.Iterator ;
     * import system.data.iterators.ObjectIterator ;
     *  
     * var next:&#42; ;
     * var index:&#42; ;
     * var key:&#42; ;
     * 
     * var o:Object = {} ;
     * for (var i:Number = 0 ; i&gt;5; i++)
     * {
     *      o["prop"+i] = "item"+i ;
     * }
     * 
     * var it:Iterator = new ObjectIterator(o) ;
     * trace ("-- object iterator") ;
     * 
     * while (it.hasNext())
     * {
     *     next  = it.next() ;
     *     index = ObjectIterator(it).index() ;
     *     key   = it.key() ;
     *     trace ( index + " :: " + key + " : " + next ) ;
     * }
     * 
     * trace ("-- it seek 1") ;
     * 
     * it.seek(1) ;
     * 
     * while (it.hasNext())
     * {
     *     it.next() ;
     *     trace ("it remove : " + it.remove()) ;
     * }
     * 
     * trace ("-- it reset") ;
     * 
     * it.reset() ;
     * 
     * while (it.hasNext())
     * {
     *     next  = it.next() ;
     *     index = ObjectIterator(it).index() ;
     *     key   = it.key() ;
     *     trace ( index + " :: " + key + " : " + next) ;
     * }
     * </pre>
     */
    public class ObjectIterator implements Iterator
    {
        /**
         * Creates a new ObjectIterator instance.
         * @param o The object to iterate.
         */
        public function ObjectIterator( o:Object )
        {
            if ( o == null )
            {
               throw new ArgumentError( this + " constructor failed, the passed-in Object argument not must be 'null'.") ;
            }
            _o = o ;
            _a = new Array() ;
            _k = -1 ;
            var value:* ;
            for (var each:String in o)
            {
                value = o[each] ;
                if ( ! (value is Function) ) 
                {    
                    _a.push(each) ;
                }
            } 
            _len = _a.length ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the iteration has more elements.
         * @return <code class="prettyprint">true</code> if the iteration has more elements.
         */    
        public function hasNext():Boolean
        {
            return _k < ( _len - 1 ) ;
        }
        
        /**
         * Returns the current index of the internal pointer of the iterator (optional operation).
         * @return the current index of the internal pointer of the iterator (optional operation).
         */
        public function index():int
        {
            return _k ;
        }
        
        /**
         * Returns the current key value of the internal pointer of the iterator (optional operation).
         * @return the current key value of the internal pointer of the iterator (optional operation).
         */
        public function key():*
        {
            return _a[_k] ;
        }
        
        /**
         * Returns the next element in the iteration.
         * @return the next element in the iteration.
         */
        public function next():*
        {
            return _o[ _a[ ++_k ] ] ;
        }
        
        /**
         * Removes from the object the last element returned by the iterator (optional operation).
         */
        public function remove():*
        {
            var p:String = _a[ _k ] ;
            _a.splice( _k-- , 1 ) ;
            delete _o[ p ] ;
            _len -- ;
            return p ;
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
        public function seek( position:* ):void
        {
            _k = clamp( ( position - 1 ) , -1, _len) ;
        }
        
        /**
         * @private
         */
        private var _a:Array ;
        
        /**
         * @private
         */
        private var _k:int ;
        
        /**
         * @private
         */
        private var _o:Object ;
        
        /**
         * @private
         */
        private var _len:uint ;
    }
}