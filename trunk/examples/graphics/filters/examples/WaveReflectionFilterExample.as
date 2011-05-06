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
    import graphics.filters.WaveReflectionFilter;

    import flash.display.Loader;
    import flash.display.Sprite;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.events.MouseEvent;
    import flash.net.URLRequest;
    
    [SWF(width="280", height="280", frameRate="24", backgroundColor="#666666")]
    
    /**
     * Test the graphics.filters.WaveReflectionFilter class, this example work only with a FP10 or sup.
     */
    public class WaveReflectionFilterExample extends Sprite 
    {
        public function WaveReflectionFilterExample()
        {
            // stage
            
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            
            // picture
            
            picture = new Loader() ;
            
            picture.addEventListener( MouseEvent.MOUSE_OVER , mouseOver ) ;
            picture.addEventListener( MouseEvent.MOUSE_OUT  , mouseOut   ) ;
            
            picture.x = 20 ;
            picture.y = 20 ;
            
            picture.load( new URLRequest("library/picture.jpg") ) ;
            
            addChild( picture ) ;
            
            filter = new WaveReflectionFilter() ;
            
            filter.amplitude = 0.3 ;
            filter.frequency = 0.1 ;
            filter.progress  = 0 ;
            
            picture.filters = [ filter ] ;
        }
        
        public var filter:WaveReflectionFilter ;
        
        public var picture:Loader ;
        
        protected function mouseOut( e:Event ):void
        {
            if ( filter )
            {
                removeEventListener(Event.ENTER_FRAME , render ) ;
            }
        }
        
        protected function mouseOver( e:Event ):void
        {
            if ( filter )
            {
                addEventListener(Event.ENTER_FRAME , render ) ;
            }
        }
        
        public function render( e:Event ):void
        {
            if ( filter )
            {
                filter.progress += 0.001 ;
                
                if ( filter.progress > 0.98 )
                {
                    filter.progress = 0 ;
                }
                
                trace( filter.progress ) ;
                
                picture.filters = [ filter ] ;
            }
        }
    }
}
