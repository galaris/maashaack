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
  Portions created by the Initial Developers are Copyright (C) 2006-2012
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

package system.logic
{
    import system.process.Action;
    import system.rules.Undefined;
    
    /**
     * Perform some tasks based on whether a given value is undefined.
     * <p><b>Example :</b></p>
     * <listing version="3.0">
     * <code class="prettyprint">
     * import examples.process.Message;
     * import system.process.logic.IfUndefined;
     * 
     * var task:IfUndefined ;
     * 
     * var value:&#42; ;
     * 
     * task = new IfUndefined(value,new Message("then #1"),new Message("else #1")) ;
     * task.run() ; // then #1
     * 
     * value = null ;
     * task  = new IfUndefined(value,new Message("then #2"),new Message("else #2")) ;
     * task.run() ; // else #2
     * 
     * value = "hello" ;
     * task = new IfUndefined(value,new Message("then #3"),new Message("else #3")) ;
     * task.run() ; // else #3
     * </code>
     * </listing>
     * @see system.rules.Undefined
     */
    public class IfUndefined extends IfTask
    {
        /**
         * Creates a new IfUndefined instance.
         * @param value The value to evaluate.
         * @param thenTask The Action reference to defines the 'then' block in the 'if' conditional task.
         * @param elseTask The Action reference to defines the 'else' block in the 'if' conditional task.
         * @param ...elseIfTasks The Array of ElseIf instance to initialize the 'elseif' blocks in the 'if' conditional task.
         */
        public function IfUndefined(value:*, thenTask:Action = null, elseTask:Action = null, ...elseIfTasks:Array )
        {
            super( new Undefined( value ) , thenTask , elseTask ) ;
            if ( elseIfTasks && elseIfTasks.length > 0 )
            {
                addElseIf.apply( this , elseIfTasks ) ;
            }
        }
    }
}
