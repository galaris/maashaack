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

package system.models.maps
{
    import system.models.ChangeModel;
    
    import system.data.Iterable;
    import system.data.Iterator;
    import system.data.Map;
    import system.data.maps.HashMap;
    import system.signals.Signal;
    import system.signals.Signaler;
    
    /**
     * This model use an internal <code class="prettyprint">Map</code> to register objects with a specific key.
     * <p><b>Example :</b></p>
     * <listing version="3.0">
     * <code class="prettyprint">
     * package examples
     * {
     *     import core.dump;
     *     
     *     import system.models.maps.MapModel;
     *     
     *     import flash.display.Sprite;
     *     
     *     public class MapModelExample extends Sprite
     *     {
     *         public function MapModelExample()
     *         {
     *             model = new MapModel() ;
     *             
     *             trace( "# model primary key : " + model.primaryKey ) ;
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
     *             
     *             trace( "#  model.get('key1') == o1 : " + ( model.get("key1") == o1 ) ) ;
     *             trace( "#  model.get('key1') == o4 : " + ( model.get("key1") == o4 ) ) ;
     *             
     *             model.update( o4 ) ;
     *             
     *             model.current = o1 ;
     *             model.current = o2 ;
     *             
     *             model.remove( o1 ) ;
     *             
     *             model.clear() ;
     *         }
     *         
     *         protected var model:MapModel ;
     *         
     *         protected var o1:Object = { id : "key1" } ;
     *         protected var o2:Object = { id : "key2" } ;
     *         protected var o3:Object = { id : "key3" } ;
     *         protected var o4:Object = { id : "key1" } ;
     *         
     *         protected function added( value:* , model:MapModel ):void
     *         {
     *             trace( model + " added : " + dump(value) ) ;
     *         }
     *         
     *         protected function beforeChanged( value:* , model:MapModel ):void
     *         {
     *             trace( model + " beforeChanged : " + dump(value) ) ;
     *         }
     *         
     *         protected function changed( value:* , model:MapModel ):void
     *         {
     *             trace( model + " changed : " + dump(value) ) ;
     *         }
     *         
     *         protected function cleared( model:MapModel ):void
     *         {
     *             trace( model + " cleared" ) ;
     *         }
     *         
     *         protected function removed( value:* , model:MapModel ):void
     *         {
     *             trace( model + " removed : " + dump(value) ) ;
     *         }
     *         
     *         protected function updated( value:* , model:MapModel ):void
     *         {
     *             trace( model + " updated : " + dump(value) ) ;
     *             trace( "#  model.get('key1') == o1 : " + ( model.get("key1") == o1 ) ) ;
     *             trace( "#  model.get('key1') == o4 : " + ( model.get("key1") == o4 ) ) ;
     *         }
     *     }
     * }
     * </code>
     * </listing>
     */
    public class MapModel extends ChangeModel implements Iterable
    {
        /**
         * Creates a new MapModel instance.
         * @param factory (optional) the Map factory reference used in the model to register all entries.
         * @param key Indicates the name of the primary key used to map all objects in the model and identifies each record in the table (default "id").
         */
        public function MapModel( factory:Map = null , key:String = "id" )
        {
            _primaryKey = ( key == null || key == "" ) ? DEFAULT_PRIMARY_KEY : key ;
            _map        = factory || new HashMap() ;
            _added      = new Signal() ;
            _removed    = new Signal() ;
            _updated    = new Signal() ;
        }
        
        /**
         * Indicates the default primary key value ("id").
         */
        public static const DEFAULT_PRIMARY_KEY:String = "id" ;
        
        /**
         * Emits a message when an entry is added in the model.
         */
        public function get added():Signaler
        {
            return _added ;
        }
        
        /**
         * Indicates the number of entries in the model.
         */
        public function get length():uint
        {
            return _map.size() ;
        }
        
        /**
         * Indicates the name of the primary key used to map all objects in the model and identifies each record in the table. 
         * By default the model use the "id" primary key in the objects.
         * <p><b>Note:</b> If you use this property and if the model contains entries, all entries will be removing.</p>
         * @see DEFAULT_PRIMARY_KEY
         */
        public function get primaryKey():String
        {
            return _primaryKey ;
        }
        
        /**
         * @private
         */
        public function set primaryKey( key:String ):void
        {
            if( key == _primaryKey )
            {
                return ;
            }
            _primaryKey =  ( key == null || key == "" ) ? DEFAULT_PRIMARY_KEY : key ;
            if ( _map.size() > 0 )
            {
                _map.clear() ;
            }
        }
        
        /**
         * Emits a message when an entry is removed in the model.
         */
        public function get removed():Signaler
        {
            return _removed ;
        }
        
        /**
         * Emits a message when an entry is updated in the model.
         */
        public function get updated():Signaler
        {
            return _removed ;
        }
        
        /**
         * Inserts an entry in the model, must be identifiable and contains an id property.
         * @throws ArgumentError if the argument of this method is 'null' or 'undefined'. 
         * @throws ArgumentError if the passed-in entry is already register in the model.
         */
        public function add( entry:Object ):void
        {
            if ( entry == null )
            {
                throw new ArgumentError( this + " add method failed, the passed-in argument not must be 'null'.") ;
            }
            validate( entry ) ;
            if ( _primaryKey in entry )
            {
                if ( !_map.containsKey( entry[_primaryKey] ) )
                {
                    _map.put( entry[_primaryKey] , entry ) ;
                    notifyAdd( entry ) ;
                }
                else
                {
                    throw new ArgumentError( this + " add method failed, the passed-in entry is already register in the model with the specified primary key, you must remove this entry before add a new entry.") ;
                }
            }
            else
            {
                throw new ArgumentError( this + " add method failed, the entry is not identifiable and don't contains a primary key with the name '" + _primaryKey + "'.") ;
            }
        }
        
        /**
         * Removes all value objects in the model.
         */
        public override function clear():void
        {
            _map.clear() ;
            super.clear() ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the model contains the specified entry.
         * @return <code class="prettyprint">true</code> if the model contains the specified entry.
         */
        public function contains( entry:Object ):Boolean
        {
            return _map.containsValue( entry ) ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the model contains the specified attribute value.
         * @return <code class="prettyprint">true</code> if the model contains the specified key in argument
         */
        public function containsByProperty( propName:String , value:* ):Boolean
        {
            if ( propName == null )
            {    
                return false ;
            }
            var datas:Array = _map.getValues() ;
            var size:int = datas.length ;
            if (size > 0)
            {
                while ( --size > -1 )
                {
                    if ( datas[size][propName] == value )
                    {
                        return true ;
                    }
                }
                return false ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the model contains the specified id key in argument.
         * @return <code class="prettyprint">true</code> if the model contains the specified id key in argument
         */
        public function containsKey( key:* ):Boolean
        {
            return _map.containsKey( key ) ;
        }
        
        /**
         * Returns the entry defined by the key passed-in argument.
         * @return the entry defined by the key passed-in argument.
         */
        public function get( key:* ):Object
        {
            return _map.get( key ) ;
        }
        
        /**
         * Returns an entry defines in the model with the specified member.
         * @return an entry defines in the model with the specified member.
         */
        public function getByProperty( propName:String , value:* ):Object
        {
            if ( propName == null )
            {
                return null ;
            }
            var datas:Array = _map.getValues() ;
            var size:int    = datas.length ;
            try
            {
                if (size > 0)
                {
                    while ( --size > -1 )
                    {
                        if ( datas[size][propName] == value )
                        {
                            return datas[size] ;
                        }
                    }
                }
            }
            catch( e:Error )
            {
                //
            }
            return null ;
        }
        
        /**
         * Returns the internal map of this model.
         * @return the internal map of this model.
         */
        public function getMap():Map
        {
            return _map ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the model is empty.
         * @return <code class="prettyprint">true</code> if the model is empty.
         */
        public function isEmpty():Boolean 
        {
            return _map.isEmpty() ;
        }
        
        /**
         * Returns the iterator of this model.
         * @return the iterator of this model.
         */
        public function iterator():Iterator
        {
            return _map.iterator() ;
        }
        
        /**
         * Returns the keys iterator of this model.
         * @return the keys iterator of this model.
         */
        public function keyIterator():Iterator
        {
            return _map.keyIterator() ;
        }
        
        /**
         * Notify a signal when a new entry is inserted in the model.
         */ 
        public function notifyAdd( entry:Object ):void
        {
            if ( !isLocked() )
            {
                _added.emit( entry , this ) ;
            }
        }
        
        /**
         * Notify a signal when a new entry is removed in the model.
         */ 
        public function notifyRemove( entry:Object ):void
        {
            if ( !isLocked() )
            {
                _removed.emit( entry , this ) ;
            }
        }
        
        /**
         * Notify a signal when a new entry is updated in the model.
         */ 
        public function notifyUpdate( entry:Object ):void
        {
            if ( !isLocked() )
            {
                _updated.emit( entry , this ) ;
            }
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
            if ( _primaryKey in entry )
            {
                if (  _map.containsKey( entry[_primaryKey] ) )
                {
                    _map.remove( entry[_primaryKey] ) ;
                    notifyRemove( entry ) ;
                }
                else
                {
                    throw new ArgumentError( this + " remove method failed, no entry register in the model with the specified primary key.") ;
                }
            }
            else
            {
                throw new ArgumentError( this + " remove method failed, the entry is not identifiable and don't contains a primary key with the name '" + _primaryKey + "'.") ;
            }
        }
        
        /**
         * Sets the internal map of this model (default use a new system.data.maps.HashMap instance).
         */
        public function setMap( map:Map ):void
        {
            _map = map || new HashMap() ;
        }
        
        /**
         * Update a value object in the model.
         * @throws ArgumentError if the entry is not register in the model.
         */
        public function update( entry:Object ):void
        {
            if ( _primaryKey in entry )
            {
                if ( _map.containsKey( entry[_primaryKey] ) )
                {
                    _map.put( entry[_primaryKey] , entry ) ;
                    notifyUpdate( entry ) ;
                }
                else
                {
                    throw new ArgumentError( this + " update method failed, no entry register in the model with the specified primary key.") ;
                }
            }
            else
            {
                throw new ArgumentError( this + " update method failed, the entry is not identifiable and don't contains a primary key with the name '" + _primaryKey + "'.") ;
            }
        }
        
        /**
         * @private
         */
        protected var _added:Signaler ;
        
        /**
         * @private
         */
        protected var _map:Map ;
        
        /**
         * @private
         */
        protected var _primaryKey:String ;
        
        /**
         * @private
         */
        protected var _removed:Signaler ;
        
        /**
         * @private
         */
        protected var _updated:Signaler ;
    }
}
