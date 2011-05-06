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
    import examples.core.Messenger;
    
    import system.ioc.ObjectFactory;
    import system.signals.Signal;
    
    import flash.display.Sprite;
    
    /**
     * Example of the receivers attribute.
     */
    public class ObjectFactory13Example extends Sprite 
    {
        public function ObjectFactory13Example()
        {
            var factory:ObjectFactory = new ObjectFactory() ;
            
            factory.create( context ) ; 
            
            // 1 - target the callback "receiver" method in the receiver object (all objects with methods can be a receiver)
            
            var signaler1:Signal = factory.getObject("signaler1") as Signal ;
            
            signaler1.emit( "signaler1" , "hello world" ) ;
            
            // 2 - target the receiver object if implements the system.signals.Receiver interface.
            
            var signaler2:Signal = factory.getObject("signaler2") as Signal ;
            
            signaler2.emit( "signaler2" , "hello world" ) ;
            
            // 3 - target the receiver register before the properties initialization.
            
            var signaler3:Signal = factory.getObject("signaler3") as Signal ;
            
            signaler3.emit( "signaler3" , "hello world" ) ;
        }
        
        ////// linkage enforcer
        
        Messenger ; Signal ;
        
        /////
        
        public var context:Array =
        [
            { 
                id        : "signaler1" ,
                type      : "system.signals.Signal" ,
                singleton : true  
            }
            ,
            { 
                id        : "signaler2" ,
                type      : "system.signals.Signal" ,
                singleton : true  
            }
            ,
            { 
                id        : "signaler3" ,
                type      : "system.signals.Signal" ,
                singleton : true  
            }
            ,
            { 
                id        : "messenger"   ,
                type      : "examples.core.Messenger" , 
                singleton : true ,
                receivers :
                [
                    { signal:"signaler1" } ,
                    { signal:"signaler2" , slot : "write"} ,
                    { signal:"signaler3" , order : "before" }
                ]
            }
        ] ;
    }
}
