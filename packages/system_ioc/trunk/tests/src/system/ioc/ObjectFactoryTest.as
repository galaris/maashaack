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
package system.ioc
{
    import library.ASTUce.framework.TestCase;

    import system.date.DateEvaluator;
    import system.evaluators.EdenEvaluator;
    import system.ioc.samples.Appointment;
    import system.ioc.samples.Civility;
    import system.ioc.samples.FactoryReference;
    import system.ioc.samples.Filter;
    import system.ioc.samples.Item;
    import system.ioc.samples.LockableObject;
    import system.ioc.samples.User;
    import system.ioc.samples.factory.AppointmentFactory;
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
            
            factory.run( objects ) ;
            
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
            
            factory.run( objects ) ;
            
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
            
            factory.run( objects ) ;
            
            object = factory.getObject("object") as LockableObject ;
            
            assertNotNull( object , "#3" ) ;
            assertEquals( 4, object.count , "#4" ) ;
        }
        
        // identify attribute
        
        public function testIdentifyAttribute():void
        {
            var objects:Array ;
            var item:Item ;
            
            ////////////
            
            factory.config.identify = false ;
            
            ////////////
            
            objects =
            [
                {   
                    id        : "item"  ,
                    type      : "system.ioc.samples.Item" ,
                    singleton : true ,
                    lazyInit  : true ,
                    identify  : true 
                }
            ] ;
            
            factory.run( objects ) ;
            
            item = factory.getObject("item") as Item ;
            
            assertNotNull( item , "#1-1" ) ;
            assertEquals( "item" , item.id , "#1-2" ) ;
            
            ////////////
            
            factory.removeSingleton("item") ;
            
            objects =
            [
                {   
                    id        : "item"  ,
                    type      : "system.ioc.samples.Item" ,
                    singleton : true ,
                    lazyInit  : true ,
                    identify  : false 
                }
            ] ;
            
            factory.run( objects ) ;
            
            item = factory.getObject("item") as Item ;
            
            assertNotNull( item , "#2-1" ) ;
            assertNull( item.id , "#2-2" ) ;
            
            ////////////
            
            factory.config.identify = true ;
            
            ////////////
            
            factory.removeSingleton("item") ;
            
            objects =
            [
                {   
                    id        : "item"  ,
                    type      : "system.ioc.samples.Item" ,
                    singleton : true ,
                    lazyInit  : true 
                }
            ] ;
            
            factory.run( objects ) ;
            
            item = factory.getObject("item") as Item ;
            
            assertNotNull( item , "#3-1" ) ;
            assertEquals( "item" , item.id , "#3-2" ) ;
            
            ////////////
            
            factory.removeSingleton("item") ;
            
            objects =
            [
                {   
                    id        : "item"  ,
                    type      : "system.ioc.samples.Item" ,
                    singleton : true ,
                    lazyInit  : true ,
                    identify  : true 
                }
            ] ;
            
            factory.run( objects ) ;
            
            item = factory.getObject("item") as Item ;
            
            assertNotNull( item , "#4-1" ) ;
            assertEquals( "item" , item.id , "#4-2" ) ;
            
            ////////////
            
            factory.removeSingleton("item") ;
            
            objects =
            [
                {   
                    id        : "item"  ,
                    type      : "system.ioc.samples.Item" ,
                    singleton : true ,
                    lazyInit  : true ,
                    identify  : false 
                }
            ] ;
            
            factory.run( objects ) ;
            
            item = factory.getObject("item") as Item ;
            
            assertNotNull( item , "#5-1" ) ;
            assertNull( item.id , "#5-2" ) ;
        }
        
        // evaluators attribute
        
        public function testEvaluatorsAttribute():void
        {
            var objects:Array =
            [
                // evaluators
                
                {
                    id        : "eden" ,
                    type      : "system.evaluators.EdenEvaluator" ,
                    singleton : true ,
                    arguments : [ { value:false } ]
                }
                ,
                {
                    id        : "date" ,
                    type      : "system.date.DateEvaluator" ,
                    singleton : true 
                }
                ,
                
                // test in the constructor
                
                {   
                    id         : "my_date"  ,
                    type       : "String" ,
                    arguments  : 
                    [ 
                        { 
                            value      : "new Date(2007,11,5,10,22,33)" , 
                            evaluators : 
                            [ 
                                new EdenEvaluator(false) , 
                                new DateEvaluator()
                            ]
                        }
                    ]
                }
                , // test in the attributes ("properties")
                {   
                    id         : "appointment_01"   ,
                    type       : "system.ioc.samples.Appointment" ,
                    properties : 
                    [ 
                        { 
                            name       : "scheduledStart" ,
                            value      : "new Date(2008,5,30,10,30,00)" , 
                            evaluators : [ "eden" , "date" ] 
                        }
                        ,
                        { 
                            name       : "scheduledEnd" ,
                            value      : "new Date(2008,5,30,12,40,00)" , 
                            evaluators : 
                            [ 
                                "eden" , 
                                new DateEvaluator()
                            ]
                        }
                    ] 
                }
                , // test in methods ("properties")
                {   
                    id         : "appointment_02"   ,
                    type       : "system.ioc.samples.Appointment" ,
                    properties : 
                    [ 
                        { 
                            name       : "setShedule" ,
                            arguments  :
                            [
                                {
                                    value      : "new Date(2008,5,30,14,00,00)" , 
                                    evaluators : 
                                    [ 
                                        new system.evaluators.EdenEvaluator(false) , 
                                        "date"
                                    ]
                                }
                                ,
                                { 
                                    value      : "new Date(2008,5,30,16,30,00)" , 
                                    evaluators : [ "eden" , "date" ] 
                                }
                            ]
                        }
                    ] 
                }
                
                , // factory method
                
                {
                    id   : "appointment_factory"   ,
                    type : "system.ioc.samples.factory.AppointmentFactory"
                }
                ,
                {   
                    id            : "appointment_03"   ,
                    type          : "system.ioc.samples.Appointment" ,
                    factoryMethod : 
                    { 
                        factory    : "appointment_factory" ,
                        name       : "build" ,
                        arguments  :
                        [
                            {
                                value      : "new Date(2008,6,30,14,00,00)" , 
                                evaluators : [ "eden" , "date" ] 
                            }
                            ,
                            { 
                                value      : "new Date(2008,6,30,16,30,00)" , 
                                evaluators : [ "eden" , "date" ] 
                            }
                        ]
                    } 
                }
                
                , // static factory method
                
                {   
                    id                  : "appointment_04"   ,
                    type                : "system.ioc.samples.Appointment" ,
                    staticFactoryMethod : 
                    { 
                        type       : "system.ioc.samples.factory.AppointmentFactory" ,
                        name       : "create" ,
                        arguments  :
                        [
                            {
                                value      : "new Date(2008,7,30,16,00,00);" , 
                                evaluators : [ "eden" , "date" ] 
                            }
                            ,
                            { 
                                value      : "new Date(2008,7,30,17,00,00);" , 
                                evaluators : [ "eden" , "date" ] 
                            }
                        ]
                    } 
                }
            ] ;
            
            ////// linkage enforcer
            
            AppointmentFactory ;
            
            /////
            
            factory.run( objects ) ;
            
            //---- test evaluators in the constructor arguments
            
            assertEquals( "05.12.2007 10:22:33" , factory.getObject("my_date").toString() , "#1" ) ; 
            
            var app:Appointment ;
            
            //---- test evaluators in properties
            
            app = factory.getObject("appointment_01") as Appointment ;
            
            assertEquals( "30.06.2008 10:30:00" , app.scheduledStart , "#2-1" ) ;
            assertEquals( "30.06.2008 12:40:00" , app.scheduledEnd   , "#2-2" ) ;
            
            //---- test evaluators in methods
            
            app = factory.getObject("appointment_02") as Appointment ;
            
            assertEquals( "30.06.2008 14:00:00" , app.scheduledStart , "#3-1" ) ;
            assertEquals( "30.06.2008 16:30:00" , app.scheduledEnd   , "#3-2" ) ;
            
            //---- test evaluators in factory method strategy
            
            app = factory.getObject("appointment_03") as Appointment ;
            
            assertEquals( "30.07.2008 14:00:00" , app.scheduledStart , "#4-1" ) ;
            assertEquals( "30.07.2008 16:30:00" , app.scheduledEnd   , "#4-2" ) ;
            
            //---- test evaluators in static factory method strategy
            
            app = factory.getObject("appointment_04") as Appointment ;
            
            assertEquals( "30.08.2008 16:00:00" , app.scheduledStart , "#5-1" ) ;
            assertEquals( "30.08.2008 17:00:00" , app.scheduledEnd   , "#5-2" ) ;
        }
        
        // reference evaluator feature
        
        public function testReferenceEvaluator():void
        {
            var objects:Array =
            [
                { 
                    id         : "VIDEO" ,
                    type       : "system.ioc.samples.Filter" ,
                    properties : [ { name:"filter" , value:1 } ]
                }
                ,
                { 
                    id         : "MP3" ,
                    type       : "system.ioc.samples.Filter" ,
                    properties : [ { name:"filter" , value:2 } ]
                }
                ,
                { 
                    id         : "CUSTOM" ,
                    type       : "system.ioc.samples.Filter" ,
                    properties : 
                    [ 
                        { name:"toggleFilter" , arguments:[ { ref : "VIDEO.filter" } , { value : true } ] } ,
                        { name:"toggleFilter" , arguments:[ { ref : "MP3.filter"   } , { value : true } ] } 
                    ]
                }
            ] ;
            
            factory.run( objects ) ;
            
            var filter:Filter = factory.getObject( "CUSTOM" ) ; 
            
            assertEquals( 3 , filter.filter ) ; 
        }
        
        // magic #root feature
        
        public function testMagicRoot():void
        {
            var root:Object = {} ;
            
            var objects:Array =
            [
                { 
                    id         : "test" ,
                    type       : "system.ioc.samples.FactoryReference" ,
                    properties : 
                    [ 
                        { name:"root" , ref : "#root" } 
                    ]
                }
                ,
                { 
                    id               : "root" ,
                    type             : "Object" ,
                    factoryReference : "#root"  
                }
            ] ;
            
            factory.config.root = root ;
            
            factory.run( objects ) ;
            
            var ref:FactoryReference = factory.getObject("test") ; 
            
            assertEquals( root , ref.root , "#1" ) ;
            assertEquals( root , factory.getObject("root") , "#2" ) ;
        }
        
        // magic #this feature
        
        public function testMagicThis():void
        {
            var objects:Array =
            [
                { 
                    id         : "test1" ,
                    type       : "system.ioc.samples.FactoryReference" ,
                    arguments  : [ { ref : "#this" } ]
                }
                ,
                { 
                    id         : "test2" ,
                    type       : "system.ioc.samples.FactoryReference" ,
                    properties : 
                    [ 
                        { name:"factory" , ref : "#this" }
                    ]
                }
            ] ;
            
            factory.run( objects ) ;
            
            var test1:FactoryReference = factory.getObject( "test1" ) as FactoryReference ;
            var test2:FactoryReference = factory.getObject( "test2" ) as FactoryReference ;
            
            assertEquals( factory , test1.factory ) ;
            assertEquals( factory , test2.factory ) ;
        }
        
        // magic #config feature
        
        public function testMagicConfig():void
        {
            var objects:Array =
            [
                { 
                    id               : "config"  ,
                    type             : "Object"  ,
                    singleton        : true      ,
                    lazyInit         : true      ,
                    factoryReference : "#config"  
                }
            ] ;
            
            factory.config.config = { message : "hello world" } ;
            
            factory.run( objects ) ;
            
            var conf:Object = factory.getObject( "config" ) ;
            
            assertEquals( "hello world" , conf.message ) ;
        }
        
        // magic #locale feature
        
        public function testMagicLocale():void
        {
            var objects:Array =
            [
                { 
                    id               : "i18n"  ,
                    type             : "Object"  ,
                    singleton        : true      ,
                    lazyInit         : true      ,
                    factoryReference : "#locale"  
                }
            ] ;
            
            factory.config.locale = { message : "hello world" } ;
            
            factory.run( objects ) ;
            
            var i18n:Object = factory.getObject( "i18n" ) ;
            
            assertEquals( "hello world" , i18n.message ) ;
        }
        
        // magic #params feature
        
        public function testMagicParams():void
        {
            var objects:Array =
            [
                { 
                    id               : "params"                ,
                    type             : "system.ioc.Parameters" ,
                    singleton        : true                    ,
                    lazyInit         : true                    ,
                    factoryReference : "#params" 
                }
            ] ;
            
            var parameters:Parameters = new Parameters() ;
            
            factory.config.parameters = parameters ;
            
            factory.run( objects ) ;
            
            // use the factory
            
            var params:Parameters = factory.getObject( "params" ) as Parameters ; 
            
            assertEquals( params , parameters ) ;
        }
        
        // magic #stage feature
        
        public function testMagicStage():void
        {
            var stage:Object = {} ;
            
            var objects:Array =
            [
                { 
                    id               : "stage" ,
                    type             : "Object" ,
                    factoryReference : "#stage"  
                }
            ] ;
            
            factory.config.stage = stage ;
            
            factory.run( objects ) ;
            
            assertEquals( stage , factory.getObject("stage") ) ;
        }
    }
}
