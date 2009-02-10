/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is AndromedAS Framework based on VEGAS.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/
package examples 
{
    import system.formatters.ExpressionFormatter;
    
    import flash.display.Sprite;    

    /**
     * This class provides an example of the ExpressionFormatter class.
     */
    public class ExpressionFormatterExample extends Sprite 
    {

        public function ExpressionFormatterExample()
        {
        	
            var source:String ;
            
            var exp:ExpressionFormatter      = new ExpressionFormatter() ;
            
            exp["o"]         = "test :" ;
            exp["root"]      = "c:" ;
            exp["system"]    = "{root}/project/system" ;
            exp["data.maps"] = "{system}/data/maps" ;
            exp["HashMap"]   = "{data.maps}/HashMap.as" ;
            
            source = "{o} the root : {root} - the class : {HashMap}" ; 
            // test : the root : c: - the class : c:/project/system/data/maps/HashMap.as
            
            trace( exp.format( source ) ) ;
            
            trace( "----" ) ;
            
            exp["maashaack"] = "%root%/maashaack/system/src" ;
            exp["maps"]      = "%maashaack%/data/maps" ;
            exp["HashMap"]   = "%maps%/HashMap.as" ;
            
            exp.beginSeparator = "%" ;
            exp.endSeparator   = "%" ;
            
            source = "%o% the root : %root% - the class : %HashMap%" ;
            
            trace( exp.format( source ) ) ;
            // test : the root : c: - the class : c:/maashaack/system/src/data/maps/HashMap.as
            
        }
    }
}
