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
    import flash.accessibility.*;
    import flash.events.*;
    
    /**
     * The DisplayObject class is the base class for all objects that can be placed on the display list.
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 9
     * @playerversion AIR 1.0
     */
    public class DisplayObject extends EventDispatcher implements IBitmapDrawable
    {
        private var _root:DisplayObject;
        private var _stage:Stage;
        private var _parent:DisplayObjectContainer;
        private var _mask:DisplayObject;
        private var _loaderInfo:LoaderInfo;

        private var _name:String;
        private var _visible:Boolean;
        
        private var _x:Number;
        private var _y:Number;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)] private var _z:Number;
        private var _scaleX:Number;
        private var _scaleY:Number;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)] private var _scaleZ:Number;
        private var _rotation:Number;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)] private var _rotationX:Number;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)] private var _rotationY:Number;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)] private var _rotationZ:Number;
        private var _alpha:Number;
        private var _width:Number;
        private var _height:Number;

        private var _cacheAsBitmap:Boolean;
        //private var _cacheAsSurface:Boolean;
        [API(CONFIG::AIR_2_0)] private var _cacheAsBitmapMatrix:Matrix;
        private var _opaqueBackground:Object;
        private var _scrollRect:Rectangle;
        private var _filters:Array;
        private var _blendMode:String;
        private var _transform:Transform;
        private var _scale9Grid:Rectangle;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)] private var _blendShader:Shader;
        private var _accessibilityProperties:AccessibilityProperties;
        
        public function DisplayObject()
        {
            CFG::dbg{ trace( "new DisplayObject()" ); }
            super();
        }

        //public native function get root():DisplayObject;
        public function get root():DisplayObject
        {
            CFG::dbg{ trace( "DisplayObject.get root()" ); }
            return _root;
        }

        //public native function get stage():Stage;
        public function get stage():Stage
        {
            CFG::dbg{ trace( "DisplayObject.get stage()" ); }
            return _stage;
        }

        //public native function get name():String;
        public function get name():String
        {
            CFG::dbg{ trace( "DisplayObject.get name()" ); }
            return _name;
        }

        //public native function set name( value:String ):void;
        public function set name( value:String ):void
        {
            CFG::dbg{ trace( "DisplayObject.set name( " + value + " )" ); }
            _name = value;
        }

        //public native function get parent():DisplayObjectContainer;
        public function get parent():DisplayObjectContainer
        {
            CFG::dbg{ trace( "DisplayObject.get parent()" ); }
            return _parent;
        }

        //public native function get mask():DisplayObject;
        public function get mask():DisplayObject
        {
            CFG::dbg{ trace( "DisplayObject.get mask()" ); }
            return _mask;
        }

        //public native function set mask( value:DisplayObject ):void;
        public function set mask( value:DisplayObject ):void
        {
            CFG::dbg{ trace( "DisplayObject.set mask( " + value + " )" ); }
            _mask = value;
        }

        //public native function get loaderInfo():LoaderInfo;
        public function get loaderInfo():LoaderInfo
        {
            CFG::dbg{ trace( "DisplayObject.get loaderInfo()" ); }
            return _loaderInfo;
        }

        //public native function get visible():Boolean;
        public function get visible():Boolean
        {
            CFG::dbg{ trace( "DisplayObject.get visible()" ); }
            return _visible;
        }

        //public native function set visible( value:Boolean ):void;
        public function set visible( value:Boolean ):void
        {
            CFG::dbg{ trace( "DisplayObject.set visible( " + value + " )" ); }
            _visible = value;
        }

        //public native function get x():Number;
        public function get x():Number
        {
            CFG::dbg{ trace( "DisplayObject.get x()" ); }
            return _x;
        }

        //public native function set x( value:Number ):void;
        public function set x( value:Number ):void
        {
            CFG::dbg{ trace( "DisplayObject.set x( " + value + " )" ); }
            _x = value;
        }

        //public native function get y():Number;
        public function get y():Number
        {
            CFG::dbg{ trace( "DisplayObject.get y()" ); }
            return _y;
        }

        //public native function set y( value:Number ):void;
        public function set y( value:Number ):void
        {
            CFG::dbg{ trace( "DisplayObject.set y( " + value + " )" ); }
            _y = value;
        }

        //public native function get z():Number;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function get z():Number
        {
            CFG::dbg{ trace( "DisplayObject.get z()" ); }
            return _z;
        }

        //public native function set z( value:Number ):void;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function set z( value:Number ):void
        {
            CFG::dbg{ trace( "DisplayObject.set z( " + value + " )" ); }
            _z = value;
        }

        //public native function get scaleX():Number;
        public function get scaleX():Number
        {
            CFG::dbg{ trace( "DisplayObject.get scaleX()" ); }
            return _scaleX;
        }

        //public native function set scaleX( value:Number ):void;
        public function set scaleX( value:Number ):void
        {
            CFG::dbg{ trace( "DisplayObject.set scaleX( " + value + " )" ); }
            _scaleX = value;
        }

        //public native function get scaleY():Number;
        public function get scaleY():Number
        {
            CFG::dbg{ trace( "DisplayObject.get scaleY()" ); }
            return _scaleY;
        }

        //public native function set scaleY( value:Number ):void;
        public function set scaleY( value:Number ):void
        {
            CFG::dbg{ trace( "DisplayObject.set scaleY( " + value + " )" ); }
            _scaleY = value;
        }

        //public native function get scaleZ():Number;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function get scaleZ():Number
        {
            CFG::dbg{ trace( "DisplayObject.get scaleZ()" ); }
            return _scaleZ;
        }

        //public native function set scaleZ( value:Number ):void;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function set scaleZ( value:Number ):void
        {
            CFG::dbg{ trace( "DisplayObject.set scaleZ( " + value + " )" ); }
            _scaleZ = value;
        }

        //public native function get mouseX():Number;
        public function get mouseX():Number
        {
            CFG::dbg{ trace( "DisplayObject.get mouseX()" ); }
            return 0;
        }

        //public native function get mouseY():Number;
        public function get mouseY():Number
        {
            CFG::dbg{ trace( "DisplayObject.get mouseY()" ); }
            return 0;
        }

        //public native function get rotation():Number;
        public function get rotation():Number
        {
            CFG::dbg{ trace( "DisplayObject.get rotation()" ); }
            return _rotation;
        }

        //public native function set rotation( value:Number ):void;
        public function set rotation( value:Number ):void
        {
            CFG::dbg{ trace( "DisplayObject.set rotation( " + value + " )" ); }
            _rotation = value;
        }

        //public native function get rotationX():Number;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function get rotationX():Number
        {
            CFG::dbg{ trace( "DisplayObject.get rotationX()" ); }
            return _rotationX;
        }

        //public native function set rotationX( value:Number ):void;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function set rotationX( value:Number ):void
        {
            CFG::dbg{ trace( "DisplayObject.set rotationX( " + value + " )" ); }
            _rotationX = value;
        }

        //public native function get rotationY():Number;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function get rotationY():Number
        {
            CFG::dbg{ trace( "DisplayObject.get rotationY()" ); }
            return _rotationY;
        }

        //public native function set rotationY( value:Number ):void;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function set rotationY( value:Number ):void
        {
            CFG::dbg{ trace( "DisplayObject.set rotationY( " + value + " )" ); }
            _rotationY = value;
        }

        //public native function get rotationZ():Number;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function get rotationZ():Number
        {
            CFG::dbg{ trace( "DisplayObject.get rotationZ()" ); }
            return _rotationZ;
        }

        //public native function set rotationZ( value:Number ):void;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function set rotationZ( value:Number ):void
        {
            CFG::dbg{ trace( "DisplayObject.set rotationZ( " + value + " )" ); }
            _rotationZ = value;
        }

        //public native function get alpha():Number;
        public function get alpha():Number
        {
            CFG::dbg{ trace( "DisplayObject.get alpha()" ); }
            return _alpha;
        }

        //public native function set alpha( value:Number ):void;
        public function set alpha( value:Number ):void
        {
            CFG::dbg{ trace( "DisplayObject.set alpha( " + value + " )" ); }
            _alpha = value;
        }

        //public native function get width():Number;
        public function get width():Number
        {
            CFG::dbg{ trace( "DisplayObject.get width()" ); }
            return _width;
        }

        //public native function set width( value:Number ):void;
        public function set width( value:Number ):void
        {
            CFG::dbg{ trace( "DisplayObject.set width( " + value + " )" ); }
            _width = value;
        }

        //public native function get height():Number;
        public function get height():Number
        {
            CFG::dbg{ trace( "DisplayObject.get height()" ); }
            return _height;
        }

        //public native function set height( value:Number ):void;
        public function set height( value:Number ):void
        {
            CFG::dbg{ trace( "DisplayObject.set height( " + value + " )" ); }
            _height = value;
        }

        //public native function get cacheAsBitmap():Boolean;
        public function get cacheAsBitmap():Boolean
        {
            CFG::dbg{ trace( "DisplayObject.get cacheAsBitmap()" ); }
            return _cacheAsBitmap;
        }

        //public native function set cacheAsBitmap( value:Boolean ):void;
        public function set cacheAsBitmap( value:Boolean ):void
        {
            CFG::dbg{ trace( "DisplayObject.set cacheAsBitmap( " + value + " )" ); }
            _cacheAsBitmap = value;
        }

        //public native function get cacheAsSurface():Boolean;
        /*public function get cacheAsSurface():Boolean
        {
            return _cacheAsSurface;
        }*/

        //public native function set cacheAsSurface( value:Boolean ):void;
        /*public function set cacheAsSurface( value:Boolean ):void
        {
            _cacheAsSurface = value;
        }*/

        //public native function get cacheAsBitmapMatrix():Matrix;
        [API(CONFIG::AIR_2_0)]
        public function get cacheAsBitmapMatrix():Matrix
        {
            CFG::dbg{ trace( "DisplayObject.get cacheAsBitmapMatrix()" ); }
            return _cacheAsBitmapMatrix;
        }

        //public native function set cacheAsBitmapMatrix( value:Matrix ):void;
        [API(CONFIG::AIR_2_0)]
        public function set cacheAsBitmapMatrix( value:Matrix ):void
        {
            CFG::dbg{ trace( "DisplayObject.set cacheAsBitmapMatrix( " + value + " )" ); }
            _cacheAsBitmapMatrix = value;
        }

        //public native function get opaqueBackground():Object;
        public function get opaqueBackground():Object
        {
            CFG::dbg{ trace( "DisplayObject.get opaqueBackground()" ); }
            return _opaqueBackground;
        }

        //public native function set opaqueBackground( value:Object ):void;
        public function set opaqueBackground( value:Object ):void
        {
            CFG::dbg{ trace( "DisplayObject.set opaqueBackground( " + value + " )" ); }
            _opaqueBackground = value;
        }

        //public native function get scrollRect():Rectangle;
        public function get scrollRect():Rectangle
        {
            CFG::dbg{ trace( "DisplayObject.get scrollRect()" ); }
            return _scrollRect;
        }

        //public native function set scrollRect( value:Rectangle ):void;
        public function set scrollRect( value:Rectangle ):void
        {
            CFG::dbg{ trace( "DisplayObject.set scrollRect( " + value + " )" ); }
            _scrollRect = value;
        }

        //public native function get filters():Array;
        public function get filters():Array
        {
            CFG::dbg{ trace( "DisplayObject.get filters()" ); }
            return _filters;
        }

        //public native function set filters( value:Array ):void;
        public function set filters( value:Array ):void
        {
            CFG::dbg{ trace( "DisplayObject.set filters( " + value + " )" ); }
            _filters = value;
        }

        //public native function get blendMode():String;
        public function get blendMode():String
        {
            CFG::dbg{ trace( "DisplayObject.get blendMode()" ); }
            return _blendMode;
        }

        //public native function set blendMode( value:String ):void;
        public function set blendMode( value:String ):void
        {
            CFG::dbg{ trace( "DisplayObject.set blendMode( " + value + " )" ); }
            _blendMode = value;
        }

        //public native function get transform():Transform;
        public function get transform():Transform
        {
            CFG::dbg{ trace( "DisplayObject.get transform()" ); }
            return _transform;
        }

        //public native function set transform( value:Transform ):void;
        public function set transform( value:Transform ):void
        {
            CFG::dbg{ trace( "DisplayObject.set transform( " + value + " )" ); }
            _transform = value;
        }

        //public native function get scale9Grid():Rectangle;
        public function get scale9Grid():Rectangle
        {
            CFG::dbg{ trace( "DisplayObject.get scale9Grid()" ); }
            return _scale9Grid;
        }

        //public native function set scale9Grid( value:Rectangle ):void;
        public function set scale9Grid( value:Rectangle ):void
        {
            CFG::dbg{ trace( "DisplayObject.set scale9Grid( " + value + " )" ); }
            _scale9Grid = value;
        }

        //public native function set blendShader( value:Shader ):void;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function set blendShader( value:Shader ):void
        {
            CFG::dbg{ trace( "DisplayObject.set blendShader( " + value + " )" ); }
            _blendShader = value;
        }

        //public native function get accessibilityProperties():AccessibilityProperties;
        public function get accessibilityProperties():AccessibilityProperties
        {
            CFG::dbg{ trace( "DisplayObject.get accessibilityProperties()" ); }
            return _accessibilityProperties;
        }

        //public native function set accessibilityProperties( value:AccessibilityProperties ):void;
        public function set accessibilityProperties( value:AccessibilityProperties ):void;
        {
            CFG::dbg{ trace( "DisplayObject.set accessibilityProperties( " + value + " )" ); }
            _accessibilityProperties = value;
        }


        //public native function globalToLocal( point:Point ):Point;
        public function globalToLocal( point:Point ):Point
        {
            CFG::dbg{ trace( "DisplayObject.globalToLocal( " + point + " )" ); }
            return new Point();
        }

        //public native function localToGlobal( point:Point ):Point;
        public function localToGlobal( point:Point ):Point
        {
            CFG::dbg{ trace( "DisplayObject.localToGlobal( " + point + " )" ); }
            return new Point();
        }

        //public native function globalToLocal3D( point:Point ):Vector3D;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public native function globalToLocal3D( point:Point ):Vector3D
        {
            CFG::dbg{ trace( "DisplayObject.globalToLocal3D( " + point + " )" ); }
            return new Vector3D();
        }

        //public native function local3DToGlobal( point3d:Vector3D ):Point;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public native function local3DToGlobal( point3d:Vector3D ):Point
        {
            CFG::dbg{ trace( "DisplayObject.local3DToGlobal( " + point3d + " )" ); }
            return new Point();
        }

        //public native function getBounds( targetCoordinateSpace:DisplayObject ):Rectangle;
        public function getBounds( targetCoordinateSpace:DisplayObject ):Rectangle
        {
            CFG::dbg{ trace( "DisplayObject.getBounds( " + targetCoordinateSpace + " )" ); }
            return new Rectangle();
        }

        //public native function getRect( targetCoordinateSpace:DisplayObject ):Rectangle;
        public function getRect( targetCoordinateSpace:DisplayObject ):Rectangle
        {
            CFG::dbg{ trace( "DisplayObject.getRect( " + targetCoordinateSpace + " )" ); }
            return new Rectangle();
        }

        public function hitTestObject( obj:DisplayObject ):Boolean
        {
            CFG::dbg{ trace( "DisplayObject.hitTestObject( " + obj + " )" ); }
            return _hitTest( false, 0, 0, false, obj );
        }
        
        public function hitTestPoint( x:Number, y:Number, shapeFlag:Boolean = false ):Boolean
        {
            CFG::dbg{ trace( "DisplayObject.hitTestPoint( " + [x,y,shapeFlag].join(", ") + " )" ); }
            return _hitTest( true, x, y, shapeFlag, null );
        }
        
        //private native function _hitTest( use_xy:Boolean, x:Number, y:Number, useShape:Boolean, hitTestObject:DisplayObject ):Boolean;
        private function _hitTest( use_xy:Boolean, x:Number, y:Number, useShape:Boolean, hitTestObject:DisplayObject ):Boolean
        {
            return false;
        }

    }
}
