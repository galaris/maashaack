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
    /**
     * The MovieClip class inherits from the following classes:
     * Sprite, DisplayObjectContainer, InteractiveObject, DisplayObject, and EventDispatcher.
     * 
     * Unlike the Sprite object, a MovieClip object has a timeline.
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 9
     * @playerversion AIR 1.0
     */
    public dynamic class MovieClip extends Sprite
    {
        private var _currentFrame:int;
        private var _framesLoaded:int;
        private var _totalFrames:int;
        private var _trackAsMenu:Boolean;
        private var _scenes:Array;
        private var _currentScene:Scene;
        private var _currentLabel:String;
        private var _currentFrameLabel:String;
        private var _enabled:Boolean;
    
        public function MovieClip()
        {
            CFG::dbg{ trace( "new MovieClip()" ); }
            super();
        }

        //public native function get currentFrame():int;
        public function get currentFrame():int
        {
            CFG::dbg{ trace( "MovieClip.get currentFrame()" ); }
            return _currentFrame;
        }

        //public native function get framesLoaded():int;
        public function get framesLoaded():int
        {
            CFG::dbg{ trace( "MovieClip.get framesLoaded()" ); }
            return _framesLoaded
        }

        //public native function get totalFrames():int;
        public function get totalFrames():int
        {
            CFG::dbg{ trace( "MovieClip.get totalFrames()" ); }
            return _totalFrames;
        }

        //public native function get trackAsMenu():Boolean;
        public function get trackAsMenu():Boolean
        {
            CFG::dbg{ trace( "MovieClip.get trackAsMenu()" ); }
            return _trackAsMenu;
        }

        //public native function set trackAsMenu( value:Boolean ):void;
        public native function set trackAsMenu( value:Boolean ):void
        {
            CFG::dbg{ trace( "MovieClip.set trackAsMenu( " + value + " )" ); }
            _trackAsMenu = value;
        }

        //public native function get scenes():Array;
        public function get scenes():Array
        {
            CFG::dbg{ trace( "MovieClip.get scenes()" ); }
            return _scenes;
        }

        //public native function get currentScene():Scene;
        public function get currentScene():Scene
        {
            CFG::dbg{ trace( "MovieClip.get currentScene()" ); }
            return _currentScene;
        }

        //public native function get currentLabel():String;
        public function get currentLabel():String
        {
            CFG::dbg{ trace( "MovieClip.get currentLabel()" ); }
            return _currentLabel;
        }

        //public native function get currentFrameLabel():String;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function get currentFrameLabel():String
        {
            CFG::dbg{ trace( "MovieClip.get currentFrameLabel()" ); }
            return _currentFrameLabel;
        }

        //public native function get enabled():Boolean;
        public function get enabled():Boolean
        {
            CFG::dbg{ trace( "MovieClip.get enabled()" ); }
            return _enabled;
        }

        //public native function set enabled( value:Boolean ):void;
        public function set enabled( value:Boolean ):void
        {
            CFG::dbg{ trace( "MovieClip.set enabled( " + value + " )" ); }
            _enabled = value;
        }

        public function get currentLabels():Array
        {
            CFG::dbg{ trace( "MovieClip.get currentLabels()" ); }
            return currentScene.labels;
        }

        //public native function play():void;
        public function play():void
        {
            CFG::dbg{ trace( "MovieClip.play()" ); }
        }

        //public native function stop():void;
        public function stop():void
        {
            CFG::dbg{ trace( "MovieClip.stop()" ); }
        }

        //public native function nextFrame():void;
        public function nextFrame():void
        {
            CFG::dbg{ trace( "MovieClip.nextFrame()" ); }
        }

        //public native function prevFrame():void;
        public function prevFrame():void
        {
            CFG::dbg{ trace( "MovieClip.prevFrame()" ); }
        }

        //public native function gotoAndPlay( frame:Object, scene:String = null ):void;
        public function gotoAndPlay( frame:Object, scene:String = null ):void
        {
            CFG::dbg{ trace( "MovieClip.gotoAndPlay( " + [frame,scene].join(", ") + " )" ); }
        }

        //public native function gotoAndStop( frame:Object, scene:String = null ):void;
        public function gotoAndStop( frame:Object, scene:String = null ):void
        {
            CFG::dbg{ trace( "MovieClip.gotoAndStop( " + [frame,scene].join(", ") + " )" ); }
        }

        //public native function addFrameScript( ...args ):void;
        public function addFrameScript( ...args ):void
        {
            CFG::dbg{ trace( "MovieClip.addFrameScript( " + args + " )" ); }
        }

        //public native function prevScene():void;
        public function prevScene():void
        {
            CFG::dbg{ trace( "MovieClip.prevScene()" ); }
        }

        //public native function nextScene():void;
        public function nextScene():void
        {
            CFG::dbg{ trace( "MovieClip.nextScene()" ); }
        }

    }
}
