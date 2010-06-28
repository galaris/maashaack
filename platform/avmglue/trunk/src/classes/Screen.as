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

    /* note:
       allow to define the screen(s) area in HostConfig ?
    */
    
    /**
     * The Screen class provides information about the display screens available to this application.
     * 
     * @langversion ActionScript 3.0
     * @playerversion AIR 1.0
     */
    [API(CONFIG::AIR_1_0)]
    public final class Screen extends EventDispatcher
    {
        private static var _screens:Array;
        private static var _mainScreen:Screen;
        
        private var _bounds:Rectangle;
        private var _visibleBounds:Rectangle;
        private var _colorDepth:int;
        
        public function Screen()
        {
            CFG::dbg{ trace( "new Screen()" ); }
            super();
        }

        //public static native function get screens():Array;
        [API(CONFIG::AIR_1_0)]
        public static function get screens():Array
        {
            CFG::dbg{ trace( "[static] Screen.get screens()" ); }
            return _screens;
        }

        [API(CONFIG::AIR_1_0)]
        public static function set screens( value:Array ):void
        {
            CFG::dbg{ trace( "[static] [flash_api] Screen.set screens( " + value + " )" ); }
            _screens = value;
        }

        //public static native function get mainScreen():Screen;
        [API(CONFIG::AIR_1_0)]
        public static native function get mainScreen():Screen
        {
            CFG::dbg{ trace( "[static] Screen.get mainScreen()" ); }
            return _mainScreen;
        }

        [API(CONFIG::AIR_1_0)]
        public static native function set mainScreen( value:Screen ):void
        {
            CFG::dbg{ trace( "[static] [flash_api] Screen.set mainScreen( " + value + " )" ); }
            _mainScreen = value;
        }

        //public static native function getScreensForRectangle(rect:Rectangle):Array;
        [API(CONFIG::AIR_1_0)]
        public static function getScreensForRectangle( rect:Rectangle ):Array
        {
            CFG::dbg{ trace( "[static] Screen.getScreensForRectangle( " + rect + " )" ); }
            //TODO
            return [];
        }


        //public native function get bounds():Rectangle;
        [API(CONFIG::AIR_1_0)]
        public function get bounds():Rectangle
        {
            CFG::dbg{ trace( "Screen.get bounds()" ); }
            return _bounds;
        }

        [API(CONFIG::AIR_1_0)]
        flash_api function set bounds( value:Rectangle ):void
        {
            CFG::dbg{ trace( "[flash_api] Screen.set bounds( " + value + " )" ); }
            _bounds = value;
        }
        
        //public native function get visibleBounds():Rectangle;
        [API(CONFIG::AIR_1_0)]
        public function get visibleBounds():Rectangle
        {
            CFG::dbg{ trace( "Screen.get visibleBounds()" ); }
            return _visibleBounds;
        }

        [API(CONFIG::AIR_1_0)]
        flash_api function set visibleBounds( value:Rectangle ):void
        {
            CFG::dbg{ trace( "[flash_api] Screen.set visibleBounds( " + value + " )" ); }
            _visibleBounds = value;
        }
        
        //public native function get colorDepth():int;
        [API(CONFIG::AIR_1_0)]
        public function get colorDepth():int
        {
            CFG::dbg{ trace( "Screen.get colorDepth()" ); }
            return _colorDepth;
        }

        [API(CONFIG::AIR_1_0)]
        flash_api function set colorDepth( value:int ):void
        {
            CFG::dbg{ trace( "[flash_api] Screen.set colorDepth( " + value + " )" ); }
            _colorDepth = value;
        }
    }
}
