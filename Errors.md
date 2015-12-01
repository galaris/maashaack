## The Error class in AS3 ##

### top-level ###

  * [Error](http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/Error.html)

  * [ArgumentError](http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/ArgumentError.html)
  * [DefinitionError](http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/DefinitionError.html)
  * [EvalError](http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/EvalError.html)
  * [RangeError](http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/RangeError.html)
  * [ReferenceError](http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/ReferenceError.html)
  * [SecurityError](http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/SecurityError.html)
  * [SyntaxError](http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/SyntaxError.html)
  * [TypeError](http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/TypeError.html)
  * [URIError](http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/URIError.html)
  * [VerifyError](http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/VerifyError.html)

### flash.errors package ###

  * [flash.errors.IllegalOperationError](http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/errors/IllegalOperationError.html)
  * [flash.errors.InvalidSWFError](http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/errors/InvalidSWFError.html)
  * [flash.errors.IOError](http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/errors/IOError.html)
  * [flash.errors.MemoryError](http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/errors/MemoryError.html)
  * [flash.errors.ScriptTimeoutError](http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/errors/ScriptTimeoutError.html)
  * [flash.errors.StackOverflowError](http://livedocs.adobe.com/flash/9.0/ActionScriptLangRefV3/flash/errors/StackOverflowError.html)

**Note :** The **flash.events.ErrorEvent** is used to dispatch an error in the event flow, if no listener are registered in the dispatcher the event throws a message :

```
import flash.events.ErrorEvent ;
import flash.events.EventDispatcher ;

var handleError:Function = function( e:ErrorEvent ):void
{
    trace( "handle : " + e ) ;
}

var dispatcher:EventDispatcher = new EventDispatcher() ;

// dispatcher.addEventListener( "test" , handleError ) ; // uncomment this line to test the ErrorEvent normal propagation

dispatcher.dispatchEvent( new ErrorEvent("test", false, false, "hello world" ) ) ;

```

## The Error class in Maashaack ##

### system.errors package ###

  * system.errors.ConcurrencyError:<br>The error throws when methods that have detected concurrent modification of an object when such modification is not permissible.<br>
<ul><li>system.errors.NoSuchElementError:<br>Thrown by an Iterator to indicate that there are no more elements in the iteration.