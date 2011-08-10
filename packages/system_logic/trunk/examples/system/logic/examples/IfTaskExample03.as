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
    import flash.display.Sprite;
    import system.logic.ElseIf;
    import system.logic.IfTask;
    import system.rules.False;
    import system.rules.True;
    
    [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]
    
    /**
     * Example, use IfTask class with addElseIf method.
     */
    public class IfTaskExample03 extends Sprite
    {
        public function IfTaskExample03()
        {
            ////////
            
            var task1:IfTask = new IfTask( false , new Message("then #1") , new Message("else #1")  ) ;
            
            task1.addElseIf( false , new Message("elseif #1-1") ) ;
            task1.addElseIf( true  , new Message("elseif #1-2") ) ;
            
            task1.run() ;
            
            ////////
            
            var task2:IfTask = new IfTask( false , new Message("then #2") , new Message("else #2")  ) ;
            
            task2.addElseIf( false , new Message("elseif #2-1") )
                 .addElseIf( false , new Message("elseif #2-2") )
                 .addElseIf( true  , new Message("elseif #2-3") ) ;
            
            task2.run() ;
            
            ////////
            
            var task3:IfTask = new IfTask( false , new Message("then #3") , new Message("else #3")  ) ;
            
            task3.addElseIf
            (
                new ElseIf( false , new Message( "elseif #3-1") ) , 
                new ElseIf( true  , new Message( "elseif #3-2") ) , 
                new ElseIf( true  , new Message( "elseif #3-3") ) 
            ) ;
            
            task3.run() ;
            
            ////////
            
            var cond:Boolean = true ;
            
            var task4:IfTask = new IfTask
            (
                // condition
                false , 
                
                // then
                new Message("then #4") , 
                
                // else
                new Message("else #4") ,
                
                // ...elseif
                new False(cond) , new Message("elseif #4-1") ,
                new ElseIf( new False(cond) , new Message( "elseif #4-2") ) , 
                new True(cond) , new Message("elseif #4-3") 
            ) ;
            
            task4.run() ;
        }
    }
}
