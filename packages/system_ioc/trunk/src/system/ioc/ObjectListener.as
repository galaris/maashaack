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
    /**
     * This object defines a listener definition in an object definition.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.ioc.ObjectListener ;
     * 
     * var init:Array = 
     * [
     *     { dispatcher:"dispatcher1" , type:"change" , method:"handleEvent" } ,
     *     { dispatcher:"dispatcher2" , type:"change" , method:"handleEvent" } 
     * ] ;
     * 
     * var listeners:Array = ObjectListener.create( init ) ;
     * 
     * trace( listeners ) ; 
     * </pre>
     * Usage, in the IoC factory we can use the "listeners" attribute in the object definition to defines the object like a listener.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.ioc.ObjectFactory ;
     * 
     * var context:Object =
     * [
     *     { 
     *         id        : "dispatcher1" ,
     *         type      : "flash.events.EventDispatcher" ,
     *         singleton : true
     *     }
     *     ,
     *     { 
     *         id        : "dispatcher2" ,
     *         type      : "flash.events.EventDispatcher" ,
     *         singleton : true
     *     }
     *     ,    
     *     { 
     *         id        : "listener"   ,
     *         type      : "examples.Listener" ,
     *         singleton : true ,
     *         listeners :
     *         [
     *             { dispatcher:"dispatcher1" , type:"change" , method:"handleEvent" , useCapture:false, priority:0 , useWeakReference:true } ,  
     *             { dispatcher:"dispatcher2" , type:"change" } 
     *         ]
     *     }    
     * ] ;
     * 
     * var factory:ObjectFactory = new ObjectFactory() ;
     * 
     * factory.create( context ) ; 
     * 
     * // 1 - target the callback "handleEvent" method in the listener object (all objects with methods can be a listener)
     * 
     * var dispatcher1:EventDispatcher = factory.getObject("dispatcher1") ;
     * 
     * dispatcher1.dispatchEvent( new Event( "change" ) ) ; // [object Listener] handleEvent [Event type="change" bubbles=false cancelable=false eventPhase=2]
     * 
     * // 2 - target the listener object if implements the system.events.EventListener interface.
     * 
     * var dispatcher2:EventDispatcher = factory.getObject("dispatcher2") ;
     * 
     * dispatcher2.dispatchEvent( new Event( "change" ) ) ; // [object Listener] handleEvent [Event type="change" bubbles=false cancelable=false eventPhase=2]
     * </pre>
     * In the previous example we implement the examples.Listener class :* 
     * <pre class="prettyprint">
     * package examples
     * {
     *     import flash.events.Event;
     *     
     *     import system.events.EventListener;
     *      
     *     public class Listener implements EventListener
     *     {
     *         public function Listener()
     *         {
     *              // constructor
     *         }
     *         
     *         public function handleEvent( e:Event ):void
     *         {
     *             trace( this + " handleEvent " + e ) ;
     *         }
     *     }
     * }
     * </pre>
     */
    public class ObjectListener
    {
        /**
         * Creates a new ObjectListener instance.
         * @param dispatcher The dispatcher expression reference of the listener.
         * @param type type name of the event dispatched by the dispatcher of this listener.
         * @param method The name of the method to invoke when the event is handle.
         * @param useCapture Determinates if the event flow use capture or not.
         * @param priority Determines the priority level of the event listener.
         * @param useWeakReference Indicates if the listener is a weak reference.
         * @param order Indicates the order to register the listener "after" or "before" (see the system.ioc.ObjectOrder enumeration class).
         */
        public function ObjectListener( dispatcher:String , type:String , method:String=null , useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false , order:String = "after" )
        {
            this.dispatcher       = dispatcher ;
            this.method           = method ;
            this.type             = type ;
            this.priority         = priority ;
            this.useCapture       = useCapture ;
            this.useWeakReference = useWeakReference ;
            this.order            = order ;
        }
        
        /**
         * Defines the "dispatcher" attribute in a listener object definition.
         */
        public static const DISPATCHER:String = "dispatcher" ;
        
        /**
         * Defines the "method" attribute in a listener object definition.
         */
        public static const METHOD:String = "method" ;
        
        /**
         * Defines the "order" attribute in a listener object definition.
         */
        public static const ORDER:String = "order" ;
                
        /**
         * Defines the "priority" attribute in a listener object definition.
         */
        public static const PRIORITY:String = "priority" ;
        
        /**
         * Defines the "useCapture" attribute in a listener object definition.
         */
        public static const USE_CAPTURE:String = "useCapture" ;
        
        /**
         * Defines the "useWeakReference" attribute in a listener object definition.
         */
        public static const USE_WEAK_REFERENCE:String = "useWeakReference" ;
        
        /**
         * Defines the "type" attribute in a listener object definition.
         */
        public static const TYPE:String = "type" ;
        
        /**
         * The dispatcher expression reference of the listener.
         */
        public var dispatcher:String ;
        
        /**
         * The name of the method to invoke when the event is handle.
         */
        public var method:String ;
        
        /**
         * The order of the listener registration ('after' or by default 'before').
         */
        public function get order():String
        {
            return _order ;
        }
        
        /**
         * @private
         */
        public function set order( value:String ):void
        {
            _order = ( value == ObjectOrder.BEFORE ) ? ObjectOrder.BEFORE : ObjectOrder.AFTER ;
        }
        
        /**
         * Determines the priority level of the event listener.
         */
        public var priority:int ;
        
        /**
         * The type name of the event dispatched by the dispatcher.
         */
        public var type:String ;
        
        /**
         * Determinates if the event flow use capture or not.
         */
        public var useCapture:Boolean ;
        
        /**
         * Indicates if the listener is a weak reference.
         */
        public var useWeakReference:Boolean ;
        
        /**
         * Returns the String representation of the object.
         * @return the String representation of the object.
         */
        public function toString():String
        {
            var s:String = "[ObjectListener" ;
            if ( dispatcher )
            {
               s += " dispatcher:\"" + dispatcher + "\"" ;
            }
            if ( type )
            {
               s += " type:\"" + type + "\"" ;
            }
            if ( method )
            {
               s += " method:\"" + method + "\"" ;  
            }
            if ( _order )
            {
                s += " order:\"" + _order + "\"" ;
            }
            s += "]" ;
            return s ;
        }
        
        /**
         * @private
         */
        private var _order:String ;
    }
}
