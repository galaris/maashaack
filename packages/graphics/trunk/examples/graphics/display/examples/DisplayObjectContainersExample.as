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
    import graphics.display.DisplayObjectContainers;

    import flash.display.Sprite;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;

    [SWF(width="760", height="480", frameRate="24", backgroundColor="#666666")]
    
    public class DisplayObjectContainersExample extends Sprite 
    {
        public function DisplayObjectContainersExample()
        {
            display1 = new Sprite() ;
            display1.graphics.beginFill( 0xF55B1B , 1 ) ;
            display1.graphics.drawCircle(30, 30, 30 ) ;
            
            display2 = new Sprite() ;
            display2.graphics.beginFill( 0x3D6AD3 , 1 ) ;
            display2.graphics.drawRect(0, 0, 60, 60) ;
            
            container1              = new Sprite() ;
            container1.mouseEnabled = false ;
            container1.x            = 20 ;
            container1.y            = 20 ;
            
            container2              = new Sprite() ;
            container2.mouseEnabled = false ;
            container2.x            = 150 ;
            container2.y            = 20 ;
            
            addChild( container1 );
            addChild( container2 );
            
            container1.addChild( display1 ) ;
            container2.addChild( display2 ) ;
            
            /////// stage
            
            stage.addEventListener( KeyboardEvent.KEY_DOWN , down ) ;
        }
        
        public var container1:Sprite ;
        
        public var container2:Sprite ;
        
        public var display1:Sprite ;
        
        public var display2:Sprite ;
        
        public function down( e:KeyboardEvent ):void
        {
            var code:uint = e.keyCode ;
            switch( code )
            {
                case Keyboard.SPACE :
                {
                    DisplayObjectContainers.swapChildren( display1, display2 ) ;
                    break ;
                }
                case Keyboard.DELETE :
                {
                    DisplayObjectContainers.clear( container1 ) ;
                    DisplayObjectContainers.clear( container2 ) ;
                    break ;
                }
            }
        }
    }
}
