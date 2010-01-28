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
    import system.console;
    import system.events.ActionEvent;
    import system.process.ActionURLStream;
    import system.diagnostics.TextFieldConsole;
    
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.net.URLRequest;
    import flash.net.URLStream;
    import flash.text.TextField;
    import flash.text.TextFormat;
    
    [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]
    
    /*
     * -default-size 740 480 -default-frame-rate 31 -default-background-color 0x666666 
     * -define+=API::RT_0_2_5,false -define+=TAMARIN::exclude,true -define+=TAMARIN::alternate,false -define+=API::FP_10_0,true 
     * -target-player=10.0.0
     */
    
    /**
     * Basic example to use the system.process.ActionURLStream process.
     */
    public class ActionURLStreamExample extends Sprite
    {
        
        public function ActionURLStreamExample()
        {
            // init
            
            stage.align     = StageAlign.TOP_LEFT;
            stage.scaleMode = StageScaleMode.NO_SCALE;
            
            textfield                   = new TextField() ;
            textfield.defaultTextFormat = new TextFormat( "Courier New" , 14 , 0xFFFFFF ) ; 
            textfield.multiline         = true ;
            textfield.selectable        = true ;
            textfield.wordWrap          = true ;
                
            addChild( textfield ) ;
                
            stage.addEventListener( Event.RESIZE , resize ) ;
            resize() ;
            
            console = new TextFieldConsole( textfield ) ;
            
            // test
            
            var url:String = "datas/config.eden" ;
            
            var loader:URLStream = new URLStream() ;
            
            var process:ActionURLStream = new ActionURLStream(loader) ;
            
            process.addEventListener(ActionEvent.START, start) ;
            process.addEventListener(ActionEvent.FINISH, finish) ;
            
            process.request = new URLRequest(url) ;
            process.run() ;
        }
        
        public function finish( e:ActionEvent ):void 
        {
            console.writeLine(e) ;
        }
        
        public function start( e:ActionEvent ):void 
        {
            console.writeLine(e) ;
        }
        
        /**
         * The debug textfield of this application.
         */
        protected var textfield:TextField ;
        
        /**
         * Invoked to resize the application content.
         */
        protected function resize( e:Event = null ):void
        {
            textfield.width  = stage.stageWidth ;
            textfield.height = stage.stageHeight ;
        }
    }
}
