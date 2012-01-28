/*
  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at
  http://www.mozilla.org/MPL/
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the
  License.
  
  The Original Code is [maashaack framework].
  
  The Initial Developers of the Original Code are
  Zwetan Kjukov <zwetan@gmail.com> and Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developers are Copyright (C) 2006-2012
  the Initial Developers. All Rights Reserved.
  
  Contributor(s):
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
*/

package graphics.layouts 
{
    import graphics.Align;
    
    import system.process.Task;
    import system.signals.Signal;
    import system.signals.Signaler;
    
    import flash.display.DisplayObject;
    import flash.display.DisplayObjectContainer;
    import flash.geom.Rectangle;
    
    /**
     * The basic implementation of the layouts.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import graphics.layouts.LayoutContainer ;
     * 
     * /////
     * 
     * function debug():void
     * {
     *     var children:Vector.<String> = new Vector.<String>() ;
     *     layout.children.map
     *     ( 
     *          function(item:DisplayObject, index:int, vector:Vector.<DisplayObject> ):void 
     *         {
     *             children.push(item.name) ;
     *         } 
     *     );
     *     trace( "> " + children ) ;
     * }
     * 
     * /////
     * 
     * var container:Sprite = new Sprite() ;
     * 
     * var child1:Sprite = new Sprite() ;
     * var child2:Sprite = new Sprite() ;
     * var child3:Sprite = new Sprite() ;
     * var child4:Sprite = new Sprite() ;
     * 
     * child1.name = "child1" ;
     * child2.name = "child2" ;
     * child3.name = "child3" ;
     * child4.name = "child4" ;
     * 
     * /////
     * 
     * container.addChild( child1 ) ;
     * container.addChild( child2 ) ;
     * container.addChild( child3 ) ;
     * container.addChild( child4 ) ;
     * 
     * /////
     * 
     * var layout:LayoutContainer = new LayoutContainer( container ) ;
     * 
     * layout.initialize( container ) ;
     * layout.useBuffering = true ;
     * 
     * /////
     * 
     * layout.setChildIndex( child1 , 3 ) ;
     * debug() ;
     * 
     * layout.swapChildren( child3 , child2 ) ;
     * debug() ;
     * 
     * layout.swapChildrenAt( 1 , 3 ) ;
     * debug() ;
     * 
     * layout.removeChildren(1,2) ;
     * debug() ;
     * 
     * layout.removeChildren() ;
     * debug() ;
     * </pre>
     */
    public class LayoutContainer extends Task implements Layout 
    {
        /**
         * Creates a new LayoutContainer instance.
         * @param container The container to layout.
         * @param init An object that contains properties with which to populate the newly layout object. If init is not an object, it is ignored.
         * @param auto This boolean indicates if the layout is auto running or not (default false).
         */
        public function LayoutContainer( container:DisplayObjectContainer = null , init:Object = null )
        {
            this.container = container ;
            if ( init )
            {
                lock() ;
                for( var prop:String in init )
                {
                    this[prop] = init[prop] ;
                }
                unlock() ;
            }
        }
        
        ////////////
        
        /**
         * The alignement of the layout.
         * @see graphics.Align
         */
        public function get align():uint
        {
            return _align ;
        }
        
        /**
         * @private
         */
        public function set align( value:uint ):void
        {
            _align = value ;
        }
        
        /**
         * A rectangle that defines the current visible area of the layout.
         */
        public function get bounds():Rectangle
        {
            return _bounds ;
        }
        
        /**
         * Indicates if the layout buffer mode "auto" or "normal" (default "auto"). 
         * The "auto" buffer mode indicates the layout auto-initialize this internal buffer when the run method is invoked with the children of the container.
         * @see graphics.layouts.LayoutMode
         */
        public function get bufferMode():String
        {
            return _bufferMode ;
        }
        
        /**
         * @private
         */
        public function set bufferMode( value:String ):void
        {
            if( _bufferMode == value )
            {
                return ;
            }
            _bufferMode = value == LayoutBufferMode.AUTO ? LayoutBufferMode.AUTO : LayoutBufferMode.NORMAL ;
        }
        
        /**
         * Indicates the container reference to change with the layout.
         */
        public function get container():DisplayObjectContainer
        {
            return _container ;
        }
        
        /**
         * @private
         */
        public function set container( container:DisplayObjectContainer ):void
        {
            _container = container ;
        }
        
        /**
         * The default height of the component, in pixels.
         */
        public function get measuredHeight():Number
        {
            return _bounds.height ;
        }
        
        /**
         * The default width of the component, in pixels.
         */
        public function get measuredWidth():Number
        {
            return _bounds.width ;
        }
        
        /**
         * This signal emit before the rendering is started.
         */
        public function get renderer():Signaler
        {
            return _renderer ;
        }
        
        /**
         * This signal emit when the rendering is finished.
         */
        public function get updater():Signaler
        {
            return _updater ;
        }
        
        ////////////
        
        /**
         * Returns a list of all display objects register in the layout buffer.
         * @return a list of all display objects register in the layout buffer.
         */
        public function get children():Vector.<DisplayObject>
        {
            var result:Vector.<DisplayObject> = new Vector.<DisplayObject> ;
            for each( var entry:LayoutEntry in _children )
            {
                result.push( entry.child ) ;
            }
            return result ;
        }
        
        /**
         * Indicates the number of children of this object.
         * @return the number of children of this object.
         */
        public function get numChildren():int
        {
            return _children.length ;
        }
        
        /**
         * Adds a child DisplayObject instance to this layout instance.
         */
        public function addChild( child:DisplayObject ):DisplayObject
        {
            var index:int = indexOf( child ) ;
            if( index > -1 )
            {
                _children.splice( index , 1 ) ;
            }
            _children.push( new LayoutEntry(child) ) ;
            return child ;
        }
        
        /**
         * Adds a child DisplayObject instance to this layout instance. The child is added at the index position specified. An index of 0 represents the back (bottom) of the display list for this layout object.
         * @throws RangeError Throws if the index position does not exist in the child list.
         */
        public function addChildAt( child:DisplayObject, index:int ):DisplayObject
        {
            if( index < 0 || index > _children.length )
            {
                throw new RangeError( this + " addChildAt failed, the index position does not exist in the child list." ) ;
            }
            var who:int = indexOf(child) ;
            if( who > -1 )
            {
                _children.splice( who , 1 ) ;
            }
            _children.splice( index , 0 , new LayoutEntry( child ) ) ;
            return child ;
        }
        
        /**
         * Determines whether the specified display object is a child of the layout instance or the instance itself.
         * @return true if the child object is a child of the layoyt or the container itself; otherwise false.
         */
        public function contains( child:DisplayObject ):Boolean
        {
            return indexOf(child) > -1 ;
        }
        
        /**
         * Returns the child display object instance that exists at the specified index.
         * @return The child display object at the specified index position.
         * @throws RangeError Throws if the index does not exist in the child list.
         */
        public function getChildAt( index:int ):DisplayObject
        {
            if( index < 0 || index >= _children.length )
            {
                throw new RangeError( this + " getChildAt failed, the index does not exist in the child list." ) ;
            }
            return _children[index].child ;
        }
        
        /**
         * Returns the child display object that exists with the specified name. 
         * If more that one child display object has the specified name, the method returns the first object in the child list.
         * @param name The name of the child to return.
         * @return The child display object with the specified name.
         */
        public function getChildByName( name:String ):DisplayObject
        {
            for each ( var entry:LayoutEntry in _children)
            {
                if( entry.child.name == name ) 
                {
                    return entry.child ;
                }
            }
            return null ;
        }
        
        /**
         * Returns the index position of a child DisplayObject instance.
         * @param child The DisplayObject instance to identify.
         * @return The index position of the child display object to identify.
         * @throws ArgumentError Throws if the child parameter is not a child of this object.
         */
        public function getChildIndex( child:DisplayObject ):int
        {
            var index:int = indexOf( child ) ;
            if( index > -1  )
            {
                return index ;
            }
            else
            {
                throw new ArgumentError( this + " getChildIndex failed, the child parameter is not a child of this object." ) ;
            }
        }
        
        /**
         * Returns the index of the specifiec Cover object in the container or -1.
         * @return the index of the specifiec Cover object in the container or -1.
         */
        public function indexOf( child:DisplayObject ):int
        {
            var i:int ;
            for each( var entry:LayoutEntry in _children )
            {
                if( entry.child == child )
                {
                     return i ;
                }
                i++ ;
            }
            return -1 ;
        }
        
        /**
         * Initialize the layout container with the specific DisplayObject elements. This method flush the layout container and remove all old elements register in the collection before initialize it.
         * @param children an Array or Vector of DisplayObject references or a DisplayObjectContainer. If this argument is null the layout is only flushed.
         */
        public function initialize( children:* = null ):void
        {
            _children.length = 0 ;
            if( children == null )
            {
                return ;
            }
            if( children is Vector.<DisplayObject> || children is Array )
            {
                var child:DisplayObject ;
                for each( child in children )
                {
                    _children.push( new LayoutEntry( child ) ) ;
                }
            }
            else if ( children is DisplayObjectContainer )
            {
                var container:DisplayObjectContainer = children as DisplayObjectContainer ;
                if ( container.numChildren >  0 )
                {
                    var len:int = container.numChildren ;
                    for( var i:int ; i<len ; i++ )
                    {
                        _children.push( new LayoutEntry( container.getChildAt(i) ) ) ;
                    }
                }
            }
        }
        
        /**
         * Removes the specified child DisplayObject instance from the child list of the layout instance. 
         * @param child The DisplayObject instance to remove.
         * @return The DisplayObject instance that you pass in the child parameter.
         * @throws ArgumentError Throws if the child parameter is not a child of this object.
         */
        public function removeChild( child:DisplayObject ):DisplayObject
        {
            var index:int = indexOf( child ) ;
            if( index > -1 )
            {
                _children.splice( index , 1 ) ;
                return child ;
            }
            else
            {
                throw new ArgumentError( this + " removeChild failed, the child parameter is not a child of this object." ) ;
            }
        }
        
        /**
         * Removes a child DisplayObject from the specified index position in the child list of the layout.
         * @param index The child index of the DisplayObject to remove.
         * @return The DisplayObject instance that was removed.
         * @throws RangeError Throws if the index does not exist in the child list.
         */
        public function removeChildAt( index:int ):DisplayObject
        {
            if( index < 0 || index >= _children.length )
            {
                throw new RangeError( this + " removeChildAt failed, the index does not exist in the child list." ) ;
            }   
            var child:DisplayObject = _children[index].child ;
            _children.splice( index , 1 ) ;
            return child ;
        }
        
        /**
         * Removes all child DisplayObject instances from the child list of the layout instance.
         */
        public function removeChildren( beginIndex:int = 0, endIndex:int = 0x7FFFFFFF ):void
        {
            _children.splice( beginIndex , endIndex - beginIndex + 1 ) ;
        }
        
        /**
         * Changes the position of an existing child in the display object container.
         * @param child The child DisplayObject instance for which you want to change the index number.
         * @param index The resulting index number for the child display object.
         * @throws ArgumentErrot Throws if the child parameter is not a child of this object.
         * @throws RangeError Throws if the index does not exist in the child list.
         */
        public function setChildIndex( child:DisplayObject , index:int ):void
        {
            if( index < 0 || index >= _children.length )
            {
                throw new RangeError( this + " setChildIndex failed, the index does not exist in the child list." ) ;
            }
            var who:int = indexOf( child ) ; 
            if( who > -1 )
            {
                var entry:LayoutEntry = _children[index] ;
                _children[who]        = _children[index] ;
                _children[index]      = entry ;
            }
            else
            {
                throw new ArgumentError( this + " setChildIndex failed, the child parameter is not a child of this object." ) ;
            }
        }
        
        /**
         * Swaps the z-order (front-to-back order) of the two specified child objects. All other child objects in the layout remain in the same index positions.
         * @param child1 The first child object.
         * @param child2 The second child object.
         * @throws ArgumentError Throws if either child parameter is not a child of this object.
         */
        public function swapChildren( child1:DisplayObject, child2:DisplayObject ):void
        {
            var index1:int = indexOf( child1 ) ; 
            var index2:int = indexOf( child2 ) ;
            if( index1 > -1 && index2 > -1 )
            {
                var entry:LayoutEntry = _children[index1] ;
                _children[index1]     = _children[index2] ;
                _children[index2]     = entry ;
            }
            else
            {
                throw new ArgumentError( this + " swapChildren failed, either child parameter is not a child of this object.") ;
            }
        }
        
        /**
         * Swaps the z-order (front-to-back order) of the child objects at the two specified index positions in the child list.
         * @param index1 The index position of the first child object.
         * @param index2 The index position of the second child object.
         * @throws RangeError If either index does not exist in the child list.
         */
        public function swapChildrenAt( index1:int, index2:int ):void
        {
            if( ( index1 < 0 || index1 >= _children.length ) || ( index2 < 0 || index2 >= _children.length ) )
            {
                throw new RangeError( this + " swapChildrenAt failed, either index does not exist in the child list." ) ;
            }
            var entry:LayoutEntry = _children[index1] ;
            _children[index1]     = _children[index2] ;
            _children[index2]     = entry ;
        }
        
        ////////////
        
        /**
         * Returns <code class="prettyprint">true</code> if the object is locked.
         * @return <code class="prettyprint">true</code> if the object is locked.
         */
        public override function isLocked():Boolean 
        {
            return _locked > 0 ;
        }
        
        /**
         * Locks the object.
         */
        public override function lock():void 
        {
            _locked++ ;
        }
        
        /**
         * Calculates the default sizes and minimum and maximum values. 
         * You can overrides this method in the specific layouts.
         */
        public function measure():void
        {
            //
        }
        
        /**
         * Render the layout, refresh and change the position of all childs in a specific container.
         */
        public function render():void
        {
            //
        }
        
        /**
         * Reset the lock security of the display.
         */
        public function resetLock():void 
        {
            _locked = 0 ;
        }
        
        /**
         * Run the layout (render and update).
         */
        public override function run(...arguments:Array):void
        {
            if ( isLocked() )
            {
                return ;
            }
            
            notifyStarted() ;
            
            if ( _bufferMode == LayoutBufferMode.AUTO && _container )
            {
                initialize( _container ) ;
            }
            
            measure() ;
            render() ;
            update() ;
        }
        
        /**
         * Unlocks the display.
         */
        public override function unlock():void 
        {
            _locked = (--_locked > 0 ) ? _locked : 0 ;
        }
        
        /**
         * This method is invoked when the rendering is finished to finalize the it after the measure invokation.
         */
        public function update():void
        {
            //
        }
        
        /**
         * @private
         */
        protected var _align:uint = Align.TOP_LEFT ;
        
        /**
         * The absolute rectangle bound area calculate with the measure method.
         * @private
         */
        protected const _bounds:Rectangle = new Rectangle() ;
        
        /**
         * @private
         */
        protected var _bufferMode:String = LayoutBufferMode.AUTO ;
        
        /**
         * The absolute rectangle bound area calculate with the measure method.
         */
        protected const _children:Vector.<LayoutEntry> = new Vector.<LayoutEntry>();
        
        /**
         * @private
         */
        protected var _container:DisplayObjectContainer ;
        
        /**
         * @private
         */ 
        protected var _locked:uint ;
        
        /**
         * @private
         */
        protected const _renderer:Signaler = new Signal() ;
        
        /**
         * @private
         */
        protected const _updater:Signaler = new Signal() ;
    }
}
