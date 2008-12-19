/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package system.events
{
    import system.data.maps.ArrayMap;
    import system.events.EventDispatcher;    

    /**
     * Stores the listeners object an notifies them with the DOM Events level 2/3 of the W3C.
     * The EventDispatcher class implements the system.events.IEventDispatcher interface. 
     * This object allows any object to be an <code class="prettyprint">EventTarget</code>.
     */
    public class EventDispatcher extends InternalDispatcher
    {
        
        /**
         * Creates a new EventDispatcher instance.
         * @param target The target object for events dispatched to the EventDispatcher object. This parameter is used when the EventDispatcher instance is aggregated by a class that implements IEventDispatcher; it is necessary so that the containing object can be the target for events. Do not use this parameter in simple cases in which a class extends EventDispatcher.
         * @param channel The optional channel value of the dispatcher (use it in a global event flow).
         */
        public function EventDispatcher( target:IEventDispatcher = null , channel:String = null )
        {
            super( target );
            this.channel = channel ;
        }
 
        /**
         * Determinates the default singleton channel.
         */
        public static const DEFAULT_SINGLETON_CHANNEL:String = "__default__" ;
        
        /**
         * Indicates the channel of the display.
         */
        public function get channel():String
        {
            return _channel ;
        } 
        
        /**
         * @private
         */
        public function set channel( value:String ):void 
        {
            _channel = value ;
        }        
        
        /**
         * Indicates if the specified singleton reference is register.
         * @param channel the channel value of the singleton reference register in the factory.
         * @return <code class="prettyprint">true</code> If the specified singleton reference is register.
         */
        public static function containsInstance( channel:String ):Boolean
        {
        	return instances.containsKey( channel ) ;
        }
        
        /**
         * Clear all globals EventDispatcher singletons.
         */
        public static function flush():void 
        {
            instances.clear() ;
        }

        /**
         * Creates and returns a singleton EventDispatcher reference specified by the passed-in name identifier.
         * @param name The name of the singleton reference to return or create (If this value is Null, the DEFAULT_SINGLETON_NAME static value is used).
         * @return The singleton EventDispatcher reference specified by the passed-in name identifier.
         */
        public static function getInstance( channel:String=null ):EventDispatcher
        {
            if (channel == null) 
            {
                channel = DEFAULT_SINGLETON_CHANNEL ;
            }
            if ( !instances.containsKey(channel) ) 
            {
            	var dispatcher:EventDispatcher = new EventDispatcher() ;
            	dispatcher.channel = channel ;
                instances.put( channel , dispatcher ) ;
            }
            return instances.get( channel ) as EventDispatcher ;
        }
                
        /**
         * Removes a global EventDispatcher instance.
         */
        public static function removeInstance(name:String=null):Boolean 
        {
            if( name == null ) 
            {
            	name = DEFAULT_SINGLETON_CHANNEL ;
            }
            if ( instances.containsKey( name ) ) 
            {
                return instances.remove( name ) != null ;
            }
            return false ;
        }
                
        /**
         * @private
         */ 
        private var _channel:String = null ;        
        
        /**
         * @private
         */    
        private static var instances:ArrayMap = new ArrayMap() ;
        
    }
    
}