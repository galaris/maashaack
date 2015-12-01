## Introduction ##

All maashaack projects are documented with asdoc from the Flex 4 SDK.

We debated a lot on wether using [NaturalDocs](http://www.naturaldocs.org/) because of the wiki-style comments
or asdoc, but because asdoc reuse the same workflow of the mxmlc and compc compilers we decided to stay with
the Flex SDK toolchain.

But asdoc is far from perfect and it can be a `b*tch` to configure it to output exactly what you want,
so we took an hybrid approach.

Basically, all main code documentation is in asdoc comments, but extended documentation is linked here on the wiki.

In short, if we have to write more than few lines of documentation, we use a `@see` tag in asdoc and point to a wiki page.

## Informations ##

basic asdoc comment
```
/** 
* The MyClass class do that. 
* Here a second line. 
* Blah blah blah. 
*/
public class MyClass extends Sprite
{

}
```

**special characters:**
| **char** | **asdoc** | comment |
|:---------|:----------|:--------|
| `<`      | `&lt;`    |         |
| `>`      | `&gt;`    |         |
| `&`      | `&#38;`   | do not use `&amp;` |
| `*`      | `&#42;`   |         |
| `?`      | `&#x2014;` | Em dash |
| `™`      | `&#x99;`  | Trademark symbol |
| ` `      | `&#xA0;`  | Nonbreaking space |
| `®`      | `&#xAE;`  | Registered trademark symbol |
| `?`      | `&#xB0;`  | Degree symbol |
| `@`      | `&#64;`   |         |

**HTML tags**
| **asdoc tag** | **description** | comment |
|:--------------|:----------------|:--------|
| `<p>`         | starts a new paragraph |         |
| `<p class="hide">` | hides text from the doc output |         |
| `<listing>`   | program listing |         |
| `<listing version="3.0">` | program listing for AS3 |         |
| `<pre>`       | formats text in monospace |         |
| `<br/>`       | adds a line break | most times using another `<p>` is best  |
| `<ul>, <li>`  | create a list   |         |
| `<table><th><tr><td>` | create a table  |         |
| `<img src="...">` | insert an image | relative path sucks with asdoc |
| `<code>`      | apply monospace formating |         |
| `<strong>, <b>` | bold text       | `<b>` is best |
| `<em>, <i>`   | italic text     | `<i>` is best |
| `<a href="...">` | create a link   |         |

**@see tag**
| **tag usage** | **description** | comment |
|:--------------|:----------------|:--------|
| `@see "some text"` | text string     |         |
| `@see http://www.google.com` | external web site |         |
| `@see page.html` | local HTML page |         |
| `@see SomeClass` | class in same package |         |
| `@see flash.display.TextField` | class in different package |         |
| `@see String` | top level class |         |
| `@see String#charCodeAt()` | method in top level class |         |
| `@see #someMethod()` | method in same class of see tag |         |
| `@see flash.util.#clearInterval()` | package level function |         |
| `@see flash.ui.ContextMenu#customItems` | property in class in different package |         |



## Using asdoc in maashaack ##

align vertically the `*` in the comments
```
/**
 * This is my comment.
 * 
 * <p>Another line of comment.</p>
 */
public function test():void
{

}
```

if you're comment take one line, use one line
```
/** Configuration of the project */
public static var config:Object = {};
```

use `@private` on the setter when you have a getter/setter
```
/**
 * Makes the stuff verbose.
 * 
 * <p>Blah blah blah.</p>
 */
public function get verbose():Boolean
{
    return _verbose;
}

/** @private */
public function set verbose( value:Boolean ):void
{
    _verbose = value;
}
```


```
   /**
    * Environment [...] .
    *
    * @langversion 3.0
    * @playerversion Flash 9
    * @playerversion AIR 1.1
    * @productversion Maashaack 1.2
    * @since 1.0.0
    */
```