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

package flash.data
{
    /**
     * The SQLResult class provides access to data returned in response to the execution of
     * a SQL statement (a SQLStatement instance).
     * 
     * @langversion ActionScript 3.0
     * @playerversion AIR 1.0
     */
    [API(CONFIG::AIR_1_0)]
    public class SQLResult
    {
        
        private var _data:Array;
        private var _rowsAffected:uint;
        private var _complete:Boolean;
        private var _rowID:Number;
        
        public function SQLResult( data:Array = null, rowsAffected:Number = 0,
                                   complete:Boolean = true, rowID:Number = 0 )
        {
            CFG::dbg{ trace( "new SQLResult( " + [data,rowsAffected,complete,rowID].join(", ") + " )" ); }
            super();

            _data         = data;
            _rowsAffected = rowsAffected;
            _complete     = complete;
            _rowID        = rowID;
        }

        [API(CONFIG::AIR_1_0)]
        public function get data():Array
        {
            CFG::dbg{ trace( "SQLResult.get data()" ); }
            return _data;
        }

        [API(CONFIG::AIR_1_0)]
        public function get rowsAffected():Number
        {
            CFG::dbg{ trace( "SQLResult.get rowsAffected()" ); }
            return _rowsAffected
        }

        [API(CONFIG::AIR_1_0)]
        public function get complete():Boolean
        {
            CFG::dbg{ trace( "SQLResult.get complete()" ); }
            return _complete;
        }

        [API(CONFIG::AIR_1_0)]
        public function get lastInsertRowID():Number
        {
            CFG::dbg{ trace( "SQLResult.get lastInsertRowID()" ); }
            return _rowID;
        }
    }
}
