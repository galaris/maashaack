
package system.reflection.samples
    {
    
    public class Basic2BasicClass extends BasicClass
        {
        
        public const constantA:String = "constantA";
        
        public var variable1A:String = "variable1A";
        
        private var _accessorA:String = "accessorA";
        
        public function Basic2BasicClass()
            {
            super();
            }
        
        public function get accessorA():String
            {
            return _accessorA;
            }
        
        public function set accessorA( value:String ):void
            {
            _accessorA = value ;
            }
        
        public function method1A():String
            {
            return "hello world";
            }
        
        public function method2A( param:String ):String
            {
            return "hello " + param;
            }
        
        public function method3A( ...args:Array ):String
            {
            return args.join( "," );
            }
        
        public function method4A():void
            {
            //do nothing
            }
        
        }
    }

