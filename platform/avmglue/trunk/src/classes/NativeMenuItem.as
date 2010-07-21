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
    import flash.ui.*;
    import flash.events.*;
    
    /**
     * The NativeMenuItem class represents a single item in a menu.
     * 
     * @langversion ActionScript 3.0
     * @playerversion AIR 1.0
     */
    [API(CONFIG::AIR_1_0)]
    public class NativeMenuItem extends EventDispatcher
    {
        private static const kInvalidCallError:uint = 2037;

        private var __mnemonicIndex:int;
        private var __submenu:NativeMenu;
        
        private var _enabled:Boolean;
        private var _menu:NativeMenu;
        private var _name:String;
        private var _separator:Boolean;
        private var _checked:Boolean;
        private var _label:String;
        private var _keyEquivalent:String;
        private var _keyEquivalentModifiers:Array;
        private var _data:Object;

        

        public function NativeMenuItem( label:String = "", isSeparator:Boolean = false )
        {
            CFG::dbg{ trace( "new NativeMenuItem( " + [label,isSeparator].join(", ") + " )" ); }
            super();

            ctor( label, isSeparator );
        }
        
        //private native function ctor( label:String, isSeparator:Boolean ):void;
        private function ctor( label:String, isSeparator:Boolean ):void
        {
            _label     = label;
            _separator = isSeparator;
        }

        //private native function set _mnemonicIndex( value:int ):void;
        private function set _mnemonicIndex( value:int ):void
        {
            __mnemonicIndex = value;
        }

        //private native function set _submenu( value:NativeMenu ):void;
        private function set _submenu( value:NativeMenu ):void
        {
            __submenu = value;
        }

        //private native function _menuPerformKeyEquivalent( menu:NativeMenu, event:KeyboardEvent ):Boolean;
        private function _menuPerformKeyEquivalent( menu:NativeMenu, event:KeyboardEvent ):Boolean
        {
            return false;
        }

        //private native function select():void;
        private function select():void
        {
            
        }

        private function performKeyEquivalent( event:KeyboardEvent ):Boolean
        {
            var mods:Array;
            var performed:Boolean;
            
            if( submenu )
            {
                performed = _menuPerformKeyEquivalent( submenu, event );
            }
            else if( !isSeparator && enabled )
            {
                if( keyEquivalent && (keyEquivalent.length > 0) && (keyEquivalent.charCodeAt( 0 ) == event.charCode) )
                {
                    mods = (keyEquivalentModifiers) ? keyEquivalentModifiers : new Array();
                    
                    if( !((mods.indexOf(Keyboard.CONTROL)   == -1) == event.controlKey) &&
                        !((mods.indexOf(Keyboard.SHIFT)     == -1) == event.shiftKey) &&
                        !((mods.indexOf(Keyboard.ALTERNATE) == -1) == event.altKey) &&
                        !((mods.indexOf(Keyboard.COMMAND)   == -1) == event.commandKey) &&
                        !((mods.indexOf(Keyboard.NUMPAD)    == -1) == event.keyLocation == KeyLocation.NUM_PAD) )
                    {
                        select();
                        performed = true;
                    }
                }
            }
            
            return performed;
        }

        private function formatToString( className:String, ...args ):String
        {
            var name:String;
            var value:*;
            
            var s:String = "";
                s += "[" + className;

            var i:uint = 0;
            while( i < args.length )
            {
                name  = args[i];
                value = this[name];
                
                if( value is String )
                {
                    s += " " + name + "=\"" + value + "\"";
                }
                else if( (value is Array) && !(value == null) )
                {
                    s += " " + name + "={ ";
                    s += value.toString();
                    s += " }";
                }
                else
                {
                    s += " " + name + "=" + value;
                }

                i++;
            }
            
            s += "]";
            return s;
        }

        private function get keyEquivalentChar():int
        {
            if( !(keyEquivalent == null) && (keyEquivalent.length > 0) )
            {
                return keyEquivalent.charCodeAt( 0 );
            }
            
            return 0;
        }
        
        
        //public native function get enabled():Boolean;
        [API(CONFIG::AIR_1_0)]
        public function get enabled():Boolean
        {
            CFG::dbg{ trace( "NativeMenuItem.get enabled()" ); }
            return _enabled;
        }

        //public native function set enabled( value:Boolean ):void;
        [API(CONFIG::AIR_1_0)]
        public function set enabled( value:Boolean ):void
        {
            CFG::dbg{ trace( "NativeMenuItem.set enabled( " + value + " )" ); }
            _enabled = value;
        }

        //public native function get menu():NativeMenu;
        [API(CONFIG::AIR_1_0)]
        public function get menu():NativeMenu
        {
            CFG::dbg{ trace( "NativeMenuItem.get menu()" ); }
            return _menu
        }

        //public native function get name():String;
        [API(CONFIG::AIR_1_0)]
        public function get name():String
        {
            CFG::dbg{ trace( "NativeMenuItem.get name()" ); }
            return _name;
        }

        //public native function set name( value:String ):void;
        [API(CONFIG::AIR_1_0)]
        public function set name( value:String ):void
        {
            CFG::dbg{ trace( "NativeMenuItem.set name( " + value + " )" ); }
            _name = value;
        }

        //public native function get isSeparator():Boolean;
        [API(CONFIG::AIR_1_0)]
        public function get isSeparator():Boolean
        {
            CFG::dbg{ trace( "NativeMenuItem.get isSeparator()" ); }
            return _separator;
        }

        //public native function get checked():Boolean;
        [API(CONFIG::AIR_1_0)]
        public function get checked():Boolean
        {
            CFG::dbg{ trace( "NativeMenuItem.get checked()" ); }
            return _checked;
        }

        //public native function set checked( value:Boolean ):void;
        [API(CONFIG::AIR_1_0)]
        public function set checked( value:Boolean ):void
        {
            CFG::dbg{ trace( "NativeMenuItem.set checked( " + value + " )" ); }
            _checked = value;
        }

        //public native function get label():String;
        [API(CONFIG::AIR_1_0)]
        public function get label():String
        {
            CFG::dbg{ trace( "NativeMenuItem.get label()" ); }
            return _label;
        }

        //public native function set label( value:String ):void;
        [API(CONFIG::AIR_1_0)]
        public function set label( value:String ):void
        {
            CFG::dbg{ trace( "NativeMenuItem.set label( " + value + " )" ); }
            _label = value;
        }

        //public native function get keyEquivalent():String;
        [API(CONFIG::AIR_1_0)]
        public function get keyEquivalent():String
        {
            CFG::dbg{ trace( "NativeMenuItem.get keyEquivalent()" ); }
            return _keyEquivalent;
        }

        //public native function set keyEquivalent( value:String ):void;
        [API(CONFIG::AIR_1_0)]
        public function set keyEquivalent( value:String ):void
        {
            CFG::dbg{ trace( "NativeMenuItem.set keyEquivalent( " + value + " )" ); }
            _keyEquivalent = value;
        }

        //public native function get keyEquivalentModifiers():Array;
        [API(CONFIG::AIR_1_0)]
        public function get keyEquivalentModifiers():Array
        {
            CFG::dbg{ trace( "NativeMenuItem.get keyEquivalentModifiers()" ); }
            return _keyEquivalentModifiers
        }

        //public native function set keyEquivalentModifiers( value:Array ):void;
        [API(CONFIG::AIR_1_0)]
        public function set keyEquivalentModifiers( value:Array ):void
        {
            CFG::dbg{ trace( "NativeMenuItem.set keyEquivalentModifiers( " + value + " )" ); }
            _keyEquivalentModifiers = value;
        }

        //public native function get mnemonicIndex():int;
        [API(CONFIG::AIR_1_0)]
        public function get mnemonicIndex():int
        {
            CFG::dbg{ trace( "NativeMenuItem.get mnemonicIndex()" ); }
            return __mnemonicIndex;
        }

        [API(CONFIG::AIR_1_0)]
        public function set mnemonicIndex( index:int ):void
        {
            CFG::dbg{ trace( "NativeMenuItem.set mnemonicIndex( " + value + " )" ); }
            if( (index >= label.length) || (index < -1) )
            {
                Error.throwError( RangeError, 2006 );
            }
            
            _mnemonicIndex = index;
        }

        //public native function get submenu():NativeMenu;
        [API(CONFIG::AIR_1_0)]
        public function get submenu():NativeMenu
        {
            CFG::dbg{ trace( "NativeMenuItem.get submenu()" ); }
            return __submenu;
        }

        [API(CONFIG::AIR_1_0)]
        public function set submenu(submenu:NativeMenu):void
        {
            CFG::dbg{ trace( "NativeMenuItem.set submenu( " + value + " )" ); }
            var parentMenu:NativeMenu;
            var parentItem:NativeMenuItem;
            var i:int;
            
            if( isSeparator )
            {
                Error.throwError( IllegalOperationError, kInvalidCallError );
            }
            
            if( submenu )
            {
                parentMenu = submenu.parent;
                if( parentMenu )
                {
                    i = 0;
                    while( i < parentMenu.numItems )
                    {
                        parentItem = parentMenu.getItemAt( i );
                        if( parentItem.submenu == submenu )
                        {
                            parentItem.submenu = null;
                        }
                        i++;
                    }
                }
            }
            
            _submenu = submenu;
        }

        //public native function get data():Object;
        [API(CONFIG::AIR_1_0)]
        public function get data():Object
        {
            CFG::dbg{ trace( "NativeMenuItem.get data()" ); }
            return _data;
        }

        //public native function set data( value:Object ):void;
        [API(CONFIG::AIR_1_0)]
        public function set data( value:Object ):void
        {
            CFG::dbg{ trace( "NativeMenuItem.set data( " + value + " )" ); }
            _data = value;
        }

        [API(CONFIG::AIR_1_0)]
        public function clone():NativeMenuItem
        {
            CFG::dbg{ trace( "NativeMenuItem.clone()" ); }
            var newMenuItem:NativeMenuItem = new NativeMenuItem( label, isSeparator );
                newMenuItem.name                   = name;
                newMenuItem.enabled                = enabled;
                newMenuItem.checked                = checked;
                newMenuItem.keyEquivalent          = keyEquivalent;
                newMenuItem.keyEquivalentModifiers = keyEquivalentModifiers;
                newMenuItem.mnemonicIndex          = mnemonicIndex;
                newMenuItem.submenu                = (submenu) ? submenu.clone() : null;
                
            return newMenuItem;
        }

        [API(CONFIG::AIR_1_0)]
        override public function toString():String
        {
            CFG::dbg{ trace( "NativeMenuItem.toString()" ); }
            return formatToString( "NativeMenuItem", "label", "keyEquivalent", "keyEquivalentChar", "keyEquivalentModifiers" );
        }

    }
}
