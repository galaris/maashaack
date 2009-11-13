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
    import system.Reflection;    
    
    /**
     * This tool class format an Array of types.
     */
    public class ArgumentsFormatter 
    {
        
        /**
         * Returns the String representation of the array of arguments passed-in this method.
         * @return the String representation of the array of arguments passed-in this method.
         */
        public static function format( arguments:Array ):String
        {
             
            var tmp:String ;
            var formatted:String = "" ;
            var size:int        =  arguments.length ;
             
            for( var i:int = 0; i < size; i++) 
            {
                var value:* = arguments[i] ;
                if( value == null ) 
                {
                    formatted += ( formatted == "" ) ? "null" : ( ", " + "null" ) ; 
                }
                else if( value is TypeOf || value is Class ) 
                {
                    var clazz:Class = ( value is TypeOf ) ? (value as TypeOf).type : ( value as Class ) ;
                    var name:String = Reflection.getClassName(clazz) ;
                    formatted += name + ( formatted == "" ? ", " : "" ) ; 
                }
                else if( value is String ) 
                {
                    tmp = value.toString() ;
                    formatted += ( formatted == "" ) ? ( "\"" + tmp + "\"" ) : ( ", \"" + tmp + "\"" ) ; 
                }
                else if( value is Array ) 
                {
                    tmp = format( value ) ;
                    formatted += ( formatted == "" ) ? "[" + format + "]" : ", [" + format + "]"; // use eden ?
                }
                else 
                {
                    value += ( ( value == "" ) ? ""  : ", " ) + value.toString() ;
                }
            }
            return formatted ;
        } 
        
    }
}
