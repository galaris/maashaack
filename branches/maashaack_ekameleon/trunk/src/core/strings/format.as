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
  Portions created by the Initial Developers are Copyright (C) 2006-2010
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
     * Format a string using indexed or named parameters.
     * 
     * <p>Usage :</p>
     * <ul>
     * <li><code>format( pattern:String, ...args:Array ):String</code></li>
     * <li><code>format( pattern:String, [arg0:*,arg1:*,arg2:*, ...] ):String</code></li>
     * <li><code>format( pattern:String, [arg0:*,arg1:*,arg2:*, ...], ...args:Array ):String</code></li>
     * <li><code>format( pattern:String, {name0:value0,name1:value1,name2:value2, ...} ):String</code></li>
     * <li><code>format( pattern:String, {name0:value0,name1:value1,name2:value2, ...}, ...args:Array ):String</code></li>
     * </ul>
     * 
     * <p>
     * TODO more documentation
     * </p>
     * 
     * @see: core.strings.fastformat
     */
    public const format:Function = function( pattern:String, ...args ):String
    {
        if( (pattern == null) || (pattern == "") )
        {
            return "";
        }
        
        var formatted:String = pattern;
        var len:uint = args.length;
        var words:Object;
        
        if( (len == 1) && (args[0] is Array) )
        {
            args = args[0];
        }
        else if( args[0] is Array )
        {
            var a:Array = args[0];
            args.shift();
            args = a.concat( args );
        }
        else if( (args[0] is Object) && (String( args[0] ) == "[object Object]") )
        {
            words = args[0];
            if( len > 1 ) { args.shift(); }
        }
        
        var search:RegExp = new RegExp( "\\{([a-z0-9,:\\-]*)\\}", "g" );
        var result:Object = search.exec( formatted );
        
        var part:String;
        var token:String;
        var c:String;
        var padc:String = " ";
        var padding:int = 0;
        
        var pad:Function = function( str:String ):String
        {
            var pos:int = str.indexOf( "," );
            
            if( pos > 0 )
            {
                padding = Number( str.substr( pos+1 ) );
                str = str.substring( 0, pos );
            }
            
            return str;
        };
        
        /* note:
           yes, here we duplicate the pad() function and yes this is on purpose
           each single function of core.strings.* need to be fully independant
        */
        var align:Function = function( str:String ):String
        {
            var right:Boolean = (padding > 0) ? false: true;
            var width:int     = (padding > 0) ? padding: -padding;
            
            if( (width < str.length) || (width == 0) )
            {
                return str;
            }
            
            while( str.length != width )
            {
                if( right )
                {
                    str += padc;
                }
                else
                {
                    str = padc + str;
                }
            }
            
            return str;
        };
        
        while( result != null )
        {
            part  = result[0];
            token = pad( result[1] );
            c = token.charAt(0);
            
            if( ("0" <= c) && (c <= "9") )
            {
                formatted = formatted.replace( part, align( args[token] ) );
            }
            else if( ("a" <= c) && (c <= "z") )
            {
                if( words.hasOwnProperty( token ) )
                {
                    formatted = formatted.replace( part, align( words[token] ) );
                }
            }
            else
            {
                //don't use format() within itself
                throw new Error( "malformed token \""+part+"\", can not start with \""+c+"\"" );
            }
            
            result = search.exec( formatted );
        }
        
        return formatted;
    };
}