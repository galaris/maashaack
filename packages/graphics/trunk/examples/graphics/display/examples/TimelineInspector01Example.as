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

package examples 
{
    import graphics.display.TimelineInspector;
    import graphics.events.FrameLabelEvent;
    
    import flash.display.FrameLabel;
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.MouseEvent;
    import flash.utils.clearTimeout;
    import flash.utils.setTimeout;
    
    /**
     * Example with the graphics.display.TimelineInspector class and a classic W3C event model propagation.
     */
    public dynamic class TimelineInspector01Example extends Sprite 
    {
        public function TimelineInspector01Example()
        {
            // stage
            
            stage.align      = StageAlign.TOP_LEFT ;
            stage.scaleMode  = StageScaleMode.NO_SCALE ;
            
            // target
            
            mc               = getChildByName("mc") as MovieClip ; // MovieClip in the stage of the application
            mc.useHandCursor = true ;
            mc.buttonMode    = true ;
            
            mc.addEventListener( MouseEvent.CLICK , click ) ;
            
            trace("Click the movieclip to start the example.");
            
            // timeline inspector
            
            var inspector:TimelineInspector = new TimelineInspector( mc , true ) ;
            
            inspector.mode = TimelineInspector.TIMELINE ;
            
            inspector.addEventListener( FrameLabelEvent.FRAME_LABEL, frameLabel ) ; 
        }
        
        public var mc:MovieClip ;
        
        /**
         * Run the test.
         */
        public function click( e:MouseEvent ):void
        {
            mc.play() ;
        }
        
        /**
         * Invoked when a new frame label notify a FrameLabelEvent.
         */
        public function frameLabel( e:FrameLabelEvent ):void
        {
            if ( id > 0 )
            {
                clearTimeout( id ) ;
            }
            var frame:FrameLabel = e.frameLabel ;
            trace( "frameLabel :: " + frame.frame + " : " + frame.name ) ;
            switch( frame.name )
            {
                case "finish" :
                {
                    mc.stop() ;
                    break ;
                }
                case "middle" :
                {
                    //mc.gotoAndStop(0) ;
                    mc.stop() ;
                    id = setTimeout( mc.play , 5000) ; // pause 5 seconds
                    break ;
                }
            }
        }
        
        protected var id:uint ;
    }
}
