/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [MaasHaack framework]
  
  The Initial Developer of the Original Code is
  Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2008
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
  
*/

package system.data.samples 
{
    import system.data.Iterator;
    import system.data.Stack;    

    public class StackClass implements Stack
    {

        public function clear():void
        {
        }
        
        public function clone():*
        {
            return null ;
        }
          
        public function isEmpty():Boolean
        {
            return false ;    
        }
        
        public function iterator():Iterator
        {
            return new IteratorClass() ;
        }  
        
        public function peek():*
        {
            return null ;
        }
        
        public function pop():*
        {
            return null ;
        }
        
        public function push(o:*):void
        {
        }
        
        public function search(o:*):uint
        {
            return 0 ;
        }
        
        public function size():uint
        {
            return 0 ;
        }
            
        public function toSource(indent:int = 0):String
        {
            return null ;
        }
    }

}
