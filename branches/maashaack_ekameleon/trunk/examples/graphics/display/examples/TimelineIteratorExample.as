/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package examples 
{
    import graphics.display.TimelineIterator;
    
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    
    /**
     * Example with the graphics.display.TimelineIterator class.
     */
    public dynamic class TimelineIteratorExample extends Sprite 
    {
        public function TimelineIteratorExample()
        {
            stage.align      = StageAlign.TOP_LEFT ;
            stage.scaleMode  = StageScaleMode.NO_SCALE ;
            
            var mc:MovieClip = getChildByName("mc") as MovieClip ;
            
            it = new TimelineIterator( mc , 2 ) ;
            
            trace( "timeline current frame : " + it.currentFrame ) ;
            trace( "timeline total frames  : " + it.totalFrames ) ;
            
            stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
        }
        
        public var it:TimelineIterator ;
        
        /**
         * Invoked when key is down.
         */
        public function keyDown( e:KeyboardEvent ):void
        {
            var code:uint = e.keyCode ;
            switch(code)
            {
                case Keyboard.LEFT :
                {
                    if ( it.hasPrevious() )
                    {
                        it.previous() ;
                    }
                    else
                    {
                        it.last() ;
                    }
                    break ;
                }
                case Keyboard.RIGHT :
                {
                    if ( it.hasNext() )
                    {
                        it.next() ;
                    }
                    else
                    {
                        it.reset() ;
                    }
                    break ;
                }
            }
            trace( "timeline : " + it.currentFrame + " | " + it.totalFrames + " | frame label : " + it.currentLabel ) ; 
        }
    }
}
