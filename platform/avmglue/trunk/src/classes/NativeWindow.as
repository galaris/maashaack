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
    import flash.geom.*;
    import flash.errors.*;
    import flash.events.*;

    /**
     * The NativeWindow class provides an interface for creating and controlling native desktop windows.
     * 
     * @langversion ActionScript 3.0
     * @playerversion AIR 1.0
     */
    [API(CONFIG::AIR_1_0)]
    public class NativeWindow extends EventDispatcher
    {

        //private static native function _checkAccess():void;
        private static function _checkAccess():void
        {
            
        }
        
        //private static native function initSupportsMenu():Boolean;
        private static function initSupportsMenu():Boolean
        {
            return true;
        }
        
        //private static native function initSupportsNotifyUser():Boolean;
        private static function initSupportsNotifyUser():Boolean
        {
            return true;
        }

        //private static native function initSystemMinSize():Point;
        private static function initSystemMinSize():Point
        {
            return new Point(0,0);
        }

        private static const _supportsMenu:Boolean       = initSupportsMenu();
        private static const _supportsNotifyUser:Boolean = initSupportsNotifyUser();
        private static const _systemMinSize:Point        = initSystemMinSize();

        //private static native function get _supportsTransparency():Boolean;
        private static function get _supportsTransparency():Boolean
        {
            return true;
        }

        [API(CONFIG::AIR_2_0)]
        public static function get isSupported():Boolean
        {
            return true;
        }

        [API(CONFIG::AIR_1_0)]
        public static function get supportsMenu():Boolean
        {
            _checkAccess();
            return _supportsMenu;
        }

        [API(CONFIG::AIR_1_0)]
        public static function get supportsNotification():Boolean
        {
            _checkAccess();
            return _supportsNotifyUser;
        }

        /**
         * @playerversion AIR 1.1
         */
        [API(CONFIG::AIR_1_0)]
        public static function get supportsTransparency():Boolean
        {
            _checkAccess();
            return _supportsTransparency;
        }

        [API(CONFIG::AIR_1_0)]
        public static function get systemMinSize():Point
        {
            _checkAccess();
            var p:Point = new Point();
            p.x = _systemMinSize.x;
            p.y = _systemMinSize.y;
            return p;
        }
        
        //public static native function get systemMaxSize():Point;
        [API(CONFIG::AIR_1_0)]
        public static function get systemMaxSize():Point
        {
            return new Point(4096,4096);
        }


        private var __title:String;
        private var __bounds:Rectangle;
        private var __x:Number;
        private var __y:Number;
        private var __width:Number;
        private var __height:Number;
        private var __minSize:Point;
        private var __maxSize:Point;
        private var __displayState:String;
        private var __active:Boolean;
        private var __type:String;
        private var __systemChrome:String;
        private var __transparent:Boolean;
        private var __visible:Boolean;
        private var __minimizable:Boolean;
        private var __maximizable:Boolean;
        private var __resizable:Boolean;
        private var __menu:NativeMenu;

        private var _stage():Stage;
        private var _closed:Boolean;
        private var _alwaysInFront:Boolean;

        public function NativeWindow( initOptions:NativeWindowInitOptions )
        {
            CFG::dbg{ trace( "new NativeWindow( " + initOptions + " )" ); }
            super();

            if( !initOptions )
            {
                Error.throwError( ArgumentError, 2007, "initOptions" );
            }
            
            if( (initOptions.transparent == true) && !(initOptions.systemChrome == NativeWindowSystemChrome.NONE) )
            {
                throw new Error( "Illegal window settings.  Transparent windows are only supported when systemChrome is set to \"none\"." );
            }
            
            if( (initOptions.type == NativeWindowType.LIGHTWEIGHT) && !(initOptions.systemChrome == NativeWindowSystemChrome.NONE) )
            {
                throw new Error( "Illegal window settings.  Lightweight windows are only supported when systemChrome is set to \"none\"." );
            }
            
            _init( initOptions, false );
        }

        //private native function _init( initOptions:NativeWindowInitOptions, allowInitialContentWindowOnly:Boolean ):void;
        private function _init( initOptions:NativeWindowInitOptions, allowInitialContentWindowOnly:Boolean ):void
        {
            __systemChrome = initOptions.systemChrome;
            __transparent  = initOptions.transparent;
            __resizable    = initOptions.resizable;
            __maximizable  = initOptions.maximizable;
            __minimizable  = initOptions.minimizable;
            __type         = initOptions.type;

            _activate();
        }

        //private native function get _title():String;
        private function get _title():String
        {
            return __title;
        }

        //private native function set _title( value:String ):void;
        private function set _title( value:String ):void
        {
            __title = value;
        }

        //private native function get _bounds():Rectangle;
        private function get _bounds():Rectangle
        {
            return __bounds;
        }

        //private native function set _bounds( value:Rectangle ):void;
        private function set _bounds( value:Rectangle ):void
        {
            __bounds = value;
        }

        //private native function set _x( value:Number ):void;
        private function set _x( value:Number ):void
        {
            __x = value;
        }

        //private native function set _y( value:Number ):void;
        private function set _y( value:Number ):void
        {
            __y = value;
        }

        //private native function set _width( value:Number ):void;
        private function set _width( value:Number ):void
        {
            __width = value;
        }

        //private native function set _height( value:Number ):void;
        private function set _height( value:Number ):void
        {
            __height = value;
        }

        //private native function get _minSize():Point;
        private function get _minSize():Point
        {
            return __minSize;
        }

        //private native function set _minSize( value:Point ):void;
        private function set _minSize( value:Point ):void
        {
            __minSize = value;
        }

        //private native function get _maxSize():Point;
        private function get _maxSize():Point
        {
            return __maxSize;
        }

        //private native function set _maxSize( value:Point ):void;
        private function set _maxSize( value:Point ):void
        {
            __maxSize = value;
        }

        //private native function get _displayState():String;
        private function get _displayState():String
        {
            return __displayState;
        }

        //private native function get _active():Boolean;
        private function get _active():Boolean
        {
            return __active;
        }

        //private native function get _type():String;
        private function get _type():String
        {
            return __type;
        }

        //private native function get _systemChrome():String;
        private function get _systemChrome():String
        {
            return __systemChrome;
        }

        //private native function get _transparent():Boolean;
        private function get _transparent():Boolean
        {
            return __transparent;
        }

        //private native function get _visible():Boolean;
        private function get _visible():Boolean
        {
            return __visible;
        }

        //private native function set _visible( value:Boolean ):void;
        private function set _visible( value:Boolean ):void
        {
            __visible = value;
        }

        //private native function get _minimizable():Boolean;
        private function get _minimizable():Boolean
        {
            return __minimizable;
        }

        //private native function get _maximizable():Boolean;
        private function get _maximizable():Boolean
        {
            return __maximizable;
        }

        //private native function get _resizable():Boolean;
        private function get _resizable():Boolean
        {
            return __resizable;
        }

        //private native function set _menu( value:NativeMenu ):void;
        private native function set _menu( value:NativeMenu ):void
        {
            __menu = value;
        }

        //private native function _minimize():void;
        private function _minimize():void
        {
            __displayState = NativeWindowDisplayState.MINIMIZED;
        }

        //private native function _maximize():void;
        private function _maximize():void
        {
            __displayState = NativeWindowDisplayState.MAXIMIZED;
        }

        //private native function _restore():void;
        private function _restore():void
        {
            __displayState = NativeWindowDisplayState.NORMAL;
        }

        //private native function _activate():void;
        private function _activate():void
        {
            __active = true;
        }

        //private native function _startMove():Boolean;
        private function _startMove():Boolean
        {
            return true;
        }

        //private native function _startResize( edgeOrCorner:String = "BR" ):Boolean;
        private function _startResize( edgeOrCorner:String = "BR" ):Boolean
        {
            return true;
        }

        //public native function get stage():Stage;
        [API(CONFIG::AIR_1_0)]
        public function get stage():Stage
        {
            CFG::dbg{ trace( "NativeWindow.get stage()" ); }
            return _stage;
        }

        //public native function get closed():Boolean;
        [API(CONFIG::AIR_1_0)]
        public function get closed():Boolean
        {
            CFG::dbg{ trace( "NativeWindow.get closed()" ); }
            return _closed;
        }

        //public native function get alwaysInFront():Boolean;
        [API(CONFIG::AIR_1_0)]
        public function get alwaysInFront():Boolean
        {
            CFG::dbg{ trace( "NativeWindow.get alwaysInFront()" ); }
            return _alwaysInFront;
        }

        //public native function set alwaysInFront( value:Boolean ):void;
        [API(CONFIG::AIR_1_0)]
        public function set alwaysInFront( value:Boolean ):void
        {
            CFG::dbg{ trace( "NativeWindow.set alwaysInFront( " + value + " )" ); }
            _alwaysInFront = value;
        }

        [API(CONFIG::AIR_1_0)]
        public function get title():String
        {
            CFG::dbg{ trace( "NativeWindow.get title()" ); }
            if( closed )
            {
                Error.throwError( IllegalOperationError, 3200 );
            }
            
            return _title;
        }

        [API(CONFIG::AIR_1_0)]
        public function set title( value:String ):void
        {
            CFG::dbg{ trace( "NativeWindow.set title( " + value + " )" ); }
            if( closed )
            {
                Error.throwError( IllegalOperationError, 3200 );
            }

            _title = value;
        }

        [API(CONFIG::AIR_1_0)]
        public function get bounds():Rectangle
        {
            CFG::dbg{ trace( "NativeWindow.get bounds()" ); }
            if( closed )
            {
                Error.throwError( IllegalOperationError, 3200 );
            }
            
            return _bounds;
        }

        [API(CONFIG::AIR_1_0)]
        public function set bounds( value:Rectangle ):void
        {
            CFG::dbg{ trace( "NativeWindow.set bounds( " + value + " )" ); }
            if( value == null )
            {
                Error.throwError( ArgumentError, 2007, "rect" );
            }
            
            if( isNaN( value.x ) || isNaN( value.y ) || isNaN( value.width ) || isNaN( value.height ) )
            {
                Error.throwError( ArgumentError, 2004 );
            }
            
            if( closed )
            {
                Error.throwError( IllegalOperationError, 3200 );
            }
            
            if( (displayState == NativeWindowDisplayState.MINIMIZED) && value.height && value.width )
            {
                restore();
            }
            else if( (stage.displayState == StageDisplayState.FULL_SCREEN) ||
                     (stage.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE) )
            {
                stage.displayState = StageDisplayState.NORMAL;
            }
            
            _bounds = value;
        }

        [API(CONFIG::AIR_1_0)]
        public function get displayState():String
        {
            CFG::dbg{ trace( "NativeWindow.get displayState()" ); }
            if( closed )
            {
                Error.throwError( IllegalOperationError, 3200 );
            }
            
            return _displayState;
        }

        [API(CONFIG::AIR_1_0)]
        public function get visible():Boolean
        {
            CFG::dbg{ trace( "NativeWindow.get visible()" ); }
            if( closed )
            {
                Error.throwError( IllegalOperationError, 3200 );
            }
            
            return _visible;
        }

        [API(CONFIG::AIR_1_0)]
        public function set visible( value:Boolean ):void
        {
            CFG::dbg{ trace( "NativeWindow.set visible( " + value + " )" ); }
            if( closed )
            {
                Error.throwError( IllegalOperationError, 3200 );
            }
            
            _visible = value;
        }

        [API(CONFIG::AIR_1_0)]
        public function get systemChrome():String
        {
            CFG::dbg{ trace( "NativeWindow.get systemChrome()" ); }
            if( closed )
            {
                Error.throwError( IllegalOperationError, 3200 );
            }
            
            return _systemChrome;
        }

        [API(CONFIG::AIR_1_0)]
        public function get transparent():Boolean
        {
            CFG::dbg{ trace( "NativeWindow.get transparent()" ); }
            if( closed )
            {
                Error.throwError( IllegalOperationError, 3200 );
            }
            
            return _transparent;
        }

        [API(CONFIG::AIR_1_0)]
        public function get type():String
        {
            CFG::dbg{ trace( "NativeWindow.get type()" ); }
            if( closed )
            {
                Error.throwError( IllegalOperationError, 3200 );
            }
            
            return _type;
        }

        [API(CONFIG::AIR_1_0)]
        public function get minimizable():Boolean
        {
            CFG::dbg{ trace( "NativeWindow.get minimizable()" ); }
            if( closed )
            {
                Error.throwError( IllegalOperationError, 3200 );
            }
            
            return _minimizable;
        }

        [API(CONFIG::AIR_1_0)]
        public function get maximizable():Boolean
        {
            CFG::dbg{ trace( "NativeWindow.get maximizable()" ); }
            if( closed )
            {
                Error.throwError( IllegalOperationError, 3200 );
            }
            
            return _maximizable;
        }

        [API(CONFIG::AIR_1_0)]
        public function get resizable():Boolean
        {
            CFG::dbg{ trace( "NativeWindow.get resizable()" ); }
            if( closed )
            {
                Error.throwError( IllegalOperationError, 3200 );
            }
            
            return _resizable;
        }

        [API(CONFIG::AIR_1_0)]
        public function get minSize():Point
        {
            CFG::dbg{ trace( "NativeWindow.get minSize()" ); }
            if( closed )
            {
                Error.throwError( IllegalOperationError, 3200 );
            }
            
            return _minSize;
        }

        [API(CONFIG::AIR_1_0)]
        public function set minSize( value:Point ):void
        {
            CFG::dbg{ trace( "NativeWindow.set minSize( " + value + " )" ); }
            if( value == null )
            {
                Error.throwError( ArgumentError, 2007, "size" );
            }
            
            if( isNaN( value.x ) || isNaN( value.y ) )
            {
                Error.throwError( ArgumentError, 2004 );
            }
            
            if( closed )
            {
                Error.throwError( IllegalOperationError, 3200 );
            }
            
            _minSize = value;
        }

        [API(CONFIG::AIR_1_0)]
        public function get maxSize():Point
        {
            CFG::dbg{ trace( "NativeWindow.get maxSize()" ); }
            if( closed )
            {
                Error.throwError( IllegalOperationError, 3200 );
            }
            
            return _maxSize;
        }

        [API(CONFIG::AIR_1_0)]
        public function set maxSize( value:Point ):void
        {
            CFG::dbg{ trace( "NativeWindow.set maxSize( " + value + " )" ); }
            if( value == null )
            {
                Error.throwError( ArgumentError, 2007, "size" );
            }
            
            if( isNaN( value.x ) || isNaN( value.y ) )
            {
                Error.throwError( ArgumentError, 2004 );
            }
            
            if( closed )
            {
                Error.throwError( IllegalOperationError, 3200 );
            }
            
            _maxSize = value;
            
            var currMax:Point  = _maxSize;
            var rect:Rectangle = bounds;
            if( (currMax.x < value.width) || (currMax.y < value.height) )
            {
                if( currMax.x < rect.width )
                {
                    rect.width = currMax.x;
                }
                
                if( currMax.y < rect.height )
                {
                    rect.height = currMax.y;
                }
                
                bounds = rect;
            }
        }

        [API(CONFIG::AIR_1_0)]
        public function get active():Boolean
        {
            CFG::dbg{ trace( "NativeWindow.get active()" ); }
            if( closed )
            {
                Error.throwError( IllegalOperationError, 3200 );
            }
            
            return _active;
        }

        //public native function get menu():NativeMenu;
        [API(CONFIG::AIR_1_0)]
        public function get menu():NativeMenu
        {
            CFG::dbg{ trace( "NativeWindow.get menu()" ); }
            return __menu;
        }

        [API(CONFIG::AIR_1_0)]
        public function set menu( value:NativeMenu ):void
        {
            CFG::dbg{ trace( "NativeWindow.set menu( " + value + " )" ); }
            if( systemChrome != NativeWindowSystemChrome.STANDARD )
            {
                throw new Error( "Illegal window settings.  Window menus are only supported when systemChrome is set to \"standard\".");
            }
            
            _menu = value;
        }
        
        [API(CONFIG::AIR_1_0)]
        public function get width():Number
        {
            CFG::dbg{ trace( "NativeWindow.get width()" ); }
            var rect:Rectangle = bounds;
            return rect.width;
        }

        [API(CONFIG::AIR_1_0)]
        public function set width( value:Number ):void
        {
            CFG::dbg{ trace( "NativeWindow.set width( " + value + " )" ); }
            if( isNaN( value ) )
            {
                Error.throwError( ArgumentError, 2004 );
            }
            
            if( closed )
            {
                Error.throwError( IllegalOperationError, 3200 );
            }
            
            if( (displayState == NativeWindowDisplayState.MINIMIZED) && value && bounds.height )
            {
                restore();
            }
            else if( (stage.displayState == StageDisplayState.FULL_SCREEN)) ||
                    (stage.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE) )
            {
                stage.displayState = StageDisplayState.NORMAL;
            }
            
            _width = value;
        }

        [API(CONFIG::AIR_1_0)]
        public function get height():Number
        {
            CFG::dbg{ trace( "NativeWindow.get height()" ); }
            var rect:Rectangle = bounds;
            return rect.height;
        }

        [API(CONFIG::AIR_1_0)]
        public function set height( value:Number ):void
        {
            CFG::dbg{ trace( "NativeWindow.set height( " + value + " )" ); }
            if( isNaN( value ) )
            {
                Error.throwError( ArgumentError, 2004 );
            }
            
            if( closed )
            {
                Error.throwError( IllegalOperationError, 3200 );
            }
            
            if( (displayState == NativeWindowDisplayState.MINIMIZED) && bounds.width && value )
            {
                restore();
            }
            else if( (stage.displayState == StageDisplayState.FULL_SCREEN) ||
                    (stage.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE) )
            {
                stage.displayState = StageDisplayState.NORMAL;
            }

            _height = value;
        }

        [API(CONFIG::AIR_1_0)]
        public function get x():Number
        {
            CFG::dbg{ trace( "NativeWindow.get x()" ); }
            var rect:Rectangle = bounds;
            return rect.x;
        }

        [API(CONFIG::AIR_1_0)]
        public function set x( value:Number ):void
        {
            CFG::dbg{ trace( "NativeWindow.set x( " + value + " )" ); }
            if( isNaN( value ) )
            {
                Error.throwError( ArgumentError, 2004 );
            }
            
            if( closed )
            {
                Error.throwError( IllegalOperationError, 3200 );
            }
            
            if( (displayState == NativeWindowDisplayState.MINIMIZED) && bounds.width && bounds.height )
            {
                restore();
            }
            else if( (stage.displayState == StageDisplayState.FULL_SCREEN) ||
                    (stage.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE) )
            {
                stage.displayState = StageDisplayState.NORMAL;
            }
            
            _x = value;
        }

        [API(CONFIG::AIR_1_0)]
        public function get y():Number
        {
            CFG::dbg{ trace( "NativeWindow.get y()" ); }
            var rect:Rectangle = bounds;
            return rect.y;
        }

        [API(CONFIG::AIR_1_0)]
        public function set y( value:Number ):void
        {
            CFG::dbg{ trace( "NativeWindow.set y( " + value + " )" ); }
            if( isNaN( value ) )
            {
                Error.throwError( ArgumentError, 2004 );
            }
            
            if( closed )
            {
                Error.throwError( IllegalOperationError, 3200 );
            }
            
            if( (displayState == NativeWindowDisplayState.MINIMIZED) && bounds.width && bounds.height )
            {
                restore();
            }
            else if( (stage.displayState == StageDisplayState.FULL_SCREEN) ||
                    (stage.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE) )
            {
                stage.displayState = StageDisplayState.NORMAL;
            }
            
            _y = value;
        }


        //public native function close():void;
        [API(CONFIG::AIR_1_0)]
        public function close():void
        {
            CFG::dbg{ trace( "NativeWindow.close()" ); }
            _closed  = true;
            __active = false;
        }
        
        //public native function orderToFront():Boolean;
        [API(CONFIG::AIR_1_0)]
        public function orderToFront():Boolean
        {
            CFG::dbg{ trace( "NativeWindow.orderToFront()" ); }
            return true;
        }

        //public native function orderToBack():Boolean;
        [API(CONFIG::AIR_1_0)]
        public function orderToBack():Boolean
        {
            CFG::dbg{ trace( "NativeWindow.orderToBack()" ); }
            return true
        }

        //public native function orderInFrontOf( window:NativeWindow ):Boolean;
        [API(CONFIG::AIR_1_0)]
        public function orderInFrontOf( window:NativeWindow ):Boolean
        {
            CFG::dbg{ trace( "NativeWindow.orderInFrontOf( " + window + " )" ); }
            return true;
        }

        //public native function orderInBackOf( window:NativeWindow ):Boolean;
        [API(CONFIG::AIR_1_0)]
        public function orderInBackOf( window:NativeWindow ):Boolean
        {
            CFG::dbg{ trace( "NativeWindow.orderInBackOf( " + window + " )" ); }
            return true;
        }

        //public native function globalToScreen( globalPoint:Point ):Point;
        [API(CONFIG::AIR_1_0)]
        public function globalToScreen( globalPoint:Point ):Point
        {
            CFG::dbg{ trace( "NativeWindow.globalToScreen( " + globalPoint + " )" ); }
            return new Point();
        }

        //public native function notifyUser( type:String ):void;
        [API(CONFIG::AIR_1_0)]
        public function notifyUser( type:String ):void
        {
            CFG::dbg{ trace( "NativeWindow.notifyUser( " + type + " )" ); }
        }

        [API(CONFIG::AIR_1_0)]
        public function minimize():void
        {
            CFG::dbg{ trace( "NativeWindow.minimize()" ); }
            if( closed )
            {
                Error.throwError( IllegalOperationError, 3200 );
            }
            
            if( (stage.displayState == StageDisplayState.FULL_SCREEN) ||
                (stage.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE) )
            {
                stage.displayState = StageDisplayState.NORMAL;
            }
            
            _minimize();
        }

        [API(CONFIG::AIR_1_0)]
        public function maximize():void
        {
            CFG::dbg{ trace( "NativeWindow.maximize()" ); }
            if( closed )
            {
                Error.throwError( IllegalOperationError, 3200 );
            }
            
            if( (stage.displayState == StageDisplayState.FULL_SCREEN) ||
                (stage.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE) )
            {
                stage.displayState = StageDisplayState.NORMAL;
            }
            
            _maximize();
        }

        [API(CONFIG::AIR_1_0)]
        public function restore():void
        {
            CFG::dbg{ trace( "NativeWindow.restore()" ); }
            if( closed )
            {
                Error.throwError( IllegalOperationError, 3200 );
            }
            
            if( (stage.displayState == StageDisplayState.FULL_SCREEN) ||
                (stage.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE) )
            {
                stage.displayState = StageDisplayState.NORMAL;
            }

            _restore();
        }

        [API(CONFIG::AIR_1_0)]
        public function startMove():Boolean
        {
            CFG::dbg{ trace( "NativeWindow.startMove()" ); }
            if( closed )
            {
                Error.throwError( IllegalOperationError, 3200 );
            }
            
            return _startMove();
        }

        [API(CONFIG::AIR_1_0)]
        public function startResize( edgeOrCorner:String = "BR" ):Boolean
        {
            CFG::dbg{ trace( "NativeWindow.startResize( " + edgeOrCorner + " )" ); }
            if( closed )
            {
                Error.throwError( IllegalOperationError, 3200 );
            }
            
            return _startResize( edgeOrCorner );
        }

        [API(CONFIG::AIR_1_0)]
        public function activate():void
        {
            CFG::dbg{ trace( "NativeWindow.activate()" ); }
            if( closed )
            {
                Error.throwError( IllegalOperationError, 3200 );
            }
            
            _activate();
        }

    }
}
