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
    import flash.errors.*;
    import flash.geom.*;
    import flash.media.*;
    import flash.accessibility.*;
    import flash.events.*;
    import flash.text.*;
    
    /**
     * The Stage class represents the main drawing area.
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 9
     * @playerversion AIR 1.0
     */
    public class Stage extends DisplayObjectContainer
    {

        private static const kInvalidParamError:uint = 2004;

        private static var _supportsOrientationChange:Boolean;

        //public static native function get supportsOrientationChange():Boolean;
        [API(CONFIG::AIR_2_0)]
        public static function get supportsOrientationChange():Boolean
        {
            CFG::dbg{ trace( "[static] Stage.get supportsOrientationChange()" ); }
            return _supportsOrientationChange;
        }

        private var __aspectRatio:String;
        private var __orientation:String;
        private var __displayState:String;

        private var _frameRate:Number;
        private var _scaleMode:String;
        private var _align:String;
        private var _stageWidth:int;
        private var _stageHeight:int;
        private var _showDefaultContextMenu:Boolean;
        private var _focus:InteractiveObject;

        private var _colorCorrection:String;
        private var _colorCorrectionSupport:String;
        private var _stageFocusRect:Boolean;
        private var _quality:String;
        private var _fullScreenSourceRect:Rectangle;
        private var _fullScreenWidth:uint;
        private var _fullScreenHeight:uint;
        private var _wmodeGPU:Boolean;
        [API(CONFIG::AIR_1_0)] private var _nativeWindow:NativeWindow;
        private var _deviceOrientation:String;
        private var _autoOrients:Boolean;
        
        public function Stage()
        {
            CFG::dbg{ trace( "new Stage()" ); }
            super();
        }

        //private native function set_displayState( value:String ):void;
        private function set_displayState( value:String ):void
        {
            __displayState = value;
        }

        //private native function get simulatedDisplayState():String;
        //private native function set simulatedDisplayState(value:String):void;

        //private native function get simulatedFullScreenSourceRect():Rectangle;
        //private native function set simulatedFullScreenSourceRect(value:Rectangle):void;

        //private native function get simulatedFullScreenWidth():uint;
        //private native function get simulatedFullScreenHeight():uint;

        //private native function set _orientation( value:String ):void;
        private function set _orientation( value:String ):void
        {
            __orientation = value;
        }

        //private native function set _aspectRatio( value:String ):void;
        private function set _aspectRatio( value:String ):void
        {
            __aspectRatio = value;
        }

        //private native function requireOwnerPermissions():void;
        private function requireOwnerPermissions():void
        {
        
        }



        //public native function get frameRate():Number;
        public function get frameRate():Number
        {
            CFG::dbg{ trace( "Stage.get frameRate()" ); }
            return _frameRate;
        }
        
        //public native function set frameRate( value:Number ):void;
        public function set frameRate( value:Number ):void
        {
            CFG::dbg{ trace( "Stage.set frameRate( " + value + " )" ); }
            _frameRate = value;
        }

        //public native function get scaleMode():String;
        public function get scaleMode():String
        {
            CFG::dbg{ trace( "Stage.get scaleMode()" ); }
            return _scaleMode;
        }
        
        //public native function set scaleMode( value:String ):void;
        public function set scaleMode( value:String ):void
        {
            CFG::dbg{ trace( "Stage.set scaleMode( " + value + " )" ); }
            _scaleMode = value;
        }

        //public native function get align():String;
        public function get align():String
        {
            CFG::dbg{ trace( "Stage.get align()" ); }
            return _align;
        }
        
        //public native function set align( value:String ):void;
        public function set align( value:String ):void
        {
            CFG::dbg{ trace( "Stage.set align( " + value + " )" ); }
            _align = value;
        }

        //public native function get stageWidth():int;
        public function get stageWidth():int
        {
            CFG::dbg{ trace( "Stage.get stageWidth()" ); }
            return _stageWidth;
        }
        
        //public native function set stageWidth( value:int ):void;
        public function set stageWidth( value:int ):void
        {
            CFG::dbg{ trace( "Stage.set stageWidth( " + value + " )" ); }
            _stageWidth = value;
        }

        //public native function get stageHeight():int;
        public function get stageHeight():int
        {
            CFG::dbg{ trace( "Stage.get stageHeight()" ); }
            return _stageHeight;
        }
        
        //public native function set stageHeight( value:int ):void;
        public function set stageHeight( value:int ):void
        {
            CFG::dbg{ trace( "Stage.set stageHeight( " + value + " )" ); }
            _stageHeight = value;
        }

        //public native function get showDefaultContextMenu():Boolean;
        public function get showDefaultContextMenu():Boolean
        {
            CFG::dbg{ trace( "Stage.get showDefaultContextMenu()" ); }
            return _showDefaultContextMenu;
        }
        
        //public native function set showDefaultContextMenu( value:Boolean ):void;
        public function set showDefaultContextMenu( value:Boolean ):void
        {
            CFG::dbg{ trace( "Stage.set showDefaultContextMenu( " + value + " )" ); }
            _showDefaultContextMenu = value;
        }

        //public native function get focus():InteractiveObject;
        public function get focus():InteractiveObject
        {
            CFG::dbg{ trace( "Stage.get focus()" ); }
            return _focus;
        }
        
        //public native function set focus( value:InteractiveObject ):void;
        public function set focus( value:InteractiveObject ):void
        {
            CFG::dbg{ trace( "Stage.set focus( " + value + " )" ); }
            _focus = value;
        }

        
        //public native function get colorCorrection():String;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function get colorCorrection():String
        {
            CFG::dbg{ trace( "Stage.get colorCorrection()" ); }
            return _colorCorrection;
        }
        
        //public native function set colorCorrection( value:String ):void;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function set colorCorrection( value:String ):void
        {
            CFG::dbg{ trace( "Stage.set colorCorrection( " + value + " )" ); }
            _colorCorrection = value;
        }

        //public native function get colorCorrectionSupport():String;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function get colorCorrectionSupport():String
        {
            CFG::dbg{ trace( "Stage.get colorCorrectionSupport()" ); }
            return _colorCorrectionSupport;
        }

        //public native function get stageFocusRect():Boolean;
        public function get stageFocusRect():Boolean
        {
            CFG::dbg{ trace( "Stage.get stageFocusRect()" ); }
            return _stageFocusRect;
        }
        
        //public native function set stageFocusRect( value:Boolean ):void;
        public function set stageFocusRect( value:Boolean ):void
        {
            CFG::dbg{ trace( "Stage.set stageFocusRect( " + value + " )" ); }
            _stageFocusRect = value;
        }

        //public native function get quality():String;
        public function get quality():String
        {
            CFG::dbg{ trace( "Stage.get quality()" ); }
            return _quality;
        }
        
        //public native function set quality( value:String ):void;
        public function set quality( value:String ):void
        {
            CFG::dbg{ trace( "Stage.set quality( " + value + " )" ); }
            _quality = value;
        }

        //public native function get displayState():String;
        public function get displayState():String
        {
            CFG::dbg{ trace( "Stage.get displayState()" ); }
            return __displayState;
        }
        
        public function set displayState( value:String ):void
        {
            CFG::dbg{ trace( "Stage.set displayState( " + value + " )" ); }
            if( (nativeWindow == undefined) || nativeWindow.closed )
            {
                Error.throwError( IllegalOperationError, 3200 );
            }
            
            set_displayState( value );
        }

        //public native function get fullScreenSourceRect():Rectangle;
        public function get fullScreenSourceRect():Rectangle
        {
            CFG::dbg{ trace( "Stage.get fullScreenSourceRect()" ); }
            return _fullScreenSourceRect;
        }
        
        //public native function set fullScreenSourceRect( value:Rectangle ):void;
        public function set fullScreenSourceRect( value:Rectangle ):void
        {
            CFG::dbg{ trace( "Stage.set fullScreenSourceRect( " + value + " )" ); }
            _fullScreenSourceRect = value;
        }

        //public native function get stageVideos():Vector.<StageVideo>;

        //public native function get fullScreenWidth():uint;
        public function get fullScreenWidth():uint
        {
            CFG::dbg{ trace( "Stage.get fullScreenWidth()" ); }
            return _fullScreenWidth;
        }

        //public native function get fullScreenHeight():uint;
        public function get fullScreenHeight():uint
        {
            CFG::dbg{ trace( "Stage.get fullScreenHeight()" ); }
            return _fullScreenHeight;
        }

        //public native function get wmodeGPU():Boolean;
        [API(CONFIG::FP_10_0_32,CONFIG::AIR_1_5_2)]
        public function get wmodeGPU():Boolean
        {
            CFG::dbg{ trace( "Stage.get wmodeGPU()" ); }
            return _wmodeGPU;
        }

        //public native function get nativeWindow():NativeWindow;
        [API(CONFIG::AIR_1_0)]
        public function get nativeWindow():NativeWindow
        {
            CFG::dbg{ trace( "Stage.get nativeWindow()" ); }
            return _nativeWindow;
        }

        //public native function get orientation():String;
        [API(CONFIG::AIR_2_0)]
        public function get orientation():String
        {
            CFG::dbg{ trace( "Stage.get orientation()" ); }
            return __orientation;
        }

        //public native function get deviceOrientation():String;
        [API(CONFIG::AIR_2_0)]
        public function get deviceOrientation():String
        {
            CFG::dbg{ trace( "Stage.get deviceOrientation()" ); }
            return _deviceOrientation;
        }

        //public native function get autoOrients():Boolean;
        [API(CONFIG::AIR_2_0)]
        public function get autoOrients():Boolean
        {
            CFG::dbg{ trace( "Stage.get autoOrients()" ); }
            return _autoOrients;
        }
        


        //public native function invalidate():void;
        public function invalidate():void
        {
            CFG::dbg{ trace( "Stage.invalidate()" ); }
        }
        
        //public native function isFocusInaccessible():Boolean;
        public function isFocusInaccessible():Boolean
        {
            CFG::dbg{ trace( "Stage.isFocusInaccessible()" ); }
            if( _focus != null )
            {
                return true;
            }

            return false;
        }

        //public native function codecCapability(codecID:uint, profileName:String=null, levelName:String=null):String;

        //should be private ??
        //public native function _assignFocus( objectToFocus:InteractiveObject, direction:String ):void;
        [API(CONFIG::AIR_1_0)]
        public native function _assignFocus( objectToFocus:InteractiveObject, direction:String ):void
        {
            CFG::dbg{ trace( "Stage._assignFocus( " + [objectToFocus,direction].join(", ") + " )" ); }
            //TODO
        }

        //override public native function removeChildAt( index:int ):DisplayObject;
        override public function removeChildAt( index:int ):DisplayObject
        {
            CFG::dbg{ trace( "Stage.removeChildAt( " + index + " )" ); }
            //TODO
            return null;
        }

        //override public native function swapChildrenAt( index1:int, index2:int ):void;
        override public function swapChildrenAt( index1:int, index2:int ):void
        {
            CFG::dbg{ trace( "Stage.swapChildrenAt( " + [index1,index2].join(", ") + " )" ); }
            //TODO
        }
        


        override public function set name( value:String ):void
        {
            CFG::dbg{ trace( "Stage.set name( " + value + " )" ); }
            Error.throwError( IllegalOperationError, 2071 );
        }
        
        override public function set mask( value:DisplayObject ):void
        {
            CFG::dbg{ trace( "Stage.set mask( " + value + " )" ); }
            Error.throwError( IllegalOperationError, 2071 );
        }
        
        override public function set visible( value:Boolean ):void
        {
            CFG::dbg{ trace( "Stage.set visible( " + value + " )" ); }
            Error.throwError( IllegalOperationError, 2071 );
        }
        
        override public function set x( value:Number ):void
        {
            CFG::dbg{ trace( "Stage.set x( " + value + " )" ); }
            Error.throwError( IllegalOperationError, 2071 );
        }
        
        override public function set y( value:Number ):void
        {
            CFG::dbg{ trace( "Stage.set y( " + value + " )" ); }
            Error.throwError(IllegalOperationError, 2071);
        }

        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        override public function set z( value:Number ):void
        {
            CFG::dbg{ trace( "Stage.set z( " + value + " )" ); }
            Error.throwError( IllegalOperationError, 2071 );
        }
        
        override public function set scaleX( value:Number ):void
        {
            CFG::dbg{ trace( "Stage.set scaleX( " + value + " )" ); }
            Error.throwError( IllegalOperationError, 2071 );
        }
        
        override public function set scaleY( value:Number ):void
        {
            CFG::dbg{ trace( "Stage.set scaleY( " + value + " )" ); }
            Error.throwError( IllegalOperationError, 2071 );
        }

        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        override public function set scaleZ( value:Number ):void
        {
            CFG::dbg{ trace( "Stage.set scaleZ( " + value + " )" ); }
            Error.throwError( IllegalOperationError, 2071 );
        }
        
        override public function set rotation( value:Number ):void
        {
            CFG::dbg{ trace( "Stage.set rotation( " + value + " )" ); }
            Error.throwError( IllegalOperationError, 2071 );
        }

        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        override public function set rotationX( value:Number ):void
        {
            CFG::dbg{ trace( "Stage.set rotationX( " + value + " )" ); }
            Error.throwError( IllegalOperationError, 2071 );
        }

        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        override public function set rotationY( value:Number ):void
        {
            CFG::dbg{ trace( "Stage.set rotationY( " + value + " )" ); }
            Error.throwError( IllegalOperationError, 2071 );
        }

        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        override public function set rotationZ( value:Number ):void
        {
            CFG::dbg{ trace( "Stage.set rotationZ( " + value + " )" ); }
            Error.throwError( IllegalOperationError, 2071 );
        }
        
        override public function set alpha( value:Number ):void
        {
            CFG::dbg{ trace( "Stage.set alpha( " + value + " )" ); }
            Error.throwError( IllegalOperationError, 2071 );
        }
        
        override public function set cacheAsBitmap( value:Boolean ):void
        {
            CFG::dbg{ trace( "Stage.set cacheAsBitmap( " + value + " )" ); }
            Error.throwError( IllegalOperationError, 2071 );
        }
        
        override public function set opaqueBackground( value:Object ):void
        {
            CFG::dbg{ trace( "Stage.set opaqueBackground( " + value + " )" ); }
            Error.throwError( IllegalOperationError, 2071 );
        }
        
        override public function set scrollRect( value:Rectangle ):void
        {
            CFG::dbg{ trace( "Stage.set scrollRect( " + value + " )" ); }
            Error.throwError( IllegalOperationError, 2071 );
        }
        
        override public function set filters( value:Array ):void
        {
            CFG::dbg{ trace( "Stage.set filters( " + value + " )" ); }
            Error.throwError( IllegalOperationError, 2071 );
        }
        
        override public function set blendMode( value:String ):void
        {
            CFG::dbg{ trace( "Stage.set blendMode( " + value + " )" ); }
            Error.throwError( IllegalOperationError, 2071 );
        }
        
        override public function set transform( value:Transform ):void
        {
            CFG::dbg{ trace( "Stage.set transform( " + value + " )" ); }
            Error.throwError( IllegalOperationError, 2071 );
        }
        
        override public function set accessibilityProperties( value:AccessibilityProperties ):void
        {
            CFG::dbg{ trace( "Stage.set accessibilityProperties( " + value + " )" ); }
            Error.throwError( IllegalOperationError, 2071 );
        }
        
        override public function set scale9Grid( value:Rectangle ):void
        {
            CFG::dbg{ trace( "Stage.set scale9Grid( " + value + " )" ); }
            Error.throwError( IllegalOperationError, 2071 );
        }
        
        override public function set tabEnabled( value:Boolean ):void
        {
            CFG::dbg{ trace( "Stage.set tabEnabled( " + value + " )" ); }
            Error.throwError( IllegalOperationError, 2071 );
        }
        
        override public function set tabIndex( value:int ):void
        {
            CFG::dbg{ trace( "Stage.set tabIndex( " + value + " )" ); }
            Error.throwError( IllegalOperationError, 2071 );
        }
        
        override public function set focusRect( value:Object ):void
        {
            CFG::dbg{ trace( "Stage.set focusRect( " + value + " )" ); }
            Error.throwError( IllegalOperationError, 2071 );
        }
        
        override public function set mouseEnabled( value:Boolean ):void
        {
            CFG::dbg{ trace( "Stage.set mouseEnabled( " + value + " )" ); }
            Error.throwError( IllegalOperationError, 2071 );
        }
        
        override public function set accessibilityImplementation( value:AccessibilityImplementation ):void
        {
            CFG::dbg{ trace( "Stage.set accessibilityImplementation( " + value + " )" ); }
            Error.throwError( IllegalOperationError, 2071 );
        }

        override public function get width():Number
        {
            CFG::dbg{ trace( "Stage.get width()" ); }
            requireOwnerPermissions();
            return super.width;
        }
        
        override public function set width( value:Number ):void
        {
            CFG::dbg{ trace( "Stage.set width( " + value + " )" ); }
            Error.throwError( IllegalOperationError, 2071 );
        }
        
        override public function get height():Number
        {
            CFG::dbg{ trace( "Stage.get height()" ); }
            requireOwnerPermissions();
            return super.height;
        }
        
        override public function set height( value:Number ):void
        {
            CFG::dbg{ trace( "Stage.set height( " + value + " )" ); }
            Error.throwError( IllegalOperationError, 2071 );
        }
        
        override public function get textSnapshot():TextSnapshot
        {
            CFG::dbg{ trace( "Stage.get textSnapshot()" ); }
            Error.throwError( IllegalOperationError, 2071 );
            return null;
        }
        
        override public function get mouseChildren():Boolean
        {
            CFG::dbg{ trace( "Stage.get mouseChildren()" ); }
            requireOwnerPermissions();
            return super.mouseChildren;
        }
        
        override public function set mouseChildren( value:Boolean ):void
        {
            CFG::dbg{ trace( "Stage.set mouseChildren( " + value + " )" ); }
            requireOwnerPermissions();
            super.mouseChildren = value;
        }
        
        override public function get numChildren():int
        {
            CFG::dbg{ trace( "Stage.get numChildren()" ); }
            requireOwnerPermissions();
            return super.numChildren;
        }
        
        override public function get tabChildren():Boolean
        {
            CFG::dbg{ trace( "Stage.get tabChildren()" ); }
            requireOwnerPermissions();
            return super.tabChildren;
        }
        
        override public function set tabChildren( value:Boolean ):void
        {
            CFG::dbg{ trace( "Stage.set tabChildren( " + value + " )" ); }
            requireOwnerPermissions();
            super.tabChildren = value;
        }

        override public function set contextMenu( value:NativeMenu ):void
        {
            CFG::dbg{ trace( "Stage.set contextMenu( " + value + " )" ); }
            Error.throwError(IllegalOperationError, 2071);
        }
        
        override public function addChild( child:DisplayObject ):DisplayObject
        {
            CFG::dbg{ trace( "Stage.addChild( " + child + " )" ); }
            requireOwnerPermissions();
            return super.addChild( child );
        }
        
        override public function addChildAt( child:DisplayObject, index:int ):DisplayObject
        {
            CFG::dbg{ trace( "Stage.addChildAt( " + [child,index].join(", ") + " )" ); }
            requireOwnerPermissions();
            return super.addChildAt( child, index );
        }
        
        override public function setChildIndex( child:DisplayObject, index:int ):void
        {
            CFG::dbg{ trace( "Stage.setChildIndex( " + [child,index].join(", ") + " )" ); }
            requireOwnerPermissions();
            super.setChildIndex( child, index );
        }
        
        override public function addEventListener( type:String, listener:Function, useCapture:Boolean = false,
                                                   priority:int = 0, useWeakReference:Boolean = false ):void
        {
            CFG::dbg{ trace( "Stage.addEventListener( " + [type,listener,useCapture,priority,useWeakReference].join(", ") + " )" ); }
            requireOwnerPermissions();
            super.addEventListener( type, listener, useCapture, priority, useWeakReference );
        }
        
        override public function dispatchEvent( event:Event ):Boolean
        {
            CFG::dbg{ trace( "Stage.dispatchEvent( " + event + " )" ); }
            requireOwnerPermissions();
            return super.dispatchEvent( event );
        }
        
        override public function hasEventListener( type:String ):Boolean
        {
            CFG::dbg{ trace( "Stage.hasEventListener( " + type + " )" ); }
            requireOwnerPermissions();
            return super.hasEventListener( type );
        }
        
        override public function willTrigger( type:String ):Boolean
        {
            CFG::dbg{ trace( "Stage.willTrigger( " + type + " )" ); }
            requireOwnerPermissions();
            return super.willTrigger( type );
        }

        [API(CONFIG::AIR_1_0)]
        public function assignFocus( objectToFocus:InteractiveObject, direction:String ):void
        {
            CFG::dbg{ trace( "Stage.assignFocus( " + [objectToFocus,direction].join(", ") + " )" ); }
            if( !(direction == FocusDirection.TOP) &&
                !(direction == FocusDirection.BOTTOM) &&
                !(direction == FocusDirection.NONE) )
            {
                Error.throwError( ArgumentError, kInvalidParamError );
                return;
            }
            
            _assignFocus( objectToFocus, direction );
        }

        [API(CONFIG::AIR_2_0)]
        public function setOrientation( newOrientation:String ):void
        {
            CFG::dbg{ trace( "Stage.setOrientation( " + newOrientation + " )" ); }
            switch( newOrientation )
            {
                case StageOrientation.DEFAULT:
                case StageOrientation.ROTATED_LEFT:
                case StageOrientation.ROTATED_RIGHT:
                case StageOrientation.UPSIDE_DOWN:
                _orientation = newOrientation;
                break;
                
                default:
                Error.throwError( ArgumentError, kInvalidParamError );
            }
        }

        [API(CONFIG::AIR_2_0)]
        public function setAspectRatio( newAspectRatio:String ):void
        {
            CFG::dbg{ trace( "Stage.setAspectRatio( " + newAspectRatio + " )" ); }
            switch( newAspectRatio )
            {
                case StageAspectRatio.PORTRAIT:
                case StageAspectRatio.LANDSCAPE:
                _aspectRatio = newAspectRatio;
                break;
                
                default:
                Error.throwError( ArgumentError, kInvalidParamError );
            }
        }

        
    }
}
