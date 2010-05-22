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
    public dynamic class Array
    {
        public static const CASEINSENSITIVE:uint = 1;
        public static const DESCENDING:uint = 2;
        public static const NUMERIC:uint = 16;
        public static const RETURNINDEXEDARRAY:uint = 8;
        public static const UNIQUESORT:uint = 4;
    
        [Inspectable(environment="none")]
        public static const length:int = 1;
        public native function Array( numElements:int = 0 );
        //public native function Array(...values);
        public native function get length():uint;
        public native function set length( newLength:uint ):void;
        public native function concat(...args):Array;
        public native function every( callback:Function, thisObject:* = null ):Boolean;
        public native function filter( callback:Function, thisObject:* = null ):Array;
        public native function forEach( callback:Function, thisObject:* = null ):void;
        public native function indexOf( searchElement:*, fromIndex:int = 0 ):int;
        public native function join( sep:* ):String;
        public native function lastIndexOf( searchElement:*, fromIndex:int=0x7fffffff ):int;
        public native function map( callback:Function, thisObject:* = null ):Array
        public native function pop():Object;
        public native function push( ...args):uint;
        public native function reverse():Array;
        public native function shift():Object;
        public native function slice(startIndex:int=0, endIndex:int=-1):Array;
        public native function some( callback:Function, thisObject:* = null ):Boolean;
        public native function sort( ...args ):Array; 
        public native function sortOn( fieldName:Object, options:Object = null ):Array; // 'key' is a String, or an Array of String. 'options' is optional.
        public native function splice( startIndex:int, deleteCount:uint, ...values ):Array;
        public native function unshift( ...args ):uint;
        public native function toLocaleString():String;
        public native function toString():String;
    }
}