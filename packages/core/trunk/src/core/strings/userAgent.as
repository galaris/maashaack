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
  Portions created by the Initial Developers are Copyright (C) 2006-2012
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

package core.strings
{
    import flash.system.ApplicationDomain;
    import flash.system.Capabilities;
    import flash.system.Security;
    import flash.system.System;
    
    /**
     * Returns a user-agent string.
     * 
     * <p>based on:</p>
     * <ul>
     * <li>http://www.mozilla.org/build/user-agent-strings.html</li>
     * <li>http://www.mozilla.org/build/revised-user-agent-strings.html</li>
     * <li>RFC 1945 - http://www.ietf.org/rfc/rfc1945.txt</li>
     * <li>RFC 2068 - http://www.ietf.org/rfc/rfc2068.txt</li>
     * <li>https://developer.mozilla.org/en/Gecko_user_agent_string_reference</li>
     * <li>http://hacks.mozilla.org/2010/09/final-user-agent-string-for-firefox-4/</li>
     * </ul>
     * 
     * <p>here some examples:</p>
     * <pre>
     * - URLRequestDefaults (only if an AIR app and with compatible option set to true)
     *   "Mozilla/5.0 (Macintosh; U; PPC Mac OS X; en) AppleWebKit/526.9+ (KHTML, like Gecko) AdobeAIR/1.5"
     *   "Mozilla/5.0 (Windows; U; en) AppleWebKit/526.9+ (KHTML, like Gecko) AdobeAIR/1.5"
     *   "Mozilla/5.0 (X11; U; Linux i686; en-US) AppleWebKit/526.9+ (KHTML, like Gecko) AdobeAIR/1.5"
     * - userAgent
     *   "Tamarin/1.0 cyclone (Macintosh; StandAlone; Mac OS 10.6.7; en; DEBUG) AdobeFlashPlayer/10.0.32.18"
     *   "Tamarin/1.0 cyclone (Macintosh; StandAlone; Mac OS 10.6.7; en; DEBUG) AdobeFlashPlayer/10.0.32.18 MyApp/2.0"
     *   "Tamarin/1.0 cyclone (Macintosh; StandAlone; Mac OS 10.6.7; en; DEBUG) MyApp/2.0"
     *   "Tamarin/1.0 cyclone (Macintosh; StandAlone; DEBUG) AdobeFlashPlayer/10.0.32.18"
     *   "Mozilla/5.0 (Macintosh; StandAlone; Mac OS 10.6.7; en; DEBUG) AdobeFlashPlayer/10.0.32.18"
     *   "Mozilla/5.0 (Macintosh; StandAlone; DEBUG) AdobeFlashPlayer/10.0.32.18"
     * </pre>
     * <p><b>note:</b></p>
     * <p>By default we consider our "product" to be Tamarin, it will work for Flash Player, AIR and RedTamarin.</p>
     * <p><b>ex:</b> "Tamarin/1.0 cyclone (Macintosh; ..."</p>
     * 
     * <p>By default if you don't provide an apptoken, it will deduced automatically 
     * (eg. "AdobeAIR/1.5" , "AdobeFlashPlayer/9.0.124.0", etc.)</p>
     * <p><b>ex:</b> "... Mac OS 10.6.7; en) AdobeFlashPlayer/10.0.32.18"</p>
     * 
     * <p>By default, self application description and application token accumulates</p>
     * <p><b>ex:</b> "... Mac OS 10.6.7; en) AdobeFlashPlayer/10.0.32.18 MyApp/2.0"</p>
     * <p>if you use the `noself` option you can remove the self application description</p>
     * <p><b>ex:</b> "... Mac OS 10.6.7; en) MyApp/2.0"</p>
     * 
     * @param apptoken (optional) a string to override the application token eg. "MyApp/2.0"
     * @param noself (optional) option to not include the self application description (requires apptoken to not be empty)
     * @param minimal (optional) option to not include OS and Language in comments
     * @param compatible (optional) option to force a compatible product token eg. "Mozilla/5.0"
     */
    public const userAgent:Function = function( apptoken:String = "", noself:Boolean = false,
                                                minimal:Boolean = false, compatible:Boolean = false ):String
    {
        var isAIR:Boolean  = (Security.sandboxType == "application");
        
        if( isAIR && compatible )
        {
            var URLRD:Class = ApplicationDomain.currentDomain.getDefinition( "flash.net.URLRequestDefaults" ) as Class;
            if( URLRD && ( "userAgent" in URLRD ) ) { return URLRD[ "userAgent" ]; }
        }
        
        //product token
        var product:String = compatible ? "Mozilla/5.0": "Tamarin/" + System.vmVersion;
        
        //application token
        var selfname:String = isAIR ? "AdobeAIR": "AdobeFlashPlayer";
        var selfversion:String = Capabilities.version.split( " " )[1].split( "," ).join( "." );
        
        
        //comment token
        var comments:Array = [];
        
        var platform:String = Capabilities.manufacturer.split( "Adobe " )[1];
        var type:String = Capabilities.playerType;
        comments.push( platform, type );
        
        if( !minimal )
        {
            var os:String = Capabilities.os;
            var lang:String = isAIR ? Capabilities["languages"]: Capabilities.language;
            comments.push( os, lang );
        }
        
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
    };
}