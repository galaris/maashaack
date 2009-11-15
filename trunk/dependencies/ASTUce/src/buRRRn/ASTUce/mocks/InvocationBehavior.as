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
     * This class provides a container to prepare a method to invoke.
     */
    public class InvocationBehavior
    {

        /**
         * Creates a new InvocationBehavior.
         * @param caller The caller scope of the method to invoke.
         * @param method The method to invoke.
         * @param arguments The arguments passed-in the method.
         */
        public function InvocationBehavior( caller:* , method:String , arguments:Array )
        {
            this.caller    = caller    ;
            this.method    = method    ;
            this.arguments = arguments ;
        }
        
        /**
         * The caller scope of the method to invoke.
         */
        public var caller:* ;
        
        /**
         * The method to invoke.
         */
        public var method:String ;
        
        /**
         * The arguments passed-in the method.
         */
        public var arguments:Array ;
        
    }
}
