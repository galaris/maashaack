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
     * Helper to implements each method with a unique name to avoid conflicting with other libraries that implement it.
     */
    public function eachIndexForMock( ar:Array , block:Function ):void
    {
        if ( ar == null || block == null )
        {
            return ;
        }
        var size:int = ar.length ;
        for( var i:int = 0 ; i < size ; i++ )
        {
            block( i , ar[i] ) ;
        }
        
    }

}
