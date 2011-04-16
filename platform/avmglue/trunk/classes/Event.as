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

package flash.events
{
    import avmplus.flash_api;
    
    /**
     * The Event class is used as the base class for the creation of Event objects,
     * which are passed as parameters to event listeners when an event occurs.
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 9
     * @playerversion AIR 1.0
     */
    public class Event
    {

        /**
         *
         * @see flash.events.Event#deactivate 
         * @eventType activate
         */
        public static const ACTIVATE:String = "activate";
        
        /**
         *
         * @see flash.events.Event#removed 
         * @eventType added
         */
        public static const ADDED:String = "added";
        
        /**
         * @playerversion Flash Player 9.0.28.0
         * @playerversion AIR 1.0
         * 
         * @see flash.events.Event#removedFromStage
         * @eventType addedToStage
         */
        public static const ADDED_TO_STAGE:String = "addedToStage";

        public static const CANCEL:String = "cancel";

        public static const CHANGE:String = "change";
        
        /**
         * @playerversion Flash Player 10
         * @playerversion AIR 1.5
         * 
         * @eventType clear
         */
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public static const CLEAR:String = "clear";

        public static const CLOSE:String = "close";

        /**
         * @playerversion AIR 1.0
         * 
         * @eventType closing
         */
        [API(CONFIG::AIR_1_0)]
        public static const CLOSING:String = "closing";

        public static const COMPLETE:String = "complete";

        public static const CONNECT:String = "connect";
        
        /**
         * @playerversion Flash Player 10
         * @playerversion AIR 1.5
         * 
         * @eventType copy
         */
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public static const COPY:String = "copy";
        
        /**
         * @playerversion Flash Player 10
         * @playerversion AIR 1.5
         * 
         * @eventType cut
         */
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public static const CUT:String = "cut";

        /**
         *
         * @see flash.events.Event#activate
         * @see Loader 
         * @eventType deactivate
         */ 
        public static const DEACTIVATE:String = "deactivate";

        public static const DISPLAYING:String = "displaying";
        
        /**
         * @eventType enterFrame
         */
        public static const ENTER_FRAME:String = "enterFrame";
        
        /**
         * @eventType exitFrame
         */
        public static const EXIT_FRAME:String = "exitFrame";

        /**
         * @playerversion AIR 1.0
         * 
         * @eventType exiting
         */
        [API(CONFIG::AIR_1_0)]
        public static const EXITING:String = "exiting";
        
        /**
         * @eventType frameConstructed
         */
        public static const FRAME_CONSTRUCTED:String = "frameConstructed";

        public static const FULLSCREEN:String = "fullscreen";

        /**
         * @playerversion AIR 1.0
         * 
         * @eventType htmlBoundsChange
         */
        [API(CONFIG::AIR_1_0)]
        public static const HTML_BOUNDS_CHANGE:String = "htmlBoundsChange";

        /**
         * @playerversion AIR 1.0
         * 
         * @eventType htmlRender
         */
        [API(CONFIG::AIR_1_0)]
        public static const HTML_RENDER:String = "htmlRender";

        /**
         * @playerversion AIR 1.0
         * 
         * @eventType htmlDOMInitialize
         */
        [API(CONFIG::AIR_1_0)]
        public static const HTML_DOM_INITIALIZE:String = "htmlDOMInitialize";

        public static const ID3:String = "id3";

        public static const INIT:String = "init";

        /**
         * @playerversion AIR 1.0
         * 
         * @eventType locationChange
         */
        [API(CONFIG::AIR_1_0)]
        public static const LOCATION_CHANGE:String = "locationChange";

        public static const MOUSE_LEAVE:String = "mouseLeave";

        /**
         * @playerversion AIR 1.0
         * 
         * @eventType networkChange
         */
        [API(CONFIG::AIR_1_0)]
        public static const NETWORK_CHANGE:String = "networkChange";

        public static const OPEN:String = "open";
        
        /**
         * @playerversion Flash Player 10
         * @playerversion AIR 1.5
         * 
         * @eventType paste
         */
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public static const PASTE:String = "paste";
        
        /**
         *
         * @see flash.events.Event#added 
         * @eventType removed
         */
        public static const REMOVED:String = "removed";
        
        /**
         * @playerversion Flash Player 9.0.28.0
         * @playerversion AIR 1.0
         * 
         * @see flash.events.Event#addedToStage
         * @eventType removedFromStage
         */
        public static const REMOVED_FROM_STAGE:String = "removedFromStage";
        
        /**
         * @eventType render
         */
        public static const RENDER:String = "render";

        public static const RESIZE:String = "resize";

        public static const SCROLL:String = "scroll";

        public static const SELECT:String = "select";
        
        /**
         * @playerversion Flash Player 10
         * @playerversion AIR 1.5
         * 
         * @eventType selectAll
         */
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public static const SELECT_ALL:String = "selectAll";

        public static const SOUND_COMPLETE:String = "soundComplete";

        /**
         * @playerversion AIR 2.0
         * 
         * @eventType standardOuptutClose
         */
        [API(CONFIG::AIR_2_0)]
        public static const STANDARD_OUTPUT_CLOSE:String = "standardOuptutClose";

        /**
         * @playerversion AIR 2.0
         * 
         * @eventType standardErrorClose
         */
        [API(CONFIG::AIR_2_0)]
        public static const STANDARD_ERROR_CLOSE:String = "standardErrorClose";

        /**
         * @playerversion AIR 2.0
         * 
         * @eventType standardInputClose
         */
        [API(CONFIG::AIR_2_0)]
        public static const STANDARD_INPUT_CLOSE:String = "standardInputClose";
        
        /**
         * @eventType tabChildrenChange
         */
        public static const TAB_CHILDREN_CHANGE:String = "tabChildrenChange";
        
        /**
         * @eventType tabEnabledChange
         */
        public static const TAB_ENABLED_CHANGE:String = "tabEnabledChange";
        
        /**
         * @eventType tabIndexChange
         */
        public static const TAB_INDEX_CHANGE:String = "tabIndexChange";

        public static const UNLOAD:String = "unload";

        /**
         * @playerversion AIR 1.0
         * 
         * @eventType userIdle
         */
        [API(CONFIG::AIR_1_0)]
        public static const USER_IDLE:String = "userIdle";

        /**
         * @playerversion AIR 1.0
         * 
         * @eventType userPresent
         */
        [API(CONFIG::AIR_1_0)]
        public static const USER_PRESENT:String = "userPresent";




        private var _type:String;
        private var _bubbles:Boolean;
        private var _cancelable:Boolean;
        private var _currentTarget:Object;
        private var _eventPhase:uint;
        private var _target:Object;
        
        private var _preventDefault:Boolean;
        private var _propagate:Boolean;
        private var _propagateImmediately:Boolean;
        
        public function Event( type:String, bubbles:Boolean = false, cancelable:Boolean = false )
        {
            CFG::dbg{ trace( "new Event( " + [type,bubbles,cancelable].join(", ") + " )" ); }
            super();
            _build( type, bubbles, cancelable );
        }

        private function _build( type:String, bubbles:Boolean, cancelable:Boolean ):void
        {
            _type       = type;
            _bubbles    = bubbles;
            _cancelable = cancelable;

            _preventDefault       = false;
            _propagate            = true;
            _propagateImmediately = true;
        }

        //public native function get type():String;
        public function get type():String
        {
            CFG::dbg{ trace( "Event.get type()" ); }
            return _type;
        }

        flash_api function set type( value:String )
        {
            CFG::dbg{ trace( "[flash_api] Event.set type( " + value + " )" ); }
            _type = value;
        }

        //public native function get bubbles():Boolean;
        public function get bubbles():Boolean
        {
            CFG::dbg{ trace( "Event.get bubbles()" ); }
            return _bubbles;
        }
        
        flash_api function set bubbles( value:Boolean )
        {
            CFG::dbg{ trace( "[flash_api] Event.set bubbles( " + value + " )" ); }
            _bubbles = value;
        }

        //public native function get cancelable():Boolean;
        public function get cancelable():Boolean
        {
            CFG::dbg{ trace( "Event.get cancelable()" ); }
            return _cancelable;
        }
        
        flash_api function set cancelable( value:Boolean )
        {
            CFG::dbg{ trace( "[flash_api] Event.set cancelable( " + value + " )" ); }
            _cancelable = value;
        }

        //public native function get target():Object;
        public function get target():Object
        {
            CFG::dbg{ trace( "Event.get target()" ); }
            return _target;
        }

        flash_api function set target( value:Object )
        {
            CFG::dbg{ trace( "[flash_api] Event.set target( " + value + " )" ); }
            _target = value;
        }

        //public native function get currentTarget():Object;
        public function get currentTarget():Object
        {
            CFG::dbg{ trace( "Event.get currentTarget()" ); }
            return _currentTarget;
        }
        
        flash_api function set currentTarget( value:Object )
        {
            CFG::dbg{ trace( "[flash_api] Event.set currentTarget( " + value + " )" ); }
            _currentTarget = value;
        }

        //public native function get eventPhase():uint;
        public function get eventPhase():uint
        {
            CFG::dbg{ trace( "Event.get eventPhase()" ); }
            return _eventPhase;
        }
        
        flash_api function set eventPhase( value:uint )
        {
            CFG::dbg{ trace( "[flash_api] Event.set eventPhase( " + value + " )" ); }
            _eventPhase = value;
        }

        public function clone():Event
        {
            CFG::dbg{ trace( "Event.clone()" ); }
            return new Event( type, bubbles, cancelable );
        }

        public function formatToString( className:String, ...arguments ):String
        {
            CFG::dbg{ trace( "Event.formatToString( " + [className,arguments].join(", ") + " )" ); }
            var str:String = "["+className;
            var i:uint;
            var member:String;
            var value:*;
            
            for( i=0; i<arguments.length; i++ )
            {
                member = arguments[i];
                value  = this[member];
                if( member in this )
                {
                    if( value is String )
                    {
                        str += " " + member + "=\"" + value + "\"";
                    }
                    else
                    {
                        str += " " + member + "=" + value;
                    }
                }
            }
            
            return str+"]";
        }
        
        //public native function stopPropagation():void;
        public function stopPropagation():void
        {
            CFG::dbg{ trace( "Event.stopPropagation()" ); }
            _propagate = false;
        }

        //public native function stopImmediatePropagation():void;
        public function stopImmediatePropagation():void
        {
            CFG::dbg{ trace( "Event.stopImmediatePropagation()" ); }
            _propagateImmediately = false;
        }

        //public native function preventDefault():void;
        public function preventDefault():void
        {
            CFG::dbg{ trace( "Event.preventDefault()" ); }
            _preventDefault = true;
        }

        //public native function isDefaultPrevented():Boolean;
        public function isDefaultPrevented():Boolean
        {
            CFG::dbg{ trace( "Event.isDefaultPrevented()" ); }
            return _preventDefault;
        }

        public function toString():String
        {
            CFG::dbg{ trace( "Event.toString()" ); }
            return formatToString( "Event", "type", "bubbles", "cancelable", "eventPhase" );
        }
        
    }
}
