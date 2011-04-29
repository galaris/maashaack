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

package system.process 
{
    import flash.events.TimerEvent;
    import flash.utils.Timer;
    
    /**
     * Provides a delayed task, the task is executed after a specific delay in milliseconds. 
     */
    public class DelayedTask extends CoreAction implements Resumable, Startable, Stoppable
    {
        /**
         * Creates a new DelayedTask instance.
         * @param task The Action object to delayed.
         * @param delay The delay, in milliseconds, to execute the task.
         */
        public function DelayedTask( task:Action = null , delay:Number = 0 )
        {
            this.task  = task ;
            _timer = new Timer(delay, 1) ;
            _timer.addEventListener( TimerEvent.TIMER, _timerProgress ) ;
        }
        
        /**
         * The delay, in milliseconds, to start the task.
         */
        public function get delay():Number
        {
            return _timer.delay ;
        }
        
        /**
         * @private
         */
        public function set delay( time:Number ):void
        {
            _timer.delay = time ;
        }
        
        /**
         * Indicates if the task is stopped.
         */
        public function get stopped():Boolean
        {
            return _stopped ;
        }
        
        /**
         * The Action reference to register.
         */
        public var task:Action ;
        
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():*
        {
            return new DelayedTask( task , delay ) ;
        }
        
        /**
         * Resume the chain.
         */
        public function resume():void 
        {
            if ( _stopped )
            {
                _stopped = false ;
                notifyResumed() ;
                if ( _state == TIMER )
                {
                    _timer.start() ;
                }
                else if( _state == TASK && task && task is Resumable )
                {
                    ( task as Resumable ).resume() ;
                }
            }
        }
        
        /**
         * Run the process.
         * You can overrides this method in your iherited class. 
         */
        public override function run( ...arguments:Array ):void 
        {
            if ( !_isRunning )
            {
                _stopped = false ;
                _state   = NONE ;
                notifyStarted() ;
                if( _timer.delay > 0 )
                {
                    _timer.start() ;
                }
                else
                {
                    notifyFinished() ;
                }
            }
        }
        
        /**
         * Starts the chain.
         */
        public function start():void 
        {
            run() ;
        }
        
        /**
         * Stops the task group.
         */
        public function stop():void
        {
            if ( running )
            {
                _state = NONE ;
                _isRunning = false ;
                _stopped   = true  ;
                if ( _timer.running )
                {
                    _state = TIMER ;
                    _timer.stop() ;
                }
                else if ( task.running && task is Stoppable )
                {
                    _state = TASK ;
                    ( task as Stoppable ).stop() ;
                }
                notifyStopped() ;
            }
        }
        
        /**
         * The state when the task is not stopped.
         */
        protected static const NONE:String = "none" ;
        
        /**
         * The state when the task is stopped during the task process.
         */
        protected static const TASK:String = "task" ;
        
        /**
         * The state when the task is stopped during the timer process.
         */
        protected static const TIMER:String = "timer" ;
        
        /**
         * @private
         */
        protected var _state:String = NONE ;
        
        /**
         * @private
         */
        protected var _stopped:Boolean ;
        
        /**
         * @private
         */
        protected var _timer:Timer ;
        
        /**
         * @private
         */
        protected function _finishTask( action:Action ):void
        {
            notifyFinished() ;
        }
        
        /**
         * @private
         */
        protected function _timerProgress( e:TimerEvent ):void
        {
            if ( task )
            {
                task.finishIt.connect( _finishTask , 0 , true ) ;
                task.run() ;
            }
        }
    }
}
