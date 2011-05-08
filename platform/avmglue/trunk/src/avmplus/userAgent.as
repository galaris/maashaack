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

package avmplus
{
    import avmplus.System;
    import avmplus.OperatingSystem;
    
    import flash.system.Capabilities;
    import flash.system.Security;
    
    
    public function userAgent( apptoken:String = "", noself:Boolean = false,
                               minimal:Boolean = false, compatible:Boolean = false ):String
    {
        var sys:* = avmplus.System;
        var selfname:String;
        var selfversion:String;
        var platform:String;
        var type:String;
        var os:String;
        var lang:String;
        
        //product token
        var product:String = compatible ? "Mozilla/5.0": "Tamarin/" + sys.getAvmplusVersion();
        
        //application token
        if( sys.profile.playerType == "RedTamarin" )
        {
            selfname = "RedTamarin";
            selfversion = sys.getRedtamarinVersion();
            
            switch( OperatingSystem.vendor )
            {
                case "Apple":
                platform = "Macintosh";
                break;

                case "Microsoft":
                platform = "Windows";
                break;

                case "Linux":
                platform = "Linux";
                break;

                default:
                platform = OperatingSystem.vendor;
            }
            
            type = "CommandLine"; //provide different strings for self-exe, as script etc. ?
            
            os   = OperatingSystem.vendorDescription;
            
            var locale:String = OperatingSystem.locale;
            if( locale.indexOf("_") > -1 ) { locale = locale.split( "_" ).join( "-" ); }
            lang = locale;
        }
        else
        {
            var isAIR:Boolean  = (Security.sandboxType == "application");
            
            selfname    = isAIR ? "AdobeAIR": "AdobeFlashPlayer";
            selfversion = Capabilities.version.split( " " )[1].split( "," ).join( "." );
            
            platform = Capabilities.manufacturer.split( "Adobe " )[1];
            
            type     = Capabilities.playerType;
            
            os       = Capabilities.os;
            
            lang     = isAIR ? Capabilities["languages"]: Capabilities.language;
        }
        
        //comment token
        var comments:Array = [];
        comments.push( platform, type );
        if( !minimal ) { comments.push( os, lang ); }
        
        if( Capabilities.isDebugger ) { comments.push( "DEBUG" ); }
        
        //user-agent string
        var UA:String = "";
            UA += product;
            UA += " (" + comments.join( "; " ) + ")";
            
            if( !noself || (apptoken == "") )
            {
            UA += " " + selfname + "/" + selfversion;
            }
            
            if( apptoken != "" )
            {
            UA += " " + apptoken;
            }
        
        return UA;
    }
}