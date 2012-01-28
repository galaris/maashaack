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
package system.rules
{
    /**
     * Used to perform a logical disjunction on two conditions or more.
     * <p><b>Example :</b></p>
     * <listing version="3.0">
     * <code class="prettyprint">
     * import system.rules.BooleanRule ;
     * import system.rules.Or ;
     * import system.rules.Rule ;
     * 
     * var rule1:Rule = new BooleanRule( true ) ;
     * var rule2:Rule = new BooleanRule( false ) ;
     * var rule3:Rule = new BooleanRule( true ) ;
     * 
     * var o:Or ;
     * 
     * o = new Or( rule1 , rule1 ) ;
     * trace( o.eval() ) ; // true
     * 
     * o = new Or( rule1 , rule2 ) ;
     * trace( o.eval() ) ; // true
     * 
     * o = new Or( rule2 , rule1 ) ;
     * trace( o.eval() ) ; // true
     * 
     * o = new Or( rule2 , rule2 ) ;
     * trace( o.eval() ) ; // false
     * 
     * o = new Or( rule1 , rule2 , rule3 ) ;
     * trace( o.eval() ) ; // true
     * 
     * o = new Or( rule1 , rule3 , rule2 ) ;
     * trace( o.eval() ) ; // true 
     * </code>
     * </listing>
     */
    public class Or implements Rule
    {
        /**
         * Creates a new Or instance.
         * @param rule1 The first conditional rule to evaluate.
         * @param rule2 The second conditional rule to evaluate.
         */
        public function Or( rule1:Rule , rule2:Rule , ...rules:Array )
        {
            this.rules = new Vector.<Rule>() ;
            this.rules.push( rule1 ) ;
            this.rules.push( rule2 ) ;
            if ( rules && rules.length > 0 )
            {
                var len:uint = rules.length ;
                for( var i:int ; i<len ; i++ )
                {
                    if( rules[i] is Rule )
                    {
                        this.rules.push(rules[i]) ;
                    }
                }
            }
        }
        
        /**
         * The collection of all rules to evaluate.
         */
        public var rules:Vector.<Rule> ;
        
        /**
         * Evaluates the specified rule.
         */
        public function eval():Boolean
        {
            if( rules.length > 0 )
            {
                var b:Boolean = rules[0].eval() ;
                var l:uint    = rules.length ;
                for ( var i:uint = 1 ; i<l ; i++ )
                {
                    b ||= rules[i].eval() ;
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
