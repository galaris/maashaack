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
package system.rules
{
    
    /**
     * Used to perform a logical disjunction on two expressions and more.
     * <p><b>Example :</b></p>
     * <listing version="3.0">
     * <code class="prettyprint">
     * import system.rules.Condition ;
     * import system.rules.Eval ;
     * import system.rules.Or ;
     * 
     * var cond1:Condition = new Eval( true ) ;
     * var cond2:Condition = new Eval( false ) ;
     * var cond3:Condition = new Eval( true ) ;
     * 
     * var o:Or ;
     * 
     * o = new Or( cond1 , cond1 ) ;
     * trace( o.eval() ) ; // true
     * 
     * o = new Or( cond1 , cond2 ) ;
     * trace( o.eval() ) ; // true
     * 
     * o = new Or( cond2 , cond1 ) ;
     * trace( o.eval() ) ; // true
     * 
     * o = new Or( cond2 , cond2 ) ;
     * trace( o.eval() ) ; // false
     * 
     * o = new Or( cond1 , cond2 , cond3 ) ;
     * trace( o.eval() ) ; // true
     * 
     * o = new Or( cond1 , cond3 , cond2 ) ;
     * trace( o.eval() ) ; // true 
     * </code>
     * </listing>
     */
    public class Or implements Condition
    {
        /**
         * Creates a new Or instance.
         * @param condition1 The first condition to evaluate.
         * @param condition2 The second condition to evaluate.
         */
        public function Or( condition1:Condition , condition2:Condition , ...conditions:Array )
        {
            this.conditions = new Vector.<Condition>() ;
            this.conditions.push( condition1 ) ;
            this.conditions.push( condition2 ) ;
            if ( conditions && conditions.length > 0 )
            {
                var len:uint = conditions.length ;
                for( var i:int ; i<len ; i++ )
                {
                    if( conditions[i] is Condition )
                    {
                        this.conditions.push(conditions[i]) ;
                    }
                }
            }
        }
        
        /**
         * The collection of all conditions to evaluate.
         */
        public var conditions:Vector.<Condition> ;
        
        /**
         * Evaluates the specified condition.
         */
        public function eval():Boolean
        {
            if( conditions.length > 0 )
            {
                var b:Boolean = conditions[0].eval() ;
                var l:uint    = conditions.length ;
                for ( var i:uint = 1 ; i<l ; i++ )
                {
                    b ||= conditions[i].eval() ;
                }
                return b ;
            }
            else
            {
                return false ;
            }
        }
    }
}
