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

package
{
    public final class Math
    {
        public static const E:Number = 2.71828182845905;
        public static const LN10:Number = 2.302585092994046;
        public static const LN2:Number = 0.6931471805599453;
        public static const LOG10E:Number = 0.4342944819032518;
        public static const LOG2E:Number = 1.442695040888963387;
        public static const PI:Number = 3.141592653589793;
        public static const SQRT1_2:Number = 0.7071067811865476;
        public static const SQRT2:Number = 1.4142135623730951;
        public native static function abs( val:Number ):Number;
        public native static function acos( val:Number ):Number;
        public native static function asin( val:Number ):Number;
        public native static function atan( val:Number ):Number;
        public native static function atan2( y:Number, x:Number ):Number;
        public native static function ceil( val:Number ):Number;
        public native static function cos( angleRadians:Number ):Number;
        public native static function exp( val:Number ):Number;
        public native static function floor( val:Number ):Number;
        public native static function log( val:Number ):Number;
        public native static function max( val1:Number, val2:Number, ...rest ):Number;
        public native static function min( val1:Number, val2:Number, ... rest ):Number;
        public native static function pow( val1:Number, val2:Number ):Number;
        public native static function random():Number;
        public native static function round( val:Number ):Number;
        public native static function sin( angleRadians:Number ):Number;
        public native static function sqrt( val:Number ):Number;
        public native static function tan( angleRadians:Number ):Number;
    }
}