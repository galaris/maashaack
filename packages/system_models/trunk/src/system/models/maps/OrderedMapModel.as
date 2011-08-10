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

package system.models.maps
{
    import system.data.Map;
    import system.data.iterators.PageByPageIterator;
    import system.data.maps.ArrayMap;
    import system.process.Runnable;
    
    import flash.errors.IllegalOperationError;
    
    /**
     * This map model object is ordered with a previous and next methods inside.
     * 
     * @example Example
     * <listing version="3.0">
     * <code class="prettyprint">
     * package examples
     * {
     *     import system.models.Model ;
     *     import system.models.maps.OrderedMapModel ;
     *     
     *     import flash.display.Sprite;
     *     import flash.events.KeyboardEvent;
     *     import flash.ui.Keyboard;
     *     
     *     public class OrderedMapModelExample extends Sprite 
     *     {
     *         public function OrderedMapModelExample()
     *         {
     *             model = new OrderedMapModel() ;
     *             
     *             model.added.connect( added ) ; 
     *             model.changed.connect( changed ) ;
     *             
     *             var count:uint = 4 ;
     *             
     *             for (var i:int ; i &lt; count ; i++ ) 
     *             {
     *                 model.add( { id : i , filter : i &lt;&lt; 1 } ) ;
     *             }
     *             
     *             model.run() ;
     *             
     *             stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
     *         }
     *         
     *         public var model:OrderedMapModel ;
     *         
     *         public function added( entry:Object , model:Model ):void
     *         {
     *             trace( "add entry:" + entry + " in " + model ) ;
     *         }
     *         
     *         public function changed( entry:Object , model:Model ):void
     *         {
     *             trace( "change entry:" + entry ) ;
     *         }
     *         
     *         public function keyDown( e:KeyboardEvent ):void
     *         {
     *             var code:uint = e.keyCode ;
     *             switch( code )
     *             {
     *                 case Keyboard.LEFT :
     *                 {
     *                     model.previous() ;
     *                     trace( "hasPrevious:" + model.hasPrevious() ) ;
     *                     break ;
     *                 }
     *                 case Keyboard.RIGHT :
     *                 {
     *                     model.next() ;
     *                     trace( "hasNext:" + model.hasNext() ) ;
     *                     break ;
     *                 }
     *                 case Keyboard.SPACE :
     *                 {
     *                     model.loop = !model.loop ;
     *                     trace( "loop:" + model.loop ) ;
     *                     break ;
     *                 }
     *             }
     *         }
     *     }
     * }
     * </code>
     * </listing>
     */
    public class OrderedMapModel extends MapModel implements Runnable
    {
        /**
         * Creates a new OrderedMapModel instance.
         * @param key Indicates the name of the primary key used to map all objects in the model and identifies each record in the table (default "id").
         */
        public function OrderedMapModel( key:String = "id" )
        {
            super( new ArrayMap() , key );
        }
        
        /**
         * @private
         */
        public override function set current( o:* ):void
        {
            seek( o ) ;
        }
        
        /**
         * Indicates if the next and previous method loops when the internal ordered iterator can find a next or previous value object.
         */
        public var loop:Boolean = true ;
        
        /**
         * Clear the model.
         */
        public override function clear():void
        {
            _it = null ;
            super.clear() ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the model has more elements.
         * @return <code class="prettyprint">true</code> if the model has more elements.
         */
        public function hasNext():Boolean
        {
            if ( _map.size() > 0 )
            {
                if ( _it.hasNext() )
                {
                    return true ;
                }
                else
                {
                    return loop;
                }
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Checks to see if there is a previous element that can be iterated to.
         * @return <code class="prettyprint">true</code> if the iterator has more elements.
         */
        public function hasPrevious():Boolean
        {
            if ( _map.size() > 0 )
            {
                if ( _it.hasPrevious() )
                {
                    return true ;
                }
                else
                {
                    return loop;
                }
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Sets the next value object in the model.
         */
        public function next():*
        {
            if ( _it )
            {
                if ( !_it.hasNext() )
                {
                    if( loop )
                    {
                        _it.reset() ;
                    }
                    else
                    {
                        return ;
                    }
                }
                current = get( _it.next() ) ;
            }
            else if ( _map.size() > 0 )
            {
                reset() ;
                next() ;
            }
            return _current ;
        }
        
        /**
         * Sets the previous value object in the model. 
         * If no value object is selected in the model this method invoke the next() method to select the first value object.
         */
        public function previous():*
        {
            if ( _it )
            {
                var prev:* ;
                if ( !_it.hasPrevious() )
                {
                    if ( loop )
                    {
                        _it.lastPage() ;
                    }
                    else
                    {
                        return ;
                    }
                    prev = _it.current() ;
                }
                else
                {
                    prev = _it.previous() ; 
                }
                current = get( prev ) ;
            }
            else if ( _map.size() > 0 )
            {
                reset() ;
                next() ;
            }
            return _current ;
        }
        
        /**
         * Reset the internal iterator of the model.
         */
        public function reset():void
        {
            if ( length > 0 )
            {
                _it = new PageByPageIterator( getMap().getKeys() ) ;
            }
            else
            {
                _it = null ;
            }
        }
        
        /**
         * Resets the model and run the model to select the next value object register in the model.
         */
        public function run( ...arguments:Array ):void
        {
            reset() ;
            if ( _map.size() > 0 )
            {
                next()  ;
            }
        }
        
        /**
         * Seek the model and select the specified object.
         * @param position The object reference to seek the model.
         * @throws ArgumentError if the passed-in ValueObject isn't register in the model.
         */
        public function seek( position:* ):void
        {
            if ( position == _current && security )
            {
                return ;
            }
            if ( _current != null )
            {
                notifyBeforeChange( _current ) ;
                _current = null ;
            }
            validate( position ) ;
            if ( contains( position ) )
            {
                var map:ArrayMap = _map as ArrayMap ;
                if ( map )
                {
                    var index:uint   = map.indexOfValue( position ) ;
                    if ( _it == null )
                    {
                        reset() ;
                    }
                    _it.seek(index) ;
                    _current = position ;
                    _it.seek( index + 1 ) ;
                    notifyChange( _current );
                }
            }
            else
            {
                throw new ArgumentError(this + " seek method failed, the passed-in entry isn't register in the model.") ;
            }
        }
        
        /**
         * Sets the internal map of this model (default use a new system.data.maps.HashMap instance).
         * @throws IllegalOperationError The OrderedMapModel class fix the internal map with an ArrayMap instance only, you can't change it.
         */
        public override function setMap( map:Map ):void
        {
            throw new IllegalOperationError( this + " setMap method is illegal. The internal Map in this class must be an ArrayMap instance only and you can't change it.") ;
        }
        
        /**
         * @private
         */
        protected var _it:PageByPageIterator ;
    }
}