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
    import core.dump;

    import system.models.Model;
    import system.models.maps.OrderedMapModel;

    import flash.display.Sprite;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    
    [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]
    
    public class OrderedMapModelExample extends Sprite 
    {
        public function OrderedMapModelExample()
        {
            model = new OrderedMapModel() ;
            
            model.added.connect( added ) ; 
            model.changed.connect( changed ) ;
            
            var count:uint = 4 ;
            
            for (var i:int ; i < count ; i++ ) 
            {
                model.add( { id : i , filter : i << 1 } ) ;
            }
            
            model.run() ;
            
            stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
        }
        
        public var model:OrderedMapModel ;
        
        public function added( entry:Object , model:Model ):void
        {
            trace( "add entry:" + dump(entry) + " in " + model ) ;
        }
        
        public function changed( entry:Object , model:Model ):void
        {
            trace( "change entry:" + dump(entry) ) ;
        }
        
        public function keyDown( e:KeyboardEvent ):void
        {
            var code:uint = e.keyCode ;
            switch( code )
            {
                case Keyboard.LEFT :
                {
                    model.previous() ;
                    // trace( "hasPrevious:" + model.hasPrevious() ) ;
                    break ;
                }
                case Keyboard.RIGHT :
                {
                    model.next() ;
                    // trace( "hasNext:" + model.hasNext() ) ;
                    break ;
                }
                case Keyboard.SPACE :
                {
                    model.loop = !model.loop ;
                    trace( "loop:" + model.loop ) ;
                    break ;
                }
            }
        }
    }
}