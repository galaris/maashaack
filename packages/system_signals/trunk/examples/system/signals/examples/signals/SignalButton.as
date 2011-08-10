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

package examples.signals
{
    import system.signals.Signal;
    import system.signals.Signaler;
    
    import flash.display.Sprite;
    import flash.events.MouseEvent;
    
    /**
     * Use composition with the Signaler interface over a Sprite.
     */
    public class SignalButton extends Sprite implements Signaler
    {
        public function SignalButton( width:Number = 160 , height:Number = 20 , color:Number = 0xA2A2A2 ):void
        {
            _signal = new Signal( [ String , SignalButton ] ) ;
            addEventListener( MouseEvent.CLICK , _click ) ;
            graphics.beginFill( color ) ;
            graphics.drawRect( 0 , 0 , width , height ) ;
            buttonMode    = true ;
            mouseEnabled  = true ;
            useHandCursor = true ;
        }
        
        public function get length():uint
        {
            return _signal.length ;
        }
        
        public function connect( receiver:* , priority:uint = 0 , autoDisconnect:Boolean = false ):Boolean
        {
            return _signal.connect( receiver , priority , autoDisconnect ) ;
        }
        
        public function connected():Boolean
        {
            return _signal.connected() ;
        }
        
        public function disconnect( receiver:* = null ):Boolean
        {
            return _signal.disconnect( receiver ) ;
        }
        
        public function emit( ...values:Array ):void
        {
            _signal.emit.apply( values ) ;
        }
       
        public function hasReceiver( receiver:* ):Boolean
        {
            return _signal.hasReceiver( receiver ) ;
        }
        
        private var _signal:Signal ;
        
        private function _click( e:MouseEvent ):void
        {
            _signal.emit( "click" , this ) ;
        }
    }
}