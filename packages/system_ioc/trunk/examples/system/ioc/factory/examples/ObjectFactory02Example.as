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
    import examples.display.Canvas;
    
    import system.ioc.ObjectFactory;
    
    import flash.display.Sprite;
    
    [SWF(width="240", height="220", frameRate="24", backgroundColor="#333333")]
    
    /**
     * Show the usage of the lock attribute in the object definitions.
     */
    public class ObjectFactory02Example extends Sprite 
    {
        public function ObjectFactory02Example()
        {
            var factory:ObjectFactory = new ObjectFactory() ;
            
            // if true all Lockable object are locked during the initialization of the properties and methods of the object in the factory.
            
            // factory.config.lock = true ; 
            
            factory.create( objects ) ;
            
            var canvas:Canvas = factory.getObject("canvas") as Canvas ;
            
            addChild( canvas ) ;
            
            // if definition.lock == true  : the object is locked.
            // if definition.lock == false : the object is not locked.
            // if definition.lock == null  : the object is locked only if the config.lock attribute in the factory is true.
            
            // in this example if the object is locked only 1 time the update() method is invoked else 4 times !
        }
        
        public var objects:Array =
        [
            {   
                id          : "canvas"  ,
                type        : "examples.display.Canvas" ,
                lock        : true , // can be 'true', 'false' or 'null'
                init        : "update" , 
                properties  : 
                [ 
                    { name : "color" , value : 0xFF00FF } , // run the update method
                    { name : "w"     , value : 200      } , // run the update method
                    { name : "h"     , value : 180      } , // run the update method
                    { name : "x"     , value : 20       } ,
                    { name : "y"     , value : 20       } 
                ]
            }
        ] ;
    }
}
