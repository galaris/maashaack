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

package graphics.transitions 
{
    import system.signals.Signal;
    import system.signals.Signaler;
    
    import flash.events.Event;
    import flash.utils.getTimer;
    
    /**
     * Constructs a <code class="prettyprint">new FrameTimer</code> object with the specified delay and repeat state. 
     * This timer use the frames by second of the animation. 
     * The timer does not start automatically, you much call the <code class="prettyprint">start()</code> method to start it.
     */
    public class FrameTimer extends FrameEngine implements ITimer 
    {
        /**
         * Creates a new FrameTimer instance.
         * The timer does not start automatically; you must call the start() method to start it.
         * @param delay The delay between timer events, in milliseconds.
         * @param repeatCount Specifies the number of repetitions. If zero, the timer repeats infinitely. If nonzero, the timer runs the specified number of times and then stops. 
         */
        public function FrameTimer( delay:Number = 0 , repeatCount:int = 0 )
        {
            _complete        = new Signal() ;
            _timer           = new Signal() ;
            this.delay       = delay ;
            this.repeatCount = repeatCount ;
        }
        
        /**
         * The timer complete signal reference.
         */
        public function get complete():Signaler
        {
            return _complete ;
        }
        
        /**
         * The timer signal reference.
         */
        public function get timer():Signaler
        {
            return _timer ;
        }
        
        /**
         * Returns a shallow copy of this object.
         * @return a shallow copy of this object.
         */
        public override function clone():*
        {
            return new FrameTimer( delay , repeatCount ) ;
        }
        
        /**
         * The total number of times the timer has fired since it started at zero.
         */
        public function get currentCount():int 
        {
            return _count ;
        }
        
        /**
         * The delay, in milliseconds, between timer events.
         * @throws Error Throws an exception if the delay specified is negative or not a finite number. 
         */
        public function get delay():Number 
        {
            return _delay ;
        }
        
        /**
         * @private
         */
        public function set delay( time:Number ):void 
        {
            if ( time < 0 || !isFinite(time) )
            {
                throw new Error( this + " the delay specified is negative or not a finite number." ) ;
            } ;
            _delay = (time > 0) ? time : 0 ;
        }
        
        /**
         * The total number of times the timer is set to run. 
         * If the repeat count is set to 0, the timer continues forever or until the stop() method is invoked or the program stops. 
         */
        public function get repeatCount():int
        {
            return _repeatCount ;
        }
        
        /**
         * @private
         */
        public function set repeatCount( count:int ):void
        {
            _repeatCount = count ;
        }
        
        /**
         * Stops the timer, if it is running, and sets the currentCount property back to 0, like the reset button of a stopwatch.
         */
        public function reset():void
        {
            if ( running )
            {
                this.stop() ;
            }
            _count = 0 ;
        }
        
        /**
         * @private
         */
        protected var _complete:Signaler ;
        
        /**
         * The internal counter of the timer.
         */
        protected var _count:int ;
        
        /**
         * The internal delay of the timer.
         */
        protected var _delay:Number ;
        
        /**
         * The internal 
         */
        protected var _lastTime:uint ;
        
        /**
         * The next value.
         */
        protected var _next:Number = 0 ;
        
        /**
         * The internal repeat counter of the timer.
         */
        protected var _repeatCount:int ;
        
        /**
         * @private
         */
        protected var _timer:Signaler ;
        
        /**
         * Invoked when the frame engine is in progress.
         */
        protected override function __enterFrame__( e:Event = null ):void
        {
            _enterFrame.emit() ;
            _next     += getTimer() - _lastTime ;
            _lastTime  = getTimer() ;
            if ( _next >= _delay ) 
            {
                _count ++ ;
                _timer.emit() ;
                _next = 0 ;
            }
            if ( _repeatCount != 0 && _count >= _repeatCount ) 
            {
                _complete.emit() ;
                this.reset() ;
            }
        }
    }
}
