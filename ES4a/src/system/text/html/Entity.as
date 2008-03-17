
package system.text.html
    {
    
    public class Entity
        {
        
        public var char:String;
        public var name:String;
        public var number:int;
        
        public function Entity( char:String, name:String, number:int )
            {
            this.char   = char;
            this.name   = name;
            this.number = number;
            }
        
        public function toString():String
            {
            return "&"+name+";";
            }
        
        public function toNumber():String
            {
            return "&#"+number+";";
            }
        
        public function valueOf():String
            {
            return char;
            }
        
        }
    }

