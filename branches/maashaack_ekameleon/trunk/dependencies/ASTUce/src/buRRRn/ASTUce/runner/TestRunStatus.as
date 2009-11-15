
/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [ASTUce: ActionScript Test Unit compact edition AS3]. 
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
*/

package buRRRn.ASTUce.runner
    {
    
    /**
     * The TestRunStatus class.
     */
    public class TestRunStatus
        {
        	
        /**
         * @private
         */
        private var _value:int;
        
        /**
         * Creates a new TestRunStatus instance.
         * @param value The status value of this instance.
         */
        public function TestRunStatus(value:int)
            {
            _value = value;
            }
        
        /**
         * The error TestRunStatus constante (1).
         */
        public static const error:TestRunStatus   = new TestRunStatus( 1 ) ;

        /**
         * The failure TestRunStatus constante (2).
         */
        public static const failure:TestRunStatus = new TestRunStatus( 2 ) ;
        
        }
    
    }

