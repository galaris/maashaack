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

package system.data.queues 
{
    import system.Comparator;
    import system.Sortable;
    import system.data.queues.LinearQueue;
    
    /**
     * This queue orders elements according to an order specified at construction time, which is specified either according to their natural order or according to a IComparator object.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.data.queues.PriorityQueue ;
     * import system.comparators.AlphaComparator ;
     * import system.comparators.NumberComparator ;
     * 
     * var init:Array = [5, 4, 3, 2, 1] ;
     * var q:PriorityQueue = new PriorityQueue( init , new NumberComparator() , Array.NUMERIC  )  ;
     * 
     * trace ("queue size : " + q.size()) ;
     * trace("queue " + q) ;
     * 
     * q.options = Array.NUMERIC + Array.DESCENDING ;
     * trace("queue " + q) ;
     * 
     * q.clear() ;
     * 
     * q.comparator = new AlphaComparator() ;
     * q.options    = Array.CASEINSENSITIVE | Array.DESCENDING ;
     * 
     * trace ("enqueue item4 : " + q.enqueue ("item4")) ;
     * trace ("enqueue item2 : " + q.enqueue ("item2")) ;
     * trace ("enqueue item3 : " + q.enqueue ("item3")) ;
     * trace ("enqueue item1 : " + q.enqueue ("item1")) ;
     * 
     * trace("queue " + q) ;
     * 
     * q.options = Array.CASEINSENSITIVE ;
     * trace("queue " + q) ;
     * </pre>
     */
    public class PriorityQueue extends LinearQueue implements Sortable
    {
        /**
         * Creates a new PriorityQueue instance.
         * @param init An optional <code class="prettyprint">Array</code> or <code class="prettyprint">Collection</code> or <code class="prettyprint">Iterable</code> object to fill the collection.
         * @param comp An optional <code class="prettyprint">Comparator</code> object used in the <code class="prettyprint">PriorityQueue</code> to defined the sort model when enqueue or modify the queue.
         * @param options The optional "options" value use to sort the priority queue.
         */
        public function PriorityQueue( init:* = null , comp:Comparator=null, options:uint = 0 )
        {
            super( init );
            _comparator = comp ;
            _options    = options ;
            sort() ;
        }
        
        /**
         * The default options value.
         */
        public static const NONE:uint = 0 ;
        
        /**
         * Determinates the <code class="prettyprint">Comparator</code> strategy used to sort the instance.
         */
        public function get comparator():Comparator
        {
            return _comparator ;
        }
        
        /**
         * @private
         */
        public function set comparator( comp:Comparator ):void
        {
            _comparator = comp ;
            sort() ;
        }
        
        /**
         * Indicates the options to sort the elements in the list.
         */
        public function get options():uint
        {
            return _options ;
        }
        
        /**
         * @private
         */
        public function set options( o:uint ):void 
        {
            _options = o ;
            sort() ;
        }
        
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():* 
        {
            return new PriorityQueue( toArray() , comparator , options );
        }
        
        /**
         * Inserts the specified element into this queue, if possible.
         */
        public override function enqueue( o:* ):Boolean 
        {
            var isEnqueue:Boolean = super.enqueue(o) ;
            if ( isEnqueue && _comparator != null ) 
            {
                sort() ;
            }
            return isEnqueue ;
        }
        
        /**
         * Sorts the queue with the internal Comparator or with the Array.sort method if the method a.
         */
        public function sort( ...arguments:Array ):void 
        {
            if ( arguments.length > 0 )
            {
                _a.sort.apply(_a, arguments ) ; 
            }
            else if ( size() > 0 && _comparator != null) 
            {
                _a.sort( _comparator.compare, _options ) ;
            }
        }
        
        /**
         * @private
         */
        protected var _comparator:Comparator ;
        
        /**
         * @private
         */
        protected var _options:uint ;
    }
}
