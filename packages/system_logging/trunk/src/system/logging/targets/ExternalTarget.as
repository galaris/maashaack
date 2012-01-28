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

    import system.hack;
    import system.logging.LoggerLevel;

    import flash.external.ExternalInterface;
    import flash.net.URLRequest;
    import flash.net.navigateToURL;

    /**
     * Provides a logger target that uses the FireBug console extension in Firefox to output log messages. 
     * You can download the FireBug and test this target : <a href="https://addons.mozilla.org/fr/firefox/addon/1843">https://addons.mozilla.org/fr/firefox/addon/1843</a>.
     * You must launch this example in FireFox with the FireBug console enabled. 
     * <p><b>Example :</b></p>
     * <pre>
     * package examples 
     * {
     *     import system.logging.Log;
     *     import system.logging.Logger;
     *     import system.logging.LoggerLevel;
     *     import system.logging.targets.ExternalTarget;
     *     
     *     import flash.display.Sprite;
     *     
     *     public class ExternalTargetExample extends Sprite
     *     {
     *         public function ExternalTargetExample()
     *         {
     *             var target:ExternalTarget = new ExternalTarget() ;
     *             
     *             target.includeDate    = true ;
     *             target.includeTime    = true ;
     *             target.includeLevel   = true ;
     *             target.includeChannel = true ;
     *             target.includeLines   = true ;
     *             
     *             target.filters        = [ "examples.*" ] ;
     *             target.level          = LoggerLevel.ALL ;
     *             
     *             var logger:Logger = Log.getLogger( "examples.TextFieldTarget" ) ;
     *             
     *             logger.log   ( "Here is some myDebug info : {0} and {1}", 2.25 , true ) ;
     *             logger.debug ( "Here is some debug message." ) ;
     *             logger.info  ( "Here is some info message." ) ;
     *             logger.warn  ( "Here is some warn message." ) ;
     *             logger.error ( "Here is some error message." ) ;
     *             logger.fatal ( "Here is some fatal error..." ) ;
     *             
     *             target.includeDate    = false ;
     *             target.includeTime    = false ;
     *             target.includeChannel = false ;
     *             
     *             logger.info( "test : [{0}, {1}, {2}]", 2, 4, 6 ) ;
     *         }
     *     }
     * }
     * </pre>
     */
    public class ExternalTarget extends LineFormattedTarget 
    {
        use namespace hack ;
        
        /**
         * Creates a new ExternalTarget instance.
         */
        public function ExternalTarget()
        {
            super();
        }
        
        /**
         * Designates the "all" external proxy message.
         */
        public static const ALL:String = "console.log" ;
        
        /**
         * Designates the "debug" external proxy message.
         */
        public static const DEBUG:String = "console.debug" ;
        
        /**
         * Designates the "error" external proxy message.
         */
        public static const ERROR:String = "console.error" ;
        
        /**
         * Designates the "fatal" external proxy message.
         */
        public static const FATAL:String = "console.error" ;
        
        /**
         * Designates the "info" external proxy message.
         */
        public static const INFO:String = "console.info" ;
        
        /**
         * A special level that can be used to turn off logging (0).
         */
        public static const NONE:String = "console.log" ;
        
        /**
         * Designates events that could be harmful to the application operation (6).
         */
        public static const WARN:String = "console.warn" ;
        
        /**
         * What a Terrible Failure: designates an exception that should never happen. (32).
         */
        public static const WTF:String = "console.warn" ;
        
        /**
         * Indicates whether this player is in a container that offers an external interface.
         */
        public function get available():Boolean
        {
            return ExternalInterface.available ;
        }
        
        /**
         * The internal javascript pattern use to log with the navigateToURL method.
         */
        public var externalUrl:String = "javascript:{0}('{1}');" ;
        
        /**
         * If the target isn't available this flag indicates if the target try to use a javascript notification with the navigateToURL method.
         */
        public var verbose:Boolean ;
        
        /**
         * Descendants of this class should override this method to direct the specified message to the desired output.
         * @param message String containing preprocessed log message which may include time, date, channel, etc. 
         * based on property settings, such as <code class="prettyprint">includeDate</code>, <code class="prettyprint">includeChannel</code>, etc.
         */
        public override function internalLog( message:* , level:LoggerLevel ):void
        {
            var methodName:String ;
            switch ( level )
            {
                case LoggerLevel.ALL :
                {
                    methodName = ExternalTarget.ALL ;
                    break ; 
                }
                case LoggerLevel.DEBUG :
                {
                    methodName = ExternalTarget.DEBUG ;
                    break ;
                }
                case LoggerLevel.ERROR :
                {
                    methodName = ExternalTarget.ERROR ;
                    break ;
                }
                case LoggerLevel.FATAL :
                {
                    methodName = ExternalTarget.FATAL ;
                    break ;
                }
                case LoggerLevel.INFO :
                {
                    methodName = ExternalTarget.INFO ;
                    break ; 
                }
                case LoggerLevel.WARN :
                {
                    methodName = ExternalTarget.WARN ;
                    break ; 
                }
                case LoggerLevel.WTF :
                {
                    methodName = ExternalTarget.WTF ;
                    break ; 
                }
                default :
                {
                    methodName = ExternalTarget.NONE ;
                    break ; 
                }
            }
            if ( ExternalInterface.available )
            {
                ExternalInterface.call( methodName, [message] ) ;
            }
            else if ( verbose )
            {
                navigateToURL( new URLRequest( fastformat( externalUrl , methodName , message ) ) ) ;  
            }
        }
    }
}
