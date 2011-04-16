/* -*- c-basic-offset: 4; indent-tabs-mode: nil; tab-width: 4 -*- */
/* vi: set ts=4 sw=4 expandtab: (add to ~/.vimrc: set modeline modelines=5) */
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is [Open Source Virtual Machine.].
 *
 * The Initial Developer of the Original Code is
 * Adobe System Incorporated.
 * Portions created by the Initial Developer are Copyright (C) 2004-2006
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *   Adobe AS3 Team
 *   Zwetan Kjukov <zwetan@gmail.com>.
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

package flash.utils
{
    import flash.events.*;
    
    /**
     * The Timer class is the interface to timers, which let you run code on a specified time sequence.
     * Use the <code>start()</code> method to start a timer.
     * Add an event listener for the <code>timer</code> event to set up code to be run on the timer interval.
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 9
     * @playerversion AIR 1.0
     */
    public class Timer extends EventDispatcher
    {
        private var _delay:Number;
        private var _repeatCount:int;
        private var _count:int;

        private var _running:Boolean;
        
        public function Timer( delay:Number, repeatCount:int = 0 )
        {
            CFG::dbg{ trace( "new Timer( " + [delay,repeatCount].join(", ") + " )" ); }
            super();

            if( (delay < 0) || !isFinite( delay ) )
            {
                Error.throwError( RangeError, 2066 );
            }

            _delay       = delay;
            _repeatCount = repeatCount;
            _count       = 0;
            
            _running     = false;
        }

        public function get delay():Number
        {
            CFG::dbg{ trace( "Timer.get delay()" ); }
            return _delay;
        }

        public function set delay( value:Number ):void
        {
            CFG::dbg{ trace( "Timer.set delay( " + value + " )" ); }
            if( (delay < 0) || !isFinite( delay ) )
            {
                Error.throwError( RangeError, 2066 );
            }

            _delay = value;

            if( running )
            {
                stop();
                start();
            }
        }
        
        public function get repeatCount():int
        {
            CFG::dbg{ trace( "Timer.get repeatCount()" ); }
            return _repeatCount;
        }

        public function set repeatCount( value:int ):void
        {
            CFG::dbg{ trace( "Timer.set repeatCount( " + value + " )" ); }
            _repeatCount = value;

            if( running && !(_repeatCount == 0) && (_count >= _repeatCount) )
            {
                stop();
            }
        }

        public function get currentCount():int
        {
            CFG::dbg{ trace( "Timer.get currentCount()" ); }
            return _count;
        }
        
        //public native function get running():Boolean;
        public function get running():Boolean
        {
            CFG::dbg{ trace( "Timer.get running()" ); }
            return _running;
        }

        private function _tick():void
        {
            _count++;
            _timerDispatch();

            if( !(_repeatCount == 0) && (_count >= _repeatCount) )
            {
                stop();
                dispatchEvent( new TimerEvent( TimerEvent.TIMER_COMPLETE, false, false ) );
            }
        }
        
        //private native function _start( delay:Number, closure:Function ):void;
        private function _start( delay:Number, closure:Function ):void
        {
            //TODO
            _running = true;
            
            var now:Number;
            var before:Number = -1;
            
            while( running )
            {
                now = getTimer();

                if( (before > -1) && ( (now-before) >= delay ) )
                {
                    closure();
                }

                before = now;
                /* note:
                   if we have a sleep() function we could call it here
                   eg. sleep( delay/2 );
                */
            }
        }

        //private native function _timerDispatch():void;
        private function _timerDispatch():void
        {
            /* note:
               only usefull as a native call
               int raise(int sig) ?
            */
        }

        public function reset():void
        {
            CFG::dbg{ trace( "Timer.reset()" ); }
            if( running )
            {
                stop();
            }

            _count = 0;
        }
        
        public function start():void
        {
            CFG::dbg{ trace( "Timer.start()" ); }
            if( !running )
            {
                _start( _delay, _tick );
            }
        }
        
        //public native function stop():void;
        public function stop():void
        {
            CFG::dbg{ trace( "Timer.stop()" ); }
            //TODO
            _running = false;
        }
        
    }
}
