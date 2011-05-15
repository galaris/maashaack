--------------------------------------------------------------------------------
build-abc
=========

small set of files to build *.abc equivalent for your *.swc library

Add abc building to your current project
----------------------------------------

Let's say you have a basic AS3 project

--------
..
 |_ build
 |    |_ build.properties
 |
 |_ src
 |    |_ test
 |         |_ MyClass.as
 |         |_ MyOtherClass.as
 |
 |_ build.xml
--------

your current build generate a SWC

to also build an ABC file, do the following

1. create a SVN external

copy the file "build-abc_ext.txt" to your build directory
--------
$ cd build
$ svn ps svn:externals . -F build-abc_ext.txt
property 'svn:externals' set on '.'
--------

now do an update
--------
$ svn update
Fetching external item into 'abc'
A    abc/asc.jar
A    abc/avmglue.abc
A    abc/builtin.abc
A    abc/toplevel.abc
--------

2. prepare a main file to build the *.abc

in your src/ directory

MyLib.as
--------
include "test/MyClass.as";
include "test/MyOtherClass.as";

--------

3. update your build.properties

--------
ASC      = build/abc/asc.jar
builtin  = build/abc/builtin.abc
toplevel = build/abc/toplevel.abc
avmglue  = build/abc/avmglue.abc

--------


4. update your build.xml

for ex:
--------
    <target name="build-abc">
        
        <java
            dir="${basedir}"
            jar="${ASC}"
            fork="true"
            failonerror="true"
        >
            <arg line="-AS3 -strict -optimize -import ${builtin} -import ${toplevel} -import ${avmglue} src/MyLib.as"/>
        </java>
        
        <move file="src/MyLib.abc" todir="bin-release" />
        
    </target>
--------


TODO

--------------------------------------------------------------------------------
