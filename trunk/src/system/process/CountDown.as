package system.process 
{
    import flash.events.TimerEvent;
    import flash.utils.Timer;

    /**
     * Run a countdown process.
     */
    public class CountDown extends CoreAction implements Resetable, Resumable, Startable, Stoppable
    {
        /**
         * Creates a new CountDown instance.
         * @param maxcount The number of seconds to countdown.
         */
        public function CountDown( maxCount:uint = 0 )
        {
            _timer = new Timer( 1000 ) ;
            _timer.addEventListener( TimerEvent.TIMER          , _timerProgress ) ;
            _timer.addEventListener( TimerEvent.TIMER_COMPLETE , _timerComplete ) ;
            this.maxCount = maxCount ;
        }
        
        /**
         * The countdown number of times the timer has fired since it started at maxCount to zero.
         */
        public function get count():uint
        {
            return _count ;
        }
        
        /**
         * Determinates the number of seconds to countdown.
         */
        public function get maxCount():uint
        {
            return _timer.repeatCount ;
        }
        
        /**
         * @private
         */
        public function set maxCount( value:uint ):void
        {
            _timer.repeatCount = value ;
        }
        
        /**
         * Indicates if the task is stopped.
         */
        public function get stopped():Boolean
        {
            return _stopped ;
        }
        
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():*
        {
            return new CountDown( _timer.repeatCount ) ;
        }
        
        /**
         * Reset the process.
         */
        public function reset():void
        {
            _timer.reset() ;
            _count = _timer.repeatCount ;
        }
        
        /**
         * Resume the process.
         */
        public function resume():void
        {
            if ( _stopped )
            {
                _stopped = false ;
                notifyResumed() ;
                _timer.start() ;
            }
        }
        
        /**
         * Run the process.
         */
        public override function run( ...arguments:Array):void
        {
            if ( running )
            {
                return ;
            }
            
            _stopped = false ;
            
            notifyStarted() ;
            
            if ( maxCount == 0 )
            {
                notifyFinished() ;
                return ;
            }
            
            _count = _timer.repeatCount ;
            _timer.reset() ;
            
            _timer.start() ;
        }
        
        /**
         * Start the process.
         */
        public function start():void 
        {
            run() ;
        }
        
        /**
         * Stop the process.
         */
        public function stop():void
        {
            if( _timer.running )
            {
                _stopped = true ;
                _timer.stop() ;
                notifyStopped() ;
            }
        }
        
        /**
         * Indicates the current count value.
         * @private
         */
        protected var _count:uint ;
        
        /**
         * @private
         */
        protected var _stopped:Boolean;
        
        /**
         * @private
         */
        protected var _timer:Timer;
        
        /**
         * @private
         */
        protected function _timerComplete( e:TimerEvent ):void
        {
            notifyFinished() ;
        }
        
        /**
         * @private
         */
        protected function _timerProgress( e:TimerEvent ):void
        {
            _count -- ;
            notifyChanged() ;
        }
    }
}
