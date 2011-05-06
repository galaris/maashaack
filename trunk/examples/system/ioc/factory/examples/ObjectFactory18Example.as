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
    import system.ioc.ObjectFactory;
    
    import flash.display.Sprite;
    
    /**
     * Example to use the locale attribute.
     */
    public class ObjectFactory18Example extends Sprite 
    {
        public function ObjectFactory18Example()
        {
            var factory:ObjectFactory = new ObjectFactory() ;
            
            factory.config.locale = 
            {
                errors :
                {
                    authentification_login    : "The login is invalid" ,
                    authentification_password : "The password login is invalid" 
                }
            };
            
            factory.create( context ) ; 
            
            trace( "error1 : " + factory.getObject( "error1" ) ) ; // error1 : The login is invalid
            trace( "error2 : " + factory.getObject( "error2" ) ) ; // error2 : The password login is invalid
        }
        
        public var context:Array =
        [
            { 
                id        : "error1" ,
                type      : "String" ,
                arguments : 
                [
                    { locale : "errors.authentification_login" } 
                ]
            }
            ,
            { 
                id        : "error2" ,
                type      : "String" ,
                arguments : 
                [
                    { locale : "errors.authentification_password" } 
                ]
            }
        ] ;
    }
}
