## Introduction ##

from the Flex documentation
> Metadata statements are associated with a class declaration, an individual data field,
> or a method. They are bound to the next line in the file. When you define a component
> property or method, add the metadata tag on the line before the property
> or method declaration.

## Details ##

see a list of [officially supported metadata tags](http://livedocs.adobe.com/flex/3/html/metadata_3.html)
amongst the more interesting are

### `[Exclude]` ###
Omits the class element from the Flex Builder tag inspector.

```
[Exclude(name="label", kind="property")]
```

What the doc does not say is this is to omits inherited members
implemented in the superclass.

### `[ExcludeClass]` ###
Omits the class from the Flex Builder tag inspector.
(equivalent to the `@private` tag in ASDoc)

```
package test
{
    [ExcludeClass]
    public class Something
    {
    
    }
}
```


### `[SWF]` ###
undocumented

```
[SWF width="#" height="#" widthPercent="#" heightPercent="#" \
     scriptRecursionLimit="#" scriptTimeLimit="#" frameRate="#" \
     backgroundColor="#" pageTitle="<String>"]
```
Allows to define SWF parameters in an AS3 project.

### `[RequiresLicense]` ###
undocumented

Internal to Adobe, used with the Chart component.

### `[CollapseWhiteSpace]` ###
undocumented

Used for certain properties that accept large strings,
where in MXML you might have newlines or whatnot for source
code formatting that you don't want to be passed through to the string.

### `[Frame]` ###
undocumented

```
[Frame(factoryClass="mx.core.FlexApplicationBootstrap")]
```

from [Modular Application (part2)](http://blogs.adobe.com/rgonzalez/2006/06/modular_applications_part_2.html)
```
This metadata is a hint to the compiler that the class containing the metadata would
like to be bootstrapped by the cited factory.
 
In other words, when you build an application based on mx.core.Application,
that isn't actually the "root" class of the SWF. The root class is actually a
compiler-generated subclass of mx.managers.SystemManager that overrides the info()
method. Turn on "keep-generated-actionscript" during your compile, and you can see what
the compiler generates.

The rules are a bit weird, but basically: if the [Frame] metadata exists on the base
class of your application, a subclass of the factory will be generated. If the metadata
is directly on your application class, it will be honored, but no subclass will be
generated; its assumed that you've already written the appropriate factory.

When a frame factory class has been specified, the compiler will basically create a
multi-frame movie, where the factory class is on the previous frame. It can arbitrarily
daisy-chain these frames; you could (although why?) build a 10-frame bootstrapped movie
this way. Note that the metadata is actually just an inline alias for the "frames"
compiler configuration option, which lets you explicitly specify the frame classes.
```

### `[Mixin]` ###
undocumented

usage
```
[Mixin]
public class Something
{
    public static function init( systemManager:ISystemManager )
    {
    trace( "call me first" );
    }
}
```
this is specific to Flex, see [StaticCodeBlock](StaticCodeBlock.md).