/* -*- c-basic-offset: 4; indent-tabs-mode: nil; tab-width: 4 -*- */
/* vi: set ts=4 sw=4 expandtab: (add to ~/.vimrc: set modeline modelines=5) */
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is [Open Source Virtual Machine.].
 *
 * The Initial Developer of the Original Code is
 * Adobe System Incorporated.
 * Portions created by the Initial Developer are Copyright (C) 2004-2006
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *   Adobe AS3 Team
 *   Zwetan Kjukov <zwetan@gmail.com>.
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

/* note:
   the include order count
   if you get an Error #1181: Forward reference to base class Something.
   you will have to reorder the includes to get it to compile with both COMPC and ASC.
*/

include "api-versions.as";

/* the avmplus package provide misc. utilities
*/

include "avmplus/avmapi.as";
include "avmplus/userAgent.as";


/* The flash.errors package contains Error classes that are considered part of the Flash runtime API.
   In contrast to the Error classes described, the flash.error package communicates errors events
   that are specific to Flash runtimes (such as Flash Player and Adobe AIR).
*/

//include "flash/errors/IOError.as"; //already declared in builtin
//include "flash/errors/EOFError.as"; //already declared in builtin
//include "flash/errors/MemoryError.as"; //already declared in builtin

include "flash/errors/IllegalOperationError.as";
include "flash/errors/ScriptTimeoutError.as";
include "flash/errors/StackOverflowError.as";
include "flash/errors/InvalidSWFError.as";
include "flash/errors/SQLErrorOperation.as";
include "flash/errors/SQLError.as";
include "flash/errors/DRMManagerError.as";



/* The flash.system package contains classes for accessing system-level functionality,
   such as security, garbage collection, etc.
*/

include "flash/system/fscommand.as";

include "flash/system/ApplicationDomain.as";
include "flash/system/Capabilities.as";
include "flash/system/ImageDecodingPolicy.as";
include "flash/system/IMEConversionMode.as";
include "flash/system/LoaderContext.as";
include "flash/system/JPEGLoaderContext.as";
include "flash/system/Security.as";
include "flash/system/SecurityDomain.as";
include "flash/system/SecurityPanel.as";
include "flash/system/System.as";
include "flash/system/SystemUpdaterType.as";
include "flash/system/TouchscreenType.as";



/* The flash.utils package contains utility classes, such as data structures like ByteArray.
   It also contains a variety of package-level functions for timing code execution,
   retrieving information about classes and objects, and converting escape characters.
*/

include "flash/utils/flash_proxy.as";

include "flash/utils/IExternalizable.as";

include "flash/utils/describeType.as";
include "flash/utils/getDefinitionByName.as";
include "flash/utils/getQualifiedClassName.as";
include "flash/utils/getQualifiedSuperclassName.as";

include "flash/utils/getTimer.as";

include "flash/utils/CompressionAlgorithm.as";



/* The flash.debugger package
*/

include "flash/debugger/enterDebugger.as";



/* The flash.geom package contains geometry classes, such as points, rectangles
   and transformation matrixes, to support the BitmapData class and the bitmap caching feature.
*/

include "flash/geom/Point.as";
include "flash/geom/Rectangle.as";
include "flash/geom/Orientation3D.as";



/* The flash.filesystem package contains classes used in accessing the filesystem.
   This package is only available to content running in Adobe AIR.
*/


/* The flash.html package contains classes used for including HTML content in an AIR application.
   The HTMLControl class is a display object that can render HTML content.
   The other classes support functionality related to HTMLControl object.
   This package is only available to content running in Adobe AIR.
*/



/* The classes in the flash.globalization package provide language and region/country
   specific functionality for string comparison and sorting, conversion of strings to upper and lower case,
   formatting of dates, times, numbers and currencies, and parsing of numbers and currencies.
*/



/* The flash.media package contains classes for working with multimedia assets such as sound and video.
   It also contains the video and audio classes available in Flash Communication Server.
*/


/* The flash.net package contains classes for sending and receiving from the network,
   such as URL downloading and Flash Remoting.
*/

