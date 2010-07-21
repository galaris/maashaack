#!/bin/bash

asc="../build/redshell/asc.jar"
builtin="../build/redshell/builtin.abc"
toplevel="../build/redshell/toplevel.abc"
avmplus="../build/redshell/redshell"
exeOSX="../build/redshell/redshell_d"
exeWIN32="../build/redshell/redshell_d.exe"


rm -f ${1%.*}.abc

java -jar $asc -AS3 -import $builtin -import $toplevel -exe $exeOSX $1
mv ${1%.*}.exe ../${1%.*}
chmod +x ../${1%.*}

java -jar $asc -AS3 -import $builtin -import $toplevel -exe $exeWIN32 $1
mv ${1%.*}.exe ../${1%.*}.exe
