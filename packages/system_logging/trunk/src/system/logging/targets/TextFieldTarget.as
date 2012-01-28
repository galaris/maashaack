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
    import system.logging.LoggerLevel;
    
    import flash.text.TextField;
    
    /**
     * Provides a logger target that uses a TextField to output log messages.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
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
     *             ///////////
     *             
     *             var field:TextField = new TextField() ;
     *             
     *             field.x                 = 10 ;
     *             field.y                 = 10 ;
     *             field.width             = 700 ;
     *             field.height            = 400 ;
     *             field.defaultTextFormat = new TextFormat("Courier New", 11) ;
     *             field.background        = true ;
     *             field.backgroundColor   = 0xFFFFFF ;
     *             field.border            = true ;
     *             field.borderColor       = 0x999999 ;
     *             field.multiline         = true ;
     *             field.wordWrap          = true ;
     *             
     *             addChild( field ) ;
     *             
     *             ///////////
     *             
     *             var target:TextFieldTarget = new TextFieldTarget(field) ;
     *             
     *             target.filters        = [ "examples.&#42;" ] ;
     *             target.level          = LoggerLevel.ALL ;
     *             
     *             target.includeDate    = true ;
     *             target.includeTime    = true ;
     *             target.includeLevel   = true ;
     *             target.includeChannel = true ;
     *             target.includeLines   = true ;
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
    public class TextFieldTarget extends LineFormattedTarget 
    {
        /**
         * Creates a new TextFieldTarget instance.
         * @param textfield The TextField reference to output the log messages.
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
         * @throws ReferenceError If the internal textfield reference is null.
         */
        public override function internalLog( message:* , level:LoggerLevel ):void
        {
            if ( textfield != null )
            {
                var txt:String     = textfield.text || "" ;
                txt               += message + "\r" ;
                textfield.text     = txt ;
                if ( autoScroll )
                {
                    textfield.scrollV  = textfield.maxScrollV ;
                }
            }
            else
            {
                throw new ReferenceError( "The internal textfield reference of the target not must be null." ) ;
            }
        }
    }
}
