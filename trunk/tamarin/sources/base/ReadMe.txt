
note:
you will need to download the Flex SDK
http://www.adobe.com/go/flexsdk2_download

and copy asc.jar
from
path\to\Flex SDK 2\lib\asc.jar
to
..\base\bin\asc.jar
------------------------------

build_tamarin.bat
compile the base libraries
shell.as and global.as into tamarin.abc

alternatively if you want to only compile
either shell.abc or global.abc
use
build_global.bat
and/or
build_shell.bat

the resulting *.abc files can be found in /src subdirectory
