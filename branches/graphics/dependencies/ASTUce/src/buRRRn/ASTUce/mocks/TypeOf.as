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
     * Register a type.
     */
    public class TypeOf 
    {
        
        /**
         * Creates a new TypeOf instance.
         * @param type The type to register.
         */        
        public function TypeOf( type:Class ):void
        {
            this.type = type ;
        }
        
        /**
         * The type Class reference.
         */
        public var type:Class ;
        
        /**
         * Returns the TypeOf reference of the specified type object (class).
         * @return the TypeOf reference of the specified type object (class).
         */      
        public static function isA( type:Class ):TypeOf
        {
            return new TypeOf( type ) ;    
        }
        
    }

}
