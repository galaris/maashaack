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
    import system.data.Collection;
    import system.data.Iterator;
    import system.data.List;    

    public class ListClass implements List 
    {

        public function add(o:*):Boolean
        {
            return true ;
        }

        public function addAt(id:uint, o:*):void
        {
        	throw new Error("addAt id:" + id + " o:" + o) ;
        }
        
        public function clear():void
        {
        	throw new Error("clear") ;
        }        
        
        public function clone():*
        {
            return new ListClass();
        }        
                
        public function contains(o:*):Boolean
        {
            return true;
        }        
        
        public function containsAll(c:Collection):Boolean
        {
            return c is Collection ;
        }
        
        public function equals(o:*):Boolean
        {
            return true ; // TODO remove in the List interface ?
        }        
        
        public function get(key:*):*
        {
            return key ;
        }
        
        public function indexOf(o:*, fromIndex:uint = 0):int
        {
            return 0;
        }
        
        public function isEmpty():Boolean
        {
            return true ;
        }
                
        public function iterator():Iterator
        {
            return new IteratorClass() ;
        }
        
        public function lastIndexOf(o:*):int
        {
            return 0;
        }
        
        public function remove(o:*):*
        {
            return "remove:" + o.toString() ;
        }
        
        public function removeAt(id:uint, len:int = 1):*
        {
            return "removeAt:" + id +",len:" + len ;
        }
        
        public function removeRange(fromIndex:uint, toIndex:uint):void
        {
        	throw new Error("removeRange fromIndex:" + fromIndex + " toIndex:" + toIndex) ;
        }
        
        public function retainAll( c:Collection ):Boolean
        {
            return true ; // TODO remove in the interface ?
        }
        
        public function setAt(id:uint, o:*):*
        {
            return null;
        }
        
        public function size():uint
        {
            return 0;
        }        
        
        public function subList(fromIndex:uint, toIndex:uint):List
        {
            return null;
        }
                        
        public function toSource(indent:int = 0):String
        {
            return "toSource" ;
        }
        

    }
}
