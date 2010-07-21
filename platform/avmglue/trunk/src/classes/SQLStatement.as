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
    import flash.system.*;
    import flash.errors.*;
    import flash.net.*;
    import flash.events.*;
    
    /**
     * A SQLStatement instance is used to execute a SQL statement against a local SQL database
     * that is open through a SQLConnection instance.
     * 
     * @langversion ActionScript 3.0
     * @playerversion AIR 1.0
     */
    [API(CONFIG::AIR_1_0)]
    public class SQLStatement extends EventDispatcher
    {
        private var _sql:String = "";
        private var _params:Object;
        private var _finalize:Boolean = false;

        private var _prepared:Boolean;
        private var _sqlConnection:SQLConnection;
        private var _itemClass:Class;
        private var _sqlResult:SQLResult;
        
        public function SQLStatement()
        {
            CFG::dbg{ trace( "new SQLStatement()" ); }
            super();

            _params = {};

            if( Security.sandboxType != Security.APPLICATION )
            {
                Error.throwError( SecurityError, 3205 );
            }
        }

        //private native function get prepared():Boolean;
        private function get prepared():Boolean
        {
            return _prepared;
        }

        //private native function internalCancel():void;
        private function internalCancel():void
        {
        
        }

        //private native function internalExecute( sql:String, params:Object, mustFinalize:Boolean, prefetch:int, responder:Responder ):void;
        private function internalExecute( sql:String, params:Object, mustFinalize:Boolean, prefetch:int, responder:Responder ):void
        {
        
        }

        //private native function internalNext( prefecth:int, responder:Responder ):void;
        private function internalNext( prefecth:int, responder:Responder ):void
        {
        
        }

        //private native function isSQLComplete( sql:String ):Boolean;
        private function isSQLComplete( sql:String ):Boolean
        {
            return false;
        }

        //private native function isExecuting():Boolean;
        private function isExecuting():Boolean
        {
            return false;
        }

        private function _checkAllowed():void
        {
            if( (_sql == null) || (_sql.length == 0) ) { Error.throwError( IllegalOperationError, 3108 ); }
            
            if( sqlConnection == null ) { Error.throwError( IllegalOperationError, 3109 ); }
            
            if( !sqlConnection.connected ) { Error.throwError( IllegalOperationError, 3104 ); }
        }
        
        private function _checkComplete():void
        {
            if( !isSQLComplete( _sql ) )
            {
                _sql = _sql + ";";
            }
        }
        
        private function _checkReady():void
        {
            if( executing ) { Error.throwError( IllegalOperationError, 3110 ); }
            
            _checkAllowed();
        }

        //public native function get sqlConnection():SQLConnection;
        [API(CONFIG::AIR_1_0)]
        public function get sqlConnection():SQLConnection
        {
            CFG::dbg{ trace( "SQLStatement.get sqlConnection()" ); }
            return _sqlConnection;
        }

        //public native function set sqlConnection( value:SQLConnection ):void;
        [API(CONFIG::AIR_1_0)]
        public function set sqlConnection( value:SQLConnection ):void
        {
            CFG::dbg{ trace( "SQLStatement.set sqlConnection( " + value + " )" ); }
            _sqlConnection = value;
        }

        //public native function get itemClass():Class;
        [API(CONFIG::AIR_1_0)]
        public function get itemClass():Class
        {
            CFG::dbg{ trace( "SQLStatement.get itemClass()" ); }
            return _itemClass;
        }

        //public native function set itemClass( value:Class ):void;
        [API(CONFIG::AIR_1_0)]
        public function set itemClass( value:Class ):void
        {
            CFG::dbg{ trace( "SQLStatement.set itemClass( " + value + " )" ); }
            _itemClass = value;
        }

        [API(CONFIG::AIR_1_0)]
        public function get executing():Boolean
        {
            CFG::dbg{ trace( "SQLStatement.get executing()" ); }
            return isExecuting();
        }

        [API(CONFIG::AIR_1_0)]
        public function get parameters():Object
        {
            CFG::dbg{ trace( "SQLStatement.get parameters()" ); }
            return _params;
        }

        [API(CONFIG::AIR_1_0)]
        public function get text():String
        {
            CFG::dbg{ trace( "SQLStatement.get text()" ); }
            return _sql;
        }

        [API(CONFIG::AIR_1_0)]
        public function set text(value:String):void
        {
            CFG::dbg{ trace( "SQLStatement.set text( " + value + " )" ); }
            if( _sql != value )
            {
                if( executing ) { Error.throwError( IllegalOperationError, 3106 ); }
                
                _finalize = !(value == _sql) && prepared;
                _sql = value.replace( /[\r]/g, "\n" );
            }
        }

        //public native function getResult():SQLResult;
        [API(CONFIG::AIR_1_0)]
        public function getResult():SQLResult
        {
            CFG::dbg{ trace( "SQLStatement.getResult()" ); }
            return _sqlResult;
        }

        [API(CONFIG::AIR_1_0)]
        public function cancel():void
        {
            CFG::dbg{ trace( "SQLStatement.cancel()" ); }
            if( executing )
            {
                internalCancel();
            }
        }

        [API(CONFIG::AIR_1_0)]
        public function clearParameters():void
        {
            CFG::dbg{ trace( "SQLStatement.clearParameters()" ); }
            _params = {};
        }

        [API(CONFIG::AIR_1_0)]
        public function execute( prefetch:int = -1, responder:Responder = null ):void
        {
            CFG::dbg{ trace( "SQLStatement.execute( " + [prefecth,responder].join(", ") + " )" ); }
            _checkReady();
            _checkComplete();
            
            internalExecute( _sql, _params, _finalize, prefetch, responder );
        }

        [API(CONFIG::AIR_1_0)]
        public function next( prefetch:int = -1, responder:Responder = null ):void
        {
            CFG::dbg{ trace( "SQLStatement.next( " + [prefecth,responder].join(", ") + " )" ); }
            if( !executing ) { Error.throwError( IllegalOperationError, 3107, "SQLStatement.next" ); }
            
            internalNext( prefetch, responder );
        }
    }
}
