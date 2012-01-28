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
 
package graphics.transitions 
{
    import system.numeric.Range;
    
    /**
     * The TweenRange class interpolate in time a value between a minimum and maximum
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * package examples 
     * {
     *     import graphics.transitions.TweenRange;
     *     import graphics.easings.bounceOut;
     *     
     *     import system.process.Action;
     *     import system.numeric.Range;
     *     
     *     import flash.display.Sprite;
     *     
     *     public class ExampleTweenRange extends Sprite
     *     {
     *         public function ExampleTweenRange()
     *         {
     *             range = new Range( 100 , 200 ) ;
     *             
     *             tween = new TweenRange ( range , bounceOut, 24, false ) ;
     *             
     *             tween.changeIt.connect( change ) ;
     *             
     *             tween.run() ;
     *         }
     *         
     *         public var range:Range ;
     *         
     *         public var tween:TweenRange ;
     *         
     *         public function change( action:Action ):void
     *         {
     *             trace( tween.position ) ;
     *         }
     *     }
     * }
     * </pre>
     */
    public class TweenRange extends TweenUnit
    {
        /**
         * Creates a new TweenRange instance.
         * @param range The range used to interpolate (by default a unity range is used between 0 and 1).
         * @param easing The easing equation reference.
         * @param duration A number indicating the length of time or number of frames for the tween motion.
         * @param useSeconds Indicates if the duration is in seconds.
         * @param auto Run the tween automatically.
         */
        public function TweenRange( range:Range = null , easing:* = null , duration:Number = 0 , useSeconds:Boolean = false , auto:Boolean = false )
        {
            this.range      = range      ;
            super( easing , duration, useSeconds, auto ) ;
        }
        
        /**
         * Determinates the maximum value of the range.
         */
        public function get max():Number
        {
            return _range.max ;
        }
        
        /**
         * @private
         */
        public function set max( value:Number ):void
        {
            _range.max = value ;
        }
        
        /**
         * Determinates the minimum value of the range.
         */
        public function get min():Number
        {
            return _range.min ;
        }
        
        /**
         * @private
         */
        public function set min( value:Number ):void
        {
            _range.min = value ;
        }
        
        /**
         * The range used to interpolate the position property. 
         * This property can't be null, by default a unity range is defined (new Range(0,1)).
         */
        public function get range():Range
        {
            return _range ;
        }
        
        /**
         * @private
         */
        public function set range( r:Range ):void
        {
            _range  = r || Range.UNITY.clone() ;
        }
        
        /**
         * Returns a shallow copy of this Tween object.
         * @return a shallow copy of this Tween object.
         */
        public override function clone():* 
        {
            return new TweenRange( _range , easing, duration, useSeconds) ;
        }
        
        /**
         * Update the current Tween in the time.
         */
        public override function update():void 
        {
            position = _easing( _time, _range.min, _range.max - _range.min , _duration ) ;
            notifyChanged() ;
        }
        
        /**
         * @private
         */
        private var _range:Range ;
    }
}
