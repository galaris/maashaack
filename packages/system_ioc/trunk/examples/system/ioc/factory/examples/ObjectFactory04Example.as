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
    import examples.core.Appointment;
    import examples.factory.AppointmentFactory;

    import system.date.DateEvaluator;
    import system.evaluators.EdenEvaluator;
    import system.ioc.ObjectFactory;

    import flash.display.Sprite;
    
    /**
     * Illustrates the usage of the evaluators attributes in the object definitions.
     */
    public class ObjectFactory04Example extends Sprite 
    {
        public function ObjectFactory04Example()
        {
            var factory:ObjectFactory = new ObjectFactory() ;
            
            factory.run( objects ) ;
            
            trace( "---- test evaluators in the constructor arguments" ) ;
                
            trace( "my date : " + factory.getObject("my_date") ) ; 
            //output: my_date : 05.12.2007 10:22:33
                
            var app:Appointment ;
                
            trace( "---- test evaluators in properties" ) ;
                
            app = factory.getObject("appointment_01") as Appointment ;
                
            trace( "> start  : " +  app.scheduledStart ) ; 
            //output: > start  : 30.06.2008 10:30:00
            
            trace( "> finish : " +  app.scheduledEnd   ) ; 
            //output: > finish : 30.06.2008 12:40:00
            
            trace( "---- test evaluators in methods" ) ;
                
            app = factory.getObject("appointment_02") as Appointment ;
            
            trace( "> start  : " +  app.scheduledStart ) ; 
            //output: > start  : 30.06.2008 14:00:00
            
            trace( "> finish : " +  app.scheduledEnd   ) ; 
            //output: > finish : 30.06.2008 16:30:00
            
            trace( "---- test evaluators in factory method strategy" ) ;
            
            app = factory.getObject("appointment_03") as Appointment ;
            
            trace( "> start  : " +  app.scheduledStart ) ; 
            //output: > start  : 30.07.2008 14:00:00
            
            trace( "> finish : " +  app.scheduledEnd   ) ; 
            //output: > finish : 30.07.2008 16:30:00
                    
            trace( "---- test evaluators in static factory method strategy" ) ;
            
            app = factory.getObject("appointment_04") as Appointment ;
            
            trace( "> start  : " +  app.scheduledStart ) ; 
            //output: > start  : 30.08.2008 16:00:00
            
            trace( "> finish : " +  app.scheduledEnd   ) ; 
            //output: > finish : 30.08.2008 17:00:00
        }
        
        ////// linkage enforcer
        
        AppointmentFactory ;
        
        /////
        
        public var objects:Array =
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
                type      : "system.evaluators.DateEvaluator" ,
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
                type       : "examples.core.Appointment" ,
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
                type       : "examples.core.Appointment" ,
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
                type : "examples.factory.AppointmentFactory"
            }
            ,
            {   
                id            : "appointment_03"   ,
                type          : "examples.core.Appointment" ,
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
                type                : "examples.core.Appointment" ,
                staticFactoryMethod : 
                { 
                    type       : "examples.factory.AppointmentFactory" ,
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
    }
}
