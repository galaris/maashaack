#!/bin/bash

asc="../build/redshell/asc.jar"
builtin="../build/redshell/builtin.abc"
toplevel="../build/redshell/toplevel.abc"
avmplus="../build/redshell/redshell"

rm -f ${1%.*}.abc

java -jar $asc -AS3 -import $builtin -import $toplevel $1
$avmplus ${1%.*}.abc
