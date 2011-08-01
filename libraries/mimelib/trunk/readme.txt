--------------------------------------------------------------------------------
mimelib
=======

How to work with the sources
----------------------------

We don't include the /bin directory as it would add 16MB

to be able to work with this code you need to follow
http://code.google.com/p/redtamarin/wiki/GettingStarted

once you have done that you should have the following /bin directory
--------
..
 |_ bin
     |_ abcdump               <- Displays the contents of abc or swf files
     |_ asc                   <- Executable wrapper for asc.jar
     |_ asc.jar
     |_ builtin.abc
     |_ createprojector       <- Utility to create a projector
     |_ EclipseExternalTools  <- Utility to create Eclipse External Tools for redtmarin
     |_ redshell              <- redshell release
     |_ redshell_d            <- redshell debug
     |_ swfmake               <- Utility to stitch ABC files together into a single swf
     |_ toplevel.abc
     
--------

With that you're all setup to work on your operating system

for ex:
now in the Flex Builder IDE, select "mimelib.as"
and in tools click "ASC_compile"

you should obtain a mimelib.abc


another ex:
in the Flex Builder IDE, select "mimelib_test.as"
and in tools click "ASC_compile"

you should obtain a mimelib_test.abc

now select "mimelib_test.abc"
and in tools click "redshell_debug"

