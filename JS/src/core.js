/*
  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at
  http://www.mozilla.org/MPL/
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the
  License.
  
  The Original Code is [maashaack framework].
  
  The Initial Developers of the Original Code are
  Zwetan Kjukov <zwetan@gmail.com> and Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developers are Copyright (C) 2006-2011
  the Initial Developers. All Rights Reserved.
  
  Contributor(s):
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
*/

load("./core/setPropFlags.js") ;

load("./core/encapsulate.js") ;
load("./core/Function.js") ;
load("./core/getPackage.js") ;
load("./core/require.js") ;
load("./core/requirePackage.js") ;
load("./core/String.js") ;

// constants

SRC     = "./" ;
SUFFIX  = ".js" ;


if ( _global.core == undefined )
{
    getPackage( "core") ;
}


// packages

getPackage( "core.arrays"  ) ;
getPackage( "core.chars"   ) ;
getPackage( "core.maths"   ) ;
getPackage( "core.objects" ) ;
getPackage( "core.reflect" ) ;
getPackage( "core.strings" ) ;

// core

require( "core.dump"       ) ;
require( "core.dumpArray"  ) ;
require( "core.dumpDate"   ) ;
require( "core.dumpObject" ) ;
require( "core.dumpString" ) ;

// core.arrays

require( "core.arrays.contains"    ) ;
require( "core.arrays.initialize"  ) ;
require( "core.arrays.pierce"      ) ;
require( "core.arrays.reduce"      ) ;
require( "core.arrays.reduceRight" ) ;
require( "core.arrays.repeat"      ) ;
require( "core.arrays.shuffle"     ) ;
require( "core.arrays.sortOn"      ) ;
require( "core.arrays.spliceInto"  ) ;

// core.chars

require( "core.chars.isAlpha"    ) ;
require( "core.chars.isASCII"    ) ;
require( "core.chars.isDigit"    ) ;
require( "core.chars.isHexDigit" ) ;
require( "core.chars.isLower"    ) ;
require( "core.chars.isOperator" ) ;
require( "core.chars.isUnicode"  ) ;
require( "core.chars.isUpper"    ) ;

// core.maths

require( "core.maths.berp"        ) ;
require( "core.maths.bounce"      ) ;
require( "core.maths.ceil"        ) ;
require( "core.maths.clamp"       ) ;
require( "core.maths.clerp"       ) ;
require( "core.maths.coserp"      ) ;
require( "core.maths.floor"       ) ;
require( "core.maths.gcd"         ) ;
require( "core.maths.hermite"     ) ;
require( "core.maths.interpolate" ) ;
require( "core.maths.lerp"        ) ;
require( "core.maths.map"         ) ;
require( "core.maths.normalize"   ) ;
require( "core.maths.percentage"  ) ;
require( "core.maths.replaceNaN"  ) ;
require( "core.maths.round"       ) ;
require( "core.maths.sign"        ) ;
require( "core.maths.sinerp"      ) ;

// core.objects

require( "core.objects.getMembers" ) ;
require( "core.objects.merge"      ) ;

// core.reflect

require( "core.reflect.hasDefinitionByName" ) ;

// core.strings

require( "core.strings.camelCase"           ) ;
require( "core.strings.capitalize"          ) ;
require( "core.strings.center"              ) ;
require( "core.strings.compare"             ) ;
require( "core.strings.clean"               ) ;
require( "core.strings.endsWith"            ) ;
require( "core.strings.fastformat"          ) ;
require( "core.strings.format"              ) ;
require( "core.strings.hyphenate"           ) ;
require( "core.strings.indexOfAny"          ) ;
require( "core.strings.insert"              ) ;
require( "core.strings.lastIndexOfAny"      ) ;
require( "core.strings.lineTerminatorChars" ) ;
require( "core.strings.pad"                 ) ;
require( "core.strings.repeat"              ) ;
require( "core.strings.startsWith"          ) ;
require( "core.strings.trim"                ) ;
require( "core.strings.trimEnd"             ) ;
require( "core.strings.trimStart"           ) ;
require( "core.strings.whiteSpaceChars"     ) ;