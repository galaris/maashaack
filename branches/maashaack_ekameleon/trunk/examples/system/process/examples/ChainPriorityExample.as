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
    import examples.process.PriorityTask;

    import system.process.Action;
    import system.process.Chain;
    import system.process.Pause;
    
    import flash.display.Sprite;
    
    [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]
    
    /**
     * Basic example to use the system.process.Chain class with the priority option in the addAction method.
     * <p><b>Run the example :</b></p>
     * <pre>
     * #start
     * #progress current:[Pause duration:3s]
     * #progress current:[PriorityTask name:task3 priority:150]
     * #progress current:[Pause duration:1s]
     * #progress current:[PriorityTask name:task2 priority:75]
     * #progress current:[Pause duration:4s]
     * #progress current:[PriorityTask name:task1 priority:25]
     * #progress current:[Pause duration:2s]
     * #finish
     * </pre>
     */
    public class ChainPriorityExample extends Sprite
    {
        public function ChainPriorityExample()
        {
            chain = new Chain() ;
            
            chain.finishIt.connect( finish ) ;
            chain.progressIt.connect( progress ) ;
            chain.startIt.connect( start ) ;
            
            // use the priority argument
            
            chain.addAction( new Pause(1) , 100 ) ;
            chain.addAction( new Pause(2) , 1   ) ;
            chain.addAction( new Pause(3) , 200 ) ;
            chain.addAction( new Pause(4) , 50  ) ;
            
            // use Priority task objects
            
            chain.addAction( new PriorityTask( "task1" , 25  ) ) ;
            chain.addAction( new PriorityTask( "task2" , 75  ) ) ;
            chain.addAction( new PriorityTask( "task3" , 150 ) ) ;
            
            chain.run() ;
        }
        
        public var chain:Chain ;
        
        public function finish( action:Action ):void
        {
            trace( "#finish" ) ;
        }
        
        public function progress( action:Action ):void
        {
            trace( "#progress current:" + chain.current ) ;
        }
        
        public function start( action:Action ):void
        {
            trace( "#start" ) ;
        }
    }
}
