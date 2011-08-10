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
    import graphics.filters.Filters;
    
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.display.StageScaleMode;
    import flash.events.KeyboardEvent;
    import flash.filters.BlurFilter;
    import flash.filters.DropShadowFilter;
    import flash.ui.Keyboard;
    
    [SWF(width="760", height="480", frameRate="24", backgroundColor="#666666")]
    
    /**
     * Test the graphics.filters.Filters class.
     */
    public class FiltersExample extends Sprite 
    {
        public function FiltersExample()
        {
            /////
            
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
            
            /////
            
            var shape:Shape = new Shape() ;
            
            shape.graphics.beginFill( 0xFF0000 ) ;
            shape.graphics.drawRect( 0 , 0 ,50 , 50 ) ;
            
            shape.x = 50 ;
            shape.y = 50 ;
            
            addChild( shape ) ;
            
            /////
            
            effects = new Filters( shape ) ;
            
            effects.addFilter( blur ) ;
            effects.addFilter( shadow ) ;
        }
        
        public var blur:BlurFilter = new BlurFilter(10,5,3) ;
        
        public var effects:Filters ;
        
        public var shadow:DropShadowFilter = new DropShadowFilter(2,45,0,0.7,10,10,1,3) ;
        
        public function keyDown( e:KeyboardEvent ):void
        {
            var code:uint = e.keyCode ;
            switch( code )
            {
                case Keyboard.UP :
                {
                    blur.blurX      = 10 ;
                    shadow.distance = 2  ;
                    shadow.angle    = 45 ;
                    break ;
                }
                case Keyboard.DOWN :
                {
                    blur.blurX      = 20 ;
                    shadow.distance = 6  ;
                    shadow.angle    = 90 ;
                    break ;
                }
            }
            effects.update() ;
        }
    }
}
