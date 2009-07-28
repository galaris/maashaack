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

    import flash.text.TextField;

    /**
     * Provides a logger target that uses a TextField to output log messages.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import flash.text.TextField ;
     * 
     * import system.logging.Log ;
     * import system.logging.Logger ;
     * import system.logging.LoggerLevel ;
     * import system.logging.LoggerTarget ;
     * import system.logging.targets.TextFieldTarget ;
     * 
     * import flash.text.TextField ;
     * import flash.text.TextFormat ;
     * 
     * var field:TextField = new TextField() ;
     * 
     * field.x                 = 10 ;
     * field.y                 = 10 ;
     * field.width             = 650 ;
     * field.height            = 400 ;
     * field.defaultTextFormat = new TextFormat("Courier New", 11) ;
     * field.background        = true ;
     * field.backgroundColor   = 0xFFFFFF ;
     * field.border            = true ;
     * field.borderColor       = 0x999999 ;
     * field.multiline         = true ;
     * field.wordWrap          = true ;
     * 
     * addChild( field ) ;
     * 
     * // setup writer
     * var target:TextFieldTarget = new TextFieldTarget(field) ;
     * 
     * target.includeDate    = true ;
     * target.includeTime    = true ;
     * target.includeLevel   = true ;
     * target.includeChannel = true ;
     * target.includeLines   = true ;
     * 
     * target.filters        = [ "system.*" ] ;
     * target.level          = LogEventLevel.ALL ;
     * 
     * var logger:Logger = Log.getLogger( "system.test.MyTest" ) ;
     * 
     * logger.log( LoggerLevel.DEBUG , "here is some myDebug info : {0} and {1}", 2.25 , true ) ;
     * logger.fatal("Here is some fatal error...") ;
     * 
     * target.includeDate    = false ;
     * target.includeTime    = false ;
     * target.includeChannel = false ;
     * 
     * logger.info("[{0}, {1}, {2}]", 2, 4, 6) ;
     * </pre>
     */
    public class TextFieldTarget extends LineFormattedTarget 
    {
        /**
         * Creates a new TextFieldTarget instance.
         * @param textfield the TextField target.
         */
        public function TextFieldTarget( textfield:TextField )
        {
            this.textfield = textfield ;
        }
        
        /**
         * This boolean indicates if the TextField autoscroll when a new log message is append in the target (default is true).
         */
        public var autoScroll:Boolean = true ;
        
        /**
         * The TextField reference of this target.
         */
        public var textfield:TextField ;
        
        /**
         * Descendants of this class should override this method to direct the specified message to the desired output.
         * @param message String containing preprocessed log message which may include time, date, category, etc. 
         * based on property settings, such as <code class="prettyprint">includeDate</code>, <code class="prettyprint">includeCategory</code>, etc.
         */
        public override function internalLog( message:* , level:LoggerLevel ):void
        {
            var txt:String     = textfield.text || "" ;
            txt += message + "\r" ;
            textfield.text     = txt ;
            if ( autoScroll )
            {
                textfield.scrollV  = textfield.maxScrollV ;
            }
        }
    }
}
