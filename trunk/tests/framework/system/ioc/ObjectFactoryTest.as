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
  Portions created by the Initial Developers are Copyright (C) 2006-2010
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
package system.ioc
{
    import buRRRn.ASTUce.framework.TestCase;

    import system.ioc.samples.Civility;
    import system.ioc.samples.LockableObject;
    import system.ioc.samples.User;
    import system.ioc.samples.factory.UserFactory;
    import system.ioc.samples.factory.UserFilterFactory;
    
    public class ObjectFactoryTest extends TestCase
    {
        public function ObjectFactoryTest( name:String = "" )
        {
            super(name);
        }
        
        public var factory:ObjectFactory ;
        
        public function setUp():void
        {
            factory = new ObjectFactory() ;
        }
        
        public function tearDown():void
        {
            factory = null ;
        }
        
        public function testInherit():void
        {
            assertTrue( factory is ObjectDefinitionContainer );
        }
        
        public function testInterface():void
        {
            assertTrue( factory is IObjectFactory ) ;
        }
        
        public function testConstructorWithArguments():void
        {
            var config:ObjectConfig = new ObjectConfig() ;
            var objects:Array      = [ { id:"test" , type:"Object" } ] ;
            factory = new ObjectFactory( config , objects ) ;
            assertEquals( config  , factory.config , "#1" ) ;            assertEquals( objects , factory.objects , "#2" ) ;
        }
        
        ///// strategy
        
        public function testStrategyFactory():void
        {
            var objects:Array =
            [
                {   
                    id          : "user_filter_factory"  ,
                    type        : "system.ioc.samples.factory.UserFilterFactory" ,
                    arguments   : [ { value : [ "lunas" ] } ]
                }
                ,
                {   
                    id                  : "user1" , 
                    type                : "system.ioc.samples.User" , 
                    staticFactoryMethod : 
                    {
                        type      : "system.ioc.samples.factory.UserFactory" , 
                        name      : "create" , 
                        arguments : [ { value : "ekameleon" } ] 
                    }
                }
                    ,
                    {
                        id             : "user2" , 
                        type           : "system.ioc.samples.User" , 
                        factoryMethod  : 
                        { 
                            factory : "user_filter_factory" , 
                            name    : "build" , 
                            arguments:[ { value:"zwetan" } ] 
                        }
                    }
                    ,
                    {   
                        id             : "user3" , 
                        type           : "system.ioc.samples.User" , 
                        factoryMethod  : {  factory:"user_filter_factory" , name:"build", arguments:[ { value : "lunas" } ]  }
                    }
                    ,
                    
                    // property factory
                    
                    {   
                        id                    : "man"    , 
                        type                  : "String" , 
                        staticFactoryProperty : { type:"system.ioc.samples.Civility" , name:"MAN" }
                    }
                    ,
                    {   
                        id              : "name"   , 
                        type            : "String" , 
                        factoryProperty : { factory:"user2" , name:"pseudo" }
                    }
                    ,
                    
                    // value factory
                    
                    {
                        id           : "my_value" , 
                        type         : "String"   , 
                        factoryValue : "hello world"
                    }
                    ,
                    
                    // reference factory
                    
                    {   
                        id               : "my_user"   , 
                        type             : "system.ioc.samples.User" , 
                        factoryReference : "user1"     ,
                        singleton        : true        ,
                        lazyInit         : true        ,
                        properties       : 
                        [ 
                            { name:"url" , value : "http://code.google.com/p/maashaack/" }
                        ]
                    }
            ] ;
            
            ///////////// linkage enforcer
            
            Civility  ; 
            UserFactory ; 
            UserFilterFactory ;
            
            ////////////
            
            factory.create( objects ) ;
            
            var user:User ;
            
            // ------------- static method factory
            
            user = factory.getObject("user1") as User ;
            
            assertNotNull( user , "#1-1") ;
            assertEquals( "[User  ekameleon]" , user.toString() , "#1-2" ) ;
            
            // ------------- method factory
            
            user = factory.getObject( "user2" ) as User ;
            assertEquals("zwetan", user.pseudo  , "#2" ) ;
            
            user = factory.getObject( "user3" ) as User ;
            assertNull( user , "#3" ) ;
            
            // ------------- static property factory
            
            assertEquals( Civility.MAN, factory.getObject("man") , "#4" ) ;
            
            // ------------- property factory
            
            assertEquals( "zwetan" , factory.getObject("name") , "#5" ) ;
            
            // ------------- value factory
            
            assertEquals( "hello world" , factory.getObject("my_value") , "#6" ) ;
            
            // ------------- reference factory ;
            
            assertEquals( "ekameleon" , factory.getObject("my_user").pseudo , "#7" )  ; 
            assertEquals( "http://code.google.com/p/maashaack/" , factory.getObject("my_user").url , "#8" ) ; 
        }
        
        // lock attribute
        
        public function testLockAttribute():void
        {
            var objects:Array ;
            var object:LockableObject ;
            
            objects =
            [
                {   
                    id          : "object"  ,
                    type        : "system.ioc.samples.LockableObject" ,
                    lock        : true , // can be 'true', 'false' or 'null'
                    init        : "update" , 
                    properties  : 
                    [ 
                        { name : "color" , value : 0xFF00FF } , // run the update method
                        { name : "w"     , value : 200      } , // run the update method
                        { name : "h"     , value : 180      } , // run the update method
                    ]
                }
            ] ;
            
            factory.create( objects ) ;
            
            object = factory.getObject("object") as LockableObject ;
            
            assertNotNull( object , "#1" ) ;
            assertEquals( 1 , object.count , "#2" ) ;
            
            ////////////
            
            factory.removeSingleton("object") ;
            
            objects =
            [
                {   
                    id          : "object"  ,
                    type        : "system.ioc.samples.LockableObject" ,
                    lock        : false , // can be 'true', 'false' or 'null'
                    init        : "update" , 
                    properties  : 
                    [ 
                        { name : "color" , value : 0xFF00FF } , // run the update method
                        { name : "w"     , value : 200      } , // run the update method
                        { name : "h"     , value : 180      } , // run the update method
                    ]
                }
            ] ;
            
            factory.create( objects ) ;
            
            object = factory.getObject("object") as LockableObject ;
            
            assertNotNull( object , "#3" ) ;
            assertEquals( 4, object.count , "#4" ) ;
        }
    }
}
