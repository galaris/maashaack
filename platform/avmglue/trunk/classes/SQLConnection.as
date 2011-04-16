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
    import flash.events.*;
    import flash.net.*;
    import flash.utils.*;
    import flash.errors.*;
    
    /**
     * A SQLConnection instance is used to manage the creation of and connection to
     * local SQL database files (local databases).
     * 
     * @langversion ActionScript 3.0
     * @playerversion AIR 1.0
     */
    [API(CONFIG::AIR_1_0)]
    public class SQLConnection extends EventDispatcher
    {
        private static const SAVEPOINT_PREFIX:String = "$air_sp$";

        private var _allowCommitRollback:Boolean = false;
        private var _savepoints:Array;

        private var _autoCompact:Boolean;
        private var _connected:Boolean;
        private var _cacheSize:uint;
        private var _columnNameStyle:String;
        private var _inTransaction:Boolean;
        private var _rowID:uint;
        private var _pageSize:uint;
        private var _totalChanges:Number;
        
        public function SQLConnection()
        {
            CFG::dbg{ trace( "new SQLConnection()" ); }
            super();

            if( Security.sandboxType != Security.APPLICATION )
            {
                Error.throwError( SecurityError, 3205 );
            }
        }

        //private native function internalAnalyze( value:String, responder:Responder ):void;
        private function internalAnalyze( value:String, responder:Responder ):void
        {
        
        }

        //private native function internalAttach( name:String, reference:Object, responder:Responder, key:ByteArray ):void;
        private function internalAttach( name:String, reference:Object, responder:Responder, key:ByteArray ):void
        {
        
        }

        //private native function internalBegin( value:String, responder:Responder ):void;
        private function internalBegin( value:String, responder:Responder ):void
        {
        
        }

        //private native function internalCancel( responder:Responder ):void;
        private function internalCancel( responder:Responder ):void
        {
        
        }

        //private native function internalClean( responder:Responder ):void;
        private function internalClean( responder:Responder ):void
        {
        
        }

        //private native function internalClose( responder:Responder ):void;
        private function internalClose( responder:Responder ):void
        {
        
        }

        //private native function internalCommit( responder:Responder ):void;
        private function internalCommit( responder:Responder ):void
        {
        
        }

        //private native function internalDeanalyze( responder:Responder ):void;
        private function internalDeanalyze( responder:Responder ):void
        {
        
        }

        //private native function internalDetach( name:String, responder:Responder ):void;
        private function internalDetach( name:String, responder:Responder ):void
        {
        
        }

        //private native function internalSetSavepoint( sql:String, responder:Responder ):void;
        private function internalSetSavepoint( sql:String, responder:Responder ):void
        {
        
        }

        //private native function internalReleaseSavepoint( sql:String, responder:Responder ):void;
        private function internalReleaseSavepoint( sql:String, responder:Responder ):void
        {
        
        }

        //private native function internalRollbackSavepoint( sql:String, responder:Responder ):void;
        private function internalRollbackSavepoint( sql:String, responder:Responder ):void
        {
        
        }

        //private native function internalGetColumnNameStyle():String;
        private function internalGetColumnNameStyle():String
        {
            return _columnNameStyle;
        }

        //private native function internalGetLastInsertRowID():Number;
        private function internalGetLastInsertRowID():Number
        {
            return _rowID;
        }

        //private native function internalLoadSchema( type:String, name:String, database:String, includeColumnSchema:Boolean, responder:Responder ):void;
        private function internalLoadSchema( type:String, name:String, database:String, includeColumnSchema:Boolean, responder:Responder ):void
        {
        
        }

        //private native function internalOpen( reference:Object, openMode:String, autoCompact:Boolean, pageSize:int, key:ByteArray ):void;
        private function internalOpen( reference:Object, openMode:String, autoCompact:Boolean, pageSize:int, key:ByteArray ):void
        {
        
        }

        //private native function internalOpenAsync( reference:Object, openMode:String, responder:Responder, autoCompact:Boolean, pageSize:int, key:ByteArray ):void;
        private function internalOpenAsync( reference:Object, openMode:String, responder:Responder, autoCompact:Boolean, pageSize:int, key:ByteArray ):void
        {
        
        }

        //private native function internalRekey( newKey:ByteArray, responder:Responder ):void;
        private function internalRekey( newKey:ByteArray, responder:Responder ):void
        {
        
        }

        //private native function internalRollback( responder:Responder ):void;
        private function internalRollback( responder:Responder ):void
        {
        
        }

        //private native function internalSetCacheSize( value:uint ):void;
        private function internalSetCacheSize( value:uint ):void
        {
            _cacheSize = value;
        }

        //private native function internalSetColumnNameStyle( value:String ):void;
        private function internalSetColumnNameStyle( value:String ):void
        {
            _columnNameStyle = value;
        }

        //private native function registerUpdateNotification():void;
        private function registerUpdateNotification():void
        {
        
        }

        //private native function unregisterUpdateNotification():void;
        private function unregisterUpdateNotification():void
        {
        
        }

        private function _checkConnected():void
        {
            if( !connected ) { Error.throwError( IllegalOperationError, 3104 ); }
        }
        
        private function _checkKey( key:ByteArray, reference:Object ):void
        {
            if( key && !(key.length == 16) ) { Error.throwError( ArgumentError, 3140 ); }
            if( key && (reference == null) ) { Error.throwError( ArgumentError, 3141 ); }
        }
        
        private function _checkNotInTransaction():void
        {
            if( inTransaction ) { Error.throwError( IllegalOperationError, 3103 ); }
        }
        
        private function _checkTransactionActive():void
        {
            if( !_allowCommitRollback && !inTransaction ) { Error.throwError( IllegalOperationError, 3105 ); }
        }
        
        private function _getSavepointName( value:String, create:Boolean = true ):String
        {
            if( value == null )
            {
                if( _savepoints == null ) { _savepoints = []; }
                
                if( create )
                {
                    value = SAVEPOINT_PREFIX + _savepoints.length.toString();
                    _savepoints.push( value );
                }
                else
                {
                    if( _savepoints.length == 0 )
                    {
                        value = "";
                    }
                    else
                    {
                        value = _savepoints.pop();
                    }
                }
            }
            else if( value.length == 0 )
            {
                Error.throwError( ArgumentError, 3141 );
            }
            
            return "\"" + value "\"";
        }

        //public native function get autoCompact():Boolean;
        [API(CONFIG::AIR_1_0)]
        public function get autoCompact():Boolean
        {
            CFG::dbg{ trace( "SQLConnection.get autoCompact()" ); }
            return _autoCompact;
        }

        [API(CONFIG::AIR_1_0)]
        flash_api function set autoCompact( value:Boolean ):void
        {
            CFG::dbg{ trace( "[flash_api] SQLConnection.set autoCompact( " + value + " )" ); }
            _autoCompact = value;
        }
        
        //public native function get connected():Boolean;
        [API(CONFIG::AIR_1_0)]
        public function get connected():Boolean
        {
            CFG::dbg{ trace( "SQLConnection.get connected()" ); }
            return _connected;
        }

        [API(CONFIG::AIR_1_0)]
        flash_api function set connected( value:Boolean ):void
        {
            CFG::dbg{ trace( "[flash_api] SQLConnection.set connected( " + value + " )" ); }
            _connected = value;
        }
        
        //public native function get cacheSize():uint;
        [API(CONFIG::AIR_1_0)]
        public function get cacheSize():uint
        {
            CFG::dbg{ trace( "SQLConnection.get cacheSize()" ); }
            return _cacheSize;
        }

        [API(CONFIG::AIR_1_0)]
        public function set cacheSize( value:uint ):void
        {
            CFG::dbg{ trace( "SQLConnection.set cacheSize( " + value + " )" ); }
            _checkConnected();
            _checkNotInTransaction();
            internalSetCacheSize( value );
        }

        [API(CONFIG::AIR_1_0)]
        public function get columnNameStyle():String
        {
            CFG::dbg{ trace( "SQLConnection.get columnNameStyle()" ); }
            if( connected )
            {
                return internalGetColumnNameStyle();
            }
            
            return SQLColumnNameStyle.DEFAULT;
        }

        [API(CONFIG::AIR_1_0)]
        public function set columnNameStyle( value:String ):void
        {
            CFG::dbg{ trace( "SQLConnection.set columnNameStyle( " + value + " )" ); }
            _checkConnected();
            internalSetColumnNameStyle( value );
        }
        
        //public native function get inTransaction():Boolean;
        [API(CONFIG::AIR_1_0)]
        public function get inTransaction():Boolean
        {
            CFG::dbg{ trace( "SQLConnection.get inTransaction()" ); }
            return _inTransaction;
        }

        [API(CONFIG::AIR_1_0)]
        flash_api function set inTransaction( value:Boolean ):void
        {
            CFG::dbg{ trace( "[flash_api] SQLConnection.set inTransaction( " + value + " )" ); }
            _inTransaction = value;
        }

        [API(CONFIG::AIR_1_0)]
        public function get lastInsertRowID():Number
        {
            CFG::dbg{ trace( "SQLConnection.get lastInsertRowID()" ); }
            if( connected )
            {
                return internalGetLastInsertRowID();
            }
            
            return 0;
        }

        [API(CONFIG::AIR_1_0)]
        flash_api function set lastInsertRowID( value:Number ):void
        {
            CFG::dbg{ trace( "[flash_api] SQLConnection.set lastInsertRowID( " + value + " )" ); }
            _rowID = value;
        }
        
        //public native function get pageSize():uint;
        [API(CONFIG::AIR_1_0)]
        public function get pageSize():uint
        {
            CFG::dbg{ trace( "SQLConnection.get pageSize()" ); }
            return _pageSize;
        }

        [API(CONFIG::AIR_1_0)]
        flash_api function set pageSize( value:uint ):void
        {
            CFG::dbg{ trace( "[flash_api] SQLConnection.set pageSize( " + value + " )" ); }
            _pageSize = value;
        }

        //public native function get totalChanges():Number;
        [API(CONFIG::AIR_1_0)]
        public function get totalChanges():Number
        {
            CFG::dbg{ trace( "SQLConnection.get totalChanges()" ); }
            return _totalChanges;
        }

        [API(CONFIG::AIR_1_0)]
        flash_api function set totalChanges( value:Number ):void
        {
            CFG::dbg{ trace( "[flash_api] SQLConnection.set totalChanges( " + value + " )" ); }
            _totalChanges = value;
        }

        [API(CONFIG::AIR_1_0)]
        override public function addEventListener( type:String, listener:Function, useCapture:Boolean = false,
                                                   priority:int = 0, useWeakReference:Boolean = false ):void
        {
            CFG::dbg{ trace( "SQLConnection.addEventListener( " + [type,listener,useCapture,priority,useWeakReference].join(", ") + " )" ); }
            super.addEventListener( type, listener, useCapture, priority, useWeakReference );
            
            if( ((type == SQLUpdateEvent.UPDATE) && hasEventListener( SQLUpdateEvent.UPDATE )) ||
                ((type == SQLUpdateEvent.INSERT) && hasEventListener( SQLUpdateEvent.INSERT )) ||
                ((type == SQLUpdateEvent.DELETE) && hasEventListener( SQLUpdateEvent.DELETE )) )
            {
                registerUpdateNotification();
            }
        }

        [API(CONFIG::AIR_1_0)]
        override public function removeEventListener( type:String, listener:Function, useCapture:Boolean = false ):void
        {
            CFG::dbg{ trace( "SQLConnection.removeEventListener( " + [type,listener,useCapture].join(", ") + " )" ); }
            if( ((type == SQLUpdateEvent.UPDATE) && hasEventListener( SQLUpdateEvent.UPDATE )) ||
                ((type == SQLUpdateEvent.INSERT) && hasEventListener( SQLUpdateEvent.INSERT )) ||
                ((type == SQLUpdateEvent.DELETE) && hasEventListener( SQLUpdateEvent.DELETE )) )
            {
                unregisterUpdateNotification();
            }
            
            super.removeEventListener( type, listener, useCapture );
        }

        [API(CONFIG::AIR_1_0)]
        public function analyze( resourceName:String = null, responder:Responder = null):void
        {
            CFG::dbg{ trace( "SQLConnection.analyze( " + [resourceName,responder].join(", ") + " )" ); }
            _checkConnected();
            internalAnalyze( resourceName, responder );
        }

        [API(CONFIG::AIR_1_0)]
        public function attach( name:String, reference:Object = null, responder:Responder = null,
                                encryptionKey:ByteArray = null ):void
        {
            CFG::dbg{ trace( "SQLConnection.attach( " + [name,reference,responder,encryptionKey].join(", ") + " )" ); }
            if( (name == null) || (name.length == 0) )
            {
                Error.throwError( ArgumentError, 3102 );
            }
            
            _checkConnected();
            _checkNotInTransaction();
            _checkKey( encryptionKey, reference );
            internalAttach( name, reference, responder, encryptionKey );
        }

        [API(CONFIG::AIR_1_0)]
        public function begin( option:String = null, responder:Responder = null ):void
        {
            CFG::dbg{ trace( "SQLConnection.begin( " + [option,responder].join(", ") + " )" ); }
            var sql:String;
            _checkConnected();
            
            if( !inTransaction )
            {
                if( (option == SQLTransactionLockType.DEFERRED) ||
                    (option == SQLTransactionLockType.EXCLUSIVE) ||
                    (option == SQLTransactionLockType.IMMEDIATE) ||
                    (option == null) )
                {
                    sql = "begin " + (option ? option : "") + ";";
                    internalBegin( sql, responder );
                }
                else
                {
                    Error.throwError( ArgumentError, 3112 );
                }
            }
            
            _allowCommitRollback = true;
        }

        [API(CONFIG::AIR_1_0)]
        public function cancel( responder:Responder=null ):void
        {
            CFG::dbg{ trace( "SQLConnection.cancel( " + responder + " )" ); }
            _checkConnected();
            internalCancel( responder );
        }

        [API(CONFIG::AIR_1_0)]
        public function commit( responder:Responder = null ):void
        {
            CFG::dbg{ trace( "SQLConnection.commit( " + responder + " )" ); }
            _checkConnected();
            _checkTransactionActive();

            _allowCommitRollback = false;
            internalCommit( responder );
        }

        [API(CONFIG::AIR_1_0)]
        public function compact( responder:Responder = null ):void
        {
            CFG::dbg{ trace( "SQLConnection.compact( " + responder + " )" ); }
            _checkConnected();
            _checkNotInTransaction();
            internalClean( responder );
        }

        [API(CONFIG::AIR_1_0)]
        public function close( responder:Responder = null ):void
        {
            CFG::dbg{ trace( "SQLConnection.close( " + responder + " )" ); }
            _allowCommitRollback = false;
            internalClose( responder );
        }

        [API(CONFIG::AIR_1_0)]
        public function deanalyze( responder:Responder = null ):void
        {
            CFG::dbg{ trace( "SQLConnection.deanalyze( " + responder + " )" ); }
            _checkConnected();
            _checkNotInTransaction();
            internalDeanalyze( responder );
        }

        [API(CONFIG::AIR_1_0)]
        public function detach( name:String, responder:Responder = null ):void
        {
            CFG::dbg{ trace( "SQLConnection.detach( " + [name,responder].join(", ") + " )" ); }
            if( (name == null) || (name.length == 0) )
            {
                Error.throwError( ArgumentError, 3102 );
            }
            
            _checkConnected();
            _checkNotInTransaction();
            internalDetach( name, responder );
        }
        
        //public native function getSchemaResult():SQLSchemaResult;
        [API(CONFIG::AIR_1_0)]
        public function getSchemaResult():SQLSchemaResult
        {
            CFG::dbg{ trace( "SQLConnection.getSchemaResult()" ); }
            return null;
        }

        [API(CONFIG::AIR_1_0)]
        public function loadSchema( type:Class = null, name:String = null, database:String = "main",
                                    includeColumnSchema:Boolean = true, responder:Responder = null ):void
        {
            CFG::dbg{ trace( "SQLConnection.loadSchema( " + [type,name,database,includeColumnSchema,responder].join(", ") + " )" ); }
            _checkConnected();
            
            var schemaType:String;

            switch( type )
            {
                case SQLIndexSchema:
                schemaType = "index";
                break;

                case SQLTableSchema:
                schemaType = "table";
                break;

                case SQLTriggerSchema:
                schemaType = "trigger";
                break;

                case SQLViewSchema:
                schemaType = "view";
                break;

                default:
                if( type != null )
                {
                    Error.throwError( ArgumentError, 3111 );
                }
            }
            
            internalLoadSchema( schemaType, name, database, includeColumnSchema, responder );
        }

        [API(CONFIG::AIR_1_0)]
        public function open( reference:Object = null, openMode:String = "create", autoCompact:Boolean = false,
                              pageSize:int = 0x0400, encryptionKey:ByteArray = null ):void
        {
            CFG::dbg{ trace( "SQLConnection.open( " + [reference,openMode,autoCompact,pageSize,encryptionKey].join(", ") + " )" ); }
            if( connected ) { Error.throwError( IllegalOperationError, 3101 ); }
            
            _checkKey( encryptionKey, reference );
            internalOpen( reference, openMode, autoCompact, pageSize, encryptionKey );
        }

        [API(CONFIG::AIR_1_0)]
        public function openAsync( reference:Object = null, openMode:String = "create", responder:Responder = null,
                                   autoCompact:Boolean = false, pageSize:int = 0x0400, encryptionKey:ByteArray = null ):void
        {
            CFG::dbg{ trace( "SQLConnection.openAsync( " + [reference,openMode,responder,autoCompact,pageSize,encryptionKey].join(", ") + " )" ); }
            if( connected ) { Error.throwError( IllegalOperationError, 3101 ); }
            
            _checkKey( encryptionKey, reference );
            internalOpenAsync( reference, openMode, responder, autoCompact, pageSize, encryptionKey );
        }

        [API(CONFIG::AIR_1_5)]
        public function reencrypt( newEncryptionKey:ByteArray, responder:Responder = null ):void
        {
            CFG::dbg{ trace( "SQLConnection.reencrypt( " + [newEncryptionKey,responder].join(", ") + " )" ); }
            _checkConnected();
            _checkNotInTransaction();
            _checkKey( newEncryptionKey, {} );
            
            if( newEncryptionKey == null ) { Error.throwError( ArgumentError, 2007, "newEncryptionKey" ); }
            
            internalRekey( newEncryptionKey, responder );
        }

        [API(CONFIG::AIR_2_0)]
        public function releaseSavepoint( name:String = null, responder:Responder = null ):void
        {
            CFG::dbg{ trace( "SQLConnection.releaseSavepoint( " + [name,responder].join(", ") + " )" ); }
            _checkConnected();
            _checkTransactionActive();
            
            var sql:String = "release savepoint " + _getSavepointName( name, false ) + ";";
            internalReleaseSavepoint( sql, responder );
        }

        [API(CONFIG::AIR_1_0)]
        public function rollback( responder:Responder = null ):void
        {
            CFG::dbg{ trace( "SQLConnection.rollback( " + responder + " )" ); }
            _checkConnected();
            _checkTransactionActive();
            
            _allowCommitRollback = false;
            internalRollback( responder );
        }

        [API(CONFIG::AIR_2_0)]
        public function rollbackToSavepoint( name:String = null, responder:Responder = null ):void
        {
            CFG::dbg{ trace( "SQLConnection.rollbackToSavepoint( " + [name,responder] + " )" ); }
            _checkConnected();
            _checkTransactionActive();
            
            var sql:String = "rollback to " + _getSavepointName( name, false ) + ";";
            internalRollbackSavepoint( sql, responder );
        }

        [API(CONFIG::AIR_2_0)]
        public function setSavepoint( name:String = null, responder:Responder = null ):void
        {
            CFG::dbg{ trace( "SQLConnection.setSavepoint( " + [name,responder] + " )" ); }
            _checkConnected();
            
            var sql:String = "savepoint " + _getSavepointName( name ) + ";";
            internalSetSavepoint( sql, responder );
            _allowCommitRollback = true;
        }

    }
}
