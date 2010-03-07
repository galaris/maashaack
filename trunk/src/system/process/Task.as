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
  Portions created by the Initial Developers are Copyright (C) 2006-2010
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
    import system.Reflection;
    import system.events.ActionEvent;
    import system.events.CoreEventDispatcher;
    import system.logging.Log;
    import system.logging.Loggable;
    import system.logging.Logger;
    import system.signals.Signal;
    import system.signals.Signaler;
    
    /**
     * Dispatched when a process is finished.
     * @eventType system.events.ActionEvent.FINISH
     * @see #notifyFinished
     */
    [Event(name="finish", type="system.events.ActionEvent")]
    
    /**
     * Dispatched when a process is started.
     * @eventType system.events.ActionEvent.START
     * @see #notifyStarted
     */
    [Event(name="start", type="system.events.ActionEvent")]
    
    /**
     * A simple representation of the <code class="prettyprint">Action</code> interface.
     */
    public dynamic class Task extends CoreEventDispatcher implements Action, Loggable
    {
        /**
         * Creates a new Task instance.
         * @param global the flag to use a global event flow or a local event flow.
         * @param channel the name of the global event flow if the <code class="prettyprint">global</code> argument is <code class="prettyprint">true</code>.
         */
        public function Task( global:Boolean = false , channel:String = null ) 
        {
            super( global , channel ) ;
            _logger = Log.getLogger( Reflection.getClassPath(this) ) ;
        }
        
        /**
         * This signal emit when the notifyFinished method is invoked. 
         */
        public function get finishIt():Signaler
        {
            return _finishIt ;
        }
        
        /**
         * @private
         */
        public function set finishIt( signal:Signaler ):void
        {
            _finishIt = signal || new Signal() ;
        }
        
        /**
         * Determinates the internal <code class="prettyprint">Logger</code> reference of this <code class="prettyprint">Loggable</code> object.
         */
        public function get logger():Logger
        {
            return _logger ;
        }
        
        /**
         * @private
         */
        public function set logger( log:Logger ):void
        {
            _logger = log || Log.getLogger( Reflection.getClassPath(this) ) ;
        }
        
        /**
         * Indicates <code class="prettyprint">true</code> if the process is in progress.
         */
        public function get running():Boolean 
        {
            return _isRunning ;
        }
        
        /**
         * This signal emit when the notifyStarted method is invoked. 
         */
        public function get startIt():Signaler
        {
            return _startIt || new Signal() ;
        }
        
        /**
         * @private
         */
        public function set startIt( signal:Signaler ):void
        {
            _startIt = signal ;
        }
        
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public function clone():*
        {
            return new Task( _isGlobal , channel ) ;
        }
        
        /**
         * Notify an ActionEvent when the process is finished.
         */
        public function notifyFinished():void 
        {
            setRunning( false ) ;
            if ( hasEventListener( _sTypeFinish ) )
            {
                dispatchEvent( new ActionEvent( _sTypeFinish , this ) ) ;
            }
            _finishIt.emit( this ) ;
        }
        
        /**
         * Notify an ActionEvent when the process is started.
         */
        public function notifyStarted():void
        {
            setRunning( true ) ;
            _startIt.emit( this ) ;
            if ( hasEventListener( _sTypeStart ) )
            {
                dispatchEvent( new ActionEvent( _sTypeStart , this ) ) ;
            }
        }
        
        /**
         * Run the process.
         * You can overrides this method in your iherited class. 
         */
        public function run( ...arguments:Array ):void 
        {
            // overrides this method.
        }
        
        /**
         * Changes the running property value.
         */
        protected function setRunning( b:Boolean ):void
        {
            _isRunning = b ;
        }
        
        /**
         * @private
         */
        private var _finishIt:Signaler = new Signal() ;
        
        /**
         * @private
         */
        protected var _isRunning:Boolean ;
        
        /**
         * @private
         */
        private var _logger:Logger ;
        
        /**
         * @private
         */
        private var _startIt:Signaler = new Signal() ;
        
        /**
         * @private
         */
        protected var _sTypeFinish:String = ActionEvent.FINISH ;
        
        /**
         * @private
         */
        protected var _sTypeStart:String = ActionEvent.START ;
    }
}