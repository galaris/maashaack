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
  Portions created by the Initial Developers are Copyright (C) 2006-2010
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

package graphics.display 
{
    import graphics.logging.logger;
    
    import flash.display.FrameLabel;
    import flash.display.MovieClip;
    
    /**
     * The TimeLineScript class use composition to register script function over MovieClip timelines.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import graphics.display.TimelineScript ;
     * 
     * var ts:TimelineScript = new TimelineScript( mc , true ) ; // mc a MovieClip in the stage
     * 
     * var start:Function = function()
     * {
     *     trace("start") ;
     * }
     * 
     * var pause:Function = function()
     * {
     *     trace("pause") ;
     *     mc.stop() ;
     *     setTimeout( mc.play , 4000 ) ; // pause 4 s
     * }
     * 
     * var finish:Function = function()
     * {
     *     trace("finish") ;
     *     mc.stop() ;
     * }
     * 
     * ts.put( "begin"   , start ) ;
     * ts.put( "middle"  , pause ) ;
     * ts.put( "finish"  , finish ) ;
     * 
     * var click:Function = function( e:MouseEvent ):void
     * {
     *     mc.play() ;
     *     trace("click") ;
     *     e.target.removeEventListener( MouseEvent.CLICK , click ) ;
     *     mc.buttonMode = false ;
     * }
     * 
     * mc.useHandCursor = true ;
     * mc.buttonMode    = true ;
     * mc.addEventListener( MouseEvent.CLICK , click ) ;
     * </pre>
     */
    public class TimelineScript
    {
        /**
         * Creates a new TimelineScript instance.
         * @param target The MovieClip reference of this iterator.
         * @param autoStop This boolean flag indicates if the specified MovieClip target reference is stopped.
         * @throws ArgumentError if the <code class="prettyprint">target</code> argument of this constructor is null.
         */
        public function TimelineScript( target:MovieClip , autoStop:Boolean=false )
        {
            if (target == null)
            {
                throw new ArgumentError( this + " constructor failed, the target argument not must be null.") ;
            }
            _target = target ;
            if ( autoStop )
            {
                _target.stop() ;
            }
        }
        
        /**
         * Indicates the target reference of this iterator.
         */
        public function get target():MovieClip
        {
            return _target ;
        }
        
        /**
         * Registers a script function in the frame specified by the label or index value passed-in the first argument of the method.
         * @param index A String label name or an uint frame index value.
         * @param script The Function instruction to register.
         * @return true if the register is success.
         */
        public function put( index:* , script:Function ):Boolean
        {
            try
            {
                var num:uint ;
                if ( index is uint )
                {
                    num = index as uint ;
                }
                else if ( index is String )
                {
                    num = resolve( index as String ) ;
                }
                _target.addFrameScript( num , script ) ;
                return true ;
            }
            catch(e:Error)
            {
                logger.error( this + " put failed : " + e.message ) ;
            }
            return false ;
        }
        
        /**
         * Unregisters a script function in the frame specified by the label or index value passed-in argument of the method.
         * @param index A String label name or an uint frame index value.
         */
        public function remove( index:* ):void
        {
            var num:int ;
            if ( index is int )
            {
                num = index as int ;
            }
            else if ( index is String )
            {
                num = resolve( index as String ) ;
            }
            _target.addFrameScript( num , null ) ;
        }
        
        /**
         * Indicates if the specified passed-in label value is in the MovieClip target.
         * @throws ArgumentError if the passed-in label value is null or empty.
         * @throws ArgumentError if the passed-in label value don't exist in the MovieClip.
         */
        protected function resolve( label:String=null ):int 
        {
            if ( label == null || label.length == 0 )
            {
                throw new ArgumentError( this + " resolve failed, the label argument not must be 'null' or empty.") ;
            }
            var frame:uint ;
            var currentLabels:Array = _target.currentLabels ;
            for each( var element:FrameLabel in currentLabels )
            {
                if (element.name == label )
                {
                    frame = element.frame - 1 ;
                    return frame > 1 ? frame : 1 ;
                }
            } ;
            throw new ArgumentError( this + " resolve the label '" + label + "' failed, the specified label don't exist in the internal MovieClip reference." ) ;
        } 
        /**
         * @private
         */
        private var _target:MovieClip ;
    }
}