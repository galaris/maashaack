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
    public final dynamic class XML extends Object
    {
        public static const length:int = 1;
        public native static function defaultSettings():Object;
        public native static function setSettings( ...rest ):void;
        public native static function settings():Object;
        public native static function get ignoreComments():Boolean;
        public native static function set ignoreComments( newIgnore:Boolean ):void;
        public native static function get ignoreProcessingInstructions():Boolean;
        public native static function set ignoreProcessingInstructions( newIgnore:Boolean ):void;
        public native static function get ignoreWhitespace():Boolean;
        public native static function set ignoreWhitespace( newIgnore:Boolean ):void;
        public native static function get prettyPrinting():Boolean;
        public native static function set prettyPrinting( newPretty:Boolean ):void;
        public native static function get prettyIndent():int;
        public native static function set prettyIndent( newIndent:int ):void;
        public native function XML( value:Object );
        public native function addNamespace( ns:Object ):XML;
        public native function appendChild( child:Object ):XML;
        public native function attribute( attributeName:* ):XMLList;
        public native function attributes():XMLList;
        public native function child( propertyName:Object ):XMLList;
        public native function childIndex():int;
        public native function children():XMLList;
        public native function comments():XMLList;
        public native function contains( value:XML ):Boolean;
        public native function copy():XML;
        public native function descendants( name:Object = "*" ):XMLList;
        public native function elements( name:Object = "*" ):XMLList;
        public native function hasOwnProperty( p:String ):Boolean;
        public native function hasComplexContent():Boolean;
        public native function hasSimpleContent():Boolean;
        public native function inScopeNamespaces():Array;
        public native function insertChildAfter( child1:Object, child2:Object ):*;
        public native function insertChildBefore( child1:Object, child2:Object ):*;
        public native function length():int;
        public native function localName():Object;
        public native function name():Object;
        public native function namespace( prefix:String = null ):*;
        public native function namespaceDeclarations(): Array;
        public native function nodeKind():String;
        public native function normalize():XML;
        public native function parent():*;
        public native function processingInstructions( name:String = "*" ):XMLList;
        public native function prependChild( value:Object ):XML;
        public native function propertyIsEnumerable( p:String ):Boolean;
        public native function removeNamespace( ns:Namespace ):XML;
        public native function replace( propertyName:Object, value:XML ):XML
        public native function setChildren( value:Object ):XML;
        public native function setLocalName( name:String ):void;
        public native function setName( name:String ):void;
        public native function setNamespace( ns:Namespace ):void;
        public native function text():XMLList;
        public native function toXMLString():String;
        public native function toString():String;
        public native function valueOf():XML;
    }
}