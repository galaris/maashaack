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
     * The Mock object class.
     */
    public dynamic class Mock 
    {
        
        /**
         * Creates a new dynamic Mock object.
         */
        public function Mock( owner:MockFactory )
        {
            this.owner = owner ;
        }
        
        /**
         * The calls array representation.
         */
        public var calls:Array = [] ;
        
        /**
         * The owner reference of this mock object.
         */
        public var owner:MockFactory ;        

        /**
         * Indicates if the mock is recording.
         */
        public var recording:Boolean ;
        
        /**
         * Adds a mock method in this Mock object.
         */
        public function addMockMethod( method:* ):void
        { 
            owner.createMethod( owner , mock , method ) ; 
        }        
        
        /**
         * Expects this Mock object.
         */
        public function expects():Mock 
        {
            recording = true ; 
            return this ;
        }
                
        
    }
    
}
