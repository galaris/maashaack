/*
  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at
  http://www.mozilla.org/MPL/
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the
  License.
  
  The Original Code is [maashaack framework].
  
  The Initial Developers of the Original Code are
  Zwetan Kjukov <zwetan@gmail.com> and Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developers are Copyright (C) 2006-2011
  the Initial Developers. All Rights Reserved.
  
  Contributor(s):
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
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
