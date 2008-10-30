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

package system.data.maps 
{
    import buRRRn.ASTUce.framework.TestCase;                    

    public class MapFormatterTest extends TestCase 
    {

        public function MapFormatterTest( name:String = "" )
        {
            super( name );
        }
        
        public function testFormat():void
        {
            var result:String ;
            
            result = MapFormatter.format() ;
            assertEquals(result, "", "1 - The MapFormatter format method failed, must return a \"\" if the method has 0 argument.") ;
            
            result = MapFormatter.format(new HashMap()) ;   
            assertEquals(result, "{}" , "2 - The MapFormatter format method failed with an empty Map.") ;
            
            result = MapFormatter.format(new HashMap(["key1"], ["value1"])) ;   
            assertEquals(result, "{key1:value1}" , "3 - The MapFormatter format method failed with a Map whith one entry inside.") ;
            
            result = MapFormatter.format(new HashMap(["key1", "key2"], ["value1", "value2"])) ;   
            assertTrue
            (
                result == "{key1:value1,key2:value2}" || "{key2:value2,key1:value1}" , 
                "4 - The MapFormatter format method failed with a Map whith two entries inside."
            ) ;
            
        }         
        
    }
}
