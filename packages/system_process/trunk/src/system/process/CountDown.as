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
    import core.dump;
    
    import system.Serializable;
    
    import flash.events.TimerEvent;
    import flash.utils.Timer;
    
    /**
     * A countdown is a sequence of counting backward to indicate the seconds, days, or other time units 
     * remaining before an event occurs or a deadline expires. The CountDown objects defines a delay in millisecond 
     * and a maximal counter value for run the count down process.
     * <p><b>Example :</b></p>
     * <listing version="3.0">
     * <code class="prettyprint">
     * package examples
     * {
     *     import system.process.Action;
     *     import system.process.CountDown;
     *     
     *     import flash.display.Sprite;
     *     import flash.events.KeyboardEvent;
     *     import flash.ui.Keyboard;
     *     
     *     public class CountDownExample extends Sprite
     *     {
     *         public function CountDownExample()
     *         {
     *             stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
     *             
     *             counter = new CountDown( 5 ) ;
     *             
     *             counter.changeIt.connect( change ) ;
     *             counter.finishIt.connect( finish ) ;
     *             counter.pauseIt.connect( change ) ;
     *             counter.resumeIt.connect( resume ) ;
     *             counter.startIt.connect( start  ) ;
     *             counter.stopIt.connect( stop  ) ;
     *             
     *             counter.run() ;
     *         }
     *         
     *         //////////
     *         
     *         public var counter:CountDown ;
     *         
     *         //////////
     *         
     *         public function change( action:Action ):void
     *         {
     *             trace( "change count:" + counter.count ) ;
     *         }
     *         
     *         public function finish( action:Action ):void
     *         {
     *             trace( "finish count:" + counter.count ) ;
     *         }
     *         
     *         public function pause( action:Action ):void
     *         {
     *             trace( "pause count:" + counter.count ) ;
     *         }
     *         
     *         public function resume( action:Action ):void
     *         {
     *             trace( "resume count:" + counter.count ) ;
     *         }
     *         
     *         public function start( action:Action ):void
     *         {
     *             trace( "start count:" + counter.count ) ;
     *         }
     *         
     *         public function stop( action:Action ):void
     *         {
     *             trace( "stop count:" + counter.count ) ;
     *         }
     *         
     *         //////////
     *         
     *         private function keyDown( e:KeyboardEvent ):void 
     *         {
     *             var code:uint = e.keyCode ;
     *             switch( code )
     *             {
     *                 case Keyboard.UP :
     *                 {
     *                     counter.stop() ;
     *                     break ;
     *                 }
     *                 case Keyboard.DOWN :
     *                 {
     *                     if( counter.stopped )
     *                     {
     *                         counter.resume() ;
     *                     }
     *                     else
     *                     {
     *                         counter.start() ;
     *                     }
     *                     break ;
     *                 }
     *                 case Keyboard.SPACE :
     *                 {
     *                     counter.reset() ;
     *                     break ;
     *                 }
     *             }
     *         }
     *     }
     * }
     * </code>
     * </listing>
     */
    public class CountDown extends CoreAction implements Resetable, Resumable, Serializable, Startable, Stoppable
    {
        /**
         * Creates a new CountDown instance.
         * @param maxcount The number of seconds to countdown.
         * @param delay The optional delay to countdown (default 1000 ms)
         */
        public function CountDown( maxCount:uint = 0 , delay:Number = 1000 )
        {
            _timer = new Timer( delay ) ;
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
         * The optional delay to countdown (default 1000 ms)
         */
        public function get delay():Number
        {
            return _timer.delay ;
        }
        
        /**
         * @private
         */
        public function set delay( value:Number ):void
        {
            _timer.delay = value ;
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
            if ( running )
            {
                _timer.start() ;
            }
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
            _count   = _timer.repeatCount ;
            
            _timer.reset() ;
            
            notifyStarted() ;
            
            if ( maxCount == 0 )
            {
                notifyFinished() ;
                return ;
            }
            
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
         * Returns the String source representation of the object.
         * @return a string representation the source code of the object.
         */
        public function toSource( indent:int = 0 ):String  
        {
            return "new system.process.CountDown(" + dump(_timer.repeatCount) + "," + dump(_timer.delay) + ")" ;
        }
        
        /**
         * Returns the string representation of this instance.
         * @return the string representation of this instance.
         */
        public function toString():String 
        {
            return "[CountDown maxCount:" + _timer.repeatCount + "]" ;
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
