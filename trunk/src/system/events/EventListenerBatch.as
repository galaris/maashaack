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

package system.events 
{
    import core.dump;
    import core.reflect.getClassPath;

    import system.data.Collection;
    import system.data.Iterator;
    import system.data.collections.formatter;
    import system.data.iterators.VectorIterator;

    import flash.events.Event;

    /**
     * The EventListenerBatch objects handle several <code class="prettyprint">EventListener</code> as one <code class="prettyprint">EventListener</code>.
     */
    public class EventListenerBatch implements Collection , EventListener
    {
        /**
         * Creates a new EventListenerBatch instance.
         * @param init The optional Array or Vector of EventListener objects to fill the batch.
         */
        public function EventListenerBatch( init:* = null )
        {
            _v = new Vector.<EventListener>() ;
            if ( init )
            {
                for each( var listener:* in init)
                {
                    if ( listener is EventListener )
                    {
                        add( listener ) ;
                    }
                }
            }
        }
        
        /**
         * Inserts an element in the collection.
         */
        public function add( o:* ):Boolean
        {
            if ( o == null ) 
            {
                return false ;
            }
            try
            {
                _v.push(o) ;
                return true ;
            }
            catch( e:Error )
            {
                //
            }
            return false ;
        }
        
        /**
         * Removes all elements in the collection.
         */
        public function clear():void
        {
            _v.length = 0 ;
        }
        
        /**
         * Returns a shallow copy of this instance.
         * @return a shallow copy of this instance.
         */ 
        public function clone():* 
        {
            var b:EventListenerBatch = new EventListenerBatch() ;
            var l:int = _v.length ;
            if ( l > 0 )
            {
                var i:int = -1 ;
                while (++i < l) 
                { 
                    b.add( _v[i] as EventListener)  ;
                }
            }
            return b ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if this collection contains the specified element.
         * @return <code class="prettyprint">true</code> if this collection contains the specified element.
         */
        public function contains( o:* ):Boolean
        {
            return _v.indexOf( o ) >- 1 ;
        }
        
        /**
         * Returns the element from this collection at the passed key index.
         * @return the element from this collection at the passed key index.
         */
        public function get( key:* ):*
        {
            return _v[key] ;
        }
        
        /**
         * Handles the event.
         */
        public function handleEvent( e:Event ):void
        {
            var l:int = _v.length ;
            if ( l > 0 )
            {
                var i:int = -1 ;
                while (++i < l) 
                { 
                    (_v[i] as EventListener).handleEvent(e) ;
                }
            }
        }
        
        /**
         * Returns the index of an element in the collection.
         * @return the index of an element in the collection.
         */
        public function indexOf( o:* , fromIndex:uint = 0 ):int
        {
            return _v.indexOf( o , fromIndex ) ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if this collection contains no elements.
         * @return <code class="prettyprint">true</code> if this collection contains no elements.
         */
        public function isEmpty():Boolean
        {
            return _v.length == 0 ;
        }
        
        /**
         * Returns the iterator reference of the object.
         * @return the iterator reference of the object.
         */  
        public function iterator():Iterator
        {
            return new VectorIterator( _v ) ;
        }
        
        /**
         * Removes a single instance of the specified element from this collection, if it is present (optional operation).
         */
        public function remove( o:* ):*
        {
            var index:int = this._v.indexOf( o ) ;
            if ( index > -1 )
            {
                this._v.splice( index , 1 ) ;
                return true ;
            }
            return false ;
        }
        
        /**
         * Returns the number of elements in this collection.
         * @return the number of elements in this collection.
         */
        public function size():uint
        {
            return _v.length ;
        }
        
        /**
         * Returns an array containing all of the elements in this collection.
         * <p><b>Note:</b> The returned Array is a reference of the internal Array used in the Collection to store the items. It's not a shallow copy of it.</p>
         * @return an array containing all of the elements in this collection.
         */
        public function toArray():Array
        {
            var ar:Array = [] ;
            var len:int = _v.length ;
            if ( len == 0 )
            {
                return ar ;
            }
            for( var i:int ; i<len ; i++)
            {
                ar[i] = _v[i] ;
            }
            return ar ;
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource( indent:int = 0 ):String
        {
            var ar:Array = toArray() ;
            var source:String = "new " + getClassPath( this , true ) ;
            source += "(" ;
            if ( ar.length > 0 )
            {
                source += dump( ar ) ;
            } 
            source += ")" ;
            return source ;
        }
        
        /**
         * Returns the vector containing all of the Runnable objects in this batch.
         * @return the vector containing all of the Runnable objects in this batch.
         */
        public function toVector():Vector.<EventListener>
        {
            return _v ;
        }
        
        /**
         * Returns the string representation of this instance.
         * @return the string representation of this instance.
         */
        public function toString():String
        {
            return formatter.format( this ) ;
        }
        /**
         * @private
         */
        private var _v:Vector.<EventListener> ;
    }
}
