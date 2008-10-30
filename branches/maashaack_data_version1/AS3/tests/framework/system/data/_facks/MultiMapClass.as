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

package system.data._facks 
{
    import system.data.Collection;
    import system.data.Iterator;
    import system.data.MultiMap;    
    
    public class MultiMapClass implements MultiMap
    {

        public function totalSize():uint
        {
            return 0 ;
        }
        
        public function values():Collection
        {
            return new CollectionClass() ;
        }
        
        public function valueIterator():Iterator
        {
            return new IteratorClass() ;
        }
        
        public function clear():void
        {
        }
        
        public function containsKey(key:*):Boolean
        {
            return true ;
        }
        
        public function containsValue(value:*):Boolean
        {
            return true ;
        }
        
        public function get(key:*):*
        {
            return key ;
        }
        
        public function getKeys():Array
        {
            return [] ;
        }
        
        public function getValues():Array
        {
            return [] ;
        }
        
        public function isEmpty():Boolean
        {
            return true ;
        }
        
        public function keyIterator():Iterator
        {
            return new IteratorClass() ;
        }
            
        public function put(key:*, value:*):*
        {
            return key.toString() + ":" + value.toString() ;
        }
        
        public function remove(o:*):*
        {
            return o ;
        }
        
        public function size():uint
        {
            return 0 ;
        }
        
        public function clone():*
        {
            return new MultiMapClass() ;
        }
        
        public function iterator():Iterator
        {
            return new IteratorClass() ;
        }
        
        public function toSource(indent:int = 0):String
        {
            return "" ;
        }
    }
}
