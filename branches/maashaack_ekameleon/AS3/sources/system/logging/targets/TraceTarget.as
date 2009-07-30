/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package system.logging.targets
{
    import system.logging.LoggerLevel;
    
    /**
      * Provides a logger target that uses the global trace() method to output log messages.
      * <p><b>Example :</b></p>
      * package examples
      * {
      *     import system.logging.Log;
      *     import system.logging.Logger;
      *     import system.logging.LoggerLevel;
      *     import system.logging.targets.TraceTarget;
      *     
      *     import flash.display.Sprite;
      *     
      *     public class TraceTargetExample extends Sprite
      *     {
      *         public function TraceTargetExample()
      *         {
      *             // setup writer
      *             var target:TraceTarget = new TraceTarget() ;
      *             
      *             target.filters        = [ "examples.*" ] ;
      *             target.level          = LoggerLevel.ALL ;
      *             
      *             target.includeDate    = true ;
      *             target.includeTime    = true ;
      *             target.includeLevel   = true ;
      *             target.includeChannel = true ;
      *             target.includeLines   = true ;
      *             
      *             var logger:Logger = Log.getLogger( "examples.TraceTarget" ) ;
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
    public class TraceTarget extends LineFormattedTarget
    {
        /**
         * Creates a new TraceTarget instance.
         */
        public function TraceTarget()
        {
            //
        }
        
        /**
         * Descendants of this class should override this method to direct the specified message to the desired output.
         * @param message String containing preprocessed log message which may include time, date, channel, etc. 
         * based on property settings, such as <code class="prettyprint">includeDate</code>, <code class="prettyprint">includeChannel</code>, etc.
         */
        public override function internalLog( message:* , level:LoggerLevel ):void
        {
            trace( message ) ;
        }
    }
}