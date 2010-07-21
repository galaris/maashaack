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
    import avmplus.flash_api;
    import flash.utils.*;
    import flash.errors.*;
    
    /**
     * The EncryptedLocalStore class provides a persistent, encrypted data storage mechanism.
     * 
     * @langversion ActionScript 3.0
     * @playerversion AIR 1.0
     */
    [API(CONFIG::AIR_1_0)]
    public class EncryptedLocalStore
    {
        private static const ENCRYPTEDLOCALSTORE_OUTOFMEMORY_ERROR               = 101;
        private static const ENCRYPTEDLOCALSTORE_PUBLISHERIDERROR_SIGINVALID     = 601;
        private static const ENCRYPTEDLOCALSTORE_PUBLISHERIDERROR_PASSEDIN_PUBID = 602;
        private static const ENCRYPTEDLOCALSTORE_APPHASH_COMPUTATION_ERROR       = 603;
        private static const ENCRYPTEDLOCALSTORE_APPHASH_CHECK_ERROR             = 604;
        private static const ENCRYPTEDLOCALSTORE_DATABASE_ACCESS_ERROR           = 605;
        private static const ENCRYPTEDLOCALSTORE_INTERNAL_ERROR                  = 606;
        private static const ENCRYPTEDLOCALSTORE_VERSION_MISMATCH                = 305;

        private static var _data:Object = {};
        
        [API(CONFIG::AIR_2_0)] private static var _isSupported:Boolean = true;
        
        //private static native function setItemNative( name:String, data:ByteArray, stronglyBound:Boolean ):uint;
        private static function setItemNative( name:String, data:ByteArray, stronglyBound:Boolean ):uint
        {
            _data[ name ] = data;
            return 0;
        }

        //private static native function getItemNative( name:String, outData:ByteArray ):uint;
        private static function getItemNative( name:String, outData:ByteArray ):uint
        {
            if( name in _data )
            {
                outData.writeBytes( _data[name] );
                return 0;
            }

            return ENCRYPTEDLOCALSTORE_DATABASE_ACCESS_ERROR;
        }

        //private static native function removeItemNative( name:String ):uint;
        private static function removeItemNative( name:String ):uint
        {
            if( name in _data )
            {
                delete _data[name];
                return 0;
            }

            return ENCRYPTEDLOCALSTORE_DATABASE_ACCESS_ERROR;
        }

        //private static native function resetNative():uint;
        private static function resetNative():uint
        {
            return 0;
        }

        private static function processErrorCode( errorCode:uint ):void
        {
            switch( errorCode )
            {
                case ENCRYPTEDLOCALSTORE_OUTOFMEMORY_ERROR:
                throw new MemoryError();
                break;

                case ENCRYPTEDLOCALSTORE_PUBLISHERIDERROR_SIGINVALID:
                throw new IllegalOperationError();
                break;

                case ENCRYPTEDLOCALSTORE_PUBLISHERIDERROR_PASSEDIN_PUBID:
                throw new Error( "EncryptedLocalStore may not use publisher IDs passed in from ADL" );
                break;

                case ENCRYPTEDLOCALSTORE_DATABASE_ACCESS_ERROR:
                throw new IOError( "EncryptedLocalStore database access error" );
                break;

                case ENCRYPTEDLOCALSTORE_INTERNAL_ERROR:
                throw new IOError( "EncryptedLocalStore internal error" );
                break;

                case ENCRYPTEDLOCALSTORE_VERSION_MISMATCH:
                throw new IOError( "EncryptedLocalStore version mismatch" );
                break;

                case ENCRYPTEDLOCALSTORE_APPHASH_COMPUTATION_ERROR:
                throw new IllegalOperationError( "An error was encountered while computing the application's digest." );
                break;

                case ENCRYPTEDLOCALSTORE_APPHASH_CHECK_ERROR:
                throw new IllegalOperationError( "The EncryptedLocalStore item belongs to an app with a different digest." );
                break;

                default:
                if( errorCode != 0 )
                {
                    throw new Error( "general internal error" );
                }
            }
        }
        
        private static function checkName( name:String ):void
        {
            if( name == null )
            {
                Error.throwError( ArgumentError, 2007, "name" );
            }
            else if( name == "" )
            {
                Error.throwError( ArgumentError, 2085, "name" );
            }
        }

        [API(CONFIG::AIR_1_0)]
        public static function setItem( name:String, data:ByteArray, stronglyBound:Boolean = false ):void
        {
            CFG::dbg{ trace( "[static] EncryptedLocalStore.setItem( " + [name,data,stronglyBound].join(", ") + " )" ); }
            checkName( name );

            var errorCode:uint = setItemNative( name, data, stronglyBound );
            processErrorCode( errorCode );
        }

        [API(CONFIG::AIR_1_0)]
        public static function getItem( name:String ):ByteArray
        {
            CFG::dbg{ trace( "[static] EncryptedLocalStore.getItem( " + name + " )" ); }
            checkName( name );
            
            var data:ByteArray = new ByteArray();
            var errorCode:uint = getItemNative( name, data );
            processErrorCode( errorCode );
            
            if( data.length > 0 )
            {
                return data;
            }
            
            return null;
        }

        [API(CONFIG::AIR_1_0)]
        public static function removeItem( name:String ):void
        {
            CFG::dbg{ trace( "[static] EncryptedLocalStore.removeItem( " + name + " )" ); }
            checkName( name );
            
            var errorCode:uint = removeItemNative( name );
            processErrorCode( errorCode );
        }

        [API(CONFIG::AIR_1_0)]
        public static function reset():void
        {
            CFG::dbg{ trace( "[static] EncryptedLocalStore.reset()" ); }
            var errorCode:uint = resetNative();
            processErrorCode( errorCode );
        }

        [API(CONFIG::AIR_2_0)]
        public static function get isSupported():Boolean
        {
            CFG::dbg{ trace( "[static] EncryptedLocalStore.get isSupported()" ); }
            return _isSupported;
        }

        [API(CONFIG::AIR_2_0)]
        flash_api static function set isSupported( value:Boolean ):void
        {
            CFG::dbg{ trace( "[flash_api] [static] EncryptedLocalStore.set isSupported( " + value + " )" ); }
            _isSupported = value;
        }
    }
}
