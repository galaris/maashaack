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
  
*/

package buRRRn.ASTUce
{
    import system.Version ;
    
    /**
     * Stores static metadata about the project
     */
    public class metadata
    {
        public static var name:String = "ASTUce";
        
        public static var fullname:String = "ActionScript Test Unit compact edition AS3";
        
        public static var version:Version = new Version();
        
        include "version.properties"
        
        version.revision = parseInt( "$Rev: 140 $".split( " " )[1] );
        
        public static var copyright:String = "Copyright © 2006-2009 Zwetan Kjukov, All right reserved.";
        public static var origin:String    = "Made in the EU.";
    }
}