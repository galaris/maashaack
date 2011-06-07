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

package system.logic
{
    import system.process.Action;
    import system.rules.EmptyString;
    
    /**
     * Perform some tasks based on whether a given value is an empty string ("").
     * <p><b>Example :</b></p>
     * <listing version="3.0">
     * <code class="prettyprint">
     * package examples
     * {
     *     import system.process.logic.IfEmptyString;
     *     
     *     import flash.display.Sprite;
     *     
     *     public class IfEmptyStringExample extends Sprite
     *     {
     *         public function IfEmptyStringExample()
     *         {
     *             var task:IfEmptyString ;
     *             
     *             var value:String ;
     *             
     *             task = new IfEmptyString( value , new Then(), new Else() ) ;
     *             task.run() ; // else
     *             
     *             value = "" ;
     *             
     *             task = new IfEmptyString( value , new Then(), new Else() ) ;
     *             task.run() ; // then
     *             
     *             value = "hello" ;
     *             
     *             task = new IfEmptyString( value , new Then(), new Else() ) ;
     *             task.run() ; // then
     *         }
     *     }
     * }
     * 
     * import system.process.Task;
     * 
     * class Then extends Task 
     * {
     *     public function Then() {}
     *     
     *     public override function run( ...arguments:Array ):void
     *     {
     *         notifyStarted() ;
     *         trace( "then" ) ;
     *         notifyFinished() ;
     *     }
     * }
     * 
     * class Else extends Task 
     * {
     *     public function Else() {}
     *     
     *     public override function run( ...arguments:Array ):void
     *     {
     *         notifyStarted() ;
     *         trace( "else" ) ;
     *         notifyFinished() ;
     *     }
     * }
     * </code>
     * </listing>
     * @see system.rules.EmptyString
     */
    public class IfEmptyString extends IfTask
    {
        /**
         * Creates a new IfEmptyString instance.
         * @param value The value to evaluate.
         * @param thenTask The Action reference to defines the 'then' block in the 'if' conditional task.
         * @param elseTask The Action reference to defines the 'else' block in the 'if' conditional task.
         * @param ...elseIfTasks The Array of ElseIf instance to initialize the 'elseif' blocks in the 'if' conditional task.
         */
        public function IfEmptyString( value:* , thenTask:Action = null , elseTask:Action = null , ...elseIfTasks:Array )
        {
            super( new EmptyString( value ) , thenTask , elseTask ) ;
            if ( elseIfTasks && elseIfTasks.length > 0 )
            {
                addElseIf.apply( this , elseIfTasks ) ;
            }
        }
    }
}
