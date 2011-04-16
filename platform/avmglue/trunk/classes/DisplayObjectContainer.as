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
    import flash.text.TextSnapshot;
    import flash.geom.*;
    
    /**
     * The DisplayObjectContainer class is the base class for all objects that can serve as
     * display object containers on the display list.
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 9
     * @playerversion AIR 1.0
     */
    public class DisplayObjectContainer extends InteractiveObject
    {
        private var _mouseChildren:Boolean;
        private var _tabChildren:Boolean;
        private var _textSnapshot:TextSnapshot;
        
        private var _children:Array;
        
        public function DisplayObjectContainer()
        {
            CFG::dbg{ trace( "new DisplayObjectContainer()" ); }
            super();

            ctor();
        }

        //private native function ctor():void;
        private function ctor():void
        {
            _children      = [];
            _tabChildren   = true;
            _mouseChildren = true;
            _textSnapshot  = new TextSnapshot();
        }

        //public native function get numChildren():int;
        public function get numChildren():int
        {
            CFG::dbg{ trace( "DisplayObjectContainer.get numChildren()" ); }
            return _children.length;
        }

        //public native function get textSnapshot():TextSnapshot;
        public function get textSnapshot():TextSnapshot
        {
            CFG::dbg{ trace( "DisplayObjectContainer.get textSnapshot()" ); }
            return _textSnapshot;
        }
        
        //public native function get tabChildren():Boolean;
        public function get tabChildren():Boolean
        {
            CFG::dbg{ trace( "DisplayObjectContainer.get tabChildren()" ); }
            return _tabChildren;
        }

        //public native function set tabChildren( value:Boolean ):void;
        public function set tabChildren( value:Boolean ):void
        {
            CFG::dbg{ trace( "DisplayObjectContainer.set tabChildren( " + value + " )" ); }
            _tabChildren = value;
        }

        //public native function get mouseChildren():Boolean;
        public function get mouseChildren():Boolean
        {
            CFG::dbg{ trace( "DisplayObjectContainer.get mouseChildren()" ); }
            return _mouseChildren;
        }

        //public native function set mouseChildren( value:Boolean ):void;
        public function set mouseChildren( value:Boolean ):void
        {
            CFG::dbg{ trace( "DisplayObjectContainer.set mouseChildren( " + value + " )" ); }
            _mouseChildren = value;
        }

        //public native function addChild( child:DisplayObject ):DisplayObject;
        public function addChild( child:DisplayObject ):DisplayObject
        {
            CFG::dbg{ trace( "DisplayObjectContainer.addChild( " + child + " )" ); }
            _children.push( child );
            return child;
        }

        //public native function addChildAt( child:DisplayObject, index:int ):DisplayObject;
        public function addChildAt( child:DisplayObject, index:int ):DisplayObject
        {
            CFG::dbg{ trace( "DisplayObjectContainer.addChildAt( " + [child,index].join(", ") + " )" ); }
            /* if( index > _children.length )
               throw new RangeError
               
               if( child === this )
               throw new ArgumentError
            */
            
            _children.splice( index, 0, child );
            return child;
        }

        //public native function removeChild( child:DisplayObject ):DisplayObject;
        public function removeChild( child:DisplayObject ):DisplayObject
        {
            CFG::dbg{ trace( "DisplayObjectContainer.removeChild( " + child + " )" ); }
            var index:int = getChildIndex( child );
            _children.splice( index, 1 );
            return child;
        }

        //public native function removeChildAt( index:int ):DisplayObject;
        public function removeChildAt( index:int ):DisplayObject
        {
            CFG::dbg{ trace( "DisplayObjectContainer.removeChildAt( " + index + " )" ); }
            var child:DisplayObject = _children[ index ];
            _children.splice( index, 1 );
            return child;
        }

        //public native function getChildIndex( child:DisplayObject ):int;
        public function getChildIndex( child:DisplayObject ):int
        {
            CFG::dbg{ trace( "DisplayObjectContainer.getChildIndex( " + child + " )" ); }
            //deal with errors stuff
            var i:uint;
            
            for( i=0; i<_children.length; i++ )
            {
                if( _children[i] == child )
                {
                    return i;
                }
            }

            return null;
        }

        //public native function setChildIndex( child:DisplayObject, index:int ):void;
        public function setChildIndex( child:DisplayObject, index:int ):void
        {
            CFG::dbg{ trace( "DisplayObjectContainer.setChildIndex( " + [child,index].join(", ") + " )" ); }
            //TODO
        }

        //public native function getChildAt( index:int ):DisplayObject;
        public function getChildAt( index:int ):DisplayObject
        {
            CFG::dbg{ trace( "DisplayObjectContainer.getChildAt( " + index + " )" ); }
            //deal with errors stuff
            return _children[ index ];
        }

        //public native function getChildByName( name:String ):DisplayObject;
        public function getChildByName( name:String ):DisplayObject
        {
            CFG::dbg{ trace( "DisplayObjectContainer.getChildByName( " + name + " )" ); }
            //deal with errors stuff
            var i:uint;
            
            for( i=0; i<_children.length; i++ )
            {
                if( _children[i].name == name )
                {
                    return _children[i];
                }
            }

            return null;
        }

        //public native function getObjectsUnderPoint( point:Point ):Array;
        public function getObjectsUnderPoint( point:Point ):Array
        {
            CFG::dbg{ trace( "DisplayObjectContainer.getObjectsUnderPoint( " + point + " )" ); }
            //TODO
            return [];
        }

        //public native function areInaccessibleObjectsUnderPoint( point:Point ):Boolean;
        public function areInaccessibleObjectsUnderPoint( point:Point ):Boolean
        {
            CFG::dbg{ trace( "DisplayObjectContainer.areInaccessibleObjectsUnderPoint( " + point + " )" ); }
            //TODO
            return false;
        }

        //public native function contains( child:DisplayObject ):Boolean;
        public function contains( child:DisplayObject ):Boolean
        {
            CFG::dbg{ trace( "DisplayObjectContainer.contains( " + child + " )" ); }
            if( child === this )
            {
                return true;
            }
            
            return _children.indexOf( child ) > -1;
        }

        //public native function swapChildrenAt( index1:int, index2:int ):void;
        public function swapChildrenAt( index1:int, index2:int ):void
        {
            CFG::dbg{ trace( "DisplayObjectContainer.swapChildrenAt( " + [index1,index2].join(", ") + " )" ); }
            //TODO
        }

        //public native function swapChildren( child1:DisplayObject, child2:DisplayObject ):void;
        public function swapChildren( child1:DisplayObject, child2:DisplayObject ):void
        {
            CFG::dbg{ trace( "DisplayObjectContainer.swapChildren( " + [child1,child2].join(", ") + " )" ); }
            //TODO
        }
    }
}
