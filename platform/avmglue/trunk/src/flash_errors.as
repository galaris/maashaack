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

/* The flash.error package contains Error classes that are considered part of the Flash runtime API.
   In contrast to the Error classes described, the flash.error package communicates errors events
   that are specific to Flash runtimes (such as Flash Player and Adobe AIR).
*/
package flash.errors
{
    
    /**
     * The IllegalOperationError exception is thrown when a method is not implemented
     * or the implementation doesn't cover the current usage.
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 9
     * @playerversion AIR 1.0
     */
    public dynamic class IllegalOperationError extends Error
    {
        prototype.name = "IllegalOperationError";
        
        public function IllegalOperationError( message:String = "" )
        {
            CFG::dbg{ trace( "new IllegalOperationError( " + message + " )" ); }
            super( message );
            this.name = prototype.name;
        }
    }

    /**
     * The IOError exception is thrown when some type of input or output failure occurs.
     * For example, an IOError exception is thrown if a read/write operation is attempted
     * on a socket that has not connected or that has become disconnected.
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 9
     * @playerversion AIR 1.0
     */
    public dynamic class IOError extends Error
    {
        prototype.name = "IOError";
        
        public function IOError( message:String = "" )
        {
            CFG::dbg{ trace( "new IOError( " + message + " )" ); }
            super( message );
            this.name = prototype.name;
        }
    }

    /**
     * An EOFError exception is thrown when you attempt to read past the end of the available data.
     * For example, an EOFError is thrown when one of the read methods in the IDataInput interface
     * is called and there is insufficient data to satisfy the read request.
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 9
     * @playerversion AIR 1.0
     */
    public dynamic class EOFError extends IOError
    {
        prototype.name = "EOFError";
        
        public function EOFError( message:String = "" )
        {
            CFG::dbg{ trace( "new EOFError( " + message + " )" ); }
            super( message );
            this.name = prototype.name;
        }
    }
    
    /**
     * The MemoryError exception is thrown when a memory allocation request fails.
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 9
     * @playerversion AIR 1.0
     */
    public dynamic class MemoryError extends Error
    {
        prototype.name = "MemoryError";
        
        public function MemoryError( message:String = "" )
        {
            CFG::dbg{ trace( "new MemoryError( " + message + " )" ); }
            super( message );
            this.name = prototype.name;
        }
    }
    
    /**
     * The ScriptTimeoutError exception is thrown when the script timeout interval is reached.
     * The script timeout interval is 15 seconds.
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 9
     * @playerversion AIR 1.0
     */
    public dynamic class ScriptTimeoutError extends Error
    {
        prototype.name = "ScriptTimeoutError";
        
        public function ScriptTimeoutError( message:String = "" )
        {
            CFG::dbg{ trace( "new ScriptTimeoutError( " + message + " )" ); }
            super( message );
            this.name = prototype.name;
        }
    }
    
    /**
     * ActionScript throws a StackOverflowError exception when the stack available to the script is exhausted.
     * ActionScript uses a stack to store information about each method call made in a script,
     * such as the local variables that the method uses.
     * The amount of stack space available varies from system to system.
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 9
     * @playerversion AIR 1.0
     */
    public dynamic class StackOverflowError extends Error
    {
        prototype.name = "StackOverflowError";
        
        public function StackOverflowError( message:String = "" )
        {
            CFG::dbg{ trace( "new StackOverflowError( " + message + " )" ); }
            super( message );
            this.name = prototype.name;
        }
    }

    /**
     * The Flash runtimes throw this exception when they encounter a corrupted SWF file.
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 9
     * @playerversion AIR 1.0
     */
    public dynamic class InvalidSWFError extends Error
    {
        prototype.name = "InvalidSWFError";
        
        public function InvalidSWFError( message:String = "", id:int = 0 )
        {
            CFG::dbg{ trace( "new InvalidSWFError( " + message + " )" ); }
            super( message, id );
            this.name = prototype.name;
        }
    }

    /**
     * This class contains the constants that represent the possible values for
     * the <code>SQLError.operation</code> property.
     * These values indicate the attempted operation that caused the error to occur.
     * 
     * @langversion ActionScript 3.0
     * @playerversion AIR 1.0
     */
    [API(CONFIG::AIR_1_0)]
    public class SQLErrorOperation
    {
        [API(CONFIG::AIR_1_0)] public static const ANALYZE:String = "analyze";
        [API(CONFIG::AIR_1_0)] public static const ATTACH:String = "attach";
        [API(CONFIG::AIR_1_0)] public static const BEGIN:String = "begin";
        [API(CONFIG::AIR_1_0)] public static const CLOSE:String = "close";
        [API(CONFIG::AIR_1_0)] public static const COMMIT:String = "commit";
        [API(CONFIG::AIR_1_0)] public static const COMPACT:String = "compact";
        [API(CONFIG::AIR_1_0)] public static const DEANALYZE:String = "deanalyze";
        [API(CONFIG::AIR_1_0)] public static const DETACH:String = "detach";
        [API(CONFIG::AIR_1_0)] public static const EXECUTE:String = "execute";
        [API(CONFIG::AIR_1_0)] public static const OPEN:String = "open";
        [API(CONFIG::AIR_1_5)] public static const REENCRYPT:String = "reencrypt";
        [API(CONFIG::AIR_2_0)] public static const RELEASE_SAVEPOINT:String = "releaseSavepoint";
        [API(CONFIG::AIR_1_0)] public static const ROLLBACK:String = "rollback";
        [API(CONFIG::AIR_2_0)] public static const ROLLBACK_TO_SAVEPOINT:String = "rollbackToSavepoint";
        [API(CONFIG::AIR_1_0)] public static const SCHEMA:String = "schema";
        [API(CONFIG::AIR_2_0)] public static const SET_SAVEPOINT:String = "setSavepoint";
    }
    
    /**
     * A SQLError instance provides detailed information about a failed operation.
     * 
     * @langversion ActionScript 3.0
     * @playerversion AIR 1.0
     */
    [API(CONFIG::AIR_1_0)]
    public class SQLError extends Error
    {
        private var _operation:String;
        private var _details:String;
        private var _detailID:int;
        private var _detailArguments:Array;
        
        public function SQLError( operation:String, details:String = "", message:String = "", id:int = 0,
                                  detailID:int = -1, detailArgs:Array = null )
        {
            CFG::dbg{ trace( "new SQLError( " + [operation,details,message,id,detailID,detailArgs].join(", ") + " ); }
            super( message, id );
            this.name = "SQLError";
            
            if( !detailArgs )
            {
                detailArgs = [];
            }

            _operation       = operation;
            _details         = details;
            _detailID        = detailID;
            _detailArguments = detailArgs;
        }
        
        [API(CONFIG::AIR_1_0)]
        public function get operation():String
        {
            return _operation;
        }
        
        [API(CONFIG::AIR_1_0)]
        public function get details():String
        {
            return _details;
        }
        
        [API(CONFIG::AIR_1_0)]
        public function get detailID():int
        {
            return _detailID;
        }
        
        [API(CONFIG::AIR_1_0)]
        public function get detailArguments():Array
        {
            return _detailArguments;
        }
        
        /* TODO:
           implement toString
        */
        
    }
    
    /**
     * The DRMManager dispatches a DRMManagerError event to report errors.
     * 
     * @langversion ActionScript 3.0
     * @playerversion AIR 1.5
     */
    [API(CONFIG::AIR_1_5)]
    public class DRMManagerError extends Error
    {
        private var _subErrorID:int;
        
        public function DRMManagerError( message:String, id:int, subErrorID:int )
        {
            CFG::dbg{ trace( "new DRMManagerError( " + [message,id,subErrorID].join(", ") + " ); }
            super( message, id );
            this.name = "DRMManagerError";
            
            _subErrorID = subErrorID;
        }

        [API(CONFIG::AIR_1_5)]
        public function get subErrorID():int
        {
            return _subErrorID;
        }

        /* TODO:
           implement toString
        */
    }
    
}

