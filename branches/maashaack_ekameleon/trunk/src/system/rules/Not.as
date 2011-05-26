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
     * Used to perform logical negation on a specific condition.
     * <p><b>Example :</b></p>
     * <listing version="3.0">
     * <code class="prettyprint">
     * import system.rules.BooleanRule ;
     * import system.rules.Not ;
     * import system.rules.Rule ;
     * 
     * var cond1:Rule = new BooleanRule( true  ) ;
     * var cond2:Rule = new BooleanRule( false ) ;
     * 
     * var no1:Not = new Not( true ) ;
     * var no2:Not = new Not( false ) ;
     * var no3:Not = new Not( cond1 ) ;
     * var no4:Not = new Not( cond2 ) ;
     * 
     * trace( no1.eval() ) ; // false
     * trace( no2.eval() ) ; // true
     * trace( no3.eval() ) ; // false
     * trace( no4.eval() ) ; // true
     * </code>
     * </listing>
     */
    public class Not implements Rule
    {
        /**
         * Creates a new Not instance.
         * @param rule The Boolean value or the Rule object to evaluate.
         */
        public function Not( rule:* = null )
        {
            this.rule = rule ;
        }
        
        /**
         * The conditional rule to evaluate.
         */
        public var rule:* ;
        
        /**
         * Evaluates the specified condition.
         */
        public function eval():Boolean
        {
            return !( ( rule is Rule ) ? (rule as Rule).eval() : Boolean( rule ) ) ;
        }
    }
}
