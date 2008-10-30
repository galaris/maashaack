
package system.data._facks 
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
