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
    import flash.system.*;
    import flash.net.*;
    import flash.utils.*;
    import flash.errors.*;
    import flash.events.*;

    /**
     * The Loader class is used to load SWF files or image (JPG, PNG, or GIF) files.
     * Use the <code>load()</code> method to initiate loading.
     * The loaded display object is added as a child of the Loader object.
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 9
     * @playerversion AIR 1.0
     */
    public class Loader extends DisplayObjectContainer
    {
        private var _content:DisplayObject;
        private var _contentLoaderInfo:LoaderInfo;
        [API(CONFIG::FP_10_1,CONFIG::AIR_2_0)] private var __uncaughtErrorEvents:UncaughtErrorEvents;
        
        public function Loader()
        {
            CFG::dbg{ trace( "new Loader()" ); }
            super();
            
        }
        
        //private native function _getJPEGLoaderContextdeblockingfilter( context:Object ):Number;
        private function _getJPEGLoaderContextdeblockingfilter( context:Object ):Number
        {
            return 0;
        }

        //private native function _load( request:URLRequest, checkPolicyFile:Boolean, applicationDomain:ApplicationDomain, securityDomain:SecurityDomain, deblockingFilter:Number ):void;
        private function _load( request:URLRequest, checkPolicyFile:Boolean, applicationDomain:ApplicationDomain, securityDomain:SecurityDomain, deblockingFilter:Number ):void
        {
        
        }

        //private native function _loadBytes( bytes:ByteArray, checkPolicyFile:Boolean, applicationDomain:ApplicationDomain, securityDomain:SecurityDomain, deblockingFilter:Number, allowLoadBytesCodeExecution:Boolean ):void;
        private function _loadBytes( bytes:ByteArray, checkPolicyFile:Boolean, applicationDomain:ApplicationDomain, securityDomain:SecurityDomain, deblockingFilter:Number, allowLoadBytesCodeExecution:Boolean ):void
        {
        
        }

        //private native function _unload( halt:Boolean, gc:Boolean ):void;
        private function _unload( halt:Boolean, gc:Boolean ):void
        {
        
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

        private function _buildLoaderContext( context:LoaderContext ):LoaderContext
        {
            if( context == null )
            {
                context = new LoaderContext();
            }
            
            if( context.applicationDomain == null )
            {
                context.applicationDomain = new ApplicationDomain( ApplicationDomain.currentDomain );
            }
            
            return context;
        }
        
        //public native function get content():DisplayObject;
        public function get content():DisplayObject
        {
            CFG::dbg{ trace( "Loader.get content()" ); }
            return _content;
        }

        //public native function get contentLoaderInfo():LoaderInfo;
        public function get contentLoaderInfo():LoaderInfo
        {
            CFG::dbg{ trace( "Loader.get contentLoaderInfo()" ); }
            return _contentLoaderInfo;
        }

        [API(CONFIG::FP_10_1,CONFIG::AIR_2_0)]
        public function get uncaughtErrorEvents():UncaughtErrorEvents
        {
            CFG::dbg{ trace( "Loader.get uncaughtErrorEvents()" ); }
            var _uncaughtErrorEvents:UncaughtErrorEvents = _getUncaughtErrorEvents();

            if( !_uncaughtErrorEvents )
            {
                _uncaughtErrorEvents = new UncaughtErrorEvents();
                _setUncaughtErrorEvents( _uncaughtErrorEvents );
            }
            
            return _uncaughtErrorEvents;
        }

        public function load( request:URLRequest, context:LoaderContext = null ):void
        {
            CFG::dbg{ trace( "Loader.load( " + [request,context].join(", ") + " )" ); }
            var _context:LoaderContext  = _buildLoaderContext( context );
            var deblockingFilter:Number = 0;
                deblockingFilter        = _getJPEGLoaderContextdeblockingfilter( _context );
            
            _load( request, _context.checkPolicyFile, _context.applicationDomain, _context.securityDomain, deblockingFilter );
        }
        
        public function loadBytes( bytes:ByteArray, context:LoaderContext = null ):void
        {
            CFG::dbg{ trace( "Loader.loadBytes( " + [bytes,context].join(", ") + " )" ); }
            var _context:LoaderContext  = _buildLoaderContext( context );
            var deblockingFilter:Number = 0;
                deblockingFilter        = _getJPEGLoaderContextdeblockingfilter( _context );
            
            _loadBytes( bytes, _context.checkPolicyFile, _context.applicationDomain, _context.securityDomain, deblockingFilter, _context.allowLoadBytesCodeExecution );
        }
        
        //public native function close():void;
        public function close():void
        {
            CFG::dbg{ trace( "Loader.close()" ); }
        }

        public function unload():void
        {
            CFG::dbg{ trace( "Loader.unload()" ); }
            _unload( false, false );
        }

        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function unloadAndStop( gc:Boolean = true ):void
        {
            CFG::dbg{ trace( "Loader.unloadAndStop( " + gc + " )" ); }
            _unload( true, gc );
        }
        
        override public function addChild( child:DisplayObject ):DisplayObject
        {
            CFG::dbg{ trace( "Loader.addChild()" ); }
            Error.throwError( IllegalOperationError, 2069 );
            return null;
        }
        
        override public function addChildAt( child:DisplayObject, index:int ):DisplayObject
        {
            CFG::dbg{ trace( "Loader.addChildAt( " + [child,index].join(", ") + " )" ); }
            Error.throwError( IllegalOperationError, 2069 );
            return null;
        }
        
        override public function removeChild( child:DisplayObject ):DisplayObject
        {
            CFG::dbg{ trace( "Loader.removeChild( " + child + " )" ); }
            Error.throwError( IllegalOperationError, 2069 );
            return null;
        }
        
        override public function removeChildAt( index:int ):DisplayObject
        {
            CFG::dbg{ trace( "Loader.removeChildAt( " + index + " )" ); }
            Error.throwError( IllegalOperationError, 2069 );
            return null;
        }
        
        override public function setChildIndex( child:DisplayObject, index:int ):void
        {
            CFG::dbg{ trace( "Loader.setChildIndex( " + [child,index].join(", ") + " )" ); }
            Error.throwError( IllegalOperationError, 2069 );
        }

    }
}
