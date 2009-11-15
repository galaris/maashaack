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
     * The ArgumentsMatcher class.
     */
    public class ArgumentMatcher 
    {
        
        /**
         * Matches the expected and actual arguments.
         */
        public static function matches( expected:*, actual:* ):* 
        {
            if( expected == null ) 
            {
                return _match( expected, actual );
            } 
            else if( expected is TypeOf && actual is TypeOf) 
            {
                return _match( expected.type , actual.type );
            } 
            else if( expected is Array ) 
            {
                return _matchArrays(expected as Array , actual as Array ) ;
            } 
            else 
            {
                return _match( expected, actual ) ;
            }
        }
        
        /**
         * @private
         */
        private static function _match( expected:* , actual:* ):Boolean 
        {
            return expected == actual ;
        }

        /**
         * @private
         */
        private static function _matchArrays( expected:Array , actual:Array ):Boolean 
        {
            if ( actual == null)
            { 
                return false ;
            }

            if( !( actual is Array ) )
            {
                return false ;
            }
            if( expected.length != actual.length )
            {
                return false;
            }
            var size:int = expected.length ;
            for( var i:int = 0 ; i < size ; i++ ) 
            {
                if( !matches(expected[i], actual[i]) )
                {
                    return false ;
                }
            }
            return true;
        }        
        
    }
}
