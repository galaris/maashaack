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
Portions created by the Initial Developers are Copyright (C) 2006-2009
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


//to avoid fwd ref
include "system/Serializable.as";
include "system/Serializer.as";
include "system/Enum.as";
include "system/Configurator.as";


//cli
include "system/cli/ArgumentsParser.as";
include "system/cli/SwitchStatus.as";

//comparators
include "system/comparators/AlphaComparator.as";
include "system/comparators/BooleanComparator.as";
include "system/comparators/CharComparator.as";
include "system/comparators/ComparableComparator.as";
//include "system/comparators/DateComparator.as";
include "system/comparators/GenericComparator.as";
include "system/comparators/NullComparator.as";
include "system/comparators/NumberComparator.as";
include "system/comparators/ReverseComparator.as";
include "system/comparators/StringComparator.as";

//diagnostics
include "system/diagnostics/_VirtualMachine.as";
include "system/diagnostics/TraceConsole.as";
include "system/diagnostics/VirtualMachine.as";

//evaluators
//include "system/evaluators/DateEvaluator.as";
include "system/evaluators/EdenEvaluator.as";
include "system/evaluators/Evaluable.as";
//include "system/evaluators/MathEvaluator.as";
include "system/evaluators/MultiEvaluator.as";
include "system/evaluators/PropertyEvaluator.as";

//formatters
//include "system/formatters/DateFormatter.as";
include "system/formatters/Formattable.as";

//hosts
include "system/hosts/Host.as";
include "system/hosts/HostID.as";
include "system/hosts/OperatingSystem.as";
include "system/hosts/PlatformID.as";


//io
include "system/io/Readable.as";
include "system/io/Writeable.as";

//network

//numeric
include "system/numeric/Mathematics.as";
include "system/numeric/Range.as";

//process

//reflection
include "system/reflection/_TypeInfo.as"; //fwd ref
include "system/reflection/_ClassInfo.as";
include "system/reflection/_ConstructorInfo.as";
include "system/reflection/AccessorInfo.as";
include "system/reflection/AccessorType.as";
include "system/reflection/ClassInfo.as";
include "system/reflection/config.as";
include "system/reflection/ConstructorInfo.as";
include "system/reflection/FilterType.as";
include "system/reflection/InterfaceInfo.as";
include "system/reflection/MemberInfo.as";
include "system/reflection/MemberType.as";
include "system/reflection/MethodInfo.as";
include "system/reflection/ReflectionConfigurator.as";
include "system/reflection/TypeInfo.as";

//resources

//serializers
  //eden
  include "system/serializers/eden/BuiltinSerializer.as";
  include "system/serializers/eden/config.as";
  include "system/serializers/eden/debug.as";
  include "system/serializers/eden/ECMAScript.as";
  include "system/serializers/eden/EdenConfigurator.as";
  include "system/serializers/eden/EdenSerializer.as";
  include "system/serializers/eden/info.as";
  include "system/serializers/eden/release.as";
  include "system/serializers/eden/strings.as";


//terminals
include "system/terminals/Console.as";
include "system/terminals/InteractiveConsole.as";
include "system/terminals/VirtualConsole.as";

//text
  //html
  //parser
  include "system/text/parser/GenericParser.as";
  //prettifier

//ui


//system
include "system/Arrays.as";
include "system/Cloneable.as";
include "system/Comparable.as";
include "system/Comparator.as";
include "system/Environment.as";
include "system/Equatable.as";
include "system/Reflection.as";
include "system/Sortable.as";
include "system/Strings.as";
include "system/SystemConfigurator.as";
include "system/Version.as";
  //statics
  include "system/metadata.as";
  //functions
  include "system/about.as";
  include "system/info.as";
  //objects
  include "system/config.as";
  include "system/console.as";
  include "system/eden.as";


