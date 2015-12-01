## Introduction ##

Even if we try to make our AS3 code as portable as possible
we have to deal with different little nuggets

  * diff of Flash Player API (FP9 vs FP10 etc.)
  * diff between Flash Player API and AIR API
  * diff between Flash Player API and Tamarin/redtamarin

## Usage ##

All conditional compilation options deal mainly with hosts and API differences

DO NOT USE THEM for dynamic configuration, eg. it will not replace the namespaces **standard**, **optimized** and **experimental**.

from the doc
```
You can use inline constants in ActionScript.

Boolean values can be used to conditionalize top-level definitions of
functions, classes, and variables,
in much the same way you would use an #IFDEF preprocessor command in C or C++.

You cannot use constant Boolean values to conditionalize metadata or import statements. 
```


for Flex Builder
```
 1. Project properties
 2. ActionScript Compiler
 3. in Additional compiler arguments

 -define+=API::FLASH,true -define+=API::REDTAMARIN,false

```

for mxmlc, compc
```
        <compc
            output="foobar.swc"
            include-classes="foobar.as"
            target-player="9.0.45"
        >
            <define name="API::FLASH" value="true" />
            <define name="API::REDTAMARIN" value="false" />
            <strict>true</strict>
            <optimize>true</optimize>

```

for ASDoc
```
        <exec executable="${asdoc.exe}">
        	<arg line="-define+=API::FLASH,true" />
        	<arg line="-define+=API::REDTAMARIN,false" />
```

for ASC
```
        <exec executable="java">
            <arg line="-jar ${redshell.asc}" />
            <arg line="-AS3 -strict -md -optimize" />
            <arg line="-config API::FLASH=false -config API::REDTAMARIN=true" />
```

you can also define them in an external config
```
my-config.xml
----
<?xml version="1.0"?>
<flex-config>
    <compiler>
        <!--
        When you update the defines you need to do a Project Clean... 
        for the the compiler to take into account the changes
        -->
        <define append="true"> 
            <name>API::FLASH</name> 
            <value>true</value> 
        </define> 
        <define append="true"> 
            <name>API::REDTAMARIN</name> 
            <value>false</value> 
        </define> 
   </compiler>
</flex-config>
----
```
and then in Flex Builder
```
 1. Project properties
 2. ActionScript Compiler
 3. in Additional compiler arguments

-load-config my-config.xml

```
and then for mxmlc, compc
```
        <compc
            output="foobar.swc"
            include-classes="foobar.as"
            target-player="9.0.45"
            load-config="my-config.xml"
        >
            <strict>true</strict>
            <optimize>true</optimize>

```


## Options ##

As a general rule we will always use upper case.

### API::FLASH ###

For code targeting the Flash Player and AIR current version.

By default, we will always assume the current stable version of the Flash Player.

If for some VERY RARE reasons we wanted to support a particular version<br>
we would use <code>API::FP_{major}_{minor}</code>.<br>
<br>
for ex: <b>API::FP_9_0</b>

see <a href='FPAPI.md'>FPAPI</a>

<h3>API::AIR</h3>

For code targeting AIR but not supporting the Flash Player.<br>
<br>
By default, we will always assume the current stable version of AIR.<br>
<br>
If for some VERY RARE reasons we wanted to support a particular version<br>
we would use <code>API::AIR_{major}_{minor}</code>.<br>
<br>
for ex: <b>API::AIR_1_5</b>

see <a href='FPAPI.md'>FPAPI</a>


<h3>API::REDTAMARIN</h3>

For code targeting <a href='http://code.google.com/p/redtamarin/'>redtamarin</a> current version.<br>
<br>
If for some VERY RARE reasons we wanted to support a particular version<br>
we would use <code>API::RT_{major}_{minor}_{build}</code>.<br>
<br>
for ex: <b>API::RT_0_3_1</b>

<h3>API::MOCK</h3>

For code providing signatures but not real implementations.<br>
see <a href='avmglue.md'>avmglue</a>.<br>
<br>
<br>
<h3>LOG::P</h3>

For logging isolation/inclusion.<br>
see <a href='logd.md'>logd</a>.<br>
<br>
<br>
<h2>Deprecated</h2>

You may still find some of those in the source code, please fill a bug.<br>
<br>
<h3><del>TAMARIN::exclude</del></h3>

Excludes block of code when compiling for Tamarin/redtamarin<br>
<br>
some examples:<br>
<br>
<pre><code>/* reason:<br>
   no TextField support in Tamarin<br>
*/<br>
TAMARIN::exclude<br>
{<br>
    suite.addTestSuite( TextFieldTargetTest );<br>
}<br>
</code></pre>


<h3><del>TAMARIN::alternate</del></h3>

Allows to provide an alternative for Tamarin/redtamarin only.<br>
<br>
<b>TAMARIN::alternate</b> will be replaced by <b>API::RT_0_2_5</b> etc.<br>
<br>
<br>
<h3><del>API versioning</del></h3>

Based on <a href='http://hg.mozilla.org/tamarin-redux/raw-file/d138e8c6e0cf/doc/apiversioning.html'>API Versioning in AVM</a> from the Tamarin project, we will use the same naming convention.<br>
<br>
<table><thead><th> constant </th><th> description </th></thead><tbody>
<tr><td> <b>API::FP_9_0</b> </td><td> Flash Player 9.0 </td></tr>
<tr><td> <b>API::FP_10_0</b> </td><td> Flash Player 10.0 </td></tr>
<tr><td> <b>API::FP_10_1</b> </td><td> Flash Player 10.1 </td></tr>
<tr><td> <b>API::AR_1_0</b> </td><td> AIR 1.0     </td></tr>
<tr><td> <b>API::AR_1_5</b> </td><td> AIR 1.5     </td></tr>
<tr><td> <b>API::AR_1_5_1</b> </td><td> AIR 1.5.1   </td></tr>
<tr><td> <b>API::AR_2_0</b> </td><td> AIR 2.0     </td></tr></tbody></table>

Technically we will almost never use <b>API::FP_9_0</b> as this our default minimum version of the API (unless we have to isolate some code for tamarin),<br>
but as we want also to support command-line AS3 (via redtamarin) we need specialized API for that<br />
(as Tamarin itself does not support all the features in the FP_9_0 API).<br>
<br>
<table><thead><th> constant </th><th> description </th></thead><tbody>
<tr><td> <b>API::RT_0_1</b> </td><td> redtamarin 0.1 </td></tr>
<tr><td> <b>API::RT_0_2</b> </td><td> redtamarin 0.2 </td></tr>
<tr><td> <b>API::RT_0_2_5</b> </td><td> redtamarin 0.2.5 </td></tr></tbody></table>

We will mainly support <a href='http://code.google.com/p/redtamarin/'>redtamarin</a> API but not <a href='http://www.mozilla.org/projects/tamarin/'>Tamarin</a> itself.<br>
<br>
Contrary to the <b>FP</b> and <b>RT</b> API where each version is a subset of itself and zero or more other versions, the <b>RT</b> API works differently and can be totally incompatible and for those cases we will uses <b>TAMARIN::exclude</b>.<br>
<br>
<br>
<h2>Proposals</h2>

These conditionals are not used yet<br>
<br>
<ul><li><b>CONFIG::release</b> release build<br>
</li><li><b>CONFIG::debugging</b> debug build<br>
</li><li><b>EDEN::release</b> release version of eden<br>
</li><li><b>EDEN::debugging</b> debug version of eden</li></ul>
