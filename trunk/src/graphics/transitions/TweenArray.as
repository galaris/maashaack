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
     * The TweenArray class interpolate a collection of numeric values defines in two Arrays (begin and finish).
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * package examples 
     * {
     *     import graphics.transitions.TweenArray;
     *     import graphics.easings.bounceOut;
     *     
     *     import system.process.Action;
     *     
     *     import flash.display.Sprite;
     *     
     *     public class ExampleTweenArray extends Sprite
     *     {
     *         public function ExampleTweenArray()
     *         {
     *             var begin:Array  = [  0 ,  10 ,  20 ,  30 ] ;
     *             var finish:Array = [ 10 , 100 , 200 , 300 ] ;
     *             
     *             tween = new TweenArray ( begin, finish, bounceOut, 24, false, true ) ;
     *             
     *             tween.changeIt.connect( change ) ; 
     *             tween.run() ;
     *         }
     *         
     *         public var tween:TweenArray ;
     *         
     *         public function change( action:Action ):void
     *         {
     *             trace( tween.change ) ;
     *         }
     *     }
     * }
     * </pre>
     */
    public class TweenArray extends TweenUnit
    {
        /**
         * Creates a new TweenArray instance.
         * @param begin The first Array used to interpolate a collection of numeric values.
         * @param finish The second Array used to interpolate a collection of numeric values.
         * @param easing The easing equation reference.
         * @param duration A number indicating the length of time or number of frames for the tween motion.
         * @param useSeconds Indicates if the duration is in seconds.
         * @param auto Run the tween automatically.
         */
        public function TweenArray( begin:Array = null , finish:Array = null , easing:* = null , duration:Number = 0 , useSeconds:Boolean = false , auto:Boolean = false )
        {
            this.begin  = begin  ;
            this.finish = finish ;
            super( easing , duration, useSeconds, auto ) ;
        }
        
        /**
         * Determinates the first Array used to interpolate a collection of numeric values.
         */
        public function get begin():Array
        {
            return _begin ;
        }
        
        /**
         * @private
         */
        public function set begin( ar:Array ):void
        {
            _begin = ar ;
           _changed = true ;
        }
        
        /**
         * This Array contains all numeric values during the interpolation between the "begin" and "finish" arrays.
         */
        public var change:Array ;
        
        /**
         * Determinates the second Array used to interpolate a collection of numeric values.
         */
        public function get finish():Array
        {
            return _finish ;
        }
        
        /**
         * @private
         */
        public function set finish( ar:Array ):void
        {
            _finish = ar ;
            _changed = true ;
        }
        
        /**
         * Returns a shallow copy of this Tween object.
         * @return a shallow copy of this Tween object.
         */
        public override function clone():* 
        {
            return new TweenArray( _begin , _finish , easing, duration, useSeconds) ;
        }
        
        /**
         * Update the current Tween in the time.
         */
        public override function update():void 
        {
            if ( _changed )
            {
                _changed = false ;
                if ( _begin == null || _begin.length == 0 )
                {
                    throw new Error( this + " update failed, the begin property not must be null or empty.") ;
                }
                if ( _finish == null || _finish.length == 0 )
                {
                    throw new Error( this + " update failed, the finish property not must be null or empty.") ;
                }
                _size = Math.min( _begin.length , _finish.length ) ;
                change = new Array( _size ) ;
            }
            for( _count = 0 ; _count < _size ; _count++ )
            {
                change[_count] = _easing( _time, _begin[_count] , _finish[_count] - _begin[_count] , _duration ) ;
            }
            notifyChanged() ;
        }
        
        /**
         * @private
         */
        protected var _begin:Array ;
        
        /**
         * @private
         */
        protected var _changed:Boolean ;
        
        /**
         * @private
         */
        protected var _finish:Array ;
        
        /**
         * @private
         */
        private var _count:int ;
        
        /**
         * @private
         */
        private var _size:int ;
    }
}
