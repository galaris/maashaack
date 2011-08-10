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
    import examples.display.Square;
    
    import system.process.Batch;
    
    import flash.display.Sprite;
    import flash.events.KeyboardEvent;
    import flash.geom.Point;
    
    [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]
    
    /**
     * Basic example to use the system.process.Batch process.
     */
    public class BatchExample extends Sprite
    {
        public function BatchExample()
        {
            var s1:Square = new Square( 50 ,  50 , 0xFF0000 ) ;
            var s2:Square = new Square( 50 , 100 , 0x00FF00 ) ;
            var s3:Square = new Square( 50 , 150 , 0x0000FF ) ;
            
            s1.finish = new Point( 600 ,  50 ) ;
            s2.finish = new Point( 600 , 100 ) ;
            s3.finish = new Point( 600 , 150 ) ;
            
            addChild(s1) ;
            addChild(s2) ;
            addChild(s3) ;
            
            command = new Batch() ;
            
            command.add( s1 ) ;
            command.add( s2 ) ;
            command.add( s3 ) ;
            
            // press a key to run the batch
            
            stage.addEventListener(KeyboardEvent.KEY_DOWN, keyDown) ;
        }
        
        public var command:Batch ;
        
        public function keyDown( e:KeyboardEvent ):void
        {
        	command.run() ;
        }
    }
}
