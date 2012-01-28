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
package system.models.arrays
{
    import system.data.OrderedIterator;
    import system.data.iterators.PageByPageIterator;
    import system.models.ChangeModel;
    import system.process.Runnable;
    import system.signals.Signal;
    import system.signals.Signaler;
    
    import flash.errors.IllegalOperationError;
    
    /**
     * Defines an <code class="prettyprint">Array</code> model with a 'page by page' iterator.
     * @example Example
     * <listing version="3.0">
     * <code class="prettyprint">
     * package examples
     * {
     *     import core.dump;
     *     
     *     import system.models.arrays.PageableArrayModel;
     *     
     *     import flash.display.Sprite;
     *     import flash.events.KeyboardEvent;
     *     import flash.ui.Keyboard;
     *     
     *     public class PageableArrayModelExample extends Sprite
     *     {
     *         public function PageableArrayModelExample()
     *         {
     *             stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
     *             
     *             model = new PageableArrayModel( 2 ) ;
     *             
     *             // model.count =  3 ;
     *             
     *             model.initialized.connect( init ) ; 
     *             model.updated.connect( update ) ; 
     *             
     *             var datas:Array  = [] ;
     *             
     *             for ( var i:uint = 0 ; i &lt; 20 ; i++ )
     *             {
     *                 datas.push( { id:i } ) ;
     *             }
     *             
     *             model.init( datas , false , false ) ;
     *             
     *             model.currentPage = 2 ;
     *         }
     *         
     *         protected var model:PageableArrayModel ;
     *         
     *         protected function init( model:PageableArrayModel ):void
     *         {
     *             trace( model + " init" ) ;
     *         }
     *         
     *         protected function update( value:&#42; , model:PageableArrayModel ):void
     *         {
     *             trace( model + " update " + model.currentPage + "/" + model.pageCount + " value:" + dump(value) ) ;
     *         }
     *         
     *         protected function keyDown( e:KeyboardEvent ):void
     *         {
     *             var code:uint = e.keyCode ;
     *             switch( code )
     *             {
     *                 case Keyboard.LEFT :
     *                 {
     *                     if ( model.hasPrevious() )
     *                     {
     *                         model.previous() ;
     *                     }
     *                     else
     *                     {
     *                         model.lastPage() ;
     *                     }
     *                     break ;
     *                 }
     *                 case Keyboard.RIGHT :
     *                 {
     *                     if ( model.hasNext() )
     *                     {
     *                         model.next() ;
     *                     }
     *                     else
     *                     {
     *                         model.firstPage() ;
     *                     }
     *                     break ;
     *                 }
     *                 case Keyboard.SPACE :
     *                 {
     *                     model.lock() ;
     *                     model.count = 4 ; // change the count value but not update the model.
     *                     model.unlock() ;
     *                }
     *             }
     *         }
     *     }
     * }
     * </code>
     * </listing>
     */
    public class PageableArrayModel extends ChangeModel implements OrderedIterator, Runnable
    {
        /**
         * Creates a new PageableArrayModel instance.
         * @param count Indicates the default number of elements by page in the model (default 1).
         * @param factory the optional internal Array reference to build the model, by default an empty Array is created.
         */
        public function PageableArrayModel( count:uint = 1 , factory:Array = null )
        {
            _elements    = factory || [] ;
            _count       = count > 1 ? count : 1 ;
            _initialized = new Signal() ;
            _updated     = new Signal() ;
        }
        
        /**
         * Determinates the number of elements in a page of this model.
         */
        public function get count():uint
        {
            return _count ;
        }
        
        /**
         * @private
         */
        public function set count( n:uint ):void
        {
            _count = n > 1 ? n : 1 ;
            refresh() ;
        }
        
        /**
         * Indicates the current page selected in the model.
         */
        public function get currentPage():uint
        {
            return _pager ? _pager.currentPage() : 0 ;
        }
        
        /**
         * @private
         */
        public function set currentPage( value:uint ):void
        {
            if ( _pager )
            {
                _pager.seek( value ) ;
                notifyUpdate( _pager.current() ) ;
            }
        }
        
        /**
         * Returns the event name use in the <code class="prettyprint">notifyInit</code> method.
         * @return the event name use in the <code class="prettyprint">notifyInit</code> method.
         */
        public function get initialized():Signaler
        {
            return _initialized ;
        }
        
        /**
         * Indicates the number of elements in the model.
         */
        public function get length():uint
        {
            return _elements.length ;
        }
        
        /**
         * Indicates the numbers of page with the current model.
         */
        public function get pageCount():Number
        {
            return _pager ? _pager.pageCount() : 0 ;
        }
        
        /**
         * Returns the event name use in the <code class="prettyprint">notifyUpdate</code> method.
         * @return the event name use in the <code class="prettyprint">notifyUpdate</code> method.
         */
        public function get updated():Signaler
        {
            return _updated ;
        }
        
        /**
         * Clear the model.
         */    
        public override function clear():void
        {
            _elements = []  ;
            super.clear() ;
        }
        
        /**
         * Seek the iterator in the first page of this object.
         */
        public function firstPage():void
        {
            if ( _pager )
            {
                _pager.firstPage() ;
                notifyUpdate( _pager.current() ) ;
            }
        }
        
        /**
         * Returns the object defined by the key passed in argument and register in the model.
         * @return the object defined by the key passed in argument and register in the model.
         */
        public function getByKey( key:* , primaryKey:String = "id" ):Object
        {
            if ( key == null || _elements.length == 0 )
            {
                return null ;
            }
            var l:int = _elements.length ;
            var result:Object ;
            for( var i:int = 0 ; i<l ; i++ )
            {
                 result = _elements[i] ;
                 if ( primaryKey in result && result[primaryKey] == key )
                 {
                    return result ;
                 }
            }
            return null ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the list has a next page.
         * @return <code class="prettyprint">true</code> if the list has a next page.
         */
        public function hasNext():Boolean
        {
            return _pager ? _pager.hasNext() : false ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the list has a previous page.
         * @return <code class="prettyprint">true</code> if the list has a previous page.
         */
        public function hasPrevious():Boolean
        {
            return _pager ? _pager.hasPrevious() : true ;
        }
        
        /**
         * Returns the current key of the internal pointer of the iterator (optional operation).
         * @return the current key of the internal pointer of the iterator (optional operation).
         */
        public function key():* 
        {
            return _pager ? _pager.key() : null ;
        }
        
        /**
         * Fill and initialize the model with an Array of ValueObject.
         * @param datas The array of all value objects to insert in the model.
         * @param autoClear (optional) If this argument is <code class="prettyprint">true</code> the clear method is invoked when the initialization begin.
         * @param autoRefresh (optional) If this argument is <code class="prettyprint">true</code> the model is running when this initialization is finished.
         */
        public function init( datas:Array , autoClear:Boolean=true , autoRefresh:Boolean=true ):void
        {
            if ( autoClear )
            {
                clear() ;
            }
            var vo:Object ;
            var len:int = datas.length ;
            for ( var i:int ; i < len ; i++ )
            {
                vo = datas[i] ;
                if ( supports( vo ) )
                {
                    _elements.push( vo ) ;
                }
            }
            if ( _elements.length > 0 )
            {
                _pager = new PageByPageIterator ( _elements , _count ) ;
            }
            else
            {
                _pager = null ;
            }
            notifyInit() ;
            if ( autoRefresh )
            {
                run() ;
            }
        }
        
        /**
         * Seek the iterator in the last page of this object.
         */
        public function lastPage():void
        {
            if ( _pager )
            {
                _pager.lastPage() ;
                notifyUpdate( _pager.current() ) ;
            }
        }
        
        /**
         * Show the next page of the model.
         */
        public function next():*
        {
            if ( hasNext() )
            {
                return notifyUpdate( _pager.next() ) ;
            }
            else
            {
                return null ;
            }
        }
        
        /**
         * Emit a message when the model is initialized.
         */ 
        public function notifyInit():void
        {
            if ( !isLocked() )
            {
                _initialized.emit( this ) ;
            }
        }
        
        /**
         * Emit a message when the model is updated. 
         */ 
        public function notifyUpdate( value:* ):*
        {
            if ( !isLocked() )
            {
                _updated.emit( value , this ) ;
            }
            return value ;
        }
        
        /**
         * Finds and indicates the page number of the specified value object register in the model. If the passed-in value object is not found 0 is returned.
         */
        public function pageOf( value:Object ):uint
        {
            var l:int = _elements.length ;
            var index:int = _elements.indexOf( value ) ;
            if ( l > 0 && index > -1 )
            {
                var page:uint = 1 ;
                for( var i:int = 1 ; i<l ; i++ )
                {
                    if ( i-1 == index )
                    {
                        return page ;
                    }
                    if ( i%_count == 0 )
                    {
                        page++ ;
                    }
                }
            }
            return 0 ;
        }
        
        /**
         * Show in the previous page in the list or previous screen.
         */
        public function previous():*
        {
            if ( hasPrevious() )
            {
                return notifyUpdate( _pager.previous() ) ;
            }
            else
            {
                return null ;
            }
        }
        
        /**
         * Refresh the iterator of the model and run it.
         */
        public function refresh():void
        {
            _pager = null ;
            if ( _elements.length > 0)
            {
                _pager = new PageByPageIterator ( _elements , _count ) ;
                run() ;
            }
        }
        
        /**
         * Removes from the underlying model the last element returned by the iterator (optional operation).
         * @throws IllegalOperationError The PageableArrayModel remove method is unsupported.
         */
        public function remove():* 
        {
            throw new IllegalOperationError("The PageableArrayModel remove method is unsupported.") ;
        }
        
        /**
         * Resets the key pointer of the iterator.
         */
        public function reset():void 
        {
            if ( _pager )
            {
                _pager.reset() ;
            }
        }
        
        /**
         * Run the model when is initialize. This method don't work if the model is locked.
         * @see system.process.Lockable
         * @see system.process.Runnable
         */
        public function run( ...arguments:Array ):void
        {
            if ( isLocked() ) 
            {
                return ;
            }
            if ( _elements.length > 0 )
            {
                next() ;
            }
        }
        
        /**
         * Seek the position of the pointer in the model but don't notify an update signal.
         */
        public function seek( position:* ):void 
        {
            if ( !isNaN( position ) )
            {
                _pager.seek( position ) ;
            }
            else
            {
                throw new ArgumentError( this + " seek failed, the position argument must be a Number.") ;
            }
        }
        
        /**
         * Returns a new Array representation of all elements in this model.
         * @return a new Array representation of all elements in this model.
         */
        public function toArray():Array
        {
            return [].contact( _elements ) ;
        }
        
        /**
         * @private
         */
        protected var _elements:Array ; 
        
        /**
         * @private
         */
        protected var _count:uint = 1 ;
        
        /**
         * @private
         */
        protected var _initialized:Signaler ;
        
        /**
         * @private
         */
        protected var _pager:PageByPageIterator ;
        
        
        /**
         * @private
         */
        protected var _updated:Signaler ;
    }
}