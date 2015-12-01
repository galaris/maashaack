## Introduction ##

This must be one of the most debated subject ~~in the AS3 community,~~ everywhere, see the wikipedia comment [|1|](#1.md)

From wikipedia I will keep the main definition
```
 In software engineering, the singleton pattern is a design pattern that is used
 to restrict instantiation of a class to one object.
```

and the implementation
```
 Implementation of a singleton pattern must satisfy the single instance and
 global access principles.
```

The most common mistake and source of the debate is because people try to apply to AS3
the Java-way, we end up with multiple different hackish way of implementing a singleton in AS3, and this is just wrong.

Remember we are hybrid, and our language (AS3) have features that allow us to do differently than Java as described bellow by Steve Yegge in [his article](http://steve.yegge.googlepages.com/singleton-considered-stupid)
```
 Yep. I was using classes purely as namespaces.
 
 Since in Java, classes are the ONLY globally available namespace
 mechanism built into the language, this is actually a common thing to
 do, Singleton or no. Unless you want to build your own reflective
 registry, or use JNDI or something, classes are your only option for
 separating your code into namespaces. So in that regard, the (very)
 little I was doing with classes wasn't actually so wrong. 
```

## Details ##

In AS3 we can define variables at the package level, we do not need to use the class as a namespace, also we can define class internal to a package and so prevent the class to be instanciated outside of this package.

### basic implementation ###

We define an internal class
```
package test
    {
 
    internal class _Singleton
        {
 
        public function _Singleton()
            {
            }
 
 
        public const testconst:String = "hello world";
 
        public var testvar:String = "bonjour le monde";
 
        public function testMethod():String
            {
            return "ni hao shijie";
            }
 
        }
    }
```

then we define a public constant
```
package test
    {
    /* globally accessible and unique object
       once there, can not be overriden
    */
    public const Singleton:_Singleton = new _Singleton();
    }
```

`test.Singleton` is unique and globally accessible and can not be overrided,
that's it you got your singleton.


### advanced implementation ###

One of the main concern (and debate) is people trying to prevent the class to be
instancied more than once because they think
> oh if my class is instancied twice it's no more a singleton

**wrong!**

the singleton is the access point, the instance, not the instanciation
you can not have two `test.Singleton`, it's a constant!.

Now the real concern would be to prevent a second instanciation of the class
to prevent unecessary huge code setup (like database access for ex).

AS3 allows to define a special internal class, if you define it outside the `package` statement.

Even class residing in the same package will not be able to instanciate that special internal class.

the implementation is slighty similar as before
```

package test
    {
    /* globally accessible and unique object
       once instancied, can not be overriden
    */
    public const Singleton:_Singleton = new _Singleton();
    }



    /* completely unaccessible to other packages and/or public definition
    */
    internal class _Singleton
        {
 
        public function _Singleton()
            {
            }
 
 
        public const testconst:String = "hello world";
 
        public var testvar:String = "bonjour le monde";
 
        public function testMethod():String
            {
            return "ni hao shijie";
            }
 
        }

```

But you should use this special case only on rare occasion, where you absolutely need it.
This is more an unwanted feature that we can use in AS3 than anything else, in fact some people could qualify that as a bug.

First, even if that special spot can not be accessed by other classes,
you could encounter name collision

```
package test
{
   public var a:_A = new _A();
}

internal class _A
{
    public function _A() {}
}

//can collide with

package test
{
   public var b:_A = new _A();
}

internal class _A //colision here
{
    public function _A() {}
}

```

So be sure to use very unique names for those special internal classes.

Second, this feature could simply vanish in the future so don't depend on it too heavyly.


## References ##

[Singleton Considered Stupid](http://steve.yegge.googlepages.com/singleton-considered-stupid)

[The Singleton](http://www.flashbrighton.org/wordpress/?p=91)

[ActionScript 3 Singleton Redux](http://www.darronschall.com/weblog/archives/000274.cfm)

[Singleton Pattern in AS3](http://life.neophi.com/danielr/2006/10/singleton_pattern_in_as3.html)

[Singleton in AS3](http://www.cynergysystems.com/blogs/page/andrewtrice?entry=singleton_in_as3)

[AS3: Singletons](http://www.gskinner.com/blog/archives/2006/07/as3_singletons.html)

[Singleton in ActionScript 3.0](http://skovalyov.blogspot.com/2006/12/there-are-some-ways-to-create-singleton.html)

[Singleton Pattern in Cairngorm 2.1 with Actionscript 3](http://tomschober.blogspot.com/2007/01/singleton-pattern-in-cairngorm-21-with.html)

http://manishjethani.com/blog/2008/04/09/how-i-do-singletons-in-as3/


## Annotation ##

#### 1 ####

How people sucks on wikipedia.

Some time ago I felt strongly about the singleton subject to the point that I've posted my [my view on wikipedia about that](http://en.wikipedia.org/wiki/Singleton_pattern#Actionscript_3.0).

No big deal, a good bunch of language listed, each coming with their own solution to implement a singleton.

Here the [original wikipedia page edited at the time](http://en.wikipedia.org/w/index.php?title=Singleton_pattern&diff=221451066&oldid=221307090).

Same page [completely removed later for cause of a spelling mistake](http://en.wikipedia.org/w/index.php?title=Singleton_pattern&diff=231374118&oldid=229764214), woupihou I wrote **instanciate** instead of **instantiate** and the whole thing is deleted.

I have better things to do than the classic wikipedia edit battle, a `const` at the package level is a very clean and standard way to define a singleton in AS3, if some morons want to continue to reinvent private class instance when they don't really exists in the language spec and have all their code butchered with `getInstance()`, please morons be my guest and continue.