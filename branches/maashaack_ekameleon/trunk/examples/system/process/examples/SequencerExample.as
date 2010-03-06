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

package examples
{
    import system.events.ActionEvent;
    import system.process.ActionProxy;
    import system.process.Pause;
    import system.process.Sequencer;
    
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.KeyboardEvent;
    
    [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]
    
    /**
     * Example to use the system.process.Sequencer.
     */
    public class SequencerExample extends Sprite
    {
        
        public function SequencerExample()
        {
            var o:Object = {} ;
            o.toString = function():String 
            {
                return "myObject" ;
            };
            
            var execute:Function = function ():void 
            {
                trace ("\t" + this + " :: execute") ;
            };
            
            var proxy:ActionProxy = new ActionProxy(o, execute) ;
            
            seq = new Sequencer() ;
            
            seq.addEventListener( ActionEvent.FINISH   , debug ) ;
            seq.addEventListener( ActionEvent.PROGRESS , progress ) ;
            seq.addEventListener( ActionEvent.START    , debug ) ;
            
            seq.addAction( new Pause(4, true) ) ;
            seq.addAction( new ActionProxy(o, execute) ) ;
            seq.addAction( new Pause(6, true) ) ;
            seq.addAction( new ActionProxy(o, execute) ) ;
            seq.addAction( new Pause(3, true) ) ;
            seq.addAction( proxy ) ;
            
            trace ("# Press a key to run...") ;
            
            stage.addEventListener( KeyboardEvent.KEY_DOWN , onKeyDown ) ;
        }
        
        public var seq:Sequencer ;
        
        public function debug( e:ActionEvent ):void 
        {
            trace ( e ) ;
        }
        
        public function onKeyDown( e:KeyboardEvent):void 
        {
            if (!seq.running) 
            {
                seq.start() ;
            }
            else 
            {
                seq.stop() ;
            }
        }
        
        public function progress( e:Event ):void 
        {
            var type:String      = e.type as String ;
            var target:Sequencer = e.target as Sequencer ;
            trace ( target + " :: progress -> " + type + " >> " + ( target.size() || 0) + " :: " + target.current ) ;
        }
    }
}
