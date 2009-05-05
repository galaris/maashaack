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
  Portions created by the Initial Developers are Copyright (C) 2006-2009
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

package system.process
{
    import system.events.ActionEvent;

    /**
     * Dispatched when a process is changed.
     * @eventType system.events.ActionEvent.CHANGE
     * @see #notifyChanged
     */
    [Event(name="change", type="system.events.ActionEvent")]

    /**
     * Dispatched when a process is cleared.
     * @eventType system.events.ActionEvent.CLEAR
     * @see #notifyCleared
     */
    [Event(name="clear", type="system.events.ActionEvent")]
        
    /**
     * Dispatched when an info process is running.
     * @eventType system.events.ActionEvent.INFO
     * @see #notifyInfo
     */
    [Event(name="info", type="system.events.ActionEvent")]
    
    /**
     * Dispatched when a process is looped.
     * @eventType system.events.ActionEvent.LOOP
     * @see #notifyLooped
     */
    [Event(name="loop", type="system.events.ActionEvent")]    
    
    /**
     * Dispatched when a process is paused.
     * @eventType system.events.ActionEvent.PAUSE
     * @see #notifyPaused
     */
    [Event(name="pause", type="system.events.ActionEvent")]     
    
    /**
     * Dispatched when a process is in progress.
     * @eventType system.events.ActionEvent.PROGRESS
     * @see #notifyProgress
     */
    [Event(name="progress", type="system.events.ActionEvent")]  
    
    /**
     * Dispatched when a process is resumed.
     * @eventType system.events.ActionEvent.RESUME
     * @see #notifyResumed
     */
    [Event(name="resume", type="system.events.ActionEvent")]  
        
    /**
     * Dispatched when a process is stopped.
     * @eventType system.events.ActionEvent.STOP
     * @see #notifyStopped
     */
    [Event(name="stop", type="system.events.ActionEvent")]      
    
    /**
     * Dispatched when a process is out of time.
     * @eventType system.events.ActionEvent.TIMEOUT
     * @see #notifyTimeOut
     */
    [Event(name="timeout", type="system.events.ActionEvent")]   
        
    /**
     * This class simplify a full implementation of the <code class="prettyprint">Action</code> interface.
     */
    public dynamic class CoreAction extends Task
    {
        
        /**
         * Creates a new Action instance.
         * @param global the flag to use a global event flow or a local event flow.
         * @param channel the name of the global event flow if the <code class="prettyprint">bGlobal</code> argument is <code class="prettyprint">true</code>.
         */
        public function CoreAction( global:Boolean = false , channel:String = null )
        {
            super( global, channel ) ;
            initEventType() ;
        }
        
        /**
         * The flag to determinate if the Action object is looped.
         */
        public var looping:Boolean ;
        
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():*
        {
            return new CoreAction() ;
        }
        
        /**
         * Returns the event name use in the notifyChanged method.
         * @return the event name use in the notifyChanged method.
         */
        public function getEventTypeCHANGE():String
        {
            return _sTypeChange ;
        }
        
        /**
         * Returns the event name use in the notifyCleared method.
         * @return the event name use in the notifyCleared method.
         */
        public function getEventTypeCLEAR():String
        {
            return _sTypeClear ;
        }
        
        /**
         * Returns the event name use in the notifyInfo method.
         * @return the event name use in the notifyInfo method.
         */
        public function getEventTypeINFO():String
        {
            return _sTypeInfo ;
        }
        
        /**
         * Returns the event name use in the notifyLooped method.
         * @return the event name use in the notifyLooped method.
         */
        public function getEventTypeLOOP():String
        {
            return _sTypeLoop ;
        }
        
        /**
         * Returns the event name use in the notifyProgress method.
         * @return the event name use in the notifyProgress method.
         */
        public function getEventTypePROGRESS():String
        {
            return _sTypeProgress ;
        }
        
        /**
         * Returns the event name use in the notifyResumed method.
         * @return the event name use in the notifyResumed method.
         */
        public function getEventTypeRESUME():String
        {
            return _sTypeResume ;
        }
        
        /**
         * Returns the event name use in the notifyStopped method.
         * @return the event name use in the notifyStopped method.
         */
        public function getEventTypeSTOP():String
        {
            return _sTypeStop ;
        }
        
        /**
         * Returns the event name use in the notifyTimeOut method.
         * @return the event name use in the notifyTimeOut method.
         */
        public function getEventTypeTIMEOUT():String
        {
            return _sTypeTimeout ;
        }
        
        /**
         * Initialize the internal event's types of this process.
         */
        public function initEventType():void
        {
            _sTypeChange   = ActionEvent.CHANGE   ;
            _sTypeClear    = ActionEvent.CLEAR    ;
            _sTypeInfo     = ActionEvent.INFO     ;
            _sTypeLoop     = ActionEvent.LOOP     ;
            _sTypeProgress = ActionEvent.PROGRESS ;
            _sTypeResume   = ActionEvent.RESUME   ;
            _sTypeStop     = ActionEvent.STOP     ;
            _sTypeTimeout  = ActionEvent.TIMEOUT  ;
        }
        
        /**
         * Notify an ActionEvent when the process is changed.
         */
        protected function notifyChanged():void 
        {
            dispatchEvent( new ActionEvent( _sTypeChange, this ) ) ;
        }
        
        /**
         * Notify an ActionEvent when the process is cleared.
         */
        protected function notifyCleared():void 
        {
            dispatchEvent( new ActionEvent( _sTypeClear, this ) ) ;
        }
        
        /**
         * Notify an ActionEvent when the process info is changed.
         */
        protected function notifyInfo( info:* ):void
        {
            dispatchEvent( new ActionEvent( _sTypeInfo, this , info ) ) ;
        }
        
        /**
         * Notify an ActionEvent when the process is looped.
         */
        protected function notifyLooped():void 
        {
            dispatchEvent( new ActionEvent( _sTypeLoop, this ) ) ;
        }
        
        /**
         * Notify an ActionEvent when the process is in progress.
         */
        protected function notifyProgress():void
        {
            dispatchEvent( new ActionEvent( _sTypeProgress, this ) ) ;
        }
        
        /**
         * Notify an ActionEvent when the process is resumed.
         */
        protected function notifyResumed():void
        {
            dispatchEvent( new ActionEvent( _sTypeResume, this ) ) ;
        }
        
        /**
         * Notify an ActionEvent when the process is stopped.
         */
        protected function notifyStopped():void
        {
            setRunning(false) ;
            dispatchEvent( new ActionEvent( _sTypeStop, this ) ) ;
        }
        
        /**
         * Notify an ActionEvent when the process is out of time.
         */
        protected function notifyTimeOut():void
        {
            dispatchEvent( new ActionEvent( _sTypeTimeout, this ) ) ;
        }
        
        /**
         * Sets the event name use in the notifyChanged method.
         */
        public function setEventTypeCHANGE( type:String ):void
        {
            _sTypeChange = type || ActionEvent.CHANGE ;
        }
        
        /**
         * Sets the event name use in the notifyCleared method.
         */
        public function setEventTypeCLEAR( type:String ):void
        {
            _sTypeClear = type || ActionEvent.CLEAR ;
        }
        
        /**
         * Sets the event name use in the notifyInfo method.
         */
        public function setEventTypeINFO( type:String ):void
        {
            _sTypeInfo = type || ActionEvent.INFO ;
        }
        
        /**
         * Sets the event name use in the notifyLooped method.
         */
        public function setEventTypeLOOP( type:String ):void
        {
            _sTypeLoop = type || ActionEvent.LOOP ;
        }
        
        /**
         * Sets the event name use in the notifyProgress method.
         */
        public function setEventTypePROGRESS( type:String ):void
        {
            _sTypeProgress = type || ActionEvent.PROGRESS ;
        }
        
        /**
         * Sets the event name use in the notifyResumed method.
         */
        public function setEventTypeRESUME( type:String ):void
        {
            _sTypeResume = type || ActionEvent.RESUME ;
        }
        
        /**
         * Sets the event name use in the notifyStopped method.
         */
        public function setEventTypeSTOP( type:String ):void
        {
            _sTypeStop = type || ActionEvent.STOP ;
        }
        
        /**
         * Sets the event name use in the notifyTimeOut method.
         */
        public function setEventTypeTIMEOUT( type:String ):void
        {
            _sTypeTimeout = type || ActionEvent.TIMEOUT ;
        }
        
        /**
         * @private
         */
        private var _sTypeChange:String ;
        
        /**
         * @private
         */
        private var _sTypeClear:String ;
        
        /**
         * @private
         */
        private var _sTypeInfo:String ;
        
        /**
         * @private
         */
        private var _sTypeLoop:String ;
        
        /**
         * @private
         */
        private var _sTypeProgress:String ;
        
        /**
         * @private
         */
        private var _sTypeResume:String ;
        
        /**
         * @private
         */
        private var _sTypeStop:String ;
        
        /**
         * @private
         */
        private var _sTypeTimeout:String ;

    }

}