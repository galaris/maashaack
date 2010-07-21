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
     * A SQLSchemaResult instance contains the information resulting from a call to
     * the <code>SQLConnection.loadSchema()</code> method.
     * 
     * @langversion ActionScript 3.0
     * @playerversion AIR 1.0
     */
    [API(CONFIG::AIR_1_0)]
    public class SQLSchemaResult
    {
        private var _tables:Array;
        private var _views:Array;
        private var _indices:Array;
        private var _triggers:Array;
        
        public function SQLSchemaResult( tables:Array, views:Array, indices:Array, triggers:Array )
        {
            CFG::dbg{ trace( "new SQLSchemaResult( " + [tables,views,indices,triggers].join(", ") + " )" ); }
            super();

            _tables   = tables   ? tables:   [];
            _views    = views    ? views:    [];
            _indices  = indices  ? indices:  [];
            _triggers = triggers ? triggers: [];
        }

        [API(CONFIG::AIR_1_0)]
        public function get tables():Array
        {
            CFG::dbg{ trace( "SQLSchemaResult.get tables()" ); }
            return _tables;
        }

        [API(CONFIG::AIR_1_0)]
        public function get views():Array
        {
            CFG::dbg{ trace( "SQLSchemaResult.get views()" ); }
            return _views;
        }

        [API(CONFIG::AIR_1_0)]
        public function get indices():Array
        {
            CFG::dbg{ trace( "SQLSchemaResult.get indices()" ); }
            return _indices;
        }

        [API(CONFIG::AIR_1_0)]
        public function get triggers():Array
        {
            CFG::dbg{ trace( "SQLSchemaResult.get triggers()" ); }
            return _triggers;
        }
    }
}
