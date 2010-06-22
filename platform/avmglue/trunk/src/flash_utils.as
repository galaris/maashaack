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

/* The flash.utils package contains utility classes, such as data structures like ByteArray.
   It also contains a variety of package-level functions for timing code execution,
   retrieving information about classes and objects, and converting escape characters.
*/
package flash.utils
{
    import avmplus.*;


    public namespace flash_proxy = "http://www.adobe.com/2006/actionscript/flash/proxy";

    /**
     * The flash_api namespace allows you to access internal parts of the flash API,
     * for ex: mock implementation.
     */
    public namespace flash_api = "http://code.google.com/p/redtamarin/2010/actionscript/flash/api";
    
    public function clearInterval( id:uint ):void
    {
        CFG::dbg{ trace( "clearInterval( " + id + " )" ); }
        SetIntervalTimer.clearInterval( id );
    }
    
    public function clearTimeout( id:uint ):void
    {
        CFG::dbg{ trace( "clearTimeout( " + id + " )" ); }
        SetIntervalTimer.clearInterval( id );
    }
    
    public function describeType( value:* ):XML
    {
        CFG::dbg{ trace( "describeType( " + value + " )" ); }
        return avmplus.describeType( value, FLASH10_FLAGS );
    }
    
    public function escapeMultiByte( value:String ):String
    {
        CFG::dbg{ trace( "escapeMultiByte( " + value + " )" ); }
        return ""; //TODO
    }
    
    public function getDefinitionByName( name:String ):Object
    {
        CFG::dbg{ trace( "getDefinitionByName( " + name + " )" ); }
        return Domain.currentDomain.getClass( name ) as Object;
    }
    
    public function getQualifiedClassName( value:* ):String
    {
        CFG::dbg{ trace( "getQualifiedClassName( " + value + " )" ); }
        return avmplus.getQualifiedClassName( value );
    }
    
    public function getQualifiedSuperclassName( value:* ):String
    {
        CFG::dbg{ trace( "getQualifiedSuperclassName( " + value + " )" ); }
        return avmplus.getQualifiedSuperclassName( value );
    }
    
    public function getTimer():int
    {
        CFG::dbg{ trace( "getTimer()" ); }
        return System.getTimer();
    }
    
    public function setInterval( closure:Function, delay:Number, ...arguments ):uint
    {
        CFG::dbg{ trace( "setInterval( " + [closure,delay,arguments].join(", ") + " ); }
        return new SetIntervalTimer(closure, delay, true, arguments).id;
    }
    
    public function setTimeout( closure:Function, delay:Number, ...arguments ):uint
    {
        CFG::dbg{ trace( "setTimeout( " + [closure,delay,arguments].join(", ") + " ); }
        return new SetIntervalTimer(closure, delay, false, arguments).id;
    }

    public function unescapeMultiByte( value:String ):String
    {
        CFG::dbg{ trace( "unescapeMultiByte( " + value + " )" ); }
        return ""; //TODO
    }

    /**
     * The CompressionAlgorithm class defines string constants for the names of compress and uncompress options.
     * These constants are used as values of the <code>algorithm</code> parameter of
     * the <code>ByteArray.compress()</code> and <code>ByteArray.uncompress()</code> methods.
     * 
     * @langversion ActionScript 3.0
     * @playerversion AIR 1.0
     */
    [API(CONFIG::AIR_1_0)]
    public final class CompressionAlgorithm
    {
        [API(CONFIG::AIR_1_0)] public static const DEFLATE:String = "deflate";
        [API(CONFIG::AIR_1_0)] public static const ZLIB:String = "zlib";
    }
}
