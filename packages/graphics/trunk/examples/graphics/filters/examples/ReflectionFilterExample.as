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
    import graphics.filters.ReflectionFilter;
    
    import flash.display.Sprite;
    import flash.display.StageScaleMode;
    import flash.media.Camera;
    import flash.media.Video;
    
    [SWF(width="760", height="480", frameRate="24", backgroundColor="#666666")]
    
    /**
     * Test the graphics.filters.ReflectionFilter class, this example work only with a FP10 or sup.
     */
    public class ReflectionFilterExample extends Sprite 
    {
        public function ReflectionFilterExample()
        {
            // stage
            
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            
            // container
            
            var container:Sprite = new Sprite() ;
            
            container.x = 75 ;
            container.y = 60 ;
            
            container.graphics.beginFill( 0x000000 ) ;
            container.graphics.drawRect( 0 , 0 , 320 , 240 ) ;
            
            addChild( container ) ;
            
            // filter
            
            var filter:ReflectionFilter = new ReflectionFilter() ;
            
            filter.bottomExtension = container.height ;
            
            filter.alpha  = 0.5  ; // alpha of the reflection
            filter.size   = 55   ; // size of the reflection
            filter.height = 240  ; // size of the display
            
            container.filters = [ filter ] ;
            
            // video
            
            var video:Video = new Video() ;
            
            video.attachCamera( Camera.getCamera() ) ;
            
            container.addChild( video ) ;
        }
    }
}
