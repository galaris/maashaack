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

package system.ioc 
{
    import system.ioc.builders.createObjectDefinition;
    
    /**
     * The concrete implementation of the IObjectDefinition interface.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import flash.text.TextField ;
     * import flash.text.TextFormat ;
     * 
     * import system.ioc.ObjectDefinition ;
     * 
     * var context:Object =
     * {
     *     id         : "my_field" ,
     *     type       : "flash.text.TextField" ,
     *     properties :
     *     [
     *         { name : "defaultTextFormat" , value : new TextFormat("verdana", 11) } ,
     *         { name : "selectable"        , value : false                         } ,
     *         { name : "text"              , value : "hello world"                 } ,
     *         { name : "textColor"         , value : 0xF7F744                      } ,
     *         { name : "x"                 , value : 100                           } ,
     *         { name : "y"                 , value : 100                           }
     *     ]
     * }
     * 
     * var definition:ObjectDefinition = ObjectDefinition.create( context ) ;
     * 
     * trace(definition.id + " : " + definition.getType()) ; // my_field : flash.text.TextField
     * </pre>
     */
    public class ObjectDefinition implements IObjectDefinition
    {
        /**
         * Creates a new ObjectDefinition instance.
         * @param id the id of the <code class="prettyprint">ObjectDefinition</code> object.
         * @param type the type of the <code class="prettyprint">ObjectDefinition</code> object.
         * @param singleton the boolean flag to indicate if the object is a sigleton or not.
         * @param lazyInit the boolean flag to indicate if the singleton object is lazy init or not.
         */    
        public function ObjectDefinition( id:* , type:String , singleton:Boolean=false , lazyInit:Boolean=false )
        {
            if ( id == null )
            {
                throw new ArgumentError( this + " constructor failed, the 'id' value passed in argument not must be empty or 'null' or 'undefined'.") ;
            }
            if ( type == null || type.length == 0 )
            {
                throw new ArgumentError( this + " constructor failed, the string 'type' passed in argument not must be empty or 'null' or 'undefined'.") ;    
            }
            _id        = id ;
            _type      = type ;
            _singleton = singleton  ;
            _scope     = singleton ? ObjectScope.SINGLETON : ObjectScope.PROTOTYPE ;
            _lazyInit  = lazyInit && _singleton ;
        }
        
        /**
         * Indicates the id of this object.
         */
        public function get id():*
        {
            return _id ;
        }
        
        /**
         * @private
         */
        public function set id( id:* ):void
        {
            _id = id ;
        }
        
        /**
         * Indicates if the object definition is a singleton and the type of the object is Identifiable if the object must be
         * populated with the id of the definition when is instanciated.
         */
        public function get identify():* 
        {
            return _identify ;
        }
        
        /**
         * @private
         */
        public function set identify( value:* ):void
        {
            _identify = ( value is Boolean ) ? value : null ;
        }
        
        /**
         * Indicates if the object definition lock this Lockable object during the population 
         * of the properties and the initialization of the methods defines in the object definition.
         */
        public function get lock():* 
        {
            return _lock ;
        }
        
        /**
         * @private
         */
        public function set lock( value:* ):void
        {
            _lock = ( value is Boolean ) ? value : null ;
        }
        
        /**
         * Creates a new ObjectDefinition instance and populated it with the specified init object in argument.
         * @param o A generic object to populate the new ObjectDefinition instance.
         * @return A ObjectDefinition instance.
         */
        public static const create:Function = createObjectDefinition ;
        
        /**
         * Returns the Array of all listener definitions of this object definition register after the object initialization.
         * @return the Array of all listener definitions of this object definition register after the object initialization.
         */
        public function getAfterListeners():Array
        {
            return _afterListeners ;
        } 
        
        /**
         * Returns the Array of all receiver definitions of this object definition register after the object initialization.
         * @return the Array of all receiver definitions of this object definition register after the object initialization.
         */
        public function getAfterReceivers():Array
        {
            return _afterReceivers ;
        }
        
        /**
         * Returns the Array of all listener definitions of this object definition register before the object initialization.
         * @return the Array of all listener definitions of this object definition register before the object initialization.
         */
        public function getBeforeListeners():Array
        {
            return _beforeListeners ;
        }
        
        /**
         * Returns the Array of all receiver definitions of this object definition register before the object initialization.
         * @return the Array of all receiver definitions of this object definition register before the object initialization.
         */
        public function getBeforeReceivers():Array
        {
            return _beforeReceivers ;
        }
        
        /**
         * Returns the constructor arguments values of this object in a Array list.
         * @return the constructor arguments values of this object in a Array list.
         */
        public function getConstructorArguments():Array 
        {
            return _constructorArguments ;
        }
        
        /**
         * Returns the collection (Array) defines in the "dependsOn" attribute.
         * @return the collection (Array) defines in the "dependsOn" attribute.
         */
        public function getDependsOn():Array
        {
            return _dependsOn ;
        }
        
        /**
         * Returns the name of the method invoked when the object is destroyed.
         * @return the name of the method invoked when the object is destroyed.
         */
        public function getDestroyMethodName():String 
        {
            return _destroyMethodName;
        }
        
        /**
         * Returns the factory stategy of this definition to create the object.
         * @return the factory stategy of this definition to create the object.
         */
        public function getFactoryStrategy():IObjectFactoryStrategy
        {
            return _factoryStrategy ;
        }
        
        /**
         * Returns the collection (Array) defines in the "generates" attribute.
         * @return the collection (Array) defines in the "generates" attribute.
         */
        public function getGenerates():Array
        {
            return _generates ;
        }
        
        /**
         * Returns the name of the method call when the object is instanciate.
         * @return the name of the method call when the object is instanciate.
         */
        public function getInitMethodName():String 
        {
            return _initMethodName;
        }
        
        /**
         * Returns the Array of all properties of this Definition.
         * @return the Array of all properties of this Definition.
         */
        public function getProperties():Array 
        {
            return _properties ;
        }
        
        /**
         * Returns the scope of the object.
         * @return the scope of the object.
         */    
        public function getScope():String 
        {
            return _scope ;
        }
        
        /**
         * Returns the type of the object (the class name).
         * @return the type of the object (the class name).
         */
        public function getType():String 
        {
            return _type ;
        }
        
        /**
         * Indicates if the object lazily initialized. Only applicable to a singleton object. 
         * If false, it will get instantiated on startup by object factories that perform eager initialization of singletons.
         * @return A boolean who indicates if the object lazily initialized. 
         */    
        public function isLazyInit():Boolean 
        {
            return _lazyInit;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the object in a Sigleton else the object is a prototype.
         * @return <code class="prettyprint">true</code> if the object in a Sigleton else the object is a prototype.
         */
        public function isSingleton():Boolean 
        {
            return _singleton ;
        }
        
        /**
         * Sets the constructor arguments values of this object.
         * @param value the array representation of all arguments in the constructor of the object instance.
         */
        public function setConstructorArguments( value:Array = null ):void 
        {
            _constructorArguments = value ;
        }
        
        /**
         * Sets the collection (Array) defines in the "dependsOn" attribute.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.ioc.ObjectDefinition ;
         * 
         * var init:Object =
         * {
         *     id   : "my_field" ,
         *     type : "flash.text.TextField" ,
         * }
         * 
         * var definition:ObjectDefinition = ObjectDefinition.create( init ) ;
         * 
         * definition.setDependsOn( [2,3,4,5, "hello"] ) ;
         * trace( definition.getDependsOn() ) ; // "hello"
         * 
         * definition.setDependsOn( [2,3,4,5] ) ;
         * trace( definition.getDependsOn() ) ; // 'empty Array'
         * 
         * definition.setDependsOn( [] ) ;
         * trace( definition.getDependsOn() ) ; // null
         * 
         * definition.setDependsOn( null ) ;
         * trace( definition.getDependsOn() ) ; // null
         * </pre>
         */   
        public function setDependsOn( ar:Array ):void 
        {
            _dependsOn = ( ar != null && ar.length > 0 ) ? ar.filter( _filterStrings ) : null ;
        }
        
        /**
         * Sets the name of the method invoked when the object is destroyed.
         * @param value the name of the destroy method of the object.
         */
        public function setDestroyMethodName( value:String = null ):void 
        {
            _destroyMethodName = value;
        }
        
        /**
         * Sets the factory stategy of this definition to create the object.
         */
        public function setFactoryStrategy( value:IObjectFactoryStrategy ):void
        {
            _factoryStrategy = value ;
        }
        
        /**
         * Sets the collection (Array) defines in the "generates" attribute.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.ioc.ObjectDefinition ;
         * 
         * var init:Object =
         * {
         *     id   : "my_field" ,
         *     type : "flash.text.TextField" ,
         * }
         * 
         * var definition:ObjectDefinition = ObjectDefinition.create( init ) ;
         * 
         * definition.setGenerates( [2,3,4,5, "hello"] ) ;
         * trace( definition.getGenerates() ) ; // "hello"
         * 
         * definition.setGenerates( [2,3,4,5] ) ;
         * trace( definition.getGenerates() ) ; // 'empty Array'
         * 
         * definition.setGenerates( [] ) ;
         * trace( definition.getGenerates() ) ; // null
         * 
         * definition.setGenerates( null ) ;
         * trace( definition.getGenerates() ) ; // null
         * </pre>
         */
        public function setGenerates( ar:Array ):void 
        {
            _generates = ( ar != null && ar.length > 0 ) ? ar.filter( _filterStrings ) : null ;
        }
        
        /**
         * Init the name of the method.
         * @param value the string 'init method' name.
         */
        public function setInitMethodName( value:String = null ):void 
        {
            _initMethodName = value;
        }
        
        /**
         * Sets the Array of all listener definition of this object definition.
         * @param ar the Array of all listener definitions of the object.
         */
        public function setListeners( ar:Array = null ):void
        {
            _afterListeners  = [] ;
            _beforeListeners = [] ;
            if ( ar == null )
            {
                return ;
            }
            var e:ObjectListener ;
            var l:int = ar.length ;
            if ( l > 0 )
            {
                for( var i:int ; i < l ; i++ )
                {
                    e = ar[i] as ObjectListener ;
                    if ( e != null )
                    {
                        if( e.order == ObjectOrder.AFTER )
                        {
                            _afterListeners.push( e ) ;
                        }
                        else
                        {
                            _beforeListeners.push( e ) ;
                        }
                    }
                }
            }
        }
        
        /**
         * Sets the Array of all receiver definition of this object definition.
         * @param ar the Array of all receiver definitions of the object.
         */
        public function setReceivers( ar:Array = null ):void
        {
            _afterReceivers  = [] ;
            _beforeReceivers = [] ;
            if ( ar == null )
            {
                return ;
            }
            var r:ObjectReceiver ;
            var l:int = ar.length ;
            if ( l > 0 )
            {
                for( var i:int ; i < l ; i++ )
                {
                    r = ar[i] as ObjectReceiver ;
                    if ( r != null )
                    {
                        if( r.order == ObjectOrder.AFTER )
                        {
                            _afterReceivers.push( r ) ;
                        }
                        else
                        {
                            _beforeReceivers.push( r ) ;
                        }
                    }
                }
            }
        }
        
        /**
         * Sets the Array of all properties of this definition.
         * @param ar the Array of all properties of the object.
         */
        public function setProperties( ar:Array = null ):void 
        {
            _properties = ar ;
        }
        
        /**
         * Sets the scope of the object.
         */    
        public function setScope( scope:String = null ):void 
        {
            if ( scope != null && ObjectScope.validate( scope ) )
            {
                _scope     = scope  || ObjectScope.PROTOTYPE ;
                _singleton = _scope == ObjectScope.SINGLETON ;
            }
        }
        
        /**
         * Sets the type of the object (the class name).
         * @param value the string representation of the type object.
         */    
        public function setType( value:String = null ):void 
        {
            _type = value ;
        }
        
        /**
         * @private
         */
        private var _afterListeners:Array ;
        
        /**
         * @private
         */
        private var _afterReceivers:Array ;
        
        /**
         * @private
         */
        private var _beforeListeners:Array ;
        
        /**
         * @private
         */
        private var _beforeReceivers:Array ;
        
        /**
         * @private
         */
        private var _constructorArguments:Array ;
        
        /**
         * @private
         */
        private var _dependsOn:Array ;
        
        /**
         * @private
         */
        private var _destroyMethodName:String;
        
        /**
         * @private
         */
        private var _factoryStrategy:IObjectFactoryStrategy ;
        
        /**
         * @private
         */
        private var _generates:Array ;
        
        /**
         * @private
         */
        private var _id:* ;
        
        /**
         * @private
         */
        private var _identify:* ;
        
        /**
         * @private
         */
        private var _initMethodName:String;
        
        /**
         * @private
         */
        private var _lazyInit:Boolean ;
        
        /**
         * @private
         */
        private var _lock:* = null ;
        
        /**
         * The internal Array of all properties of the object.
         * @private
         */
        private var _properties:Array ;
        
        /**
         * The scope of the object.
         * @private
         */
        private var _scope:String ;
        
        /**
         * Indicates if the definition is singleton.
         * @private
         */
        private var _singleton:Boolean ;
        
        /**
         * The type of the IDefinition object.
         * @private
         */
        private var _type:String;
        
        /**
         * @private
         */
        private function _filterStrings( item:* , index:int , ar:Array ):Boolean
        {
            return item is String && item.length > 0 ;
        }
    }
}