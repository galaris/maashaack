## Before ##

In general you would write your multiline like that
```
    var help:String = "";
help += "Usage:\n";
help += " createprojector [-exe avmshell] [-o filename] file\n";
help += " file           a *.swf or *.abc file\n";
help += " -exe avmshell  the avmshell executable to use\n";
help += " -o filename    defines the name of the output file\n";
```


## After ##

thanks to E4X we have XML literals in AS3

so you can write your multiline like this
```
    var help:String = <x><![CDATA[
Usage:
 createprojector [-exe avmshell] [-o filename] file
 file           a *.swf or *.abc file
 -exe avmshell  the avmshell executable to use
 -o filename    defines the name of the output file
]]></x>.text()[0];
```

Or even better
```
    var help:String = <![CDATA[
Usage:
 createprojector [-exe avmshell] [-o filename] file
 file           a *.swf or *.abc file
 -exe avmshell  the avmshell executable to use
 -o filename    defines the name of the output file
]]>;
```

Yep, the CDATA node is enough to create an XML node,<br>
but mainly because you type your variable as a <code>String</code><br>
the CDATA declaration is implicitly converted with <code>toString()</code>.<br>
<br>
Simple to check<br>
<pre><code>    var help:String = &lt;![CDATA[<br>
Usage:<br>
 createprojector [-exe avmshell] [-o filename] file<br>
 file           a *.swf or *.abc file<br>
 -exe avmshell  the avmshell executable to use<br>
 -o filename    defines the name of the output file<br>
]]&gt;;<br>
<br>
trace( help is XML ); //false <br>
trace( help is String ); //true<br>
</code></pre>

Note that you could keep typing your variable as <code>XML</code>
<pre><code>    var help:XML = &lt;![CDATA[<br>
Usage:<br>
 createprojector [-exe avmshell] [-o filename] file<br>
 file           a *.swf or *.abc file<br>
 -exe avmshell  the avmshell executable to use<br>
 -o filename    defines the name of the output file<br>
]]&gt;;<br>
<br>
trace( help is XML ); //true <br>
trace( help is String ); //false<br>
trace( help ); // toString() is automatically called here<br>
</code></pre>

And why would you want to keep the <code>XML</code> type instead of the <code>String</code> type ?<br>
<br>
for JavaScript XML injection :)<br>
<pre><code>import flash.external.ExternalInterface;<br>
<br>
//before<br>
/*<br>
var something:XML =<br>
        &lt;script&gt;<br>
                &lt;![CDATA[<br>
                    function()<br>
                    {<br>
                        window.alert( "hello world" );<br>
                    }<br>
                ]]&gt;<br>
        &lt;/script&gt;;<br>
*/<br>
<br>
//after<br>
var something:XML = &lt;![CDATA[<br>
function()<br>
{<br>
    window.alert( "hello world" );<br>
}<br>
]]&gt;;<br>
<br>
ExternalInterface.call( something );<br>
</code></pre>