/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [MaasHaack framework]
  
  The Initial Developer of the Original Code is
  Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  
*/

package system.text.jsmin 
{

    /**
     * The enumeration of the levels to minimize a javascript expression.
     * @author eKameleon
     */
    public class JSMinifierLevel 
    {
    	
    	/**
    	 * The agressive level remove any linefeed and doesn't take care of potential missing semicolons (can be regressive).
    	 */
    	public static const AGRESSIVE:int = 3 ;
    	
    	/**
    	 * The minimal level keep linefeeds if single.
    	 */
    	public static const MINIMAL:int = 1 ;
    	
    	/**
    	 * The normal level with the standard algorithm.
    	 */
    	public static const NORMAL:int = 2 ;
    	
    	/**
    	 * Returns a valid level value between 1 and 3 with the specified value in argument.
    	 * @return a valid level value between 1 and 3 with the specified value in argument.
    	 */
    	public function getLevel( value:int ):int
    	{
    	   return ( value < 1 || value > 3 ) ? NORMAL : value ;	
    	}
    	
    }
}
