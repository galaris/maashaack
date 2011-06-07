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
    import core.reflect.getClassPath;
    import core.reflect.getDefinitionByName;
    
    import system.process.Action;
    import system.process.Task;
    import system.rules.BooleanRule;
    import system.rules.Rule;
    
    /**
     * Perform some tasks based on whether a given condition holds true or not.
     * <p>{if}{then}{..elseif}{else} condition block</p>
     * <p>Usage :</p>
     * <pre>
     * var task:IfTask = new IfTask( rule:Rule    , thenTask:Action , elseTask:Action , ...elseIfTasks:Array )
     * var task:IfTask = new IfTask( rule:Boolean , thenTask:Action , elseTask:Action , ...elseIfTasks:Array )
     * </pre>
     */
    public class IfTask extends Task
    {
        /**
         * Creates a new IfTask instance.
         * @param rule The conditional rule of the task. Can be a Rule object or a Boolean value.
         * @param thenTask The Action reference to defines the 'then' block in the 'if' conditional task.
         * @param elseTask The Action reference to defines the 'else' block in the 'if' conditional task.
         * @param ...elseIfTasks The Array of ElseIf instance to initialize the 'elseif' blocks in the 'if' conditional task.
         */
        public function IfTask( rule:* = null , thenTask:Action = null , elseTask:Action = null , ...elseIfTasks:Array )
        {
            _elseIfTasks = new Vector.<ElseIf>() ;
            if ( rule )
            {
                _rule = ( rule is Rule ) ? rule : new BooleanRule( rule ) ;
            }
            _thenTask = thenTask  ;
            _elseTask = elseTask  ;
            if ( elseIfTasks && elseIfTasks.length > 0 )
            {
                addElseIf.apply( this , elseIfTasks ) ;
            }
        }
        
        /**
         * Returns the shallow copy of the object.
         * @return the shallow copy of the object.
         */
        public override function clone():*
        {
            var clazz:Class  = getDefinitionByName( getClassPath(this) ) as Class;
            var clone:IfTask = new clazz() as IfTask ;
            clone.addRule(_rule) ;
            clone.addThen(_thenTask) ;
            clone.addElse(_elseTask) ;
            if ( clone && _elseIfTasks.length > 0 )
            {
                for each( var ei:ElseIf in _elseIfTasks )
                {
                    clone.addElseIf( ei ) ;
                }
            }
            return clone ;
        }
        
        /**
         * Indicates if the class throws errors or notify a finished event when the task failed.
         */
        public var throwError:Boolean ;
        
        /**
         * Defines the action when the condition block use the else condition.
         * @param action The action to defines with the else condition in the IfTask reference.
         * @return The current IfTask reference.
         * @throws Error if an 'else' action is already register.
         */
        public function addElse( action:Action ):IfTask
        {
            if ( _elseTask ) 
            {
                throw new Error( this + " addElse failed, you must not nest more than one <else> into <if>");
            }
            else
            {
                _elseTask = action ;
            }
            return this ;
        }
        
        /**
         * Defines an action when the condition block use the elseif condition.
         * @param condition The condition of the 'elseif' element.
         * @param task The task to invoke if the 'elseif' condition is succeed.
         * @return The current IfTask reference.
         * @throws Error The condition and action reference not must be null.
         */
        public function addElseIf( ...elseIfTask:Array  ):IfTask
        {
            if ( elseIfTask && elseIfTask.length > 0 )
            {
                var ei:ElseIf ;
                var len:int = elseIfTask.length ;
                for( var i:int ; i<len ; i++ )
                {
                    ei = null ;
                    if( elseIfTask[i] is ElseIf )
                    {
                        ei = elseIfTask[i] as ElseIf ;
                    }
                    else if ( (elseIfTask[i] is Rule || elseIfTask[i] is Boolean ) && elseIfTask[i+1] is Task )
                    {
                        ei = new ElseIf( elseIfTask[i] , elseIfTask[i+1] ) ;
                        i++ ;
                    }
                    if ( ei )
                    {
                        _elseIfTasks.push( ei ) ;
                    }
                }
            }
            return this ;
        }
        
        /**
         * Defines the main conditional rule of the task.
         * @param rule The main Rule of the task.
         * @return The current IfTask reference.
         * @throws Error if a 'condition' is already register.
         */
        public function addRule( rule:* ):IfTask
        {
            if ( _rule ) 
            {
                throw new Error( this + " addCondition failed, you must not nest more than one <condition> into <if>");
            }
            else
            {
                _rule = ( rule is Rule ) ? rule : new BooleanRule(rule) ;
            }
            return this ;
        }
        
        /**
         * Defines the action when the condition block success and must run the 'then' action.
         * @param action Defines the 'then' action in the IfTask reference.
         * @return The current IfTask reference.
         * @throws Error if the 'then' action is already register.
         */
        public function addThen( action:Action ):IfTask
        {
            if ( _thenTask ) 
            {
                throw new Error( this + " addThen failed, you must not nest more than one <then> into <if>");
            }
            else
            {
                _thenTask = action ;
            }
            return this ;
        }
        
        /**
         * Removes the 'then' action.
         * @return The current IfTask reference.
         */
        public function removeAllElseIf():IfTask
        {
            _elseIfTasks.length = 0 ;
            return this ;
        }
        
        /**
         * Removes the 'else' action.
         * @return The current IfTask reference.
         */
        public function removeElse():IfTask
        {
            _elseTask = null ;
            return this ;
        }
        
        /**
         * Removes the 'conditional rule' of the task.
         * @return The current IfTask reference.
         */
        public function removeRule():IfTask
        {
            _rule = null ;
            return this ;
        }
        
        /**
         * Removes the 'then' action.
         * @return The current IfTask reference.
         */
        public function removeThen():IfTask
        {
            _thenTask = null ;
            return this ;
        }
        
        /**
         * Run the process.
         */
        public override function run( ...arguments:Array ):void 
        {
            _done = false ;
            
            if ( running )
            {
                return ;
            }
            
            notifyStarted() ;
            
            if ( throwError && !_rule )
            {
                throw new Error( this + " run failed, the 'conditional rule' of the task not must be null.") ;
            }
            
            if ( _rule && _rule.eval() )
            {
                if( _thenTask )
                {
                    _execute( _thenTask ) ;
                }
                else if ( throwError )
                {
                    throw new Error( this + " run failed, the 'then' action not must be null.") ;
                }
            }
            else
            {
                if ( _elseIfTasks.length > 0 )
                {
                    var ei:ElseIf ;
                    var len:int = _elseIfTasks.length ;
                    for (var i:int ; (i<len) && !_done ; i++ )
                    {
                        ei = _elseIfTasks[i] as ElseIf ;
                        if ( ei.eval() )
                        {
                            _execute( ei.then ) ;
                        }
                    }
                }
                
                if( !_done && _elseTask )
                {
                    _execute( _elseTask ) ;
                }
            }
            
            if( !_done )
            {
                if ( throwError )
                {
                    throw new Error( this + " run failed, the 'then' action not must be null.") ;
                }
                else
                {
                    notifyFinished() ;
                }
            }
        }
        
        /**
         * @private
         */
        protected var _rule:Rule ;
        
        /**
         * @private
         */
        protected var _done:Boolean ;
        
        /**
         * @private
         */
        protected var _elseIfTasks:Vector.<ElseIf> ;
        
        /**
         * @private
         */
        protected var _elseTask:Action ;
        
        /**
         * @private
         */
        protected var _thenTask:Action ;
        
        /**
         * @private
         */
        protected function _execute( action:Action ):void
        {
            if ( action )
            {
                _done = true ;
                action.finishIt.connect( _finishTask , 1 , true ) ;
                action.run() ;
            }
        }
        
        /**
         * @private
         */
        protected function _finishTask( a:Action ):void
        {
            notifyFinished() ;
        }
    }
}
