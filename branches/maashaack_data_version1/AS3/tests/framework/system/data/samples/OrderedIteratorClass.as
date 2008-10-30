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
    import system.data.OrderedIterator;            

    public class OrderedIteratorClass implements OrderedIterator
    {
    
        public function OrderedIteratorClass()
        {
        }
    
        public function hasNext():Boolean
        {
            return true ;
        }
        
        public function hasPrevious():Boolean
        {
            return true ;
        }    
        
        public function key():*
        {
            return "key" ;
        }
        
        public function next():*
        {
            return "next" ;
        }
    
        public function previous():*
        {
            return "previous" ;
        }    
        
        public function remove():*
        {
            return "remove" ;
        }
        
        public function reset():void
        {
            throw new Error("reset") ;
        }
        
        public function seek(position:*):void
        {
            throw new Error( "seek:" + position ) ;
        }
    
    }

}
