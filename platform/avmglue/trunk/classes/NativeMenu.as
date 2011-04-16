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
    import flash.events.*;
    
    /**
     * The NativeMenu class contains methods and properties for defining native menus.
     * 
     * @langversion ActionScript 3.0
     * @playerversion AIR 1.0
     */
    [API(CONFIG::AIR_1_0)]
    public class NativeMenu extends EventDispatcher
    {
        private var __items:Array;

        private var _parent:NativeMenu;
        
        public function NativeMenu()
        {
            CFG::dbg{ trace( "new NativeMenu()" ); }
            super();

            _ctor();
        }

        private function _ctor():void
        {
            __items = [];
        }
        
        //private native function get _numItems():int;
        private function get _numItems():int
        {
            return __items.length;
        }

        //private native function _addItemAt( item:NativeMenuItem, index:int ):NativeMenuItem;
        private function _addItemAt( item:NativeMenuItem, index:int ):NativeMenuItem
        {
            __items == __items.splice( index, 0, item );
        }

        //private native function _containsItem( item:NativeMenuItem ):Boolean;
        private function _containsItem( item:NativeMenuItem ):Boolean
        {
            return __items.indexOf( item ) > -1;
        }

        //private native function _getItemAt( index:int ):NativeMenuItem;
        private function _getItemAt( index:int ):NativeMenuItem
        {
            if( __items[ index ] )
            {
                return __items[ index ]
            }

            return null;
        }

        //private native function _getItemByName( name:String ):NativeMenuItem;
        private function _getItemByName( name:String ):NativeMenuItem
        {
            var i:uint;
            for( i=0; i<__items.length; i++ )
            {
                if( __items[i].name == name )
                {
                    return __items[i];
                }
            }

            return null;
        }

        //private native function _removeItemAt( index:int ):NativeMenuItem;
        private function _removeItemAt( index:int ):NativeMenuItem
        {
            if( __items[index] )
            {
                var found:NativeMenuItem = __items[index];
                __items = __items.splice( index, 1 );
                return found;
            }

            return null;
        }

        //private native function _getItemIndex( item:NativeMenuItem ):int;
        private function _getItemIndex( item:NativeMenuItem ):int
        {
            return __items.indexOf( item );
        }

        //private native function _display( stage:Stage, stageX:Number, stageY:Number ):void;
        private function _display( stage:Stage, stageX:Number, stageY:Number ):void
        {
        
        }

        //public static native function get isSupported():Boolean;
        [API(CONFIG::AIR_2_0)]
        public static function get isSupported():Boolean
        {
            CFG::dbg{ trace( "[static] NativeMenu.get isSupported()" ); }
            return false;
        }


        //public native function get parent():NativeMenu;
        [API(CONFIG::AIR_1_0)]
        public function get parent():NativeMenu
        {
            CFG::dbg{ trace( "NativeMenu.get parent()" ); }
            return _parent;
        }

        [API(CONFIG::AIR_1_0)]
        public function get numItems():int
        {
            CFG::dbg{ trace( "NativeMenu.get numItems()" ); }
            return _numItems;
        }
        
        [API(CONFIG::AIR_1_0)]
        public function get items():Array
        {
            CFG::dbg{ trace( "NativeMenu.get items()" ); }
            var itemArray:Array = [];
            
            var i:int = 0;
            while( i < _numItems )
            {
                itemArray.push( getItemAt( i ) );
                i++;
            }
            
            return itemArray;
        }

        [API(CONFIG::AIR_1_0)]
        public function set items( itemArray:Array ):void
        {
            CFG::dbg{ trace( "NativeMenu.set items( " + itemArray + " )" ); }
            var i:int = 0;
            while( i < itemArray.length )
            {
                if( !(itemArray[i] is NativeMenuItem) )
                {
                    Error.throwError( ArgumentError, 2005 );
                }
                i++;
            }
            
            removeAllItems();
            i = 0;
            while( i < itemArray.length )
            {
                addItem( itemArray[i] );
                i++;
            }
        }

        [API(CONFIG::AIR_1_0)]
        public function addItem( item:NativeMenuItem ):NativeMenuItem
        {
            CFG::dbg{ trace( "NativeMenu.addItem( " + item + " )" ); }
            return addItemAt( item, numItems );
        }

        [API(CONFIG::AIR_1_0)]
        public function addItemAt( item:NativeMenuItem, index:int ):NativeMenuItem
        {
            CFG::dbg{ trace( "NativeMenu.addItemAt( " + [item,index].join(", ") + " )" ); }
            if( (index > _numItems) || (index < 0) )
            {
                Error.throwError( RangeError, 2006 );
            }
            
            if( item == null )
            {
                Error.throwError( ArgumentError, 2007, "item" );
            }
            
            if( item.menu != null )
            {
                Error.throwError( ArgumentError, 2004, "item" );
            }
            
            return _addItemAt( item, index );
        }

        [API(CONFIG::AIR_1_0)]
        public function containsItem( item:NativeMenuItem ):Boolean
        {
            CFG::dbg{ trace( "NativeMenu.containsItem( " + item + " )" ); }
            if( item == null )
            {
                Error.throwError( ArgumentError, 2007, "item" );
            }
            
            return _containsItem( item );
        }
        
        [API(CONFIG::AIR_1_0)]
        public function getItemAt( index:int ):NativeMenuItem
        {
            CFG::dbg{ trace( "NativeMenu.getItemAt( " + index + " )" ); }
            if( (index >= _numItems) || (index < 0) )
            {
                Error.throwError( RangeError, 2006 );
            }
            
            return _getItemAt( index );
        }
        
        [API(CONFIG::AIR_1_0)]
        public function getItemByName( name:String ):NativeMenuItem
        {
            CFG::dbg{ trace( "NativeMenu.getItemByName( " + name + " )" ); }
            if( name == null )
            {
                Error.throwError( ArgumentError, 2007, "name" );
            }
            
            return _getItemByName( name );
        }
        
        [API(CONFIG::AIR_1_0)]
        public function removeItem( item:NativeMenuItem ):NativeMenuItem
        {
            CFG::dbg{ trace( "NativeMenu.removeItem( " + item + " )" ); }
            if( item == null )
            {
                Error.throwError( ArgumentError, 2007, "item" );
            }
            
            var index:int = getItemIndex( item );
            return removeItemAt( index );
        }

        [API(CONFIG::AIR_1_0)]
        public function removeItemAt( index:int ):NativeMenuItem
        {
            CFG::dbg{ trace( "NativeMenu.removeItemAt( " + index + " )" ); }
            if( (index >= _numItems) || (index < 0) )
            {
                Error.throwError( RangeError, 2006 );
            }
            
            return _removeItemAt( index );
        }

        [API(CONFIG::AIR_1_0)]
        public function removeAllItems():void
        {
            CFG::dbg{ trace( "NativeMenu.removeAllItems()" ); }
            var nbItems:int = numItems;
            var i:int = 0;
            while( i < nbItems )
            {
                removeItemAt( 0 );
                i++;
            }
        }

        [API(CONFIG::AIR_1_0)]
        public function getItemIndex( item:NativeMenuItem ):int
        {
            CFG::dbg{ trace( "NativeMenu.getItemIndex( " + item + " )" ); }
            if( item == null )
            {
                Error.throwError( ArgumentError, 2007, "item" );
            }
            
            return _getItemIndex( item );
        }

        [API(CONFIG::AIR_1_0)]
        public function setItemIndex( item:NativeMenuItem, index:int ):void
        {
            CFG::dbg{ trace( "NativeMenu.setItemIndex( " + [item,index].join(", ") + " )" ); }
            if( (index >= _numItems) || (index < 0) )
            {
                Error.throwError( RangeError, 2006 );
            }
            
            if( item == null )
            {
                Error.throwError( ArgumentError, 2007, "item" );
            }
            
            var currentIndex:int = getItemIndex( item );
            if( currentIndex != -1 )
            {
                removeItemAt( currentIndex );
            }
            addItemAt( item, index );
        }

        [API(CONFIG::AIR_1_0)]
        public function addSubmenuAt( submenu:NativeMenu, index:int, label:String ):NativeMenuItem
        {
            CFG::dbg{ trace( "NativeMenu.addSubmenuAt( " + [submenu,index,label].join(", ") + " )" ); }
            var item:NativeMenuItem = new NativeMenuItem( label );
                item.submenu = submenu;

            return addItemAt( item, index );
        }

        [API(CONFIG::AIR_1_0)]
        public function addSubmenu( submenu:NativeMenu, label:String ):NativeMenuItem
        {
            CFG::dbg{ trace( "NativeMenu.addSubmenu( " + [submenu,label].join(", ") + " )" ); }
            return addSubmenuAt( submenu, numItems, label );
        }

        [API(CONFIG::AIR_1_0)]
        public function display( stage:Stage, stageX:Number, stageY:Number ):void
        {
            CFG::dbg{ trace( "NativeMenu.display( " + [stage,stageX,stageY].join(", ") + " )" ); }
            _display( stage, stageX, stageY );
        }

        [API(CONFIG::AIR_1_0)]
        public function clone():NativeMenu
        {
            CFG::dbg{ trace( "NativeMenu.clone()" ); }
            var newMenu:NativeMenu = new NativeMenu();
            
            var i:int = 0;
            while( i < numItems )
            {
                newMenu.addItem( getItemAt( i ).clone() );
                i++;
            }
            
            return newMenu;
        }

        /*
        private function performKeyEquivalent(event:KeyboardEvent):Boolean
        {
            var i:int;
            var performed:Boolean;
            i = 0;
            while (i < this.numItems) {
                if (this._menuItemPerformKeyEquivalent(this.getItemAt(i), event)){
                    performed = true;
                    break;
                };
                i++;
            };
            return (performed);
        }
        
        private native function _menuItemPerformKeyEquivalent(item:NativeMenuItem, event:KeyboardEvent):Boolean;
        */

        /*
        public function dispatchContextMenuSelect( event:MouseEvent )
        {
            dispatchEvent( new ContextMenuEvent( ContextMenuEvent.MENU_SELECT,
                                                 false,
                                                 false,
                                                 (event.target as InteractiveObject),
                                                 (event.currentTarget as InteractiveObject) ) );
        }
        */
        
    }
}
