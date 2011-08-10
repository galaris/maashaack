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

package system.ioc 
{
    import system.data.Identifiable;
    
    /**
     * Describes an object instance, which has property values, constructor argument values, and further information supplied by concrete implementations.
     */
    public interface IObjectDefinition extends Identifiable
    {
        /**
         * Indicates if the object definition is a singleton and the type of the object is Identifiable if the object must be
         * populated with the id of the definition when is instanciated.
         */
        function get identify():* ;
        
        /**
         * @private
         */
        function set identify( value:* ):void ;
        
        /**
         * Indicates if the object definition lock this Lockable object during the population 
         * of the properties and the initialization of the methods defines in the object definition.
         */
        function get lock():* ; 
        
        /**
         * @private
         */
        function set lock( value:* ):void ;
        
        /**
         * Returns the Array of all listener definitions of this object definition register after the object initialization.
         * @return the Array of all listener definitions of this object definition register after the object initialization.
         */
        function getAfterListeners():Array ;
        
        /**
         * Returns the Array of all receiver definitions of this object definition register after the object initialization.
         * @return the Array of all receiver definitions of this object definition register after the object initialization.
         */
        function getAfterReceivers():Array ;
        
        /**
         * Returns the Array of all listener definitions of this object definition register before the object initialization.
         * @return the Array of all listener definitions of this object definition register before the object initialization.
         */
        function getBeforeListeners():Array ;
        
        /**
         * Returns the Array of all receiver definitions of this object definition register before the object initialization.
         * @return the Array of all receiver definitions of this object definition register before the object initialization.
         */
        function getBeforeReceivers():Array ;
        
        /**
         * Returns the constructor arguments values of this object in a Array list.
         * @return the constructor arguments values of this object in a Array list.
         */
        function getConstructorArguments():Array ;
        
        /**
         * Returns the collection (Array) defines in the "dependsOn" attribute.
         * @return the collection (Array) defines in the "dependsOn" attribute.
         */
        function getDependsOn():Array ;
        
        /**
         * Returns the name of the method invoked when the object is destroyed.
         * @return the name of the method invoked when the object is destroyed.
         */    
        function getDestroyMethodName():String ; 
        
        /**
         * Returns the factory stategy of this definition to create the object.
         * @return the factory stategy of this definition to create the object.
         */
        function getFactoryStrategy():IObjectFactoryStrategy ;
        
        /**
         * Returns the collection (Array) defines in the "generates" attribute.
         * @return the collection (Array) defines in the "generates" attribute.
         */    
        function getGenerates():Array ;
        
        /**
         * Returns the name of the method call when the object is instanciate.
         * @return the name of the method call when the object is instanciate.
         */
        function getInitMethodName():String ;
        
        /**
         * Returns the Array of all properties of this Definition.
         * @return the Array of all properties of this Definition.
         */
        function getProperties():Array ;
        
        /**
         * Determinates the scope of the object.
         */
        function getScope():String  ;
        
        /**
         * Determinates the type of the object (the class name).
         */
        function getType():String  ;
        
        /**
         * Indicates if the object lazily initialized. Only applicable to a singleton object. 
         * If false, it will get instantiated on startup by object factories that perform eager initialization of singletons.
         * @return A boolean who indicates if the object lazily initialized. 
         */
        function isLazyInit():Boolean ;
        
        /**
         * Returns <code class="prettyprint">true</code> if the object in a Sigleton else the object is a prototype.
         * @return <code class="prettyprint">true</code> if the object in a Sigleton else the object is a prototype.
         */
        function isSingleton():Boolean ;
        
        /**
         * Sets the constructor arguments values of this object.
         */
        function setConstructorArguments( value:Array = null ):void ;
        
        /**
         * Sets the collection (Array) defines in the "dependsOn" attribute.
         */
        function setDependsOn( ar:Array ):void ;
        
        /**
         * Sets the name of the method invoked when the object is destroyed.
         */
        function setDestroyMethodName( value:String = null ):void ; 
        
        /**
         * Sets the factory stategy of this definition to create the object.
         */
        function setFactoryStrategy( value:IObjectFactoryStrategy ):void  ;
        
        /**
         * Sets the collection (Array) defines in the "generates" attribute.
         */
        function setGenerates( ar:Array ):void ;
        
        /**
         * Init the name of the method.
         */
        function setInitMethodName( value:String = null ):void ;
        
        /**
         * Sets the Array of all listener definition of this object definition.
         * @param ar the Array of all listener definitions of the object.
         */
        function setListeners( ar:Array = null ):void ;
        
        /**
         * Sets the Array of all receiver definition of this object definition.
         * @param ar the Array of all receiver definitions of the object.
         */
        function setReceivers( ar:Array = null ):void ;
        
        /**
         * Sets the Array of all properties of this definition.
         */
        function setProperties( ar:Array = null ):void ;
        
        /**
         * Sets the scope of the object.
         */
        function setScope( scope:String = null ):void ;
        
        /**
         * Sets the type of the object (the class name).
         */
        function setType( value:String = null ):void ; 
    }
}
