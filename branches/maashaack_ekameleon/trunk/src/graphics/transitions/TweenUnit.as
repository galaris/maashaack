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
    import graphics.easings.linear;

    /**
     * The TweenUnit class interpolate in time a value between 0 and 1.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * package examples 
     * {
     *     import graphics.transitions.TweenUnit;
     *     import graphics.easings.bounceOut;
     *     
     *     import system.process.Action;
     *     
     *     import flash.display.Sprite;
     *     
     *     public class ExampleTweenUnit extends Sprite
     *     {
     *         public function ExampleTweenUnit()
     *         {
     *             tween = new TweenUnit ( bounceOut, 24, false, true ) ;
     *             tween.changeIt.connect( change ) ;
     *             tween.run() ;
     *         }
     *         
     *         public var tween:TweenUnit ;
     *         
     *         public function change( action:Action ):void
     *         {
     *             trace( tween.position ) ;
     *         }
     *     }
     * }
     * </pre>
     */
    public class TweenUnit extends Motion
    {
        /**
         * Creates a new TweenUnit instance.
         * @param easing The easing equation reference.
         * @param duration A number indicating the length of time or number of frames for the tween motion.
         * @param useSeconds Indicates if the duration is in seconds.
         * @param auto Run the tween automatically.
         */
        public function TweenUnit( easing:* = null , duration:Number = 0 , useSeconds:Boolean = false , auto:Boolean = false )
        {
            this.duration   = duration   ;
            this.easing     = easing     ;
            this.useSeconds = useSeconds ;
            if ( auto ) 
            {
                run() ;
            }
        }
        
        /**
         * Defines the easing method reference of this entry.
         */
        public function get easing():Function
        {
            return _easing ;
        }
        
        /**
         * @private
         */
        public function set easing( f:Function ):void 
        {
            _easing = f || linear ;
        }
        
        /**
         * The current position of this tween.
         */
        public var position:Number ;
        
        /**
         * Returns a shallow copy of this Tween object.
         * @return a shallow copy of this Tween object.
         */
        public override function clone():* 
        {
            return new TweenUnit(easing, duration, useSeconds) ;
        }
        
        /**
         * Set the TweenUnit properties.
         * @param easing the easing function of the tween entry.
         * @param duration A number indicating the length of time or number of frames for the tween motion.
         * @param useSeconds Indicates if the duration is in seconds.
         */
        public function set( easing:* , duration:Number = 0 , useSeconds:Boolean = false ):void
        {
            this.duration   = duration   ;
            this.useSeconds = useSeconds ;
            this.easing     = easing     ;
        }
        
        /**
         * Update the current Tween in the time.
         */
        public override function update():void 
        {
            position = _easing( _time, 0, _change , _duration ) ;
            notifyChanged() ;
        }
        
        /**
         * @private
         */
        protected var _change:Number = 1 ; // max - min
        
        /**
         * @private
         */
        protected var _easing:Function ;
    }
}
