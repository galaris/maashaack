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
    import core.dump;
    import core.reflect.getClassPath;
    
    import system.Serializable;
    
    import flash.events.TimerEvent;
    import flash.utils.Timer;
    
    /**
     * The pause command is used to pause the currently running process until a specific delay is not finished or until the user stop it.
     * <p><b>Example :</b></p>
     * <listing version="3.0">
     * <code class="prettyprint">
     * import system.events.Action ;
     * import system.process.Pause ;
     * 
     * var finish:Function = function( action:Action ):void
     * {
     *     trace( "finish" ) ;
     * }
     * 
     * var start:Function = function( action:Action ):void
     * {
     *     trace( "start" ) ;
     * }
     * 
     * var pause:Pause = new Pause( 10 ) ; // 10 seconds
     * 
     * pause.startIt.connect( start ) ;
     * pause.finishIt.connect( finish ) ;
     * 
     * pause.run() ;
     * </code>
     * </listing>
     */
    public dynamic class Pause extends CoreAction implements Serializable, Startable, Stoppable
    {
        /**
         * Creates a new Pause instance.
         * @param duration the duration of the pause.
         * @param useSeconds the flag to indicates if the duration is in second or not.
         */
        public function Pause( duration:Number = 0 , useSeconds:Boolean = true )
        {
            _duration = (isNaN(duration) && duration < 0 && !isFinite(duration) ) ? 0 : duration ;
            _useSeconds = useSeconds ;
            _timer = new Timer( delay , 1 ) ;
            _timer.addEventListener( TimerEvent.TIMER_COMPLETE , _onFinished ) ;
            _timer.addEventListener( TimerEvent.TIMER , _onTimer ) ;
        }
        
        /**
         * Indicates the delay of the pause in ms. This property use the duration and useSeconds properties to defined the delay.
         * @see #duration
         */
        public function get delay():Number
        {
            return useSeconds ? ( Math.round( duration * 1000 ) ) : duration ; 
        }
        
        /**
         * Indicates the duration of the process.
         */
        public function get duration():Number
        {
            return ( isNaN(_duration) && !isFinite(_duration) ) ? 1 : _duration ;
        }
        
        /**
         * @private
         */
        public function set duration( n:Number ):void 
        {
            _duration = (isNaN(n) && n < 0 && !isFinite(n) ) ? 0 : n ;
            _timer.delay = delay ;
        }
        
        /**
         * Indicates if the pause use seconds or not.
         */
        public function get useSeconds():Boolean
        {
            return _useSeconds ;
        }
        
        /**
         * @private
         */
        public function set useSeconds( b:Boolean ):void
        {
            _useSeconds = b ;
            _timer.delay = delay ;
        }
        
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():*
        {
            return new Pause(duration, useSeconds) ;
        }
        
        /**
         * Runs the process.
         */
        public override function run( ...arguments:Array ):void 
        {
            if ( running ) 
            {
                return ;
            }
            notifyStarted() ;
            _timer.start() ;
        }
        
        /**
        * Start the pause process.
        */
        public function start():void 
        {
            run() ;
        }
        
        /**
         * Stop the pause process.
         */
        public function stop():void 
        {
            if (_timer.running) 
            {
                _timer.stop()     ;
                notifyStopped()   ;
                notifyFinished()  ;
            }
        }
        
        /**
         * Returns the String source representation of the object.
         * @return a string representation the source code of the object.
         */
        public function toSource( indent:int = 0 ):String  
        {
            return "new " + getClassPath(this, true) + "(" + dump(delay) + "," + dump(useSeconds) + ")" ;
        }
        
        /**
         * Returns the string representation of this instance.
         * @return the string representation of this instance.
         */
        public function toString():String 
        {
            return "[Pause duration:" + duration + (useSeconds ? "s" : "ms") + "]" ;
        }
        
        /**
         * @private
         */
        private var _duration:Number = 0;
        
        /**
         * @private
         */
        private var _timer:Timer ;
        
        /**
         * @private
         */
        private var _useSeconds:Boolean ;
        
        /**
         * Invoked when the internal timer of this process is finished.
         */
        private function _onFinished(e:TimerEvent):void
        {
            notifyFinished() ;
        }
        
        /**
         * Invoked when the timer of this process is in progress.
         */
        private function _onTimer(e:TimerEvent):void
        {
            notifyProgress() ;
        }
    }
}
