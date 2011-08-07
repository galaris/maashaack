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

//core.*
include "src/core/_toUnicodeNotation.as";
include "src/core/bit.as";
include "src/core/dump.as";
include "src/core/dumpArray.as";
include "src/core/dumpDate.as";
include "src/core/dumpObject.as";
include "src/core/dumpString.as";
include "src/core/uri.as";
include "src/core/version.as";

//core.arrays.*
include "src/core/arrays/contains.as";
include "src/core/arrays/initialize.as";
include "src/core/arrays/pierce.as";
include "src/core/arrays/reduce.as";
include "src/core/arrays/reduceRight.as";
include "src/core/arrays/repeat.as";
include "src/core/arrays/shuffle.as";
include "src/core/arrays/spliceInto.as";

//core.chars.*
include "src/core/chars/isAlpha.as";
include "src/core/chars/isASCII.as";
include "src/core/chars/isDigit.as";
include "src/core/chars/isHexDigit.as";
include "src/core/chars/isLower.as";
include "src/core/chars/isOctalDigit.as";
include "src/core/chars/isOperator.as";
include "src/core/chars/isUnicode.as";
include "src/core/chars/isUpper.as";

//core.functors.*
include "src/core/functors/aop.as";
include "src/core/functors/bind.as";

//core.html.*
include "src/core/html/anchor.as";
include "src/core/html/big.as";
include "src/core/html/blink.as";
include "src/core/html/bold.as";
include "src/core/html/fixed.as";
include "src/core/html/fontColor.as";
include "src/core/html/fontSize.as";
include "src/core/html/italics.as";
include "src/core/html/link.as";
include "src/core/html/paragraph.as";
include "src/core/html/small.as";
include "src/core/html/span.as";
include "src/core/html/strike.as";
include "src/core/html/sub.as";
include "src/core/html/sup.as";
include "src/core/html/underline.as";

//core.maths.*
include "src/core/maths/acosD.as";
include "src/core/maths/acosHm.as";
include "src/core/maths/acosHp.as";
include "src/core/maths/angleOfLine.as";
include "src/core/maths/asinD.as";
include "src/core/maths/asinH.as";
include "src/core/maths/atan2D.as";
include "src/core/maths/atanD.as";
include "src/core/maths/atanH.as";
include "src/core/maths/berp.as";
include "src/core/maths/bounce.as";
include "src/core/maths/cartesianToPolar.as";
include "src/core/maths/ceil.as";
include "src/core/maths/clamp.as";
include "src/core/maths/clerp.as";
include "src/core/maths/cosD.as";
include "src/core/maths/coserp.as";
include "src/core/maths/cosH.as";
include "src/core/maths/DEG2RAD.as";
include "src/core/maths/degreesToRadians.as";
include "src/core/maths/distance.as";
include "src/core/maths/distanceByObject.as";
include "src/core/maths/EPSILON.as";
include "src/core/maths/fixAngle.as";
include "src/core/maths/floor.as";
include "src/core/maths/gcd.as";
include "src/core/maths/hermite.as";
include "src/core/maths/hypothenuse.as";
include "src/core/maths/interpolate.as";
include "src/core/maths/isEven.as";
include "src/core/maths/isOdd.as";
include "src/core/maths/LAMBDA.as";
include "src/core/maths/lerp.as";
include "src/core/maths/log10.as";
include "src/core/maths/logN.as";
include "src/core/maths/map.as";
include "src/core/maths/normalize.as";
include "src/core/maths/percentage.as";
include "src/core/maths/PHI.as";
include "src/core/maths/polarToCartesian.as";
include "src/core/maths/RAD2DEG.as";
include "src/core/maths/radiansToDegrees.as";
include "src/core/maths/replaceNaN.as";
include "src/core/maths/round.as";
include "src/core/maths/sign.as";
include "src/core/maths/sinD.as";
include "src/core/maths/sinerp.as";
include "src/core/maths/sinH.as";
include "src/core/maths/tanD.as";
include "src/core/maths/tanH.as";

//core.objects.*
include "src/core/objects/getMembers.as";
include "src/core/objects/merge.as";

//core.reflect.*
//include "src/core/reflect/getClassByName.as"; //for redtamarin we use the toplevel getClassByName()
include "src/core/reflect/getClassMethods.as";
include "src/core/reflect/getClassName.as";
include "src/core/reflect/getClassPackage.as";
include "src/core/reflect/getClassPath.as";
include "src/core/reflect/getDefinitionByName.as";
include "src/core/reflect/hasClassByName.as";
include "src/core/reflect/hasDefinitionByName.as";
include "src/core/reflect/invoke.as";

//core.strings.*
include "src/core/strings/camelCase.as";
include "src/core/strings/capitalize.as";
include "src/core/strings/center.as";
include "src/core/strings/clean.as";
include "src/core/strings/compare.as";
include "src/core/strings/endsWith.as";
include "src/core/strings/fastformat.as";
include "src/core/strings/format.as";
include "src/core/strings/hyphenate.as";
include "src/core/strings/indexOfAny.as";
include "src/core/strings/insert.as";
include "src/core/strings/lastIndexOfAny.as";
include "src/core/strings/lineTerminatorChars.as";
include "src/core/strings/pad.as";
include "src/core/strings/padLeft.as";
include "src/core/strings/padRight.as";
include "src/core/strings/repeat.as";
include "src/core/strings/startsWith.as";
include "src/core/strings/trim.as";
include "src/core/strings/trimEnd.as";
include "src/core/strings/trimStart.as";
//include "src/core/strings/userAgent.as"; //for redtamarin we use avmplus.userAgent in avmglue
include "src/core/strings/whiteSpaceChars.as";
include "src/core/strings/WildExp.as";

//core.vectors.*
include "src/core/vectors/create.as";
include "src/core/vectors/getVectorDefinition.as";
include "src/core/vectors/isVector.as";
include "src/core/vectors/toArray.as";


