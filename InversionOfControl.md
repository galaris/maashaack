# Inversion of Control - Definitions #

<a href='http://creativecommons.org/licenses/by-sa/3.0/'><img src='http://i.creativecommons.org/l/by-sa/2.0/uk/88x31.png' alt='Licence Creative Commons' /> </a>



## Dependency Injection ##

The **Dependency Injection** (DI) refer to the process of supplying code in an existing application. Classes are not responsible in the instantiation of the other classes they need. Objects are **injected** when the instance is initialised.

This **Design Pattern** use many classes or objects that work together. We can also talk about the notion of dependency between objects. There are many ways to use this design pattern. Let's have a closer look to the different types of dependency injection in object oriented code.

**Hard-coding dependencies**

The class create its own dependency. This method is the most simple to handle dependency but it is also the less flexible.

```
package
{
    public class Writer
    {
        public function Writer(){}
        
        public function write( message:String ):void
        {
            ( new Pen() ).write( message ) ;
        }
    }
}
```

In the previous example the class **Writer** use in its method **write( message:String )** an object of type **Pen**. This method is hence dependent of an object of type **Pen**.

The code has a very simple effect but creating directly the object of type **Pen** in the method limit the possibilities of the class and its future evolutions. In case the **Pen** class change we also have to modify the writer class with is not very convenient.

**Looking up dependencies**

This method needs a context. The class call an object and use its method as needed. The context is an external object that handle all the dependencies.

```
package
{
    public class Writer
    {
        public function Writer(){}
       
        public function write( message:String ):void
        {
            var context:Tools = new Tools() ;
            
            context.getPen().write( message ) ;
        }
    }
}
```

**Constructor injection**

This method is a simple and classical approach. Here the model use a class with constructor and parameters for each dependency. Dependencies are set when the class is instantiated.

```
package
{
    public class Writer
    {
        public function Writer( pen:Pen )
        {
            _pen = pen ;
        }
       
        protected var _pen:Pen ;
        
        public function write( message:String ):void
        {
            _pen.write( message ) ;
        }
    }
}
```

Here the constructor of the class inject a reference of type **Pen** that allow the **write()** method to work correctly.

**Setter injection**

Here dependencies are set through the public properties of the class. The dependencies are set after the creation of the object.

Example with a simple public attribute :

```
package
{
    public class Writer
    {
        public function Writer() {}
        
        public var pen:Pen ;

        public function write( message:String ):void
        {
            if( pen )
            {
                pen.write( message ) ;
            }
        }
    }
}
```

Example with a simple public setter method :

```
package
{
    public class Writer
    {
        public function Writer() {}
        
        protected var pen:Pen ;
        
        public function setPen( p:Pen ):void
        {
            this.pen = p ;
        }
        
        public function write( message:String ):void
        {
            if( pen )
            {
                pen.write( message ) ;
            }
        }
    }
}
```

The **setPen()** method inject the dependency in the Write object this can be any object of type **Pen** in order to have the **write()** method working correctly.

Example with a simple public virtual accessor :

```
package
{
    public class Writer
    {
        public function Writer() {}
        
        protected var _pen:Pen ;
        
        public function get pen():Pen
        {
            return _pen ;
        }

        public function set pen( p:Pen ):void
        {
            _pen = p ;
        }
        
        public function write( message:String ):void
        {
            if( _pen )
            {
                _pen.write( message ) ;
            }
        }
    }
}
```

The virtual property "pen" inject in the Write object any object of type **Pen** i order to have the **write()** method working correctly.

**Interface injection**

This approach is the same as **setter injection** or **constructor injection** but here the dependency is typed with an interface :

```
package
{
    public class Writer
    {
        public function Writer() {}
        
        protected var _pen:IPen ;
        
        public function get pen():IPen
        {
            return _pen ;
        }

        public function set pen( p:IPen ):void
        {
            _pen = p ;
        }
        
        public function write( message:String ):void
        {
            if( _pen )
            {
                _pen.write( message ) ;
            }
        }
    }
}
```

In its example **IPen** is an interface who defines the public method **write()**.

```
package
{
    interface class IPen
    {
        function write( message:String ):void ;
    }
}
```

This solution is very flexible and lightweight because it does not develop immediately a class more or less complex to instantiate instances of class **"Write"**. The dependency is defined simply about a behavior.

## Inversion of Control ##

The design pattern **Inversion of Control**, also called **IoC** (another name for **Dependency Injection**) define a set of programming technique where the flow of system control and its objects are reversed from the usual flow.

This concept is based on the "[Hollywood Principle](http://en.wikipedia.org/wiki/Hollywood_Principle)" : **Don't call us, we will call you**.

The main principle is simple, it indicates an application framework that does not need to be called to run the application, the framework itself which is responsible for creating the interactions between objects (whenever it's possible).

![http://maashaack.googlecode.com/svn/gfx/framework/ioc/ioc_hollywood_principle.gif](http://maashaack.googlecode.com/svn/gfx/framework/ioc/ioc_hollywood_principle.gif)

This model highlights the concept of **Programming Layers**. This concept allows to separate each element of an application and work with each independently and then tie them together very simply by having the fewest dependencies as possible at the outset. So the framework to link each layer with each other in time by injecting any dependencies in the object that needs it.

## Container based on Inversion of Control ##

An **Inversion of Control** container is an application infrastructure that feed numerous services need in order to have the application running.

The main services of an **IoC** container classic are :

**Lookup**

The container store or create reference for every objects in the application. it can also be seen as a factory for the application.

**Lifecycle management**

The **lifecycle** of the objects is handled by the container. It can create new objects, automatically inject predefined values in properties of a new instance when it is created, call method when the object is initialised or destructed, etc.

**Configuration**

Objects can be configured through external data without having to rebuild the application; it is possible to use external data with the following formats **eden**, **JSON**, **XML**, ... to create or initialise the application.

**Dependency Injection**

Containers are not limited to handling and configuring objects with simple types, they can also handle link and dependency between objects.

## Object definitions in the IoC containers ##

An **[object definition](ObjectDefinitions.md)** is an object that will create a new object in an application with the **[IoC factory](ObjectFactory.md)**. The **[object definition](ObjectDefinitions.md)** can be regarded as a manual or a guide predefined by the developers of the application using this container.

This manual may contain :

  * an identifier that can save its definition and then create objects,
  * the type of the object that we want to create,
  * the parameters that one wishes to spend in the constructor,
  * the default values that you want to apply on the object (properties and methods),
  * the method name that you want to invoke once the object is created to initialize it,
  * inject dependencies with other objects defined also in the factory,
  * etc.

The **[object definition](ObjectDefinitions.md)** can provide further information on the strategy used by the factory to create the object or the nature of this object in the life cycle of the application like the scope of the object : singleton or prototype.

If one were reduced to its simplest form the definition of an **[IoC container](ObjectFactory.md)**, we could say that it consists of a collection of **[object definitions](ObjectDefinitions.md)** to structure effectively and solid applied throughout its life cycle.