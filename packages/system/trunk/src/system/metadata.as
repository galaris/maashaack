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

package system
{
    import core.strings.format;
    
    import system.terminals.console;
    
    /**
     * Stores static metadata about the project
     */
    public class metadata
    {
        /** Name of the project. */
        public static var name:String = "maashaack";
        
        /** Code Name of the project. */
        public static var codename:String = "x4a";
        
        /** Full name of the project. */
        public static var fullname:String = "maashaack application framework";
        
        /** Version of the project. */
        public static var version:Version = new Version();
        /*FDT_IGNORE*/
        include "version.properties";
        /*FDT_IGNORE*/
        version.revision = parseInt( "$Rev: 603 $".split( " " )[1] );
        
        /** Copyright of the project. */
        public static var copyright:String = "Copyright © 2006-2012 Zwetan Kjukov and Marc Alcaraz, All right reserved.";
        
        /** Origin of the project. */
        public static var origin:String = "Made in the EU.";
        
        /**
        * Prints the informations of the framework.
        * 
        * @param verbose (optional) display more informations, default is <code>false</code>
        * @param showConfig (optional) display the pretty printing of the config object, default is <code>false</code>
        */
        public static function about( verbose:Boolean = false, showConfig:Boolean = false ):void
        {
            console.writeLine( info( verbose, showConfig ) );
        }
        
        /**
        * Returns the informations of the framework.
        * 
        * @param verbose (optional) add more informations, default is <code>false</code>
        * @param showConfig (optional) add the pretty printing of the config object, default is <code>false</code>
        */
        public static function info( verbose:Boolean = false, showConfig:Boolean = false ):String
        {
            var CRLF:String = "\n";
            
            var str:String = "";
                if( !verbose && config.verbose )
                {
                    verbose = true;
                }
                
                if( verbose ) {
                str += "{sep}{crlf}";
                str += "{name}: {fullname} v{version}{crlf}";
                str += "Host: {host}{isdebug}{crlf}";
                str += "Operating System: {os}{crlf}";
                str += "{copyright}{crlf}";
                str += "{origin}{crlf}";
                str += "{sep}";
                } else {
                str += "{name} v{version}";
                }
                
                if( showConfig ) {
                str += "{crlf}config:";
                str += "{config}{crlf}";
                str += "{sep}";
                }
                
            return format( str,
                           {
                           sep: strings.separator,
                           crlf: CRLF,
                           name: metadata.name,
                           fullname: metadata.fullname,
                           version: metadata.version,
                           host: Environment.host,
                           isdebug: Environment.isDebug( ) ? " (debug)" : "",
                           os: Environment.os,
                           copyright: metadata.copyright,
                           origin: metadata.origin,
                           config: config.toSource()
                           }
                        );
        }
        
        /**
         * Stores the configuration options of the framework.
         */
        public static var config:SystemConfigurator = new SystemConfigurator( {
                                                                              verbose: false
                                                                              } );
        
        /**
         * Stores the string resources of the framework. 
         */
        public static var strings:SystemStrings = new SystemStrings();
        
    }
}
