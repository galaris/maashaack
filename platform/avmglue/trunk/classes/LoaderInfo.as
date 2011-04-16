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
    import avmplus.flash_api;
    import flash.system.*;
    import flash.events.*;
    import flash.errors.*;
    import flash.utils.*;

    /**
     * The LoaderInfo class provides information about a loaded SWF file
     * or a loaded image file (JPEG, GIF, or PNG).
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 9
     * @playerversion AIR 1.0
     */
    public class LoaderInfo extends EventDispatcher
    {
        //public static native function getLoaderInfoByDefinition( object:Object ):LoaderInfo;
        public static function getLoaderInfoByDefinition( object:Object ):LoaderInfo
        {
            CFG::dbg{ trace( "[static] LoaderInfo.getLoaderInfoByDefinition( " + object + " )" ); }
            return null;
        }

        [API(CONFIG::FP_10_1,CONFIG::AIR_2_0)] private var __uncaughtErrorEvents:UncaughtErrorEvents;
        
        private var _loaderURL:String;
        private var _url:String;
        private var _bytesLoaded:uint;
        private var _bytesTotal:uint;
        private var _applicationDomain:ApplicationDomain;
        private var _swfVersion:uint;
        private var _actionScriptVersion:uint;
        private var _frameRate:Number;
        private var _width:int;
        private var _height:int;
        private var _contentType:String;
        private var _sharedEvents:EventDispatcher;
        private var _sameDomain:Boolean;
        private var _childAllowsParent:Boolean;
        private var _parentAllowsChild:Boolean;
        private var _loader:Loader;
        private var _content:DisplayObject;
        private var _bytes:ByteArray;
        private var _parameters:Object;

        private var _parentSandboxBridge:Object;
        private var _childSandboxBridge:Object;

        private var _isURLInaccessible:Boolean;

        public function LoaderInfo()
        {
            CFG::dbg{ trace( "new LoaderInfo()" ); }
            super();

            //throw an error ?
        }

        //private native function _getUncaughtErrorEvents():UncaughtErrorEvents;
        [API(CONFIG::FP_10_1,CONFIG::AIR_2_0)]
        private function _getUncaughtErrorEvents():UncaughtErrorEvents
        {
            return __uncaughtErrorEvents;
        }

        //private native function _setUncaughtErrorEvents( value:UncaughtErrorEvents ):void;
        [API(CONFIG::FP_10_1,CONFIG::AIR_2_0)]
        private function _setUncaughtErrorEvents( value:UncaughtErrorEvents ):void
        {
            __uncaughtErrorEvents = value;
        }
        
        //private native function _getArgs():Object;
        private function _getArgs():Object
        {
            if( _parameters != null )
            {
                return _parameters;
            }
            else
            {
                return {};
            }
        }
        

        //public native function get loaderURL():String;
        public function get loaderURL():String
        {
            CFG::dbg{ trace( "LoaderInfo.get loaderURL()" ); }
            return _loaderURL;
        }

        flash_api function set loaderURL( value:String ):void
        {
            CFG::dbg{ trace( "[flash_api] LoaderInfo.set loaderURL( " + value + " )" ); }
            _loaderURL = value;
        }

        //public native function get url():String;
        public function get url():String
        {
            CFG::dbg{ trace( "LoaderInfo.get url()" ); }
            return _url;
        }

        flash_api function set url( value:String ):void
        {
            CFG::dbg{ trace( "[flash_api] LoaderInfo.set url( " + value + " )" ); }
            _url = value;
        }

        //public native function get bytesLoaded():uint;
        public function get bytesLoaded():uint
        {
            CFG::dbg{ trace( "LoaderInfo.get bytesLoaded()" ); }
            return _bytesLoaded;
        }

        flash_api function set bytesLoaded( value:uint ):void
        {
            CFG::dbg{ trace( "[flash_api] LoaderInfo.set bytesLoaded( " + value + " )" ); }
            _bytesLoaded = value;
        }

        //public native function get bytesTotal():uint;
        public function get bytesTotal():uint
        {
            CFG::dbg{ trace( "LoaderInfo.get bytesTotal()" ); }
            return _bytesTotal;
        }

        flash_api function set bytesTotal( value:uint ):void
        {
            CFG::dbg{ trace( "[flash_api] LoaderInfo.set bytesTotal( " + value + " )" ); }
            _bytesTotal = value;
        }

        //public native function get applicationDomain():ApplicationDomain;
        public function get applicationDomain():ApplicationDomain
        {
            CFG::dbg{ trace( "LoaderInfo.get applicationDomain()" ); }
            return _applicationDomain;
        }

        flash_api function set applicationDomain( value:ApplicationDomain ):void
        {
            CFG::dbg{ trace( "[flash_api] LoaderInfo.set applicationDomain( " + value + " )" ); }
            _applicationDomain = value;
        }

        //public native function get swfVersion():uint;
        public function get swfVersion():uint
        {
            CFG::dbg{ trace( "LoaderInfo.get swfVersion()" ); }
            return _swfVersion;
        }

        flash_api function set swfVersion( value:uint ):void
        {
            CFG::dbg{ trace( "[flash_api] LoaderInfo.set swfVersion( " + value + " )" ); }
            _swfVersion = value;
        }

        //public native function get actionScriptVersion():uint;
        public function get actionScriptVersion():uint
        {
            CFG::dbg{ trace( "LoaderInfo.get actionScriptVersion()" ); }
            return _actionScriptVersion;
        }

        flash_api function set actionScriptVersion( value:uint ):void
        {
            CFG::dbg{ trace( "[flash_api] LoaderInfo.set actionScriptVersion( " + value + " )" ); }
            _actionScriptVersion = value;
        }

        //public native function get frameRate():Number;
        public function get frameRate():Number
        {
            CFG::dbg{ trace( "LoaderInfo.get frameRate()" ); }
            return _frameRate;
        }

        flash_api function set frameRate( value:Number ):void
        {
            CFG::dbg{ trace( "[flash_api] LoaderInfo.set frameRate( " + value + " )" ); }
            _frameRate = value;
        }

        //public native function get width():int;
        public function get width():int
        {
            CFG::dbg{ trace( "LoaderInfo.get width()" ); }
            return _width;
        }

        flash_api function set width( value:int ):void
        {
            CFG::dbg{ trace( "[flash_api] LoaderInfo.set width( " + value + " )" ); }
            _width = value;
        }

        //public native function get height():int;
        public function get height():int
        {
            CFG::dbg{ trace( "LoaderInfo.get height()" ); }
            return _height;
        }

        flash_api function set height( value:int ):void
        {
            CFG::dbg{ trace( "[flash_api] LoaderInfo.set height( " + value + " )" ); }
            _height = value;
        }

        //public native function get contentType():String;
        public function get contentType():String
        {
            CFG::dbg{ trace( "LoaderInfo.get contentType()" ); }
            return _contentType;
        }

        flash_api function set contentType( value:String ):void
        {
            CFG::dbg{ trace( "[flash_api] LoaderInfo.set contentType( " + value + " )" ); }
            _contentType = value;
        }

        //public native function get sharedEvents():EventDispatcher;
        public function get sharedEvents():EventDispatcher
        {
            CFG::dbg{ trace( "LoaderInfo.get sharedEvents()" ); }
            return _sharedEvents;
        }

        flash_api function set sharedEvents( value:EventDispatcher ):void
        {
            CFG::dbg{ trace( "[flash_api] LoaderInfo.set sharedEvents( " + value + " )" ); }
            _sharedEvents = value;
        }

        //public native function get sameDomain():Boolean;
        public function get sameDomain():Boolean
        {
            CFG::dbg{ trace( "LoaderInfo.get sameDomain()" ); }
            return _sameDomain;
        }

        flash_api function set sameDomain( value:Boolean ):void
        {
            CFG::dbg{ trace( "[flash_api] LoaderInfo.set sameDomain( " + value + " )" ); }
            _sameDomain = value;
        }

        //public native function get childAllowsParent():Boolean;
        public function get childAllowsParent():Boolean
        {
            CFG::dbg{ trace( "LoaderInfo.get childAllowsParent()" ); }
            return _childAllowsParent;
        }

        flash_api function set childAllowsParent( value:Boolean ):void
        {
            CFG::dbg{ trace( "[flash_api] LoaderInfo.set childAllowsParent( " + value + " )" ); }
            _childAllowsParent = value;
        }

        //public native function get parentAllowsChild():Boolean;
        public function get parentAllowsChild():Boolean
        {
            CFG::dbg{ trace( "LoaderInfo.get parentAllowsChild()" ); }
            return _parentAllowsChild;
        }

        flash_api function set parentAllowsChild( value:Boolean ):void
        {
            CFG::dbg{ trace( "[flash_api] LoaderInfo.set parentAllowsChild( " + value + " )" ); }
            _parentAllowsChild = value;
        }

        //public native function get loader():Loader;
        public function get loader():Loader
        {
            CFG::dbg{ trace( "LoaderInfo.get loader()" ); }
            return _loader;
        }

        flash_api function set loader( value:Loader ):void
        {
            CFG::dbg{ trace( "[flash_api] LoaderInfo.set loader( " + value + " )" ); }
            _loader = value;
        }

        //public native function get content():DisplayObject;
        public function get content():DisplayObject
        {
            CFG::dbg{ trace( "LoaderInfo.get content()" ); }
            return _content;
        }

        flash_api function set content( value:DisplayObject ):void
        {
            CFG::dbg{ trace( "[flash_api] LoaderInfo.set content( " + value + " )" ); }
            _content = value;
        }

        //public native function get bytes():ByteArray;
        public function get bytes():ByteArray
        {
            CFG::dbg{ trace( "LoaderInfo.get bytes()" ); }
            return _bytes;
        }

        flash_api function set bytes( value:ByteArray ):void
        {
            CFG::dbg{ trace( "[flash_api] LoaderInfo.set bytes( " + value + " )" ); }
            _bytes = value;
        }

        //public native function get parentSandboxBridge():Object;
        [API(CONFIG::AIR_1_0)]
        public function get parentSandboxBridge():Object
        {
            CFG::dbg{ trace( "LoaderInfo.get parentSandboxBridge()" ); }
            return _parentSandboxBridge;
        }

        //public native function set parentSandboxBridge( value:Object ):void;
        [API(CONFIG::AIR_1_0)]
        public function set parentSandboxBridge( value:Object ):void
        {
            CFG::dbg{ trace( "LoaderInfo.set parentSandboxBridge( " + value + " )" ); }
            _parentSandboxBridge = value;
        }

        //public native function get childSandboxBridge():Object;
        [API(CONFIG::AIR_1_0)]
        public function get childSandboxBridge():Object
        {
            CFG::dbg{ trace( "LoaderInfo.get childSandboxBridge()" ); }
            return _childSandboxBridge;
        }

        //public native function set childSandboxBridge( value:Object ):void;
        [API(CONFIG::AIR_1_0)]
        public function set childSandboxBridge( value:Object ):void
        {
            CFG::dbg{ trace( "LoaderInfo.set childSandboxBridge( " + value + " )" ); }
            _childSandboxBridge = value;
        }

        public function get parameters():Object
        {
            CFG::dbg{ trace( "LoaderInfo.get parameters()" ); }
            var m:String;
            var args:Object = _getArgs();
            var rtn:Object  = {};
            
            for( m in args )
            {
                rtn[m] = args[m];
            }
            
            return rtn;
        }

        flash_api function set parameters( value:Object ):void
        {
            CFG::dbg{ trace( "[flash_api] LoaderInfo.set parameters( " + value + " )" ); }
            _parameters = value;
        }

        [API(CONFIG::FP_10_1,CONFIG::AIR_2_0)]
        public function get uncaughtErrorEvents():UncaughtErrorEvents
        {
            CFG::dbg{ trace( "LoaderInfo.get uncaughtErrorEvents()" ); }
            var _uncaughtErrorEvents:UncaughtErrorEvents = _getUncaughtErrorEvents();
            
            if( !_uncaughtErrorEvents )
            {
                _uncaughtErrorEvents = new UncaughtErrorEvents();
                _setUncaughtErrorEvents( _uncaughtErrorEvents );
            }
            
            return _uncaughtErrorEvents;
        }

        [API(CONFIG::FP_10_1,CONFIG::AIR_2_0)]
        flash_api function set uncaughtErrorEvents( value:UncaughtErrorEvents ):void
        {
            CFG::dbg{ trace( "[flash_api] LoaderInfo.set uncaughtErrorEvents( " + value + " )" ); }
            _setUncaughtErrorEvents( value );
        }

        [API(CONFIG::FP_10_1,CONFIG::AIR_2_0)]
        public function get isURLInaccessible():Boolean
        {
            CFG::dbg{ trace( "LoaderInfo.get isURLInaccessible()" ); }
            return _isURLInaccessible;
        }

        [API(CONFIG::FP_10_1,CONFIG::AIR_2_0)]
        flash_api function set isURLInaccessible( value:Boolean ):void
        {
            CFG::dbg{ trace( "[flash_api] LoaderInfo.set isURLInaccessible( " + value + " )" ); }
            _isURLInaccessible = value;
        }

        override public function dispatchEvent( event:Event ):Boolean
        {
            CFG::dbg{ trace( "LoaderInfo.dispatchEvent( " + event + " )" ); }
            Error.throwError( IllegalOperationError, 2118 );
            return false;
        }
    }
}
