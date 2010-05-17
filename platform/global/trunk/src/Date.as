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
    public final dynamic class Date
    {
        public static const length:int = 7;
        public function get fullYear():Number { return getFullYear(); }
        public function set fullYear(value:Number):void { setFullYear(value); }
        public function get month():Number { return getMonth(); }
        public function set month(value:Number):void { setMonth(value); }
        public function get date():Number { return getDate(); }
        public function set date(value:Number):void { setDate(value); }
        public function get hours():Number { return getHours(); }
        public function set hours(value:Number):void { setHours(value); }
        public function get minutes():Number { return getMinutes(); }
        public function set minutes(value:Number):void { setMinutes(value); }
        public function get seconds():Number { return getSeconds(); }
        public function set seconds(value:Number):void { setSeconds(value); }
        public function get milliseconds():Number { return getMilliseconds(); }
        public function set milliseconds(value:Number):void { setMilliseconds(value); }
        public function get fullYearUTC():Number { return getUTCFullYear(); }
        public function set fullYearUTC(value:Number):void { setUTCFullYear(value); }
        public function get monthUTC():Number { return getUTCMonth(); }
        public function set monthUTC(value:Number):void { setUTCMonth(value); }
        public function get dateUTC():Number { return getUTCDate(); }
        public function set dateUTC(value:Number):void { setUTCDate(value); }
        public function get hoursUTC():Number { return getUTCHours(); }
        public function set hoursUTC(value:Number):void { setUTCHours(value); }
        public function get minutesUTC():Number { return getUTCMinutes(); }
        public function set minutesUTC(value:Number):void { setUTCMinutes(value); }
        public function get secondsUTC():Number { return getUTCSeconds(); }
        public function set secondsUTC(value:Number):void { setUTCSeconds(value); }
        public function get millisecondsUTC():Number { return getUTCMilliseconds(); }
        public function set millisecondsUTC(value:Number):void { setUTCMilliseconds(value); }
        public function get time():Number { return getTime(); }
        public function set time(value:Number):void { setTime(value); }
        public function get timezoneOffset():Number { return getTimezoneOffset(); }
        public function get day():Number { return getDay(); }
        public function get dayUTC():Number { return getUTCDay(); }
        public native static function UTC( year:Number, month:Number, date:Number = 1, hour:Number = 0,
                                           minute:Number = 0, second:Number = 0, millisecond:Number = 0 ):Number;
        public native function Date( yearOrTimevalue:Object, month:Number, date:Number = 1, hour:Number = 0,
                                     minute:Number = 0, second:Number = 0, millisecond:Number = 0 );
        public native function getDate():Number;
        public native function getDay():Number;
        public native function getFullYear():Number;
        public native function getHours():Number;
        public native function getMilliseconds():Number;
        public native function getMinutes():Number;
        public native function getMonth():Number;
        public native function getSeconds():Number;
        public native function getTime():Number;
        public native function getTimezoneOffset():Number;
        public native function getUTCDate():Number;
        public native function getUTCDay():Number;
        public native function getUTCFullYear():Number;
        public native function getUTCHours():Number;
        public native function getUTCMilliseconds():Number;
        public native function getUTCMinutes():Number;
        public native function getUTCMonth():Number;
        public native function getUTCSeconds():Number;
        public native function getUTCYear():Number;
        public native function getYear():Number;
        public native static function parse(date:String):Number;
        public native function setDate(day:Number):Number;
        public native function setFullYear(year:Number, month:Number, day:Number):Number;
        public native function setHours(hour:Number, minute:Number, second:Number, millisecond:Number):Number;
        public native function setMilliseconds(millisecond:Number):Number;
        public native function setMinutes(minute:Number, second:Number, millisecond:Number):Number;
        public native function setMonth(month:Number, day:Number):Number;
        public native function setSeconds(second:Number, millisecond:Number):Number;
        public native function setTime(millisecond:Number):Number;
        public native function setUTCDate(day:Number):Number;
        public native function setUTCFullYear(year:Number, month:Number, day:Number):Number;
        public native function setUTCHours(hour:Number, minute:Number, second:Number, millisecond:Number):Number;
        public native function setUTCMilliseconds(millisecond:Number):Number;
        public native function setUTCMinutes(minute:Number, second:Number, millisecond:Number):Number;
        public native function setUTCMonth(month:Number, day:Number):Number;
        public native function setUTCSeconds(second:Number, millisecond:Number):Number;
        public native function setYear(year:Number):Number;
        public native function toDateString():String;
        public native function toTimeString():String;
        public native function toLocaleString():String;
        public native function toLocaleDateString():String;
        public native function toLocaleTimeString():String;
        public native function toUTCString():String;
        public native function toString():String;
        public native function valueOf():Number;
    }

}