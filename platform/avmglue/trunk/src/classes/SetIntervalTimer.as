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
    
    /* note:
       this class is an utility class connected
       to setInterval() setTimeout() clearInterval() clearTimeout()

       Not documented in the FLash API asdoc.
       
       Depending on how we decide to implement it
        - in AS3 we keep it like that
        - in native, then we'll probably need to connect to a global timer loop
          see some infos here
          http://blog.kaourantin.net/?p=82

          before:
          --------
          while( sleep ( 1000/120 milliseconds ) )
          {
              // Every browser provides a different timer interval  ...
              if( timerPending )
              {
                  // AS2 Intervals, AS3 Timers
                  handleTimers();
              }

              if( localConnectionPending )
              {
                  handleLocalConnection();
              }

              if( videoFrameDue )
              {
                  decodeVideoFrame();
              }

              if( audioBufferEmpty )
              {
                  refillAudioBuffer();
              }

              if( nextSWFFrameDue )
              {
                  parseSWFFrame();
                  
                  if( actionScriptInSWFFrame )
                  {
                      executeActionScript();
                  }
              }

              if( needsToUpdateScreen )
              {
                  updateScreen();
              }

              //...
          }
          --------

          after:
          --------
          while( sleepuntil( nextEventTime  ) OR externalEventOccured() )
          {
              //...

              if( timerPending ) 
              {
                  // AS2 Intervals, AS3 Timers
                  handleTimers();
                  nextEventTime = nextTimerTime();
              }

              if( localConnectionPending )
              {
                  handleLocalConnection();
                  nextEventTime = min( nextEventTime , nextLocalConnectionTime() );
              }

              if( videoFrameDue )
              {
                  decodeVideoFrame();
                  nextEventTime = min( nextEventTime , nextVideoFrameTime() );
              }

              if( audioBufferEmpty )
              {
                  refillAudioBuffer();
                  nextEventTime = min( nextEventTime , nextAudioRebufferTime() );
              }

              if( nextSWFFrameDue )
              {
                  parseSWFFrame();
                  if( actionScriptInSWFFrame )
                  {
                      executeActionScript();
                  }
                  nextEventTime = min( nextEventTime , nextFrameTime() );
              }

              if( needsToUpdateScreen )
              {
                  updateScreen();
              }

              //...
          }
          --------

          we don't care about updating the screen or executing SWF frames or any other thing of renderers
          but we could implement such loops
            - to deal with sounds (yep you can have sounds in a CLI)
            - to deal with events dispatch (if we decide to implemented them natively)
            - to deal with LocalConnection (IPC) or any other form of Socket or Socket Server
    */
    internal final class SetIntervalTimer extends Timer
    {
        private static var intervals:Array = [];
        
        public var id:uint;
        private var _closure:Function;
        private var _rest:Array;
        
        public function SetIntervalTimer( closure:Function, delay:Number, repeats:Boolean, rest:Array )
        {
            super( delay, (repeats ? 0 : 1) );

            _closure = closure;
            _rest    = rest;

            addEventListener( TimerEvent.TIMER, onTimer );
            start();

            id = intervals.length + 1;
            intervals.push( this );
        }

        private function onTimer( event:TimerEvent ):void
        {
            _closure.apply( null, _rest );

            if( repeatCount == 1 )
            {
                if( intervals[ id - 1 ] == this )
                {
                    delete intervals[ id - 1 ];
                }
            }
        }

        public static function clearInterval( id_to_clear:uint ):void
        {
            id_to_clear--;
            if( intervals[ id_to_clear ] is SetIntervalTimer )
            {
                intervals[ id_to_clear ].stop();
                delete intervals[ id_to_clear ];
            }
        }
        
    }
}
