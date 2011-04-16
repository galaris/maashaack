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

package flash.display
{
    /* note:
       call() and addCallback() are indeed public but totally undocumented by Adobe
    */
    /**
     * AVM1Movie is a simple class that represents AVM1 movie clips, which use ActionScript 1.0 or 2.0.
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 9
     * @playerversion AIR 1.0
     */
    public class AVM1Movie extends DisplayObject
    {
        private var _callbackTable:Object;
        private var __interopAvailable:Boolean;
        
        public function AVM1Movie()
        {
            CFG::dbg{ trace( "new AVM1Movie()" ); }
            super();

            _ctor();
        }

        private function _ctor():void
        {
            _callbackTable     = {};
            /* note:
               to configure with HostConfig ?
               for now we set it to false as we don't plan at all
               to deal with AVM1 interop and/or load AS1/AS2 SWF inside Tamarin
            */
            __interopAvailable = false;
        }

        //private native function get _interopAvailable():Boolean;
        private function get _interopAvailable():Boolean
        {
            return __interopAvailable;
        }

        //private native function _callAS2( functionName:String, arguments:ByteArray ):void;

        //private native function _setCallAS3( closure:Function ):void;

        public function call( functionName:String, ...parameters ):*
        {
            CFG::dbg{ trace( "AVM1Movie.call( " + [functionName,parameters].join(", ") + " )" ); }
            if( !_interopAvailable ) { Error.throwError( IllegalOperationError, 2014 ); }
            
            return null;
        }
        
        public function addCallback( functionName:String, closure:Function ):void
        {
            CFG::dbg{ trace( "AVM1Movie.addCallback( " + [functionName,closure].join(", ") + " )" ); }
            if( !_interopAvailable ) { Error.throwError( IllegalOperationError, 2014 ); }
            
            _callbackTable[ functionName ] = closure;
        }
    }
}
