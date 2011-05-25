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
  Portions created by the Initial Developers are Copyright (C) 2006-2009
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
    import examples.process.Message;
    
    import system.process.Action;
    import system.process.Chain;
    import system.process.logic.IfTask;
    import system.rules.Eval;
    
    import flash.display.Sprite;
    
    [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]
    
    /**
     * Basic example to use the system.process.Task.
     */
    public class IfTaskExample extends Sprite
    {
        public function IfTaskExample()
        {
            var chain:Chain = new Chain() ;
            
            chain.finishIt.connect( finish ) ;
            chain.startIt.connect( start )   ;
            
            ///////// example 1 : if basic
            
            var task1:IfTask = new IfTask( new Eval(true) , new Message("then true") ) ;
            
            chain.addAction( task1 ) ;
            
            ///////// example 2 : if-else
            
            var task2:IfTask = new IfTask( new Eval(false) , new Message("then true") , new Message("else false") ) ;
            
            chain.addAction( task2 ) ;
            
            ////////
            
            var task3:IfTask = new IfTask() ;
            
            task3.addCondition( new Eval(true) ).addThen( new Message("then true") ).addElse( new Message("else false") ) ;
            
            chain.addAction( task3 ) ;
            
            ////////
            
            var task4:IfTask = new IfTask() ;
            
            task4.addCondition( new Eval(false) ).addThen( new Message("then true") ).addElse( new Message("else false") ) ;
            
            chain.addAction( task4 ) ;
            
            ////////
            
            chain.run() ;
        }
        
        public function finish( action:Action ):void
        {
            trace( "---- finish" ) ;
        }
        
        public function start( action:Action ):void
        {
            trace( "---- start" ) ;
        }
    }
}
