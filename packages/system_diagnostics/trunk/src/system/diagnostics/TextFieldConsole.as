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
  Portions created by the Initial Developers are Copyright (C) 2006-2011
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
 
package system.diagnostics 
{
    import system.terminals.InteractiveConsole;

    import flash.text.TextField;
    
    /**
     * The TextFieldConsole use a TextField display that redirect messages in the debug application.
     * <p><b>Note:</b> You can not read from the output and so the TextFieldConsole is not interactive.</p>
     */
    public class TextFieldConsole implements InteractiveConsole 
    {
        /**
         * Creates a new TextFieldConsole instance.
         * @param textfield The TextField reference to redirect the messages.
         */
        public function TextFieldConsole( textfield:TextField , autoScroll:Boolean = true , verbose:Boolean = true )
        {
            this.textfield  = textfield ;
            this.autoScroll = true ;
            this.verbose    = verbose ;
            _buffer = "";
        }
        
        /**
         * Indicates if the field must scroll when the writeLine method is invoked.
         */
        public var autoScroll:Boolean ;
        
        /**
         * The TextField reference of this console.
         */
        public var textfield:TextField ;
        
        /**
         * Indicates the verbose mode.
         */
        public var verbose:Boolean ;
        
        public final function read():String
        {
            return "";
        }
        
        public final function readLine():String
        {
            API::FLASH
            {
                return "";
            }
            
            API::REDTAMARIN
            {
                return readLine();
            }
        }
        
        public final function write( ...messages ):void
        {
            _buffer += _format( messages );
        }
        
        
        /**
         * Appends the message format and add newline character.
         */
        public function writeLine( ...messages ):void
        {
            var msg:String = _format( messages ) ;
            
            msg = _buffer + msg  ;
            
            if ( verbose )
            {
                trace( msg ) ; 
            }
            
            var txt:String = textfield.text ;
            txt += msg + "\r" ;
            
            textfield.text = txt ;
            
            if ( autoScroll )
            {
                textfield.scrollV = textfield.maxScrollV ;
            }
            
            _buffer = "" ;
        }
        
        private var _buffer:String;
        
        private final function _fastFormat( format:String, ...args:Array ):String
        {
            if( (format == null) || (format == "") )
            {
                return "";
            }
            
            var len:uint = args.length;
            var a:Array;
            
            if( (len == 1) && (args[0] is Array) )
            {
                a   = args[0] as Array;
                len = a.length;
            }
            else
            {
                a = args;
            }
            
            var i:uint;
            for( i=0; i < len; i++ )
            {
                format = format.replace( new RegExp( "\\{"+i+"\\}", "g" ), a[i] );
            }
            
            return format;
        }
        
        private final function _format( messages:Array ):String
        {
            if( messages.length == 0 )
            {
                return "";
            }
            
            var msg:String;
            var format:String;
            
            if( messages[0] is String )
            {
                format = String( messages.shift() );
                msg = _fastFormat( format, messages );
            }
            else
            {
                msg = messages.join( "" );
            }
            
            return msg;
        }
    }
}
