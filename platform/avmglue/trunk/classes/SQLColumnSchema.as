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
     * The SQLColumnSchema class provides information describing the characteristics
     * of a specific column within a table in a database.
     * 
     * @langversion ActionScript 3.0
     * @playerversion AIR 1.0
     */
    [API(CONFIG::AIR_1_0)]
    public class SQLColumnSchema
    {
        private var _name:String;
        private var _primaryKey:Boolean;
        private var _allowNull:Boolean;
        private var _autoIncrement:Boolean;
        private var _dataType:String;
        private var _collationType:String;

        public function SQLColumnSchema( name:String, primaryKey:Boolean, allowNull:Boolean,
                                         autoIncrement:Boolean, dataType:String, defaultCollationType:String )
        {
            CFG::dbg{ trace( "new SQLColumnSchema( " + [name,primaryKey,allowNull,autoIncrement,dataType,defaultCollationType].join(", ") + " )" ); }
            super();

            _name          = name;
            _primaryKey    = primaryKey;
            _allowNull     = allowNull
            _autoIncrement = autoIncrement;
            _dataType      = dataType;
            _collationType = defaultCollationType;
        }

        [API(CONFIG::AIR_1_0)]
        public function get name():String
        {
            CFG::dbg{ trace( "SQLColumnSchema.get name()" ); }
            return _name;
        }

        [API(CONFIG::AIR_1_0)]
        public function get primaryKey():Boolean
        {
            CFG::dbg{ trace( "SQLColumnSchema.get primaryKey()" ); }
            return _primaryKey;
        }

        [API(CONFIG::AIR_1_0)]
        public function get allowNull():Boolean
        {
            CFG::dbg{ trace( "SQLColumnSchema.get allowNull()" ); }
            return _allowNull;
        }

        [API(CONFIG::AIR_1_0)]
        public function get autoIncrement():Boolean
        {
            CFG::dbg{ trace( "SQLColumnSchema.get autoIncrement()" ); }
            return _autoIncrement;
        }

        [API(CONFIG::AIR_1_0)]
        public function get dataType():String
        {
            CFG::dbg{ trace( "SQLColumnSchema.get dataType()" ); }
            return _dataType;
        }

        [API(CONFIG::AIR_1_0)]
        public function get defaultCollationType():String
        {
            CFG::dbg{ trace( "SQLColumnSchema.get defaultCollationType()" ); }
            return _collationType;
        }
    }
}
