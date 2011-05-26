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
    import system.process.logic.ElseIf;
    import system.process.logic.IfTask;
    
    import system.rules.BooleanRule;
    
    import flash.display.Sprite;
    
    [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]
    
    /**
     * Basic example to use the system.process.logic.IfTask class.
     */
    public class IfTaskExample extends Sprite
    {
        public function IfTaskExample()
        {
            var chain:Chain = new Chain() ;
            
            chain.finishIt.connect( finish ) ;
            chain.startIt.connect( start )   ;
            
            ///////// example 1 : if basic
            
            var task1:IfTask = new IfTask( new BooleanRule(true) , new Message("then #1") ) ;
            
            chain.addAction( task1 ) ;
            
            ///////// example 2 : if-else
            
            var task2:IfTask = new IfTask( new BooleanRule(false) , new Message("then #2") , new Message("else #2") ) ;
            
            chain.addAction( task2 ) ;
            
            //////// example3 : use IfTask method with true condition
            
            var task3:IfTask = new IfTask() ;
            
            task3.addRule( new BooleanRule(true)  )
                 .addThen( new Message("then #3") )
                 .addElse( new Message("else #3") ) ;
            
            chain.addAction( task3 ) ;
            
            //////// example4 : use IfTask method with false condition
            
            var task4:IfTask = new IfTask() ;
            
            task4.addRule( new BooleanRule(false) )
                 .addThen( new Message("then #4") )
                 .addElse( new Message("else #4") ) ;
            
            chain.addAction( task4 ) ;
            
            //////// example5 : use elseif
            
            var task5:IfTask = new IfTask( new BooleanRule(false) , new Message("then #5") , new Message("else #5")  ) ;
            
            task5.addElseIf( new BooleanRule(true)  , new Message("elseif #5-1") ) ;
            task5.addElseIf( new BooleanRule(false) , new Message("elseif #5-2") ) ;
            
            chain.addAction( task5 ) ;
            
            //////// example6 : use elseif
            
            var task6:IfTask = new IfTask( new BooleanRule(false) , new Message("then #6") , new Message("else #6")  ) ;
            
            task6.addElseIf( new BooleanRule(false) , new Message("elseif #6-1") )
                 .addElseIf( new BooleanRule(true)  , new Message("elseif #6-2") )
                 .addElseIf( new BooleanRule(true)  , new Message("elseif #6-3") ) ;
            
            chain.addAction( task6 ) ;
            
            //////// example7
            
            var task7:IfTask = new IfTask( new BooleanRule(false) , new Message("then #7") , new Message("else #7")  ) ;
            
            task7.addElseIf
            (
                new BooleanRule(false) , new Message("elseif #7-1") ,
                new ElseIf( new BooleanRule( true ) , new Message( "elseif #7-2") ) , 
                new BooleanRule(true)  , new Message("elseif #7-3") 
            ) ;
            
            chain.addAction( task7 ) ;
            
            //////// example7
            
            var task8:IfTask = new IfTask
            (
                // condition
                new BooleanRule(false) , 
                // then
                new Message("then #8") , 
                // else
                new Message("else #8") ,
                // elseif
                new BooleanRule(false) , new Message("elseif #8-1") ,
                new ElseIf( new BooleanRule( false ) , new Message( "elseif #8-2") ) , 
                new BooleanRule(true) , new Message("elseif #8-3") 
            ) ;
            
            // task8.removeAllElseIf() ;
            
            chain.addAction( task8 ) ;
            
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
