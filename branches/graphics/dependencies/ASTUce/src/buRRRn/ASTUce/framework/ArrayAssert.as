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
  Marc Alcaraz <ekameleon@gmail.com>.

*/

package buRRRn.ASTUce.framework
    {
    
    /**
    * A set of assert methods specialized for arrays.
    */
    public class ArrayAssert extends Assert
        {
        
        /**
         * Asserts that any two Arrays are equal.
         * @throws AssertionFailedError If they are not equals.
         */   
        public static function assertEquals( expected:Array, actual:Array, message:String = "" ):void
            {
            if( expected == actual )
                {
                return;
                }
            
            var exp:String = _serialize( expected );
            var act:String = _serialize( actual );
            
            if( expected.length != actual.length )
                {
                //_failNotEquals( expected, actual, message );
                throw new ComparisonFailure( exp, act, message );
                }
            
            Assert.assertEquals( exp, act, message );
            }
        
        }
    }

