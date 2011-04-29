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
     * The TweenLite class lets you use ActionScript to move, resize, and fade movie clips easily on the Stage by specifying a property of the target movie clip to be tween animated over a number of frames or seconds.
     * The TweenLite class also lets you specify a variety of easing methods.
     * <p>Easing refers to gradual acceleration or deceleration during an animation, which helps your animations appear more realistic.</p>
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import graphics.transitions.TweenLite ;
     * import graphics.transitions.easing.Back ;
     * import system.process.ActionEvent ;
     * 
     * var debug:Function = function( ev:ActionEvent ):void
     * {
     *     trace (":: debug -> " + ev.type + " : " + ev.target ) ;
     * }
     * 
     * var tw:TweenLite = new TweenLite (mc, "x", Back.easeOut, mc.x, 400, 2, true, true) ;
     * tw.looping = true ;
     * tw.addEventListener( ActionEvent.START    , debug ) ;
     * tw.addEventListener( ActionEvent.PROGRESS , debug ) ;
     * tw.addEventListener( ActionEvent.FINISH   , debug ) ;
     * tw.addEventListener( ActionEvent.LOOP     , debug ) ;
     * </pre>
     */
    public class TweenLite extends Motion 
    {
        /**
         * Creates a new TweenLite instance.
         * @param obj The target object of this tween.
         * @param prop The property name of the object to interpolate.
         * @param easing The easing equation reference (use a Function or an Easing object)..
         * @param begin A number indicating the begining value of the target object property that is to be tweened.
         * @param finish A number indicating the ending value of the target object property that is to be tweened.
         * @param duration A number indicating the length of time or number of frames for the tween motion.
         * @param useSeconds Indicates if the duration is in seconds.
         * @param auto Run the tween automatically.
         */
        public function TweenLite( obj:*=null , prop:String=null , easing:*=null , begin:Number=NaN  , finish:Number=NaN , duration:Number=0 , useSeconds:Boolean=false , auto:Boolean=false )
        {
            this.target     = obj        ;
            this.duration   = duration   ;
            this.useSeconds = useSeconds ;
            this.setTweenEntry( prop , easing, begin, finish ) ;
            if ( auto ) 
            {
                run() ;
            }
        }
        
        /**
         * The TweenEntry reference of this tween.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import graphics.transitions.TweenEntry ;
         * import graphics.transitions.TweenLite ;
         * import graphics.transitions.easing.Bounce ;
         * 
         * var tw:TweenLite = new TweenLite( mc ) ;
         * tw.duration   = 1 ;
         * tw.useSeconds = true ;
         * 
         * tw.tweenEntry = new TweenEntry( "x" , Bounce.easeOut, mc.x , 500 ) ;
         * tw.start() ;
         * </pre>
         */
        public function get tweenEntry():TweenEntry 
        {
            return _entry ;
        }
        
        /**
         * @private
         */
        public function set tweenEntry( entry:TweenEntry ):void 
        {
            _entry = entry || new TweenEntry() ;
        }
        
        /**
         * Returns a shallow copy of this Tween object.
         * @return a shallow copy of this Tween object.
         */
        public override function clone():* 
        {
            var t:TweenLite = new TweenLite(target) ;
            t.duration   = duration   ;
            t.useSeconds = useSeconds ;
            t.tweenEntry = tweenEntry.clone() ;
            return t ;
        }
        
        /**
         * Instructs the tweened animation to continue tweening from its current animation point to a new finish and duration point.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * system system.events.ActionEvent ;
         * 
         * import graphics.transitions.TweenLite ;
         * import graphics.transitions.easing.Bounce ;
         * 
         * var continueTo:Function = function( e:ActionEvent ):void
         * {
         *     tw.removeEventListener( ActionEvent.FINISH , continueTo ) ;
         *     var target:TweenLite = e.target as TweenLite ;
         *     trace(e + " continueTo(100,2)" ) ;
         *     target.continueTo( 100 , 3 ) ;
         * }
         * 
         * var tw:TweenLite = new TweenLite( mc, "x", Bounce.easeOut, mc.x, 550, 1, true ) ;
         * tw.addEventListener( ActionEvent.FINISH , continueTo ) ;
         * tw.run() ;
         * </pre>
         * @param finish A number indicating the ending value of the target object property that is to be tweened.
         * @param duration A number indicating the length of time or number of frames for the tween motion.
         * @param noRestart This optional flag is used to fix the restart process of the tween.
         */
        public function continueTo( finish:Number, duration:Number=NaN, noRestart:Boolean=false ):void 
        {
            _entry.begin  = target[_entry.prop] ;
            _entry.finish = finish ;
            if ( !isNaN(duration) )
            {
                this.duration = duration;
            }
            if ( noRestart )
            {
                return ;
            }
            if ( !running )
            {
                run();
            }
        }
        
        /**
         * Set the TweenEntry property of this TweenLite object.
         * @param prop the property name of the object to change.
         * @param easing the easing function of the tween entry (use a Function or an Easing object).
         * @param begin the begin value.
         * @param finish the finish value. 
         */
        public function setTweenEntry( prop:String, easing:* , begin:Number , finish:Number ):void
        {
            _entry.prop   = prop   ;
            _entry.easing = easing ;
            _entry.begin  = begin  ;
            _entry.finish = finish ;
        }
        
        /**
         * Update the current Tween in the time.
         */
        public override function update():void 
        {
            _target[ _entry.prop ] = _entry.set( _time, _duration ) ;
            notifyChanged() ;
        }
        
        /**
         * Instructs the tweened animation to play in reverse from its last direction of tweened property increments. 
         * If this method is called before a Tween object's animation is complete, the animation abruptly jumps to the end of its play and then plays in a reverse direction from that point.
         * <p><b>Example :</b></p>
         * <pre class="prettyprint">
         * import system.events.ActionEvent ;
         * 
         * import graphics.transitions.TweenLite ;
         * import graphics.transitions.easing.Bounce ;
         * 
         * var yoyo:Function = function( e:ActionEvent ):void
         * {
         *     var target:TweenLite = e.target as TweenLite ;
         *     trace(e + " yoyo()" ) ;
         *     target.yoyo() ;
         * }
         * 
         * var tw:TweenLite = new TweenLite( mc, "x", Bounce.easeOut, mc.x, 550, 2, true ) ;
         * tw.addEventListener( ActionEvent.FINISH , yoyo ) ;
         * tw.run() ;
         * </pre>
         */
        public function yoyo():void 
        {
            continueTo( _entry.begin, time );
        }
        
        /**
         * @private
         */
        private var _entry:TweenEntry = new TweenEntry() ;
    }
}
