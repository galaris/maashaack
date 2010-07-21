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
     * The Bitmap class represents display objects that represent bitmap images.
     * These can be images that you load with the <code>flash.display.Loader</code> class,
     * or they can be images that you create with the <code>Bitmap()</code> constructor.
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 9
     * @playerversion AIR 1.0
     */
    public class Bitmap extends DisplayObject
    {

        private var _bitmapData:BitmapData;
        private var _pixelSnapping:String;
        private var _smoothing:Boolean;
        
        public function Bitmap( bitmapData:BitmapData = null, pixelSnapping:String = "auto", smoothing:Boolean = false )
        {
            CFG::dbg{ trace( "new Bitmap( " + [bitmapData,pixelSnapping,smoothing].join(", ") + " )" ); }
            super();

            ctor( bitmapData, pixelSnapping, smoothing );
        }

        //private native function ctor( bitmapData:BitmapData, pixelSnapping:String, smoothing:Boolean ):void;
        private function ctor( bitmapData:BitmapData, pixelSnapping:String, smoothing:Boolean ):void
        {
            _bitmapData    = bitmapData;
            _pixelSnapping = pixelSnapping;
            _smoothing     = smoothing;
        }

        //public native function get pixelSnapping():String;
        public function get pixelSnapping():String
        {
            CFG::dbg{ trace( "Bitmap.get pixelSnapping()" ); }
            return _pixelSnapping;
        }

        //public native function set pixelSnapping( value:String ):void;
        public function set pixelSnapping( value:String ):void
        {
            CFG::dbg{ trace( "Bitmap.set pixelSnapping( " + value + " )" ); }
            _pixelSnapping = value;
        }

        //public native function get smoothing():Boolean;
        public function get smoothing():Boolean
        {
            CFG::dbg{ trace( "Bitmap.get smoothing()" ); }
            return _smoothing;
        }

        //public native function set smoothing( value:Boolean ):void;
        public function set smoothing( value:Boolean ):void
        {
            CFG::dbg{ trace( "Bitmap.set smoothing( " + value + " )" ); }
            _smoothing = value;
        }

        //public native function get bitmapData():BitmapData;
        public function get bitmapData():BitmapData
        {
            CFG::dbg{ trace( "Bitmap.get bitmapData()" ); }
            return _bitmapData;
        }

        //public native function set bitmapData( value:BitmapData ):void;
        public function set bitmapData( value:BitmapData ):void
        {
            CFG::dbg{ trace( "Bitmap.set bitmapData( " + value + " )" ); }
            _bitmapData = value;
        }
    }
}
