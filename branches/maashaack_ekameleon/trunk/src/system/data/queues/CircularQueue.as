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

package system.data.queues 
{
    import core.dump;
    import core.reflect.getClassPath;
    
    import system.data.Boundable;
    import system.data.Iterator;
    import system.data.Queue;
    import system.data.iterators.ArrayIterator;
    import system.data.iterators.ProtectedIterator;
    
    import flash.errors.IllegalOperationError;
    
    /**
     * The CircularQueue class allows for storing objects in a circular queue of a predefined size.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.data.Iterator ;
     * import system.datas.queues.CircularQueue ;
     * 
     * var q:CircularQueue = new CircularQueue(5) ;
     * 
     * trace ("maxSize : " + q.maxSize()) ;
     * trace ("enqueue item1 : " + q.enqueue ("item1")) ;
     * trace ("enqueue item2 : " + q.enqueue ("item2")) ;
     * trace ("enqueue item3 : " + q.enqueue ("item3")) ;
     * trace ("enqueue item4 : " + q.enqueue ("item4")) ;
     * trace ("enqueue item5 : " + q.enqueue ("item5")) ;
     * trace ("enqueue item6 : " + q.enqueue ("item6")) ;
     * 
     * trace ("element : " + q.element()) ;
     * trace ("dequeue : " + q.dequeue()) ;
     * trace ("element : " + q.element()) ;
     * trace ("size : " + q.size()) ;
     * trace ("isFull : " + q.isFull()) ;
     * trace ("array : " + q.toArray()) ;
     * 
     * trace("") ;
     * 
     * trace ("queue : " + q) ;
     * 
     * trace("") ;
     * 
     * trace ("dequeue : " + q.dequeue()) ;
     * trace ("enqueue item6 : " + q.enqueue("item6")) ;
     * trace ("enqueue item7 : " + q.enqueue("item7")) ;
     * trace ("peek : " + q.peek()) ;
     * trace ("size : " + q.size()) ;
     * trace ("isFull : " + q.isFull()) ;
     * 
     * trace("") ;
     * 
     * trace ("q : " + q) ;
     * 
     * trace ("------- clone") ;
     * 
     * var clone:CircularQueue = q.clone() ;
     * 
     * trace ("dequeue clone : " + clone.dequeue()) ;
     * trace ("enqueue clone item8 : " + clone.enqueue("item8")) ;
     * trace ("original queue : " + q) ;
     * trace ("clone queue : " + clone) ;
     * trace ("clone iterator :") ;
     * 
     * var i:Iterator = clone.iterator() ;
     * while (i.hasNext()) 
     * {
     *     trace ("\t+ " + i.next()) ;
     * }
     * 
     * trace("clone.toSource : " + clone.toSource()) ;
     * </pre>
     */
    public class CircularQueue implements Boundable, Queue 
    {
        /**
         * Creates a new CircularQueue instance.
         * @param qSize the max number of element in the queue
         * @param elements an array with elements to enqueue in the current stack.
         */
        public function CircularQueue( qSize:uint=uint.MAX_VALUE , elements:Array=null )
        {
            _qSize = (qSize > MAX_CAPACITY) ? MAX_CAPACITY : (qSize + 1) ;
            
            clear() ;
            
            if (elements == null) 
            {
                return ;
            }
            else
            {
                var l:int = elements.length ;
                if (l > 0)
                {
                    for (var i:int = 0 ; i<l ; i++)
                    {
                        enqueue( elements[i] ) ;
                    }
                }
            }
        }
        
        /**
         * The default numbers of elements in the queue.
         */
        public static var MAX_CAPACITY:uint = uint.MAX_VALUE ;
        
        /**
         * Unsupported method in all CircularQueue objects.
         * @throws IllegalOperationError the add() method is unsupported in a CircularQueue instance.
         */
        public function add(o:*):Boolean
        {
            throw new IllegalOperationError("The CircularQueue class does support the add() method.") ;
            return false ;
        }
        
        /**
         * Clear all elements in the queue.
         */
        public function clear():void
        {
            _queue = new Array(_qSize) ;
            _count = 0 ;
            _rear  = 0 ;
            _front = 0 ;
        }
        
        /**
         * Returns a shallow copy of the queue.
         * @return a shallow copy of the queue.
         */
        public function clone():*
        {
            var s:int    = _qSize - 1 ;
            var a:Array  = toArray() ;
            return new CircularQueue(s , a) ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the queue contains the object passed in argument.
         * @return <code class="prettyprint">true</code> if the queue contains the object passed in argument.
         */
        public function contains(o:*):Boolean
        {
            return _queue.indexOf(o) != -1 ;
        }
        
        /**
         * Retreives the first element in the queue object, return a boolean.
         * @return <code class="prettyprint">true</code> if the first element in the queue is dequeue.
         */
        public function dequeue():Boolean
        {
            return poll() != null  ;
        }
        
        /**
         * Returns the value of the first element in the queue.
         * @return the value of the first element in the queue.
         */
        public function element():*
        {
            return _queue[_front] ;
        }
        
        /**
         * Enqueue a new element in the queue if the que is not full, return a boolean.
         */
        public function enqueue(o:*):Boolean
        {
            var next:uint = _rear + 1 ;
            if ( (next == _front) || ( ( next == _qSize) && (_front == 0) )) 
            {
                return false ;
            } 
            else 
            {
                _queue[_rear++] = o ;
                _count ++ ;
                if (_rear == _qSize) 
                {
                    _rear = 0 ;   
                }
            }
            return true ;
        }
        
        /**
         * Unsupported method in all CircularQueue objects.
         * @throws IllegalOperationError the get() method is unsupported in a CircularQueue instance.
         */
        public function get(key:*):*
        {
            throw new IllegalOperationError("The CircularQueue class does support the get() method.") ;
        }
        
        /**
         * Unsupported method in all CircularQueue objects.
         * @throws IllegalOperationError the indexOf() method is unsupported in a CircularQueue instance.
         */
        public function indexOf(o:*, fromIndex:uint = 0):int
        {
            throw new IllegalOperationError("The CircularQueue class does support the indexOf() method.") ;
            return 0 ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the queue is empty.
         * @return <code class="prettyprint">true</code> if the queue is empty.
         */
        public function isEmpty():Boolean
        {
            return _count == 0 ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the queue is full.
         * @return <code class="prettyprint">true</code> if the queue is full.
         */
        public function isFull():Boolean
        {
            return _count == maxSize() ;
        }
        
        /**
         * Returns the iterator representation of the queue.
         * @return the iterator representation of the queue.
         * @see system.data.iterators.ProtectedIterator
         */
        public function iterator():Iterator
        {
            return (new ProtectedIterator( new ArrayIterator( toArray() ) ) ) ;
        }
        
        /**
         * Returns the max number of occurrences in the given queue.
         * @return the max number of occurrences in the given queue.
         */
        public function maxSize():uint
        {
            return _qSize - 1 ;
        }
        
        /**
         * Retrieves, but does not remove, the head of this queue, returning null if this queue is empty.
         */
        public function peek():*
        {
            return ( _count == 0 ) ? null : _queue[_front] ;
        }
        
        /**
         * Retrieves and removes the head of this queue.
         */
        public function poll():*
        {
            if (_front == _qSize) 
            {
                _front = 0 ; // loop back
            }
            if (_front == _rear) 
            {
                return null;  // queue is empty
            }
            else  
            {
                _count-- ;
                var mem:* = _queue[_front] ;
                _queue[_front] = undefined ;
                _front++ ;
                return mem ; // return mem object
            }
        }
        
        /**
         * Unsupported method in all CircularQueue objects.
         * @throws IllegalOperationError the remove() method is unsupported in a CircularQueue instance.
         */
        public function remove(o:*):*
        {
            throw new IllegalOperationError("The CircularQueue class does support the remove() method.") ;
            return null ;
        }
        
        /**
         * Returns the number of elements in the CircularQueue.
         * @return the number of elements in the CircularQueue.
         */
        public function size():uint
        {
            return _count ;
        }
        
        /**
         * Returns the array representation of the CircularQueue.
         * @return the array representation of the CircularQueue.
         */
        public function toArray():Array
        {
            if (_count == 0) 
            {
                return [] ;
            } 
            else 
            {
                var r:Array = new Array(_count) ;
                var i:Number = (_front == _qSize) ? 0 : _front ;
                var cpt:uint = 0 ;
                while (cpt < _count) 
                {
                    r[cpt++] = _queue[i++] ;
                    if (i == _qSize) i = 0 ;
                }
                return r ;
            }
        }
        
        /**
         * Returns a eden representation of the object.
         * @return a string representation of the source code of the object.
         */
        public function toSource(indent:int = 0):String
        {
            var source:String = "new " + getClassPath( this , true ) ;
            
            source += "(" ;
            
            source += maxSize() ;
            
            var ar:Array = toArray() ;
            
            if ( ar.length > 0 )
            {
                source += "," ;
                source += dump( ar ) ;
            } 
            
            source += ")" ;
            
            return source ;
        }
        
        /**
         * Returns the string representation of this instance.
         * @return the string representation of this instance
         */
        public function toString():String
        {
            return formatter.format(this) ;
        } 
       
        /**
         * The number of objects currently stored in the queue.
         * @private
         */
        private var _count:uint ; 
        
        /**
         * The array index for the next object to be removed from the queue.
         * @private
         */
        private var _front:uint ;
        
        /**
         * @private
         */
        private var _queue:Array ;
        
        /**
         * The number of objects in the array : queue size + 1
         * @private
         */
        private var _qSize:uint ;
        
        /**
         * The array index for the next object to be stored in the queue.
         * @private
         */
        private var _rear:uint ;
    }
}
