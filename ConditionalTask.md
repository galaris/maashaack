# The conditional task engine #

<a href='http://creativecommons.org/licenses/by-sa/3.0/'><img src='http://i.creativecommons.org/l/by-sa/2.0/uk/88x31.png' alt='Licence Creative Commons' /></a> author : Marc ALCARAZ ([ekameleon](https://code.google.com/u/109962507657971592081/))



## Generality ##

The conditional tasks are used to define which tasks will be executed based on the outcome of a given test defines with a specific conditional rule.

The conditional tasks are very powerful because while making sure not to execute the complex instructions immediately, It allows to pre-set advanced strategies before launching the all important processes when we want during the application life cycle.

The conditional rules defines the logic of the conditional blocks who serve to create a powerful conditional execution logic system. All rules are defines with a set of conditions : equality, comparison, null or undefined object, etc.

## Package system.rules ##

To create a **conditional task** you must use conditional rules to test and evaluate values or objects in your applications.

The **system.rules** package defines a basic interface and classes to defines this conditional rules or create your custom rules.

### Rule ###

Basic interface of all conditional rules in the system.rules package.

You can use all conditional rules in the **system.rules** package or create your custom conditions.

**usage**

```
Rule.eval():Boolean
```

**example**

```
package example
{
    import system.rules.Rule ;
    
    public class IsPositive implements Rule
    {
        public function IsPositive( value:* )
        {
            this.value = value ;
        }

        public var value:* ;

        public function eval():Boolean
        {
            return value > 0
        }
    }
}
```

The **IsPositive** class is a custom conditional rule who implements the **Rule** interface to evaluate if a value is a number and positive.

In the **system.rules** package you can find a set of simple rules with the classes : _True, False, Not, Equals, NotEquals, And, Or,_ etc.

### BooleanRule ###

Evaluates a basic boolean condition.

**usage**

```
new BooleanRule( b:Boolean )
new BooleanRule( cond:Condition )
```

**example**

```
import system.rules.Rule ;
import system.rules.BooleanRule ;

var rule1:Rule = new BooleanRule( true  ) ;
var rule2:Rule = new BooleanRule( false ) ;
var rule3:Rule = new BooleanRule( rule1 ) ;

trace( rule1.eval() ) ; // true
trace( rule2.eval() ) ; // false
trace( rule3.eval() ) ; // true
```

### Equals ###

Defines if two values are equals.

**usage**

```
new Equals( value1:* , value2:* )
```

**Note :** value1 can be an Equatable object, a Rule Object, an object with the equals method inside or the `==` operator is used.

**example**

```
import system.rules.Rule ;
import system.rules.Equals ;
import system.rules.BooleanRule ;

var e:Equals ;

///// Compares objects.

e = new Equals( 1 , 1 ) ;
trace( e.eval() ) ; // true

e = new Equals( 1 , 2 ) ;
trace( e.eval() ) ; // false

///// Compares Condition objects.

var cond1:Rule = new BooleanRule( true  ) ;
var cond2:Rule = new BooleanRule( false ) ;
var cond3:Rule = new BooleanRule( true  ) ;

e = new Equals( cond1 , cond1 ) ;
trace( e.eval() ) ; // true

e = new Equals( cond1 , cond2 ) ;
trace( e.eval() ) ; // false

e = new Equals( cond1 , cond3 ) ;
trace( e.eval() ) ; // true

///// Compares Equatable objects.

var equals:Function = function( o:Object ):Boolean
{
    return this.id == o.id ;
}

var o1:Object = { id:1 , equals:equals } ;
var o2:Object = { id:2 , equals:equals } ;
var o3:Object = { id:1 , equals:equals } ;

e = new Equals( o1 , o1 ) ;
trace( e.eval() ) ; // true

e = new Equals( o1 , o2 ) ;
trace( e.eval() ) ; // false

e = new Equals( o1 , o3 ) ;
trace( e.eval() ) ; // true
```

### True ###

Evaluates if the value or the condition is true.

**usage**

```
new True( condition:* )
```

**example**

```
import system.rules.Rule ;
import system.rules.True ;

var cond1:Rule = new True( true  ) ;
var cond2:Rule = new True( false ) ;
var cond3:Rule = new True( cond1 ) ;
var cond4:Rule = new True( cond2 ) ;

trace( cond1.eval() ) ; // true
trace( cond2.eval() ) ; // false
trace( cond3.eval() ) ; // true
trace( cond4.eval() ) ; // false
```

### False ###

Evaluates if the value or the condition is false.

**usage**

```
new False( condition:* )
```

**example**

```
import system.rules.Rule ;
import system.rules.False ;

var cond1:Rule = new False( true  ) ;
var cond2:Rule = new False( false ) ;
var cond3:Rule = new False( cond1 ) ;
var cond4:Rule = new False( cond2 ) ;

trace( cond1.eval() ) ; // false
trace( cond2.eval() ) ; // true
trace( cond3.eval() ) ; // true
trace( cond4.eval() ) ; // false
```

### Not ###

Used to perform logical negation on a specific condition.

**usage**

```
new Not( b:Boolean )
new Not( cond:Condition )
```

**example**

```
import system.rules.BooleanRule ;
import system.rules.Not ;
import system.rules.Rule ;

var cond1:Rule = new BooleanRule( true  ) ;
var cond2:Rule = new BooleanRule( false ) ;

var no1:Not = new Not( true ) ;
var no2:Not = new Not( false ) ;
var no3:Not = new Not( cond1 ) ;
var no4:Not = new Not( cond2 ) ;

trace( no1.eval() ) ; // false
trace( no2.eval() ) ; // true
trace( no3.eval() ) ; // false
trace( no4.eval() ) ; // true
```

### NotEquals ###

Performs a logical comparison of the two values to determine if are not equal.

**usage**

```
new NotEquals( value1 , value2 )
```

**example**

```
import system.rules.BooleanRule ;
import system.rules.NotEquals ;
import system.rules.Rule ;

var ne:NotEquals ;

///// Compares objects.

ne = new NotEquals( 1 , 1 ) ;
trace( ne.eval() ) ; // false

ne = new NotEquals( 1 , 2 ) ;
trace( ne.eval() ) ; // true

///// Compares Condition objects.

var cond1:Rule = new BooleanRule( true  ) ;
var cond2:Rule = new BooleanRule( false ) ;
var cond3:Rule = new BooleanRule( true  ) ;

ne = new NotEquals( cond1 , cond1 ) ;
trace( ne.eval() ) ; // false

ne = new NotEquals( cond1 , cond2 ) ;
trace( ne.eval() ) ; // true

ne = new NotEquals( cond1 , cond3 ) ;
trace( ne.eval() ) ; // false

///// Compares Equatable objects.

var equals:Function = function( o:Object ):Boolean
{
    return this.id == o.id ;
}

var o1:Object = { id:1 , equals:equals } ;
var o2:Object = { id:2 , equals:equals } ;
var o3:Object = { id:1 , equals:equals } ;

ne = new NotEquals( o1 , o1 ) ;
trace( ne.eval() ) ; // false

ne = new NotEquals( o1 , o2 ) ;
trace( ne.eval() ) ; // true

ne = new NotEquals( o1 , o3 ) ;
trace( ne.eval() ) ; // false
```

### And ###

Used to perform a logical conjunction on two conditions and more.

**usage**

```
new And( c1:Condition , c2:Condition , …conditions:Array = null )
```

**example**

```
import system.rules.BooleanRule ;
import system.rules.And ;
import system.rules.Rule ;

var cond1:Rule = new BooleanRule( true  ) ;
var cond2:Rule = new BooleanRule( false ) ;
var cond3:Rule = new BooleanRule( true  ) ;

var a:And ;

a = new And( cond1 , cond1 ) ;
trace( a.eval() ) ; // true

a = new And( cond1 , cond1 , cond1 ) ;
trace( a.eval() ) ; // true

a = new And( cond1 , cond2 ) ;
trace( a.eval() ) ; // false

a = new And( cond2 , cond1 ) ;
trace( a.eval() ) ; // false

a = new And( cond2 , cond2 ) ;
trace( a.eval() ) ; // false

a = new And( cond1 , cond2 , cond3 ) ;
trace( a.eval() ) ; // false

a = new And( cond1 , cond3 , cond2 ) ;
trace( a.eval() ) ; // false
```

### Or ###

Used to perform a logical disjunction on two conditions or more.

**usage**

```
new Or( c1:Rule , c2:Rule , …conditions:Array = null )
```

**example**

```
import system.rules.BooleanRule ;
import system.rules.Or ;
import system.rules.Rule ;

var cond1:Rule = new BooleanRule( true ) ;
var cond2:Rule = new BooleanRule( false ) ;
var cond3:Rule = new BooleanRule( true ) ;

var o:Or ;

o = new Or( cond1 , cond1 ) ;
trace( o.eval() ) ; // true

o = new Or( cond1 , cond2 ) ;
trace( o.eval() ) ; // true

o = new Or( cond2 , cond1 ) ;
trace( o.eval() ) ; // true

o = new Or( cond2 , cond2 ) ;
trace( o.eval() ) ; // false

o = new Or( cond1 , cond2 , cond3 ) ;
trace( o.eval() ) ; // true

o = new Or( cond1 , cond3 , cond2 ) ;
trace( o.eval() ) ; // true
```

### GreaterThan ###

Used to indicates if a value is greater than another value.

**usage**

```
new GreaterThan( value1 , value2 )
```

**example**

```
import system.rules.Rule ;
import system.rules.GreaterThan ;

var rule:Rule ;

rule = new GreaterThan( 1 , 1 ) ;
trace( rule.eval() ) ; // false

rule = new GreaterThan( 1 , 2 ) ;
trace( rule.eval() ) ; // false

rule = new GreaterThan( 3 , 2 ) ;
trace( rule.eval() ) ; // true
```

### GreaterOrEqualsThan ###

Used to indicates if a value is greater or equal than another value.

**usage**

```
new GreaterOrEqualsThan( value1 , value2 )
```

**example**

```
import system.rules.Rule ;
import system.rules.GreaterOrEqualsThan ;

var rule:Rule ;

rule = new GreaterOrEqualsThan( 1 , 1 ) ;
trace( rule.eval() ) ; // true

rule = new GreaterOrEqualsThan( 1 , 2 ) ;
trace( rule.eval() ) ; // false

rule = new GreaterOrEqualsThan( 3 , 2 ) ;
trace( rule.eval() ) ; // true
```

### LessThan ###

Used to indicates if a value is less than another value.

**usage**

```
new LessThan( value1 , value2 )
```

**example**

```
import system.rules.Rule ;
import system.rules.LessThan ;

var rule:Rule ;

rule = new LessThan( 1 , 1 ) ;
trace( rule.eval() ) ; // false

rule = new LessThan( 1 , 2 ) ;
trace( rule.eval() ) ; // true

rule = new LessThan( 3 , 2 ) ;
trace( rule.eval() ) ; // false
```

### LessOrEqualsThan ###

Used to indicates if a value is less or equal than another value.

**usage**

```
new LessOrEqualsThan( value1 , value2 )
```

**example**

```
import system.rules.Rule ;
import system.rules.LessThan ;

var rule:Rule ;

rule = new LessThan( 1 , 1 ) ;
trace( rule.eval() ) ; // false

rule = new LessThan( 1 , 2 ) ;
trace( rule.eval() ) ; // true

rule = new LessThan( 3 , 2 ) ;
trace( rule.eval() ) ; // false
```

### Even ###

Evaluates if the value is even.

**usage**

```
new Even( value )
```

**example**

```
import system.rules.Even ;
import system.rules.Rule ;

var rule:Rule ;

rule = new Even( 0 ) ;
trace( rule.eval() ) ; // true

rule = new Even( 1 ) ;
trace( rule.eval() ) ; // false

rule = new Even( 2 ) ;
trace( rule.eval() ) ; // true

rule = rule Even( 3 ) ;
trace( rule.eval() ) ; // false
```

### Odd ###

Evaluates if the value is odd.

**usage**

```
new Odd( value1 )
```

**example**

```
import system.rules.Rule ;
import system.rules.Odd ;

var rule:Rule ;

rule = new Odd( 0 ) ;
trace( rule.eval() ) ; // false

rule = new Odd( 1 ) ;
trace( rule.eval() ) ; // true

rule = new Odd( 2 ) ;
trace( rule.eval() ) ; // false

rule = new Odd( 3 ) ;
trace( rule.eval() ) ; // true
```

### DivBy ###

Evaluates if the modulo of two values returns 0

**usage**

```
new DivBy( value1 , value2 )
```

**example**

```
import system.rules.Rule ;
import system.rules.DivBy ;

var cond:Rule ;

cond = new DivBy( 4 , 2 ) ;
trace( cond.eval() ) ; // true

cond = new DivBy( 5 , 2 ) ;
trace( cond.eval() ) ; // false
```

### Null ###

Evaluates if the value is null.

**usage**

```
new Null( value:* , strict:Boolean = false )
```

**example**

```
import system.rules.Rule ;
import system.rules.Null ;

var cond:Rule ;

cond = new Null( undefined , true ) ;
trace( cond.eval() ) ; // false

cond = new Null( undefined ) ;
trace( cond.eval() ) ; // true

cond = new Null( null ) ;
trace( cond.eval() ) ; // true

cond = new Null( "hello" ) ;
trace( cond.eval() ) ; // false
```

### Undefined ###

Evaluates if the value is undefined.

**usage**

```
new Undefined( value:* )
```

**example**

```
import system.rules.Rule ;
import system.rules.Undefined ;

var value:* ;

var cond1:Rule = new Undefined( value ) ;

value = {} ;

var cond2:Rule = new Undefined( value ) ;

trace( cond1.eval() ) ; // true
trace( cond2.eval() ) ; // false
```

### EmptyString ###

Evaluates if the value is an empty String.

**usage**

```
new EmptyString( value:* )
```

**example**

```
import system.rules.Rule ;
import system.rules.EmptyString ;

var cond1:Rule = new EmptyString( null ) ;
var cond1:Rule = new EmptyString( 1 ) ;
var cond3:Rule = new EmptyString( "hello" ) ;
var cond4:Rule = new EmptyString( "" ) ;

trace( cond1.eval() ) ; // false
trace( cond2.eval() ) ; // false
trace( cond3.eval() ) ; // false
trace( cond4.eval() ) ; // true
```

### Zero ###

Evaluates if the value is 0.

**usage**

```
new Zero( value:* )
```

**example**

```
import system.rules.Rule ;
import system.rules.Zero ;

var cond:Rule ;

cond = new Zero( 0 ) ;
trace( cond.eval() ) ; // true

cond = new Zero( 10 ) ;
trace( cond.eval() ) ; // false
```

## Package system.logic ##

### system.logic.IfTask ###

Performs some tasks based on whether a given condition holds true or not.

The **system.logic.IfTask** class extends the **system.process.Task** class and implements the **system.process.Action** interface, it can be used in a **Chain** or **BatchTask** object.

**usage**

```
new IfTask ( rule:Boolean , thenTask:Action , elseTask:Action , …elseIfTask:Array )
new IfTask ( rule:Rule , thenTask:Action , elseTask:Action , …elseIfTask:Array )
```

**Methods**

  * task.addRule( rule:**):IfTask
  * task.addThen( action:Action ):IfTask
  * task.addElse( action:Action ):IfTask
  * task.addElseIf( …elseIfTasks:Array ):IfTask
  * task.removeRule():IfTask
  * task.removeThen():IfTask
  * task.removeElse():IfTask
  * task.removeAllElseIf():IfTask**

**Note :** In the constructor of the **IfTask** class and this **'addElseIf'** method the optional **…elseIfTasks** Array arguments are a suite of **ElseIf** objects or a couple of **Rule** and **Task** objects.

In all the next examples i defines and use the custom class **examples.process.Message** defines with the source code :

```
package examples.process
{
   import system.process.Task;
   
   public class Message extends Task
   {
       public function Message( message:String )
       {
           this.message = message ;
       }
       
       public var message:String ;
       
       public override function run( ...arguments:Array ):void
       {
           notifyStarted() ;
           trace( message ) ;
           notifyFinished() ;
       }
   }
}
```

**Example 1**

```
import examples.process.Message ;

import system.process.Task ;
import system.logic.IfTask ;

import system.rules.BooleanRule ;

var task:Task = new IfTask() ;

task.addRule( ge) ) ;
task.addThen( new Message("then")    ) ;
task.addElse( new Message("else")    ) ;

task.addElseIf
(
    new BooleanRule(false) , new Message("elseif #1") 
)

task.addElseIf
(
    new ElseIf(new BooleanRule(true),new Message("elseif #2")) , 
    new ElseIf(new BooleanRule(true),new Message("elseif #3")) , 
    
    new BooleanRule(true) , new Message("elseif #4") ,
    new BooleanRule(true) , new Message("elseif #5") 
 ) ;

task.run() ;
```

**Example 2 (inline invocation)**

```
import examples.process.Message ;

import system.process.Task ;
import system.logic.IfTask ;
import system.rules.Equals ;

var task:Task = new IfTask() ;

task.addRule(new Equals(1,2))
    .addThen(new Message("then"))
    .addElse(new Message("else"))
    .run() ;
```

### system.logic.ElseIf ###

Performs a specific elseif conditional task in the **IfTask** instances.

**usage**

```
new ElseIf ( rule:Boolean , then:Action )
new ElseIf ( rule:Rule    , then:Action )
```

**example**

```
import examples.process.Message ;

import system.process.Task ;
import system.logic.ElseIf ;
import system.logic.IfTask ;

import system.rules.Equals ;

var value:Number = 10 ;

var ei1:ElseIf = new ElseIf((value>10),new Message("value > 10")) ;
var ei2:ElseIf = new ElseIf(new Equals(value,10),new Message("value == 10")) ;

var task:Task = new IfTask() ;

task.addRule( value < 10 )
    .addThen( new Message("value < 10") )
    .addElseIf( ei1 , ei2 )
    .run() ;
```

### system.logic.ElseIf subclasses ###

You can use a pre-set of **ElseIf** subclasses, all this classes extends the ElseIf class and defines a specific constructor who defines the specific rules to use it easily and automatically :

_**ElseIfEmptyString, ElseIfEquals, ElseIfFalse, ElseIfGreaterOrEqualsThan, ElseIfGreaterThan, ElseifLessOrEqualsThan, ElseIfLessThan, ElseIfNull, ElseIfTrue, ElseIfZero**_

**example**

```
import examples.process.Message ;

import system.process.Task ;
import system.logic.ElseIfZero ;
import system.logic.IfTask ;

var value:Number = 0 ;

var task:Task = new IfTask() ;

task.addRule( value < 10 )
    .addThen( new Message("value < 10") )
    .addElseIf( new ElseIfZero( value , new Message("value == 0") ) )
    .run() ;
```

### system.logic.IfTrue ###

Perform some tasks based on whether a given condition holds true.

The **system.logic.IfTrue** class extends the **IfTask** class. This conditional task use a system.rules.True rule to defines the process.

**usage**

```
new IfTrue( condition:* , thenTask:Action = null , elseTask:Action = null , ...elseIfTasks:Array )
```

**example**

```
import examples.process.Message;
import system.logic.IfTrue;

var task:IfTrue ;

var value:uint = 10 ;  

task = new IfTrue(value == 10,new Message("then"),new Message("else")) ;

task.run() ; // then
```

### system.logic.IfFalse ###

Perform some tasks based on whether a given condition holds false.

The **system.logic.IfFalse** class extends the **IfTask** class. This conditional task use a system.rules.False rule to defines the process.

**usage**

```
new IfFalse( condition:* , thenTask:Action = null , elseTask:Action = null , ...elseIfTasks:Array )
```

**example**

```
import examples.process.Message;
import system.logic.IfFalse;

var task:IfFalse ;

var value:uint = 10 ;  

task = new IfFalse(value == 10,new Message("then"),new Message("else")) ;

task.run() ; // else
```

### system.logic.IfEquals ###

Perform some tasks based on whether a given condition holds equality of two values.

The **system.logic.ifEquals** class extends the **IfTask** class. This conditional task use a **system.rules.Equals** rule to defines the process.

**usage**

```
new IfEquals( value1:* , value2:* , thenTask:Action = null , elseTask:Action = null , ...elseIfTasks:Array )
```

**example**

```
import examples.process.Message;
import system.logic.IfEquals;

var a:uint = 10 ;
var b:uint = 20 ;

var task:IfEquals ;

task = new IfEquals( 10 , 10 , new Message("then"), new Message("else")) ;
task.run() ; // then

task = new IfEquals( 10 , 20 , new Message("then"), new Message("else")) ;
task.run() ; // else
```

### system.logic.IfNull ###

Perform some tasks based on whether a given value is null (strict or not).

The **system.logic.IfNull** class extends the **IfTask** class. This conditional task use a **system.rules.Null** rule to defines the process.

**usage**

```
new IfNull( value:* , strict:Boolean = false , thenTask:Action = null , elseTask:Action = null , ...elseIfTasks:Array )
```

**example**

```
import examples.process.Message;
import system.logic.IfNull;

var task:IfNull ;

var value:* ;  

task = new IfNull( undefined , true , new Message("then #1") , new Message("else #1") ) ;
task.run() ; // else #1
            
task = new IfNull( undefined , false , new Message("then #2") , new Message("else #2") ) ;
task.run() ; // then #2
           
task = new IfNull( null , false , new Message("then #3") , new Message("else #3") ) ;
task.run() ; // then #3
            
task = new IfNull( "hello" , false , new Message("then #4") , new Message("else #4") ) ;
task.run() ; // else #4
```

### system.logic.IfUndefined ###

Perform some tasks based on whether a given value is undefined.

The **system.logic.IfUndefined** class extends the **IfTask** class. This conditional task use a **system.rules.Undefined** rule to defines the process.

**usage**

```
new IfUndefined( value:* , thenTask:Action = null , elseTask:Action = null , ...elseIfTasks:Array )
```

**example**

```
import examples.process.Message;
import system.logic.IfUndefined;

var task:IfUndefined ;
 
var value:* ;

task = new IfUndefined(value,new Message("then #1"),new Message("else #1")) ;
task.run() ; // then #1
            
value = null ;
task  = new IfUndefined(value,new Message("then #2"),new Message("else #2")) ;
task.run() ; // else #2
            
value = "hello" ;
task = new IfUndefined(value,new Message("then #3"),new Message("else #3")) ;
task.run() ; // else #3
```

### system.logic.IfZero ###

Perform some tasks based on whether a given value is 0.

The **system.logic.IfZero** class extends the **IfTask** class. This conditional task use a **system.rules.Zero** rule to defines the process.

**usage**

```
new IfZero( value:* , thenTask:Action = null , elseTask:Action = null , ...elseIfTasks:Array )
```

**example**

```
package examples
{
    import system.logic.IfZero;
    
    import flash.display.Sprite;
    
    public class IfZeroExample extends Sprite
    {
        public function IfZeroExample()
        {
            var task:IfZero ;
            
            var value:uint ;
            
            task = new IfZero( value , new Then(), new Else() ) ;
            task.run() ; // then
            
            value = 10 ;
            
            task = new IfZero( value , new Then(), new Else() ) ;
            task.run() ; // else
            
            value = 0 ;
            
            task = new IfZero( value , new Then(), new Else() ) ;
            task.run() ; // then
        }
    }
}

import system.process.Task;

class Then extends Task 
{
    public function Then() {}
    
    public override function run( ...arguments:Array ):void
    {
        notifyStarted() ;
        trace( "then" ) ;
        notifyFinished() ;
    }
}

class Else extends Task 
{
    public function Else() {}
    
    public override function run( ...arguments:Array ):void
    {
        notifyStarted() ;
        trace( "else" ) ;
        notifyFinished() ;
    }
}
```

### system.logic.IfEmptyString ###

Perform some tasks based on whether a given value is an empty string ("").

The **system.logic.IfEmptyString** class extends the **IfTask** class. This conditional task use a **system.rules.EmptyString** rule to defines the process.

**usage**

```
new IfEmptyString( value:* , thenTask:Action = null , elseTask:Action = null , ...elseIfTasks:Array )
```

**example**

```
package examples
{
    import system.logic.IfEmptyString;
    
    import flash.display.Sprite;
    
    public class IfEmptyStringExample extends Sprite
    {
        public function IfEmptyStringExample()
        {
            var task:IfEmptyString ;
            
            var value:String ;
            
            task = new IfEmptyString( value , new Then(), new Else() ) ;
            task.run() ; // else
            
            value = "" ;
            
            task = new IfEmptyString( value , new Then(), new Else() ) ;
            task.run() ; // then
            
            value = "hello" ;
            
            task = new IfEmptyString( value , new Then(), new Else() ) ;
            task.run() ; // else
        }
    }
}

import system.process.Task;

class Then extends Task 
{
    public function Then() {}
    
    public override function run( ...arguments:Array ):void
    {
        notifyStarted() ;
        trace( "then" ) ;
        notifyFinished() ;
    }
}

class Else extends Task 
{
    public function Else() {}
    
    public override function run( ...arguments:Array ):void
    {
        notifyStarted() ;
        trace( "else" ) ;
        notifyFinished() ;
    }
}
```

### system.logic.IfGreaterThan ###

Perform some tasks based on whether a given value is greater than another value.

The **system.logic.IfGreaterThan** class extends the **IfTask** class. This conditional task use a **system.rules.GreaterThan** rule to defines the process.

**usage**

```
new IfGreaterThan( value1:* , value2:* , thenTask:Action = null , elseTask:Action = null , ...elseIfTasks:Array )
```

**example**

```
package examples
{
    import system.logic.IfGreaterThan;
    
    import flash.display.Sprite;
    
    public class IfGreaterThanExample extends Sprite
    {
        public function IfGreaterThanExample()
        {
            var task:IfGreaterThan ;
            
            var th:Then = new Then() ;
            var el:Else = new Else() ;
           
            var value1:uint = 10 ;
            var value2:uint = 20 ;
            
            task = new IfGreaterThan(value1,value2,th,el) ;
            task.run() ; // else
            
            task = new IfGreaterThan(value2,value1,th,el) ;
            task.run() ; // then
            
            task = new IfGreaterThan(value1,value1,th,el) ;
            task.run() ; // else
        }
    }
}

import system.process.Task;

class Then extends Task 
{
    public function Then() {}
    
    public override function run( ...arguments:Array ):void
    {
        notifyStarted() ;
        trace( "then" ) ;
        notifyFinished() ;
    }
}

class Else extends Task 
{
    public function Else() {}
    
    public override function run( ...arguments:Array ):void
    {
        notifyStarted() ;
        trace( "else" ) ;
        notifyFinished() ;
    }
}
```

### system.logic.IfGreaterOrEqualsThan ###

Perform some tasks based on whether a given value is greater or equals than another value.

The **system.logic.IfGreaterOrEqualsThan** class extends the **IfTask** class. This conditional task use a **system.rules.GreaterOrEqualsThan** rule to defines the process.

**usage**

```
new IfGreaterOrEqualsThan( value1:* , value2:* , thenTask:Action = null , elseTask:Action = null , ...elseIfTasks:Array )
```

**example**

```
package examples
{
    import system.logic.IfGreaterOrEqualsThan;
    
    import flash.display.Sprite;
    
    public class IfGreaterOrEqualsThanExample extends Sprite
    {
        public function IfGreaterOrEqualsThanExample()
        {
            var task:IfGreaterOrEqualsThan ;
            
            var th:Then = new Then() ;
            var el:Else = new Else() ;

            var value1:uint = 10 ;
            var value2:uint = 20 ;
            
            task = new IfGreaterOrEqualsThan(value1,value2,th,el) ;
            task.run() ; // else
            
            task = new IfGreaterOrEqualsThan(value2,value1,th,el) ;
            task.run() ; // then
            
            task = new IfGreaterOrEqualsThan(value2,value1,th,el) ;
            task.run() ; // then
        }
    }
}

import system.process.Task;

class Then extends Task 
{
    public function Then() {}
    
    public override function run( ...arguments:Array ):void
    {
        notifyStarted() ;
        trace( "then" ) ;
        notifyFinished() ;
    }
}

class Else extends Task 
{
    public function Else() {}
    
    public override function run( ...arguments:Array ):void
    {
        notifyStarted() ;
        trace( "else" ) ;
        notifyFinished() ;
    }
}
```

### system.logic.IfLessThan ###

Perform some tasks based on whether a given value is less than another value.

The **system.logic.IfLessThan** class extends the **IfTask** class. This conditional task use a **system.rules.LessThan** rule to defines the process.

**usage**

```
new IfLessThan( value1:* , value2:* , thenTask:Action = null , elseTask:Action = null , ...elseIfTasks:Array )
```

**example**

```
package examples
{
    import system.logic.IfLessThan;
    
    import flash.display.Sprite;
    
    public class IfLessThanExample extends Sprite
    {
        public function IfLessThanExample()
        {
            var task:IfLessThan ;
            
            var th:Then = new Then() ;
            var el:Else = new Else() ;
           
            var value1:uint = 10 ;
            var value2:uint = 20 ;
            
            task = new IfLessThan(value1,value2,th,el) ;
            task.run() ; // then
            
            task = new IfLessThan(value2,value1,th,el) ;
            task.run() ; // else
            
            task = new IfLessThan(value1,value1,th,el) ;
            task.run() ; // else
        }
    }
}

import system.process.Task;

class Then extends Task 
{
    public function Then() {}
    
    public override function run( ...arguments:Array ):void
    {
        notifyStarted() ;
        trace( "then" ) ;
        notifyFinished() ;
    }
}

class Else extends Task 
{
    public function Else() {}
    
    public override function run( ...arguments:Array ):void
    {
        notifyStarted() ;
        trace( "else" ) ;
        notifyFinished() ;
    }
}
```

### system.logic.IfLessOrEqualsThan ###

Perform some tasks based on whether a given value is less or equals than another value.

The **system.logic.IfLessOrEqualsThan** class extends the **IfTask** class. This conditional task use a **system.rules.LessOrEqualsThan** rule to defines the process.

**usage**

```
new IfLessOrEqualsThan( value1:* , value2:* , thenTask:Action = null , elseTask:Action = null , ...elseIfTasks:Array )
```

**example**

```
package examples
{
    import system.logic.IfLessOrEqualsThan;
    
    import flash.display.Sprite;
    
    public class IfLessOrEqualsThanExample extends Sprite
    {
        public function IfLessOrEqualsThanExample()
        {
            var task:IfLessOrEqualsThan ;
            
            var th:Then = new Then() ;
            var el:Else = new Else() ;

            var value1:uint = 10 ;
            var value2:uint = 20 ;
            
            task = new IfLessOrEqualsThan(value1,value2,th,el) ;
            task.run() ; // then
            
            task = new IfLessOrEqualsThan(value2,value1,th,el) ;
            task.run() ; // else
            
            task = new IfLessOrEqualsThan(value2,value1,th,el) ;
            task.run() ; // then
        }
    }
}

import system.process.Task;

class Then extends Task 
{
    public function Then() {}
    
    public override function run( ...arguments:Array ):void
    {
        notifyStarted() ;
        trace( "then" ) ;
        notifyFinished() ;
    }
}

class Else extends Task 
{
    public function Else() {}
    
    public override function run( ...arguments:Array ):void
    {
        notifyStarted() ;
        trace( "else" ) ;
        notifyFinished() ;
    }
}
```