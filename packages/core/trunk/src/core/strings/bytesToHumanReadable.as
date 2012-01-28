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
    /**
     * Formats a <a href='http://en.wikipedia.org/wiki/Byte'>bytes</a> value in a human readable string value.
     * @param bytes The bytes value to format.
     * @param precision An integer between 0 and 20, inclusive, that represents the desired number of decimal places.
     * @param SI Indicates if the formatter use the International System of Units (SI).
     * @param force A string to indicates if the value must be format with a forced unity :
     * <ul>
     * <li>auto  : ""</li> 
     * <li>kilo  : "K"</li>
     * <li>mega  : "M"</li>
     * <li>giga  : "G"</li>
     * <li>tera  : "T"</li>
     * <li>peta  : "P"</li>
     * <li>exa   : "E"</li>
     * <li>zetta : "Z"</li>
     * <li>yotta : "Y"</li>
     * </ul>
     */
    public function bytesToHumanReadable( bytes:Number, precision:uint = 2, SI:Boolean = false, force:String = "" ):String
    {
        const unit:uint = SI ? 1000 : 1024;
        
        if( (bytes < unit) && ((force == "") || (force == "B")) ) 
        { 
            return bytes + " B"; 
        }
        
        var u:String;
        var s:String;
        
        const kilo:Number  = unit;
        const mega:Number  = kilo  * unit;
        const giga:Number  = mega  * unit;
        const tera:Number  = giga  * unit;
        const peta:Number  = tera  * unit;
        const exa:Number   = peta  * unit;
        const zetta:Number = exa   * unit;
        const yotta:Number = zetta * unit;
        
        if( (bytes >= 0) && (bytes < kilo) )           { u =  ""; }
        else if( (bytes >= kilo)  && (bytes < mega) )  { u = "K"; }
        else if( (bytes >= mega)  && (bytes < giga) )  { u = "M"; }
        else if( (bytes >= giga)  && (bytes < tera) )  { u = "G"; }
        else if( (bytes >= tera)  && (bytes < peta) )  { u = "T"; }
        else if( (bytes >= peta)  && (bytes < exa) )   { u = "P"; }
        else if( (bytes >= exa)   && (bytes < zetta) ) { u = "E"; }
        else if( (bytes >= zetta) && (bytes < yotta) ) { u = "Z"; }
        else if( (bytes >= yotta) )                    { u = "Y"; }
        
        if( force != "" )
        {
            if( force == "B" ) { force = ""; }
            u = force;
        }
        
        switch( u )
        {
            case "K": s = Number( bytes / kilo  ).toFixed( precision ); break;
            case "M": s = Number( bytes / mega  ).toFixed( precision ); break;
            case "G": s = Number( bytes / giga  ).toFixed( precision ); break;
            case "T": s = Number( bytes / tera  ).toFixed( precision ); break;
            case "P": s = Number( bytes / peta  ).toFixed( precision ); break;
            case "E": s = Number( bytes / exa   ).toFixed( precision ); break;
            case "Z": s = Number( bytes / zetta ).toFixed( precision ); break;
            case "Y": s = Number( bytes / yotta ).toFixed( precision ); break;
            case "":
            default:
            s = bytes + "";
        }
        
        var zeros:String = new Array(precision+1).join("0");
        var parts:Array  = s.split(".");
        
        if( s.indexOf( "." ) > -1 && (zeros == parts[1]) ) 
        { 
            s = parts[0]; 
        }
        
        return s + " " + u + (SI ? "i" : "") + "B";
    }
}