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
include "core/input.as";
include "core/output.as";
include "core/_toUnicodeNotation.as";
include "core/bit.as";
include "core/dump.as";
include "core/dumpArray.as";
include "core/dumpDate.as";
include "core/dumpObject.as";
include "core/dumpString.as";
include "core/filedump.as";
include "core/filedumpObject.as";
include "core/uri.as";
include "core/version.as";

//core.arrays.*
include "core/arrays/contains.as";
include "core/arrays/initialize.as";
include "core/arrays/pierce.as";
include "core/arrays/reduce.as";
include "core/arrays/reduceRight.as";
include "core/arrays/repeat.as";
include "core/arrays/rotate.as";
include "core/arrays/shuffle.as";
include "core/arrays/spliceInto.as";

//core.bytearrays.*
include "core/bytearrays/copy.as";
include "core/bytearrays/equals.as";

//core.chars.*
include "core/chars/isAlpha.as";
include "core/chars/isAlphaOrDigit.as";
include "core/chars/isASCII.as";
include "core/chars/isContained.as";
include "core/chars/isDigit.as";
include "core/chars/isHexDigit.as";
include "core/chars/isLower.as";
include "core/chars/isOctalDigit.as";
include "core/chars/isOperator.as";
include "core/chars/isUnicode.as";
include "core/chars/isUpper.as";
include "core/chars/isWhiteSpace.as";
include "core/chars/whiteSpaces.as";

//core.data.*
include "core/data/aliases.as";

//core.functors.*
include "core/functors/aop.as";
include "core/functors/bind.as";

//core.html.*
include "core/html/anchor.as";
include "core/html/big.as";
include "core/html/blink.as";
include "core/html/bold.as";
include "core/html/fixed.as";
include "core/html/fontColor.as";
include "core/html/fontSize.as";
include "core/html/italics.as";
include "core/html/link.as";
include "core/html/paragraph.as";
include "core/html/small.as";
include "core/html/span.as";
include "core/html/strike.as";
include "core/html/sub.as";
include "core/html/sup.as";
include "core/html/underline.as";

//core.maths.*
include "core/maths/acosD.as";
include "core/maths/acosHm.as";
include "core/maths/acosHp.as";
include "core/maths/angleOfLine.as";
include "core/maths/asinD.as";
include "core/maths/asinH.as";
include "core/maths/atan2D.as";
include "core/maths/atanD.as";
include "core/maths/atanH.as";
include "core/maths/berp.as";
include "core/maths/bounce.as";
include "core/maths/cartesianToPolar.as";
include "core/maths/ceil.as";
include "core/maths/clamp.as";
include "core/maths/clerp.as";
include "core/maths/cosD.as";
include "core/maths/coserp.as";
include "core/maths/cosH.as";
include "core/maths/DEG2RAD.as";
include "core/maths/degreesToRadians.as";
include "core/maths/distance.as";
include "core/maths/distanceByObject.as";
include "core/maths/EARTH_RADIUS_IN_METERS.as";
include "core/maths/EPSILON.as";
include "core/maths/fibonacci.as";
include "core/maths/fixAngle.as";
include "core/maths/floor.as";
include "core/maths/gcd.as";
include "core/maths/haversine.as";
include "core/maths/hermite.as";
include "core/maths/hypothenuse.as";
include "core/maths/interpolate.as";
include "core/maths/isEven.as";
include "core/maths/isOdd.as";
include "core/maths/LAMBDA.as";
include "core/maths/lerp.as";
include "core/maths/log10.as";
include "core/maths/logN.as";
include "core/maths/map.as";
include "core/maths/MILE_TO_METER.as";
include "core/maths/modulo.as";
include "core/maths/nearlyEquals.as";
include "core/maths/normalize.as";
include "core/maths/percentage.as";
include "core/maths/PHI.as";
include "core/maths/polarToCartesian.as";
include "core/maths/RAD2DEG.as";
include "core/maths/radiansToDegrees.as";
include "core/maths/replaceNaN.as";
include "core/maths/round.as";
include "core/maths/sign.as";
include "core/maths/sinD.as";
include "core/maths/sinerp.as";
include "core/maths/sinH.as";
include "core/maths/tanD.as";
include "core/maths/tanH.as";
include "core/maths/vicenty.as";

//core.objects.*
include "core/objects/fuse.as";
include "core/objects/getMembers.as";
include "core/objects/merge.as";

//core.reflect.*
//include "core/reflect/getClassByName.as"; //for redtamarin we use the toplevel getClassByName()
include "core/reflect/getClassMethods.as";
include "core/reflect/getClassName.as";
include "core/reflect/getClassPackage.as";
include "core/reflect/getClassPath.as";
include "core/reflect/getDefinitionByName.as";
include "core/reflect/hasClassByName.as";
include "core/reflect/hasDefinitionByName.as";
include "core/reflect/hasInterface.as";
include "core/reflect/invoke.as";
include "core/reflect/isDynamic.as";
include "core/reflect/isFinal.as";
include "core/reflect/isInstance.as";
include "core/reflect/isStatic.as";

//core.strings.*
include "core/strings/bytesToHumanReadable.as";
include "core/strings/camelCase.as";
include "core/strings/capitalize.as";
include "core/strings/center.as";
include "core/strings/clean.as";
include "core/strings/compare.as";
include "core/strings/endsWith.as";
include "core/strings/fastformat.as";
include "core/strings/format.as";
include "core/strings/hexformat.as";
include "core/strings/hyphenate.as";
include "core/strings/indexOfAny.as";
include "core/strings/insert.as";
include "core/strings/lastIndexOfAny.as";
include "core/strings/lineTerminatorChars.as";
include "core/strings/pad.as";
include "core/strings/padLeft.as";
include "core/strings/padRight.as";
include "core/strings/repeat.as";
include "core/strings/startsWith.as";
include "core/strings/trim.as";
include "core/strings/trimEnd.as";
include "core/strings/trimStart.as";
//include "core/strings/userAgent.as"; //for redtamarin we use avmplus.userAgent in avmglue
include "core/strings/whiteSpaces.as";
include "core/strings/WildExp.as";

//core.vectors.*
include "core/vectors/create.as";
include "core/vectors/getVectorDefinition.as";
include "core/vectors/isVector.as";
include "core/vectors/toArray.as";


