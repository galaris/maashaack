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
    import core.reflect.getClassName;

    import flash.events.Event;
    
    /**
     * <code class="prettyprint">system.events.BasicEvent</code> is the basical event structure to work with <code class="prettyprint">system.events.EventDispatcher</code>.
     * <p><b>Example</b></p>
     * <pre class="prettyprint"> 
     * import system.events.BasicEvent ;
     * var e:BasicEvent = new BasicEvent( "change" , this , { value:"hello world" } ) ;
     * </pre> 
     */
    public class BasicEvent extends Event 
    {
        /**
         * Creates a new <code class="prettyprint">BasicEvent</code> instance.
         * <pre class="prettyprint">
         * var e:BasicEvent = new BasicEvent( type:String, [target:Object, [context:*, [bubbles:Boolean, [cancelable:Boolean, [time:Number]]]]]) ;
         * </pre>
         * @param type the string type of the instance. 
         * @param target the target of the event.
         * @param context the optional context object of the event.
         * @param bubbles indicates if the event is a bubbling event.
         * @param cancelable indicates if the event is a cancelable event.
         * @param time this optional parameter is used in the eden deserialization to copy the timestamp value of this event.
          */
        public function BasicEvent( type:String  , target:Object = null , context:* = null , bubbles:Boolean = false , cancelable:Boolean = false, time:uint = 0 )
        {
            super( type , bubbles, cancelable ) ;
            
            _context = _context != null ? _context : context ;
            _target  = _target  != null ? _target  : target ;
            _time    = ( time > 0) ? time : ( (new Date()).valueOf() ) ;
            _type    = type ;
        }
        
        /**
         * Determinates the optional context of this event.
         */
        public function get context():*
        {
            return _context ;
        }
        
        /**
         * @private
         */
        public function set context( o:* ):void 
        {
            _context = o || null ;
        }
        
        /**
         * Indicates the custom event target.
         */
        public override function get target():Object
        {
            return _target || super.target ;
        }
        
        /**
         * @private
         */
        public function set target( o:Object ):void 
        {
            _target = o ;
        }
        
        /**
         * Indicates the timestamp of the event.
         */
        public function get timeStamp():uint 
        {
            return _time ;
        }
        
        /**
         * Returns the type of event.
         * @return the type of event.
         */
        public override function get type():String 
        {
            return _type ;
        }
        
        /**
         * Sets the type of event.
         */
        public function set type( s:String ):void 
        {
            _type = type ;
        }
        
        /**
         * Returns the shallow copy of this event.
         * @return the shallow copy of this event.
         */
        public override function clone():Event 
        {
            return new BasicEvent( type , target , context ) ;
        }
        
        /**
         * Dispatch the event with the global event flow.
         * @see EventDispatcher.getInstance(channel:String) static method.
         */
        public function dispatch( channel:String=null ):void
        {
            EventDispatcher.getInstance( channel ).dispatchEvent( this ) ;
        }
         
        /**
         * Returns the string representation of this event.
         * @return the string representation of this event.
         */
        public override function toString():String 
        {
            return formatToString( getClassName(this), "type", "target", "context", "bubbles", "cancelable", "eventPhase" ); 
        }
        
        /**
         * @private
         */
        private var _context:* ;
        
        /**
         * @private
         */
        private var _target:Object ;
        
        /**
         * @private
         */
        private var _time:uint ;
        
        /**
         * @private
         */
        private var _type:String ;
        
        /**
         * Sets the timestamp of the event (used this method only in internal in the Event class).
         */
        protected function setTimeStamp( time:uint = 0 ):void 
        {
            _time = (time > 0) ? time : (new Date()).valueOf() ;
        }
    }
}
