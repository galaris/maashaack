
package system.reflection.samples
    {
    
    public class BasicClass
        {
        
        public const constant:String = "constant";
        
        public var variable1:String = "variable1";
        
        private var _accessor:String = "accessor";
        
        public function BasicClass()
            {
            
            }
        
        public function get accessor():String
            {
            return _accessor;
            }
        
        public function set accessor( value:String ):void
            {
            _accessor = value ;
            }
        
        public function method1():String
            {
            return "hello world";
            }
        
        public function method2( param:String ):String
            {
            return "hello " + param;
            }
        
        public function method3( ...args:Array ):String
            {
            return args.join( "," );
            }
        
        public function method4():void
            {
            //do nothing
            }
        
        }
    }

