## Introduction ##

Java developers have [static initialization blocks](http://java.sun.com/docs/books/jls/third_edition/html/classes.html#39245), C# developers have [static constructors](http://msdn2.microsoft.com/en-us/library/k9x6w0hc(vs.80).aspx),
simply put it allow you to initialize code when your class is loaded.


## Details ##

Flex use this principle in the Automation Framework classes,
see [About the automation APIs](http://livedocs.adobe.com/flex/3/html/help.html?content=agents_3.html).

The Flex doc call that a [delegate class](http://livedocs.adobe.com/flex/3/html/help.html?content=functest_components2_14.html) and is very specific to Flex but still can be usefull in some special cases.

see jim Cheng comment on http://adamflater.blogspot.com/2007/03/static-code-blocks.html
```
It's used in the Automation Framework classes mainly to register automation delegate
implementations to component classes before any instances get the chance to be created.
You can do a text search through the framework classes and find all the instances in the
mx.automation.* namespace. It's not all that interesting what they do in their init()
calls, but you'll get the general idea pretty quickly.

The Flex Framework uses this scheme to "beat the developer to the punch" in terms of
initialization such that any component instances are ready to be automated as soon as
they can be instantiated either via direct ActionScript 3.0 code or through MXML.

It's a sneaky trick, but can be useful if you're doing similar things like writing APIs
for other AS3 developers where you need to ensure that some critical early
initialization routines occur "silently" before they ever get a chance to use your API.
For example, installing a logger (such as Adobe's Automation Framework) would be a
perfect use case for this.
```

Alternatively any class in AS3 can have static code execution
```
package
{
    public class Something
    {
        trace( "static execution" );
        Something.hello.push( "world" );
        Something.hello.push( "world" );
        Something.hello.push( "world" );
        
        public function Something()
        {
        trace( "ctor called" )
        trace( "Something.hello: " + Something.hello );
        }
        
        public static var hello:Array = [];
        
    }
}
```

the differene with Flex is using `[Mixin]` the `init()` function will be called
on the 1st frame during SystemManager instanciation, and with static code execution
the code will be called as soon as you import or instanciate the class but before the constructor get called.

In both case, the static block will be called only once.