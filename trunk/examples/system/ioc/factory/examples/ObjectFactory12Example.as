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
    import examples.core.Listener;
    
    import system.ioc.ObjectFactory;
    
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.EventDispatcher;
    
    /**
     * Example of the listeners attribute.
     */
    public class ObjectFactory12Example extends Sprite 
    {
        public function ObjectFactory12Example()
        {
            var factory:ObjectFactory = new ObjectFactory() ;
            
            factory.create( context ) ; 
            
            // 1 - target the callback "handleEvent" method in the listener object (all objects with methods can be a listener)
            
            var dispatcher1:EventDispatcher = factory.getObject("dispatcher1") as EventDispatcher ;
            
            dispatcher1.dispatchEvent( new Event( "change" ) ) ;
            
            // 2 - target the listener object if implements the system.events.EventListener interface.
            
            var dispatcher2:EventDispatcher = factory.getObject("dispatcher2") as EventDispatcher ;
            
            dispatcher2.dispatchEvent( new Event( "change" ) ) ;
            
            // 3 - target the listener register before the properties initialization.
            
            var dispatcher3:EventDispatcher = factory.getObject("dispatcher3") as EventDispatcher ;
            
            dispatcher3.dispatchEvent( new Event( "change" ) ) ;
        }
        
        ////// linkage enforcer
        
        Listener ;
        
        /////
        
        public var context:Array =
        [
            { 
                id        : "dispatcher1" ,
                type      : "flash.events.EventDispatcher" ,
                singleton : true
            }
            ,
            { 
                id        : "dispatcher2" ,
                type      : "flash.events.EventDispatcher" ,
                singleton : true
            }
            ,
            { 
                id        : "dispatcher3" ,
                type      : "flash.events.EventDispatcher" ,
                singleton : true
            }
            ,
            { 
                id        : "listener"   ,
                type      : "examples.core.Listener" ,
                singleton : true ,
                listeners :
                [
                    { dispatcher:"dispatcher1" , type:"change" , method:"change" , useCapture:false, priority:0 , useWeakReference:true } , 
                    { dispatcher:"dispatcher2" , type:"change" } ,
                    { dispatcher:"dispatcher3" , type:"change" , order : "before" }
                ]
            }
        ] ;
    }
}
