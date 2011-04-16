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
    /**
     * The EventDispatcher class is the base class for all classes that dispatch events.
     * The EventDispatcher class implements the <code>IEventDispatcher</code> interface
     * and is the base class for the <code>DisplayObject</code> class.
     *
     * The EventDispatcher class allows any object on the display list to be an event target and as such,
     * to use the methods of the IEventDispatcher interface.
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 9
     * @playerversion AIR 1.0
     */
    public class EventDispatcher implements IEventDispatcher
    {
        private var _target:IEventDispatcher;
        private var _listeners:Array;
        
        public function EventDispatcher( target:IEventDispatcher = null )
        {
            CFG::dbg{ trace( "new EventDispatcher( " + target + " )" ); }
            super();
            _build( target );
        }

        //private native function get listeners():Array;
        private function get listeners():Array
        {
            CFG::dbg{ trace( "EventDispatcher.get listeners()" ); }
            return _listeners;
        }
        
        //private native function _build( target:IEventDispatcher ):void;
        private function _build( target:IEventDispatcher ):void
        {
            //TODO
            if( target == null )
            {
                target = this;
            }
            
            _target    = target;
            _listeners = [];
            
        }

        //private native function _dispatchEvent( event:Event ):Boolean;
        private function _dispatchEvent( event:Event ):Boolean
        {
            //TODO
            return false;
        }
        
        //public native function addEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ):void;
        public function addEventListener( type:String, listener:Function, useCapture:Boolean = false,
                                          priority:int = 0, useWeakReference:Boolean = false ):void
        {
            CFG::dbg{ trace( "EventDispatcher.addEventListener( " + [type,listener,useCapture,priority,useWeakReference].join(", ") + " )" ); }
            //TODO
        }
        
        public function dispatchEvent( event:Event ):Boolean
        {
            CFG::dbg{ trace( "EventDispatcher.addEventListener( " + event + " )" ); }
            if( event.target )
            {
                return _dispatchEvent( event.clone() );
            }

            return _dispatchEvent( event );
        }

        //public native function hasEventListener( type:String ):Boolean;
        public function hasEventListener( type:String ):Boolean
        {
            CFG::dbg{ trace( "EventDispatcher.hasEventListener( " + type + " )" ); }
            //TODO
            return false;
        }

        //public native function removeEventListener( type:String, listener:Function, useCapture:Boolean = false ):void;
        public function removeEventListener( type:String, listener:Function, useCapture:Boolean = false ):void
        {
            CFG::dbg{ trace( "EventDispatcher.removeEventListener( " + [type,listener,useCapture].join(", ") + " )" ); }
            //TODO
        }

        //public native function willTrigger( type:String ):Boolean;
        public function willTrigger( type:String ):Boolean
        {
            CFG::dbg{ trace( "EventDispatcher.willTrigger( " + type + " )" ); }
            //TODO
            return false;
        }
        
    }
}
