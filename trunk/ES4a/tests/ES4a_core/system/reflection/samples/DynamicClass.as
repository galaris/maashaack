
package system.reflection.samples
	{
	
	public dynamic class DynamicClass
		{
		
		prototype.variable10 = "variable10";
		
		public function DynamicClass()
			{
			
			}
		
		prototype.method10 = function():String
			{
			return "hello world";
			}
		
		prototype.method20 = function( param:String ):String
			{
			return "hello " + param;
			}
		
		prototype.method30 = function( ...args:Array ):String
			{
			return args.join( "," );
			}
		
		prototype.method40 = function():void
			{
			//do nothing
			}
		
		}
	}

