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

package graphics.transitions 
{
    import system.signals.Signal;
    import system.signals.Signaler;

    import flash.events.TimerEvent;
    import flash.utils.Timer;
    
    /**
     * This class extends the flash.utils.Timer class and implement the graphics.transitions.ITimer class.
     * The Timer class is the interface to Flash Player timers. 
     * You can create new Timer objects to run code on a specified time sequence. 
     * Use the start() method to start a timer. 
     * Add an event listener for the timer event to set up code to be run on the timer interval.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * package examples 
     * {
     *     import graphics.transitions.Timer;
     *     
     *     import flash.display.Sprite;
     *     import flash.events.KeyboardEvent;
     *     import flash.events.TimerEvent;
     *     
     *     public class ExampleTimer extends Sprite
     *     {
     *         public function ExampleTimer()
     *         {
     *             stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
     *             
     *             timer = new graphics.transitions.Timer( 3000, 2 );
     *             
     *             timer.addEventListener( TimerEvent.TIMER , timerHandler);
     *             timer.addEventListener( TimerEvent.TIMER_COMPLETE , timerHandler);
     *             
     *             timer.start();
     *         }
     *         
     *         public var timer:Timer ;
     *         
     *         public function timerHandler(event:TimerEvent):void 
     *         {
     *             trace( timer.currentCount + " " + event.type  );
     *         }
     *         
     *         public function keyDown( e:KeyboardEvent ):void
     *         {
     *             timer.reset() ;
     *             timer.start() ;
     *         }
     *     }
     * }
     * </pre> 
     */
    public class Timer extends flash.utils.Timer implements ITimer
    {
        /**
         * Constructs a new Timer object with the specified delay and repeatCount states. 
         * The timer does not start automatically; you must call the start() method to start it.
         * @param delay The delay between timer events, in milliseconds.
         * @param repeatCount Specifies the number of repetitions. If zero, the timer repeats infinitely. If nonzero, the timer runs the specified number of times and then stops.
         */
        public function Timer( delay:Number, repeatCount:int = 0 )
        {
            _complete = new Signal() ;
            _timer    = new Signal() ;
            super( delay, repeatCount ) ;
            addEventListener( TimerEvent.TIMER, __timer__ , false , 9999 ) ;
            addEventListener( TimerEvent.TIMER_COMPLETE, __timerComplete__ , false , 9999 ) ;
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
         * @private
         */
        protected var _complete:Signaler ;
        
        /**
         * @private
         */
        protected var _timer:Signaler ;
        
        /**
         * @private
         */
        protected function __timer__( e:TimerEvent = null ):void
        {
            _timer.emit() ;
        }
        
        /**
         * @private
         */
        protected function __timerComplete__( e:TimerEvent = null ):void
        {
            _complete.emit() ;
        }
    }
}
