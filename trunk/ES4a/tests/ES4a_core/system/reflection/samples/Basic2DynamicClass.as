
package system.reflection.samples
	{
	
	public dynamic class Basic2DynamicClass extends BasicClass
		{
		
		prototype.variable100 = "variable100";
		
		public function Basic2DynamicClass()
			{
			super();
			}
		
		prototype.method100 = function():String
			{
			return "hello world";
			}
		
		prototype.method200 = function( param:String ):String
			{
			return "hello " + param;
			}
		
		prototype.method300 = function( ...args:Array ):String
			{
			return args.join( "," );
			}
		
		prototype.method400 = function():void
			{
			//do nothing
			}
		
		}
	}

