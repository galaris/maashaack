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
 * and other provisions required by the GPL or the LGPL. If you do not deletef
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

package avmplus
{
    import flash.utils.ByteArray;
    import flash.errors.IllegalOperationError;
    
    internal class StandardStreamErr implements StandardStream
    {
        private var _type:String;
        
        public function StandardStreamErr()
        {
            _type = "stderr";
        }
        
        public function read( length:uint = 0 ):String
        {
            throw new IllegalOperationError( "can not read on stream " + _type );
            return null; //unreachable
        }
        
        public function readBinary( length:uint = 0 ):ByteArray
        {
            throw new IllegalOperationError( "can not read on stream " + _type );
            return null; //unreachable
        }
        
        public function write( data:String ):void
        {
            //System.write( data );
            var bytes:ByteArray = new ByteArray();
                bytes.writeUTFBytes( data );
                bytes.writeByte(0);
                bytes.position = 0;

            writeBinary( bytes );
        }
        
        public function writeBinary( bytes:ByteArray ):void
        {
            System.hack_sys::stderrWrite( bytes );
        }

        public function toString():String
        {
            return _type;
        }
        
    }
}
