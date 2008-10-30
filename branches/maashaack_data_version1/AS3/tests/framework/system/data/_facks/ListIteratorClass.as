
package system.data._facks 
{
    import system.data.ListIterator;            

    public class ListIteratorClass implements ListIterator 
    {

        public function hasNext():Boolean
        {
            return true ;
        }
        
        public function hasPrevious():Boolean
        {
            return true ;
        }        

        public function insert(o:*):void
        {
            throw new Error( "insert:" + o.toString() ) ;
        }
        
        public function key():*
        {
            return "key" ;
        }        
        
        public function next():*
        {
            return "next" ;
        }        
        
        public function nextIndex():uint
        {
            return 0;
        }
        
        public function previous():*
        {
            return "previous" ;
        }        
        
        public function previousIndex():int
        {
            return 0;
        }
               
        public function remove():*
        {
            return "remove" ;
        }
        
        public function reset():void
        {
        	throw new Error( "reset" ) ;
        }
        
        public function seek(position:*):void
        {
        	throw new Error( "seek:" + position ) ;
        }
        
        public function set(o:*):void
        {
            throw new Error( "set:" + o.toString() ) ;
        }
                 
        
    }
}
