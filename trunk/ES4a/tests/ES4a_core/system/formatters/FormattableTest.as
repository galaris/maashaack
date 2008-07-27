/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [ES4a: ECMAScript 4 MaasHaack framework].
  
  The Initial Developer of the Original Code is
  Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
    - Zwetan Kjukov <zwetan@gmail.com>
*/

package system.formatters 
{
    import buRRRn.ASTUce.framework.TestCase;                

    /**
     * The IFormatterTest test case.
     */
    public class FormattableTest extends TestCase 
    {

       /**
        * Creates a new IFormatterTest instance.
        */ 
        public function FormattableTest(name:String = "")
        {
            super( name );
        }
        
        public function testFormat():void
        {
            
            var formatter:ConcreteFormatter = new ConcreteFormatter() ;
            
            assertEquals( formatter.format(2) , "2" , "format method failed.") ;
            
            
        }
        
    }
}

import system.formatters.Formattable;

class ConcreteFormatter implements Formattable
{

    public function format(value:* = null):String
    {
    	return value.toString() ;
    }
}
