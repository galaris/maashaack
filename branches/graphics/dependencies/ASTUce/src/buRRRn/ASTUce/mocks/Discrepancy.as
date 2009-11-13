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
  ALCARAZ Marc <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):

*/
package buRRRn.ASTUce.mocks 
{

    /**
     * The Discrepancy class.
     */
    public class Discrepancy 
    {
        
        /**
         * Creates a new Discrepancy instance.
         */
        public function Discrepancy( message:String , behavior:InvocationBehavior )
        {
            this.message  = message ;
            this.behavior = behavior ;
        }
        
        /**
         * The behavior value.
         */
        public var behavior:InvocationBehavior ;
        
        /**
         * The message value.
         */
        public var message:String ;
        
        
        
    }
}
