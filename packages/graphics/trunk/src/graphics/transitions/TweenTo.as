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
 
package graphics.transitions 
{
    /**
     * The TweenTo class interpolate an object from specific number properties to other values.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * package examples 
     * {
     *     import graphics.Align;
     *     import graphics.FillStyle;
     *     import graphics.LineStyle;
     *     import graphics.drawing.Pen;
     *     import graphics.drawing.RectanglePen;
     *     import graphics.easings.bounceOut;
     *     import graphics.transitions.TweenTo;
     *     
     *     import flash.display.Shape;
     *     import flash.display.Sprite;
     *     import flash.display.StageScaleMode;
     *     import flash.events.KeyboardEvent;
     *     import flash.ui.Keyboard;
     *     
     *     public class TweenToExample extends Sprite
     *     {
     *         public function TweenToExample()
     *         {
     *             /// stage
     *             
     *             stage.scaleMode = StageScaleMode.NO_SCALE ;
     *             
     *             stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
     *             
     *             /// build and draw the shape
     *             
     *             var shape:Shape = new Shape() ;
     *             var pen:Pen     = new RectanglePen( shape ) ;
     *             
     *             pen.fill = new FillStyle(0xFFFFFF) ;
     *             pen.line = new LineStyle(1,0x999999) ;
     *             pen.draw(0,0,32,32,Align.CENTER) ;
     *             
     *             shape.x = 50 ;
     *             shape.y = 50 ;
     *             
     *             addChild( shape ) ;
     *             
     *             // initialize and run the tween
     *             
     *             var to:Object =
     *             {
     *                 x        : 700 ,
     *                 y        : 250 ,
     *                 rotation : 180
     *             };
     *             
     *             tween = new TweenTo( shape, to, bounceOut, 1.5, true , true ) ;
     *         }
     *         
     *         public var tween:TweenTo ;
     *         
     *         protected function keyDown( e:KeyboardEvent ):void
     *         {
     *             var code:uint = e.keyCode ;
     *             switch( code )
     *             {
     *                 case Keyboard.UP :
     *                 {
     *                     tween.duration = 1 ;
     *                     tween.run( { x : 50 , y : 50 , rotation : 0 } ) ;
     *                     break ;
     *                 }
     *                 default :
     *                 {
     *                     tween.duration = 1.5 ;
     *                     tween.to = { x : 700 , y : 250 , rotation : 180 } ;
     *                     tween.run() ;
     *                     break ;
     *                 }
     *             }
     *         }
     *     }
     * }
     * </pre>
     */
    public class TweenTo extends TweenUnit
    {
        /**
         * Creates a new TweenTo instance.
         * @param obj The target object of this tween.
         * @param to A generic object to defines the value of all properties to change over the specified object during the tween process.
         * @param easing The easing equation reference.
         * @param duration A number indicating the length of time or number of frames for the tween motion.
         * @param useSeconds Indicates if the duration is in seconds.
         * @param auto Run the tween automatically.
         * @param from The optional generic object to defines the initial values of the numeric attributes to change. 
         */
        public function TweenTo( obj:* = null , to:Object = null , easing:* = null , duration:Number = 0 , useSeconds:Boolean = false , auto:Boolean = false , from:* = null )
        {
            super( easing , duration, useSeconds, false ) ;
            this.target = obj  ;
            this.from   = from ;
            this.to     = to   ;
            if ( auto ) 
            {
                run() ;
            }
        }
        
        /**
         * Determinates the generic object with all numeric attributes to start the transition. 
         * If this object is null, the default numeric attributes of the target are used.
         */
        public function get from():Object
        {
            return _from ;
        }
        
        /**
         * @private
         */
        public function set from( obj:* ):void
        {
            _from    = obj ;
            _changed = true ;
        }
        
        /**
         * @private
         */
        public override function set target( obj:* ):void
        {
            _target  = obj ;
            _changed = true ;
        }
        
        /**
         * Determinates the generic object with all properties to change inside.
         */
        public function get to():Object
        {
            return _to ;
        }
        
        /**
         * @private
         */
        public function set to( obj:* ):void
        {
            _to = obj ;
            _changed = true ;
        }
        
        /**
         * Returns a shallow copy of this TweenTo object.
         * @return a shallow copy of this TweenTo object.
         */
        public override function clone():* 
        {
            return new TweenTo( _target , _to , easing, _duration, useSeconds , false, _from ) ;
        }
        
        /**
         * Notify an ActionEvent when the process is finished.
         */
        public override function notifyFinished():void 
        {
            _changed = true ;
            super.notifyFinished() ;
        }
        
        /**
         * Runs the process.
         */
        public override function run( ...arguments:Array ):void 
        {
            if ( arguments.length > 0 && arguments[0] != null )
            {
                to = arguments[0] as Object ;
            }
            _changed = true ;
            super.run() ;
        }
        
        /**
         * Update the current Tween in the time.
         */
        public override function update():void 
        {
            if ( _changed )
            {
                _changed = false ;
                if ( _target == null)
                {
                    throw new Error( this + " update failed, the 'target' property not must be null.") ;
                }
                if ( _to == null)
                {
                    throw new Error( this + " update failed, the 'to' property not must be null.") ;
                }
                if ( _from )
                {
                    _begin = _from ;
                }
                else
                {
                    _begin = {} ;
                    for ( _prop in _to )
                    {
                        _begin[_prop] = _target[_prop] ;
                    }
                }
            }
            for ( _prop in _to )
            {
                _target[_prop] = _easing( _time, _begin[_prop] , _to[_prop] - _begin[_prop] , _duration ) ;
            }
            notifyChanged() ;
        }
        
        /**
         * @private
         */
        protected var _begin:* ;
        
        /**
         * @private
         */
        protected var _changed:Boolean ;
        
        /**
         * @private
         */
        protected var _from:* ;
        
        /**
         * @private
         */
        protected var _prop:String ;
        
        /**
         * @private
         */
        protected var _to:Object ;
    }
}
