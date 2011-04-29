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
  Portions created by the Initial Developers are Copyright (C) 2006-2011
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

    import system.signals.Signal;
    import system.signals.Signaler;

    import flash.display.DisplayObjectContainer;
    import flash.geom.Rectangle;

    /**
     * The basic implementation of the layouts.
     */
    public class CoreLayout implements Layout 
    {
        /**
         * Creates a new CoreLayout instance.
         * @param container The container to layout.
         * @param init An object that contains properties with which to populate the newly layout object. If init is not an object, it is ignored.
         * @param auto This boolean indicates if the layout is auto running or not (default false).
         */
        public function CoreLayout( container:DisplayObjectContainer = null , init:Object = null , auto:Boolean = false )
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
            if( auto )
            {
                run() ;
            }
        }
        
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
         * A rectangle that defines the area of the layout.
         */
        public function get bounds():Rectangle
        {
            return _bounds ;
        }
        
        /**
         * @private
         */
        public function set bounds( area:Rectangle ):void
        {
            _bounds = area ;
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
         * @private
         */
        public function set measuredHeight( value:Number ):void
        {
            _bounds.height = isNaN( value ) ? 0 : value ;
        }
        
        /**
         * The default width of the component, in pixels.
         */
        public function get measuredWidth():Number
        {
            return _bounds.width ;
        }
        
        /**
         * @private
         */
        public function set measuredWidth( value:Number ):void
        {
            _bounds.width = isNaN( value ) ? 0 : value ;
        }
        
        /**
         * This signal emit before the rendering is started.
         */
        public function get renderer():Signaler
        {
            return _renderer ;
        }
        
        /**
         * @private
         */
        public function set renderer( signal:Signaler ):void
        {
            _renderer = signal || new Signal() ;
        }
        
        /**
         * This signal emit when the rendering is finished.
         */
        public function get udpater():Signaler
        {
            return _updater ;
        }
        
        /**
         * @private
         */
        public function set udpater( signal:Signaler ):void
        {
            _updater = signal || new Signal() ;
        }
        
        /**
         * Returns <code class="prettyprint">true</code> if the object is locked.
         * @return <code class="prettyprint">true</code> if the object is locked.
         */
        public function isLocked():Boolean 
        {
            return _lock > 0 ;
        }
        
        /**
         * Locks the object.
         */
        public function lock():void 
        {
            _lock ++ ;
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
            _lock = 0 ;
        }
        
        /**
         * Run the layout (render and update).
         */
        public function run(...arguments:Array):void
        {
            if ( isLocked() && !container )
            {
                return ;
            }
            _renderer.emit( this ) ;
            render() ;
            measure() ;
            update() ;
            _updater.emit( this ) ;
        }
        
        /**
         * Unlocks the display.
         */
        public function unlock():void 
        {
            _lock = Math.max( _lock - 1 , 0 ) ;
        }
        
        /**
         * This method is invoked when the rendering is finished to finalize the it after the measure invokation.
         */
        public function update():void
        {
            //
        }
        
        /**
         * The absolute rectangle bound area calculate with the measure method.
         */
        protected var _bounds:Rectangle = new Rectangle() ;
        
        /**
         * @private
         */
        protected var _align:uint = Align.TOP_LEFT ;
        
        /**
         * @private
         */
        protected var _container:DisplayObjectContainer ;
        
        /**
         * @private
         */ 
        protected var _lock:uint ;
        
        /**
         * @private
         */
        protected var _renderer:Signaler = new Signal() ;
        
        
        /**
         * @private
         */
        protected var _updater:Signaler = new Signal() ;
    }
}
