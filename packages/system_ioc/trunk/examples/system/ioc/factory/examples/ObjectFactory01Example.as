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
    import examples.core.Civility;
    import examples.core.User;
    import examples.factory.UserFactory;
    import examples.factory.UserFilterFactory;
    
    import system.ioc.ObjectFactory;
    
    import flash.display.Sprite;
    
    /**
     * Illustrates the usage of the custom factory strategies in the IoC factory.
     */
    public class ObjectFactory01Example extends Sprite 
    {
        public function ObjectFactory01Example()
        {
            var factory:ObjectFactory = new ObjectFactory() ;
            
            factory.create( objects ) ;
            
            var user:User ;
            
            trace("------------- static method factory") ;
            
            user = factory.getObject( "user1" ) ;
            trace( "user1 pseudo : " + user ) ; // ekameleon
            
            trace("------------- method factory") ;
            
            user = factory.getObject( "user2" ) ;
            trace( "user2 pseudo : " + user ) ; // pegas
            
            user = factory.getObject( "user3" ) ;
            trace( "user3 pseudo : " + user ) ; // null
            
            trace("------------- static property factory") ;
            
            trace("civility : " + factory.getObject("man") ) ;
            
            trace("------------- property factory") ;
            
            trace("name : " + factory.getObject("name") ) ; 
            
            trace("------------- value factory") ;    
            
            trace("my_value : " + factory.getObject("my_value") ) ;
            
            trace("------------- reference factory") ;
            
            trace("my_user : " + factory.getObject("my_user") + " -> " + factory.getObject("my_user").url ) ; 
        }
        
        ///////////// linkage enforcer
        
        Civility  ; 
        UserFactory ; 
        UserFilterFactory ;
        
        ////////////
        
        public var objects:Array =
        [
            {   
                id          : "user_filter_factory"  ,
                type        : "examples.factory.UserFilterFactory" ,
                arguments   : [ { value : [ "lunas" ] } ]
            }
            ,
            {   
                id                  : "user1"     , 
                type                : "examples.core.User" , 
                staticFactoryMethod : { type:"examples.factory.UserFactory" , name:"create" , arguments:[ { value : "ekameleon" } ] }
            }
            ,
            {   
                id             : "user2" , 
                type           : "examples.core.User" , 
                factoryMethod  : { factory:"user_filter_factory" , name:"build" , arguments:[ { value:"pegas" } ] }
            }
            ,
            {   
                id             : "user3" , 
                type           : "examples.core.User" , 
                factoryMethod  : {  factory:"user_filter_factory" , name:"build", arguments:[ { value : "lunas" } ]  }
            }
            ,
            
            // examples.core property factory
            
            {   
                id                    : "man"    , 
                type                  : "String" , 
                staticFactoryProperty : { type:"examples.core.Civility" , name:"MAN" }
            }
            ,
            {   
                id              : "name"   , 
                type            : "String" , 
                factoryProperty : { factory:"user2" , name:"pseudo" }
            }
            ,
            
            // examples.core value factory
            
            {
                id           : "my_value" , 
                type         : "String"   , 
                factoryValue : new String("hello world")
            }
            ,
            
            // examples.core reference factory
            
            {   
                id               : "my_user"   , 
                type             : "examples.core.User" , 
                factoryReference : "user1"     ,
                singleton        : true        ,
                lazyInit         : true        ,
                properties       : 
                [ 
                    { name:"url" , value : "http://www.ekameleon.net/" }
                ]
            }
        ] ;
    }
}
