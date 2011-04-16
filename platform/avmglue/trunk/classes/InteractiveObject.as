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
    import flash.accessibility.*;
    import flash.ui.*;
    import flash.desktop.*;
    import flash.net.*;

    /**
     * The InteractiveObject class is the abstract base class for all display objects with which the user can interact,
     * using the mouse, keyboard, or other user input device.
     * 
     * You cannot instantiate the InteractiveObject class directly.
     * A call to the <code>new InteractiveObject()</code> constructor throws an <code>ArgumentError</code> exception.
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 9
     * @playerversion AIR 1.0
     */
    public class InteractiveObject extends DisplayObject
    {

        private var m_contextMenu:NativeMenu = null;
        private var _cutItem:NativeMenuItem;
        private var _copyItem:NativeMenuItem;
        private var _deleteItem:NativeMenuItem;
        private var _pasteItem:NativeMenuItem;
        private var _selectAllItem:NativeMenuItem;
    
        public function InteractiveObject()
        {
            CFG::dbg{ trace( "new InteractiveObject()" ); }
            super();

            if( this is DisplayObjectContainer )
            {
                return;
            }

            _constructInteractiveObject();
            addEventListener( MouseEvent.CONTEXT_MENU, onContextMenuEvent, false, -1, true );
        }

        private native function _constructInteractiveObject():void;

        private native function _getEditString(key:String):String;

        private native function _setContextMenuOwner():void;

        private native function _isRichTextEditor():Boolean;

        private native function _getTextLinkAtMouse(event:MouseEvent):String;

        private native function _textCanCut():Boolean;

        private native function _textCanCopy():Boolean;

        private native function _textCanPaste():Boolean;

        private native function _textCanClear():Boolean;

        private function _defaultFP9ContextMenu():NativeMenu
        {
            var contextMenu:* = new NativeMenu();
            this._cutItem = new NativeMenuItem(this._getEditString("EDIT__CUT"));
            contextMenu.addItem(this._cutItem);
            this._cutItem.addEventListener(Event.SELECT, function (event:Event):void{
                NativeApplication.nativeApplication.cut();
            });
            this._cutItem.enabled = this._textCanCut();
            this._copyItem = new NativeMenuItem(this._getEditString("EDIT__COPY"));
            contextMenu.addItem(this._copyItem);
            this._copyItem.addEventListener(Event.SELECT, function (event:Event):void{
                NativeApplication.nativeApplication.copy();
            });
            this._copyItem.enabled = this._textCanCopy();
            this._pasteItem = new NativeMenuItem(this._getEditString("EDIT__PASTE"));
            contextMenu.addItem(this._pasteItem);
            this._pasteItem.addEventListener(Event.SELECT, function (event:Event):void{
                NativeApplication.nativeApplication.paste();
            });
            this._pasteItem.enabled = this._textCanPaste();
            this._deleteItem = new NativeMenuItem(this._getEditString("EDIT__DELETE"));
            contextMenu.addItem(this._deleteItem);
            this._deleteItem.addEventListener(Event.SELECT, function (event:Event):void{
                NativeApplication.nativeApplication.clear();
            });
            this._deleteItem.enabled = this._textCanClear();
            this._selectAllItem = new NativeMenuItem(this._getEditString("EDIT__SELECT_ALL"));
            contextMenu.addItem(this._selectAllItem);
            this._selectAllItem.addEventListener(Event.SELECT, function (event:Event):void{
                NativeApplication.nativeApplication.selectAll();
            });
            this._selectAllItem.enabled = true;
            return (contextMenu);
        }

        private function onContextMenuEvent(event:MouseEvent):void{
            var menu:NativeMenu;
            var testMenu:ContextMenu;
            var ctxtMenuObj:Object;
            var thisObj:Object;
            var linkStr:String;
            if (!(event.isDefaultPrevented())){
                menu = this.contextMenu;
                if (menu != null){
                    this._setContextMenuOwner();
                    if (this._isRichTextEditor()){
                        testMenu = new ContextMenu();
                        if (testMenu.hasOwnProperty("clipboardItems")){
                            ctxtMenuObj = (this.m_contextMenu as Object);
                            thisObj = (this as Object);
                            if (ctxtMenuObj["clipboardItems"] != null){
                                thisObj["configureClipboardItems"].call(this, ctxtMenuObj["clipboardItems"]);
                            };
                            linkStr = this._getTextLinkAtMouse(event);
                            ctxtMenuObj["link"] = ((linkStr) ? new URLRequest(linkStr) : null);
                        } else {
                            if (this._cutItem){
                                this._cutItem.enabled = this._textCanCut();
                                this._copyItem.enabled = this._textCanCopy();
                                this._pasteItem.enabled = this._textCanPaste();
                                this._deleteItem.enabled = this._textCanClear();
                                this._selectAllItem.enabled = true;
                            };
                        };
                    };
                    menu.dispatchContextMenuSelect(event);
                    menu.display(stage, event.stageX, event.stageY);
                    event.stopPropagation();
                };
            };
        }

        private function get clipboardItems():ContextMenuClipboardItems
        {
            var items:ContextMenuClipboardItems = new ContextMenuClipboardItems();
            return (items);
        }
        
        private function configureClipboardItems(items:ContextMenuClipboardItems)
        {
            items.cut = this._textCanCut();
            items.copy = this._textCanCopy();
            items.paste = this._textCanPaste();
            items.clear = this._textCanClear();
            items.selectAll = true;
        }


        public native function get tabEnabled():Boolean;

        public native function set tabEnabled(enabled:Boolean):void;

        public native function get tabIndex():int;

        public native function set tabIndex(index:int):void;

        public native function get focusRect():Object;

        public native function set focusRect(focusRect:Object):void;

        public native function get mouseEnabled():Boolean;

        public native function set mouseEnabled(enabled:Boolean):void;

        public native function get doubleClickEnabled():Boolean;

        public native function set doubleClickEnabled(enabled:Boolean):void;

        public native function get accessibilityImplementation():AccessibilityImplementation;

        public native function set accessibilityImplementation(value:AccessibilityImplementation):void;

        public function get contextMenu():NativeMenu
        {
            var testMenu:ContextMenu;
            var ctxtMenuObj:Object;
            var thisObj:Object;
            if (((this._isRichTextEditor()) && ((this.m_contextMenu == null)))){
                testMenu = new ContextMenu();
                if (testMenu.hasOwnProperty("clipboardItems")){
                    this.m_contextMenu = testMenu;
                    ctxtMenuObj = (this.m_contextMenu as Object);
                    thisObj = (this as Object);
                    ctxtMenuObj["clipboardItems"] = thisObj["clipboardItems"];
                    ctxtMenuObj["clipboardMenu"] = true;
                    thisObj["configureClipboardItems"].call(this, ctxtMenuObj["clipboardItems"]);
                } else {
                    this.m_contextMenu = this._defaultFP9ContextMenu();
                };
            };
            return (this.m_contextMenu);
        }
        
        public function set contextMenu(cm:NativeMenu):void
        {
            addEventListener(MouseEvent.CONTEXT_MENU, this.onContextMenuEvent, false, -1, true);
            this.m_contextMenu = cm;
        }
        
    }
}
