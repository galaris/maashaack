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

package system.process
{
    import system.signals.Signal;
    import system.signals.Signaler;
    
    /**
     * This class simplify a full implementation of the <code class="prettyprint">Action</code> interface.
     */
    public class CoreAction extends Task
    {
        /**
         * Creates a new CoreAction instance.
         */
        public function CoreAction()
        {
            //
        }
        
        /**
         * This signal emit when the notifyChanged method is invoked. 
         */
        public function get changeIt():Signaler
        {
            return _changeIt ;
        }
        
        /**
         * @private
         */
        public function set changeIt( signal:Signaler ):void
        {
            _changeIt = signal || new Signal() ;
        }
        
        /**
         * This signal emit when the notifyCleared method is invoked. 
         */
        public function get clearIt():Signaler
        {
            return _clearIt ;
        }
        
        /**
         * @private
         */
        public function set clearIt( signal:Signaler ):void
        {
            _clearIt = signal || new Signal() ;
        }
        
        /**
         * This signal emit when the notifyInfo method is invoked. 
         */
        public function get infoIt():Signaler
        {
            return _infoIt ;
        }
        
        /**
         * @private
         */
        public function set infoIt( signal:Signaler ):void
        {
            _infoIt = signal || new Signal() ;
        }
        
        /**
         * The flag to determinate if the Action object is looped.
         */
        public var looping:Boolean ;
        
        /**
         * This signal emit when the notifyLooped method is invoked. 
         */
        public function get loopIt():Signaler
        {
            return _loopIt ;
        }
        
        /**
         * @private
         */
        public function set loopIt( signal:Signaler ):void
        {
            _loopIt = signal || new Signal() ;
        }
        
        /**
         * This signal emit when the notifyPause method is invoked. 
         */
        public function get pauseIt():Signaler
        {
            return _pauseIt ;
        }
        
        /**
         * @private
         */
        public function set pauseIt( signal:Signaler ):void
        {
            _pauseIt = signal || new Signal() ;
        }
        
        /**
         * This signal emit when the notifyProgress method is invoked. 
         */
        public function get progressIt():Signaler
        {
            return _progressIt ;
        }
        
        /**
         * @private
         */
        public function set progressIt( signal:Signaler ):void
        {
            _progressIt = signal || new Signal() ;
        }
        
        /**
         * This signal emit when the notifyResumed method is invoked.
         */
        public function get resumeIt():Signaler
        {
            return _resumeIt ;
        }
        
        /**
         * @private
         */
        public function set resumeIt( signal:Signaler ):void
        {
            _resumeIt = signal || new Signal() ;
        }
        
        /**
         * This signal emit when the notifyStopped method is invoked.
         */
        public function get stopIt():Signaler
        {
            return _stopIt ;
        }
        
        /**
         * @private
         */
        public function set stopIt( signal:Signaler ):void
        {
            _stopIt = signal || new Signal() ;
        }
        
        /**
         * This signal emit when the notifyTimeOut method is invoked.
         */
        public function get timeoutIt():Signaler
        {
            return _timeoutIt ;
        }
        
        /**
         * @private
         */
        public function set timeoutIt( signal:Signaler ):void
        {
            _timeoutIt = signal || new Signal() ;
        }
        
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():*
        {
            return new CoreAction() ;
        }
        
        /**
         * Notify when the process is changed.
         */
        public function notifyChanged():void 
        {
            if ( !isLocked() )
            {
                _changeIt.emit( this ) ;
            }
        }
        
        /**
         * Notify when the process is cleared.
         */
        public function notifyCleared():void 
        {
            if ( !isLocked() )
            {
                _clearIt.emit( this ) ;
            }
        }
        
        /**
         * Notify a specific information when the process is changed.
         */
        public function notifyInfo( info:* ):void
        {
            if ( !isLocked() )
            {
                _infoIt.emit( this , info ) ;
            }
        }
        
        /**
         * Notify when the process is looped.
         */
        public function notifyLooped():void 
        {
            _phase = TaskPhase.RUNNING ;
            if ( !isLocked() )
            {
                _loopIt.emit( this ) ;
            }
        }
        
        /**
         * Notify when the process is paused.
         */
        public function notifyPaused():void
        {
            setRunning( false ) ;
            _phase  = TaskPhase.STOPPED ;
            if ( !isLocked() )
            {
                _pauseIt.emit( this ) ;
            }
        }
        
        /**
         * Notify when the process is in progress.
         */
        public function notifyProgress():void
        {
            if ( !isLocked() )
            {
                _progressIt.emit( this ) ;
            }
        }
        
        /**
         * Notify when the process is resumed.
         */
        public function notifyResumed():void
        {
            _phase  = TaskPhase.RUNNING ;
            if ( !isLocked() )
            {
                _resumeIt.emit( this ) ;
            }
        }
        
        /**
         * Notify when the process is stopped.
         */
        public function notifyStopped():void
        {
            setRunning( false ) ;
            _phase  = TaskPhase.STOPPED ;
            if ( !isLocked() )
            {
                _stopIt.emit( this ) ;
            }
        }
        
        /**
         * Notify when the process is out of time.
         */
        public function notifyTimeOut():void
        {
            _phase  = TaskPhase.TIMEOUT ;
            if ( !isLocked() )
            {
                _timeoutIt.emit( this ) ;
            }
        }
        
        /**
         * @private
         */
        protected var _changeIt:Signaler = new Signal() ;
        
        /**
         * @private
         */
        protected var _clearIt:Signaler = new Signal() ;
        
        /**
         * @private
         */
        protected var _infoIt:Signaler = new Signal() ;
        
        /**
         * @private
         */
        protected var _loopIt:Signaler = new Signal() ;
        
        /**
         * @private
         */
        protected var _pauseIt:Signaler = new Signal() ;
        
        /**
         * @private
         */
        protected var _progressIt:Signaler = new Signal() ;
        
        /**
         * @private
         */
        protected var _resumeIt:Signaler = new Signal() ;
        
        /**
         * @private
         */
        protected var _stopIt:Signaler = new Signal() ;
        
        /**
         * @private
         */
        protected var _timeoutIt:Signaler = new Signal() ;
    }
}