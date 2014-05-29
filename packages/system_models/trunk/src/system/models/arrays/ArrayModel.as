
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
  Portions created by the Initial Developers are Copyright (C) 2006-2014
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

package system.models.arrays
{
    import system.models.ChangeModel;
    import system.signals.Signal;
    
    /**
     * This model use an internal <code class="prettyprint">Array</code> to register objects.
     * <p><b>Example :</b></p>
     * <listing version="3.0">
     * <code class="prettyprint">
     * package examples
     * {
     *     import core.dump;
     *     
     *     import system.models.arrays.ArrayModel;
     *     
     *     import flash.display.Sprite;
     *     
     *     public class ArrayModelExample extends Sprite
     *     {
     *         public function ArrayModelExample()
     *         {
     *             model = new ArrayModel() ;
     *             
     *             model.added.connect( added ) ;
     *             model.beforeChanged.connect( beforeChanged ) ;
     *             model.changed.connect( changed ) ;
     *             model.cleared.connect( cleared ) ;
     *             model.removed.connect( removed ) ;
     *             model.updated.connect( updated ) ;
     *             
     *             model.add( o1 ) ;
     *             model.add( o2 ) ;
     *             model.add( o3 ) ;
     *             model.add( o4 ) ;
     *             model.add( o5 ) ;
     *             model.add( o6 ) ;
     *             
     *             debug( this + " model length:" + model.length ) ;
     *             
     *             debug( this + " model.get(0) == o1 : " + dump( model.get(0)) ) ;
     *             debug( this + " model.get(1) == o4 : " + dump( model.get(1)) ) ;
     *             
     *             model.updateAt( 0 , o4 ) ;
     *             debug( this + " model.get(0) == o1 : " + dump( model.get(0)) ) ;
     *             
     *             model.current = o1 ;
     *             model.current = o2 ;
     *             
     *             model.removeAt( 0 ) ;
     *             model.removeAt( 0 , 2 ) ;
     *             model.remove( o6 ) ;
     *             
     *             debug( this + " model length:" + model.length ) ;
     *             
     *             model.clear() ;
     *             
     *             debug( this + " model length:" + model.length ) ;
     *         }
     *         
     *         protected var model:ArrayModel ;
     *         
     *         protected var o1:Object = { id : "key1" } ;
     *         protected var o2:Object = { id : "key2" } ;
     *         protected var o3:Object = { id : "key3" } ;
     *         protected var o4:Object = { id : "key4" } ;
     *         protected var o5:Object = { id : "key5" } ;
     *         protected var o6:Object = { id : "key6" } ;
     *         
     *         protected function added( index:uint , value:* , model:ArrayModel ):void
     *         {
     *             trace( model + " added : " + dump(value) ) ;
     *         }
     *         
     *         protected function beforeChanged( value:* , model:ArrayModel ):void
     *         {
     *             trace( model + " beforeChanged : " + dump(value) ) ;
     *         }
     *         
     *         protected function changed( value:* , model:ArrayModel ):void
     *         {
     *             trace( model + " changed : " + dump(value) ) ;
     *         }
     *         
     *         protected function cleared( model:ArrayModel ):void
     *         {
     *             trace( model + " cleared" ) ;
     *         }
     *         
     *         protected function removed( index:uint , old:* , model:ArrayModel ):void
     *         {
     *             debug( model + " removed at:" + index + " old:" + dump(old) ) ;
     *         }
     *         
     *         protected function updated( index:uint , old:* , model:ArrayModel ):void
     *         {
     *             trace( model + " updated at:" + index + " old:" + dump( old ) ) ;
     *         }
     *     }
     * }
     * </code>
     * </listing>
     */
    public class ArrayModel extends ChangeModel
    {
        /**
         * Creates a new ArrayModel instance.
         * @param factory The optional Array factory reference used in the model to register all entries.
         */
        public function ArrayModel( factory:Array = null )
        {
            _array = factory || [] ;
        }
        
        /**
         * Emits a message when an entry is added in the model.
         */
        public const added:Signal = new Signal() ;
        
        /**
         * Indicates the number of entries in the model.
         */
        public function get length():uint
        {
            return _array.length ;
        }
        
        /**
         * Emits a message when an entry is removed in the model.
         */
        public const removed:Signal = new Signal() ;
        
        /**
         * Emits a message when an entry is updated in the model.
         */
        public const updated:Signal = new Signal() ;
        
        /**
         * Inserts an entry in the model.
         * @param entry The entry to insert in the model.
         * @throws ArgumentError if the entry in argument is 'null' or 'undefined'. 
         */
        public function add( entry:Object ):void
        {
            if ( entry == null )
            {
                throw new ArgumentError( this + " add method failed, the passed-in argument not must be 'null'.") ;
            }
            validate( entry ) ;
            _array.push( entry ) ;
            notifyAdd( _array.length - 1 , entry ) ;
        }
        
        /**
         * Inserts an entry in the model.
         * @throws ArgumentError if the entry in argument is 'null' or 'undefined'. 
         */
        public function addAt( index:uint , entry:Object ):void
        {
            if ( entry == null )
            {
                throw new ArgumentError( this + " add method failed, the passed-in argument not must be 'null'.") ;
            }
            validate( entry ) ;
            _array.splice( index , 0 , entry ) ;
            notifyAdd( index , entry ) ;
        }
        
        /**
         * Removes all value objects in the model.
         */
        public override function clear():void
        {
            _array.length = 0 ;
            super.clear() ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the model contains the specified entry.
         * @param entry The entry reference to verify.
         * @return <code class="prettyprint">true</code> if the model contains the specified entry.
         */
        public function contains( entry:Object ):Boolean
        {
            return _array.indexOf( entry ) > -1 ;
        }
        
        /**
         * Returns the element from this model at the passed index.
         * @param index The index of the element to return.
         * @return the element from this model at the passed index.
         */
        public function get( index:uint ):Object
        {
            return _array[ index ] ;
        }
        
        /**
         * Returns the internal array representation of this model.
         * @return the internal array representation of this model.
         */
        public function getArray():Array
        {
            return _array ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the model is empty.
         * @return <code class="prettyprint">true</code> if the model is empty.
         */
        public function isEmpty():Boolean 
        {
            return _array.length == 0;
        }
        
        /**
         * Removes an entry in the model.
         */
        public function remove( entry:Object ):void
        {
            if ( entry == null )
            {
                throw new ArgumentError( this + " remove method failed, the entry passed in argument not must be null.") ;
            }
            var index:int = _array.indexOf( entry );
            if ( index > -1 )
            {
                removeAt( index ) ;
            }
            else
            {
                throw new ArgumentError( this + " remove method failed, the entry is not register in the model.") ;
            }
        }
        
        /**
         * Removes from this model all the elements that are contained between the specific <code class="prettyprint">id</code> position and the end of this list (optional operation).
         * @param id The index of the element or the first element to remove.
         * @param count The number of elements to remove (default 1).  
         * @return The Array representation of all elements removed in the original list.
         */        
        public function removeAt( index:uint, count:int = 1 ):*
        {
            count = count > 1 ? count : 1 ;
            var old:* = _array.splice( index , count );
            if( old )
            {
                notifyRemove( index, old ) ;
            }
        }
        
        /**
         * Removes from this model all of the elements whose index is between fromIndex, inclusive and toIndex, exclusive. 
         * <p>Shifts any succeeding elements to the left (reduces their index).</p> 
         * <p>This call shortens the model by (toIndex - fromIndex) elements. (If toIndex==fromIndex, this operation has no effect.)</p>
         * @param fromIndex The from index (inclusive) to remove elements in the list.
         * @param toIndex The to index (exclusive) to remove elements in the list.
         */
        public function removeRange( fromIndex:uint , toIndex:uint ):*
        {
            if ( fromIndex == toIndex )
            {
                return null ;
            }
            return removeAt( fromIndex , toIndex - fromIndex ) ;
        }
        
        /**
         * Update an entry in the model with the specified index.
         * @param index The index to update an entry.
         * @param entry the new value to insert in the model at the specified index.
         */
        public function updateAt( index:uint , entry:Object ):void
        {
            validate( entry ) ;
            var old:Object = _array[ index ] ;
            if( old )
            {
                _array[ index ] = entry ;
                notifyUpdate( index , old ) ;
            }
        }
        
        /**
         * Sets the internal map of this model (default use a new system.data.maps.HashMap instance).
         */
        public function setArray( ar:Array ):void
        {
            _array = ar || [] ;
        }
        
        /**
         * @private
         */
        protected var _array:Array ;
        
        /**
         * Notify a signal when a new entry is inserted in the model.
         */ 
        protected function notifyAdd( index:uint, entry:Object ):void
        {
            if ( !isLocked() )
            {
                added.emit( index, entry , this ) ;
            }
        }
        
        /**
         * Notify a signal when a new entry is removed in the model.
         */ 
        protected function notifyRemove( index:uint, entry:Object ):void
        {
            if ( !isLocked() )
            {
                removed.emit( index, entry , this ) ;
            }
        }
        
        /**
         * Notify a signal when a new entry is updated in the model.
         */ 
        protected function notifyUpdate( index:uint, entry:Object ):void
        {
            if ( !isLocked() )
            {
                updated.emit( index, entry , this ) ;
            }
        }
    }
}