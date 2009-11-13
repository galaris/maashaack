
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
  
    - Alcaraz Marc (aka eKameleon) <vegas@ekameleon.net> (2007-2008)

*/
package buRRRn.ASTUce.framework
    {
    
    /**
     * A Protectable can be run and can throw errors.
     * @see TestResult
     */
    public dynamic class Protectable
        {
        
        /**
         * Creates a new Protectable instance.
         */
        public function Protectable()
            {
            
            }
        
        /**
         * Runs the the following method protected.
         * <p><b>Note :</b> yes, you have to define this method in the prototype so it can be dynamically overrided</p>
         */
        prototype.protect = function():void
            {
            
            };
        
        }
    
    }

