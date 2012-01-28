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

package system.logging.targets 
{
    import core.strings.fastformat;
    
    import system.logging.LoggerLevel;
    
    /**
     * Provides a logger target that uses the SOS Max console to output log messages. 
     * Thanks <b>PowerFlasher</b> and the free <a href='http://sos.powerflasher.de/'>SOS Max Console</a>
     */
    public class SOSTarget extends SocketTarget 
    {
        /**
         * Creates a new SOSTarget instance.
         * @param host The host of the socket connection (default "localhost").
         * @param port The port of the socket connection (default 4444).
         * @param auto Indicates if the target is auto connected with the server.
         */
        public function SOSTarget( name:String=null, color:Number=NaN , idenfify:Boolean=true , host:String = "localhost" , port:int = 4444 , auto:Boolean = true )
        {
            super( host , port , auto ) ;
            
            if (name != null)
            {
                setApplicationName( name ) ;
            }
            
            setApplicationColor(isNaN(color) ? SOSTarget.DEFAULT_COLOR : color) ;
            
            setLevelColor( LoggerLevel.ALL   ) ;
            setLevelColor( LoggerLevel.DEBUG ) ;
            setLevelColor( LoggerLevel.ERROR ) ;
            setLevelColor( LoggerLevel.FATAL ) ;
            setLevelColor( LoggerLevel.INFO  ) ;
            setLevelColor( LoggerLevel.WARN  ) ;
            setLevelColor( LoggerLevel.WTF   ) ;
            
            if ( idenfify )
            {
                this.identify() ;
            }
        }
        
        ///// Default LoggerLevel colors
        
        /**
         * Provides the color in the SOS console to display all levels. 
         */
        public static var ALL_COLOR:Number = 0xE6E6E6 ;
        
        /**
         * Provides the 'debug' color in the SOS console. 
         */
        public static var DEBUG_COLOR:Number = 0xDEECFE ;
        
        /**
         * Provides the 'default' color in the SOS console. 
         */
        public static var DEFAULT_COLOR:Number = 0xFFFFFF ;
        
        /**
         * Provides the 'error' color in the SOS console. 
         */
        public static var ERROR_COLOR:Number = 0xEDCC81 ;
        
        /**
         * Provides the 'fatal' color in the SOS console. 
         */
        public static var FATAL_COLOR:Number = 0xFDD1B5 ;
        
        /**
         * Provides the 'info' color in the SOS console. 
         */
        public static var INFO_COLOR:Number = 0xD2FAB8 ;
        
        /**
         * Provides the 'warn' color in the SOS console. 
         */
        public static var WARN_COLOR:Number = 0xFDFDB5 ;
        
        /**
         * Provides the 'wtf' color in the SOS console. 
         */
        public static var WTF_COLOR:Number = 0xE2355B ;
        
        ///// SOS socket command patterns
        
        /**
         * Provides the message pattern to send in the SOS console the application color. 
         */
        public static const APPLICATION_COLOR:String = "!SOS<appColor>{0}</appColor>" ;
        
        /**
         * Provides the message pattern to send in the SOS console the application name. 
         */
        public static const APPLICATION_NAME:String = "!SOS<appName>{0}</appName>" ;
        
        /**
         * Provides the message to send in the SOS console to clear the console. 
         */
        public static const CLEAR:String = "!SOS<clear/>" ;
        
        /**
         * Provides the message to send in the SOS console to identify the application. 
         */
        public static const IDENTIFY:String = "!SOS<identify/>" ;
        
        /**
         * Provided the "setLabelColor" pattern.
         */
        public static var LEVEL_COLOR:String = "!SOS<setKey><name>{0}</name><color>{1}</color></setKey>" ;
        
        /**
         * Provides the message pattern to send in the SOS console the "showMessage" expression. 
         */
        public static const SHOW_MESSAGE:String = "!SOS<showMessage key=\"{0}\"><![CDATA[{1}]]></showMessage>" ;
        
        /**
         * Provides the message pattern to send in the SOS console the "showFoldMessage" expression. 
         */
        public static const SHOW_FOLD_MESSAGE:String = "!SOS<showFoldMessage key=\"{0}\"><title><![CDATA[{1}]]></title><message><![CDATA[{2}]]></message></showFoldMessage>" ;
        
        /**
         * Defines the level colors policy in the message sending to the SOS console.
         */
        public var levelPolicy:Boolean = true ;
        
        /**
         * Clear the console.
         */
        public function clear():void 
        {
            send( CLEAR ) ;
        }
        
        /**
         * Shows some Information about the Connection. This time it is : HostName, HostAddress and Color.
         */
        public function identify():void
        {
            send( IDENTIFY ) ;
        }
        
        /**
         * Descendants of this class should override this method to direct the specified message to the desired output.
         * @param message String containing preprocessed log message which may include time, date, category, etc. based on property settings, such as <code class="prettyprint">includeDate</code>, <code class="prettyprint">includeCategory</code>, etc.
         * @param level the LogEventLevel of the message.
         */
        public override function internalLog( message:* , level:LoggerLevel ):void
        {
            sendLevelMessage( message , level ) ;
        }
        
        /**
         * Send a fold message with a specific level.
         */
        public function sendFoldLevelMessage( title:String , message:String , level:LoggerLevel ):void
        {
            if( levelPolicy ) 
            {
                message = fastformat( SHOW_FOLD_MESSAGE , LoggerLevel.getLevelString( level ) , title, message ) ;
            }
            send( message ) ;
        }
        
        /**
         * Send a message with a specific level.
         */
        public function sendLevelMessage( message:String , level:LoggerLevel ):void 
        {
            if( levelPolicy ) 
            {
                message = fastformat( SHOW_MESSAGE , level.toString() , message.toString() ) ;
            } 
            send( message ) ;
        }
        
        /**
         * Sets the name of the application in the SOS console.
         */
        public function setApplicationName( name:String ):void 
        {
            send( fastformat( APPLICATION_NAME , name ) ) ;
        }
        
        /**
         * Sets the color of the application, the Color must be set as Integer Value. So 16768477 equals 0xffdddd.
         */
        public function setApplicationColor( color:Number ):void 
        {
            send( fastformat( APPLICATION_COLOR , color ) ) ;
        }
        
        /**
         * Sets the color for a specific level. If the color argument is NaN, the default color of the passed-in LoggerLevel is used.
         * @see LogEventLevel
         */
        public function setLevelColor( level:LoggerLevel, color:Number=NaN ):void 
        {
            if (!LoggerLevel.isValidLevel(level))
            {
                return ;
            }
            send
            ( 
                fastformat
                ( 
                    LEVEL_COLOR ,
                    String(level) , 
                    isNaN(color) ? SOSTarget[ String(level) + "_COLOR" ] : color 
                )
            ) ;
        }
    }
}
