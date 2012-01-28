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
    import core.maths.clamp;
    
    import system.data.Map;
    import system.data.maps.ArrayMap;
    
    import flash.errors.IllegalOperationError;
    
    /**
     * This map model object is indexed with a numeric index value.
     * @example Example
     * <listing version="3.0">
     * <code class="prettyprint">
     * package examples
     * {
     * }
     * </code>
     * </listing>
     */
    public class IndexedMapModel extends MapModel
    {
        /**
         * Creates a new IndexedMapModel instance.
         * @param key Indicates the name of the primary key used to map all objects in the model and identifies each record in the table (default "id").
         */
        public function IndexedMapModel(key:String = "id")
        {
            super( new ArrayMap() , key );
        }
        
        
        /**
         * Sets the current entry selected in this model.
         * @throws ArgumentError If the passed-in object parameter is not register in the model.
         */
        public override function set current( o:* ):void
        {
            if( o == null )
            {
                _index = -1 ;
                super.current = null ;
            }
            else
            {
                var m:ArrayMap = getMap() as ArrayMap ;
                var i:int      = m.indexOfValue( o ) ;
                if ( i > -1 )
                {
                    _index = i ;
                    super.current = o ;
                }
                else
                {
                    throw new ArgumentError( this + " current=" + o + " failed, the entry object must be register in the model to be selected") ;
                }
            }
        }
        
        /**
         * Indicates the current index of the current selected value object in the model.
         */
        public function get index():int
        {
            return _index ;
        }
        
        /**
         * @private
         */
        public function set index( value:int ):void
        {
            var m:ArrayMap = _map as ArrayMap ;
            
            if ( looping )
            {
                if ( value < 0 )
                {
                    value = m.size() - 1 ;
                }
                else if ( value > m.size() - 1 )
                {
                    value = 0 ;
                }
            }
            else
            {
                value = clamp( value , 0 , m.size() - 1 ) ;
            }
            
            if ( value == _index )
            {
                return ;
            }
            
            var e:* = m.getValueAt( value )  ;
            if ( e )
            {
                _index = value ;
                super.current = e ;
            }
            else
            {
                _index = -1 ;
            }
        }
        
        /**
         * Indicates if index attribute loop when this value is out of the range (between 0 and the size()-1).
         */
        public var looping:Boolean ;
        
        /**
         * Clear the model.
         */
        public override function clear():void
        {
            _index = -1 ;
            super.clear() ;
        }
        
        /**
         * Returns the entry registerd in the model at the specified numeric index.
         * @return the entry registerd in the model at the specified numeric index.
         */
        public function getAt( index:uint ):*
        {
            return (_map as ArrayMap).getValueAt( index ) ;
        }
        
        /**
         * Removes a value object in the model.
         */
        public override function remove( entry:Object ):void
        {
            if ( entry && _current == entry )
            {
                _index   = -1   ;
                _current = null ;
            }
            super.remove( entry ) ;
        }
        
        /**
         * Not available in the IndexedMapModel instances.
         * @throws IllegalOperationError The IndexedMapModel class fix the internal map with an ArrayMap instance only, you can't change it.
         */
        public override function setMap( map:Map ):void
        {
            throw new IllegalOperationError( this + " setMap method is illegal. The internal Map in this class must be an ArrayMap instance only and you can't change it.") ;
        }
        
        /**
         * @private
         */
        protected var _index:int = -1 ;
    }
}