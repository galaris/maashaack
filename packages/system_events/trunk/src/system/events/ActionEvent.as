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

package system.events
{
    import flash.events.Event;
    
    /**
     * The ActionEvent is notify by all the objects who implements the Action interface.
     */
    public class ActionEvent extends BasicEvent
    {
        /**
         * Creates a new ActionEvent instance.
         * @param type the string type of the instance.
         * @param target the target of the event.
         * @param info The information object of this action event.
         * @param context the optional context object of the event.
         * @param bubbles indicates if the event is a bubbling event.
         * @param cancelable indicates if the event is a cancelable event.
         * @param time this optional parameter is used in the eden deserialization to copy the timestamp value of this event.
         */
        public function ActionEvent( type:String , target:Object = null, info:* = null , context:* = null , bubbles:Boolean = false , cancelable:Boolean = false, time:Number = 0 )
        {
            super(type, target, context, bubbles, cancelable, time) ;
            this.info = info ;
        }
        
        /**
         * The name of the event when the process is changed.
         * @eventType change
         */
        public static const CHANGE:String = "change" ;
        
        /**
         * The name of the event when the process is cleared.
         * @eventType clear
         */
        public static const CLEAR:String = "clear" ;
        
        /**
         * The name of the event when the process is finished.
         * @eventType finish
         */
        public static const FINISH:String = "finish" ;
        
        /**
         * The name of the event when the process info is changed.
         * @eventType change
         */
        public static const INFO:String = "info" ;
        
        /**
         * The name of the event when the process is looped.
         * @eventType loop
         */
        public static const LOOP:String = "loop" ;
        
        /**
         * The name of the event when the process is in pause.
         * @eventType pause
         */
        public static const PAUSE:String = "pause" ;
        
        /**
         * The name of the event when the process is in progress.
         * @eventType progress
         */
        public static const PROGRESS:String = "progress" ;
        
        /**
         * The name of the event when the process is resumed.
         * @eventType resume
         */
        public static const RESUME:String = "resume" ;
        
        /**
         * The name of the event when the process is started.
         * @eventType start
         */
        public static const START:String = "start" ;
        
        /**
         * The name of the event when the process is stopped.
         * @eventType stop
         */        
        public static const STOP:String = "stop" ;
        
        /**
         * The name of the event when the process is cleared.
         * @eventType timeout
         */       
        public static const TIMEOUT:String = "timeout" ;
        
        /**
         * Indicates the info object of this event.
         */
        public function get info():*
        {
            return _info ;
        }
        
        /**
         * @private
         */
        public function set info( info:* ):void 
        {
            _info = info ;
        }
        
        /**
         * Returns the shallow copy of this object.
         * @return the shallow copy of this object.
         */
        public override function clone():Event 
        {
            return new ActionEvent( type, target, info, context ) ;
        }
        
        /**
         * @private
         */
        private var _info:* ;
    }
}