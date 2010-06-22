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
     * An object dispatches a TextEvent object when a user enters text in a text field
     * or clicks a hyperlink in an HTML-enabled text field.
     * 
     * There are two types of text events: <code>TextEvent.LINK</code> and <code>TextEvent.TEXT_INPUT</code>.
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 9
     * @playerversion AIR 1.0
     */
    public class TextEvent extends Event
    {
        public static const LINK:String = "link";
        public static const TEXT_INPUT:String = "textInput";

        private var _text:String;

        public function TextEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false, text:String = "" )
        {
            CFG::dbg{ trace( "new TextEvent( " + [type,bubbles,cancelable,text].join(", ") + " )" ); }
            super( type, bubbles, cancelable );
            _text = text;
        }

        public function get text():String
        {
            CFG::dbg{ trace( "TextEvent.get text()" ); }
            return _text;
        }
        
        public function set text( value:String ):void
        {
            CFG::dbg{ trace( "TextEvent.set text( " + value + " )" ); }
            _text = value;
        }
        
        public override function clone():Event
        {
            CFG::dbg{ trace( "TextEvent.clone()" ); }
            var te:TextEvent = new TextEvent( type, bubbles, cancelable, _text );
            //te.copyNativeData( this );
            return te;
        }
        
        public override function toString():String
        {
            CFG::dbg{ trace( "TextEvent.toString()" ); }
            return formatToString( "TextEvent", "type", "bubbles", "cancelable", "eventPhase", "text" );
        }

        //private native function copyNativeData( other:TextEvent ):void;
        private function copyNativeData( other:TextEvent ):void
        {
            //TODO
            /* note:
               not sure what this is supposed to do
               but again as we don;t deal with GUI we can ignore it
            */
        }
        
    }
}
