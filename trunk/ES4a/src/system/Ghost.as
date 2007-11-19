
/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [ES4a: ECMAScript 4 MaasHaack framework].
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
*/

package system
    {
    
    /* Class: Ghost
       The Global host.
       
       Autoselect the current host.
       
       The ES4 language can be executed in different hosts
       who can have different native API signatures,
       the goal of the Ghost class is to allow an implementer
       to provide a common public API signature which will
       contain specific host implementation.
       
       example:
       (code)
       ...
       class MyPublicAPI extend Ghost
           {
           
           //public API signature
           public function getDrives():Array
               {
               return __::getDrives();
               }
           
           //Apollo (AIR) implementation
           apollo function getDrives():Array
               {
               import flash.filesystem;
               return filesystem.listRootDirectories();
               }
           
           //red tamarin implementation
           redtamarin function getDrives():Array
               {
               import standard.*;
               retrun getdrives();
               }
           }
       ...
       
       //usage
       trace( MyPublicAPI.getDrives() );
       (end)
       
       Ok it add indirection and could slow a very little a method call,
       but this is for the sake of clean public API :).
       (you don't want to go back to preprocesor hell do you ?)
    */
    public class Ghost extends Ghosts
        {
        protected static var __:Namespace = unknown;
        
        private static function _selectByName( name:String ):void
            {
            __ = new Namespace( name );
            }
        
        private static function _selectByHostID( id:HostID ):void
            {
            /* note:
               instead of doing a switch we could
               get the toString() from the HostID
               and use _selectByName()
            */
            switch( id )
                {
                case HostID.Flash:
                __ = flash;
                break;
                
                case HostID.Apollo:
                __ = flash;
                break;
                
                case HostID.Unknown:
                default:
                __ = unknown;
                }
            }
        
        private static function inTheShell():void
            {
            _selectByHostID( Environment.host.id );
            }
        
        /* Method: shadow
           Alllow to "shadow" the current host.
        */
        public static function shadow( name:String ):void
            {
            _selectByName( name );
            }
        
        inTheShell();
        }
    
    }

