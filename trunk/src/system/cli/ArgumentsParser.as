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

package system.cli
{
    /**
     * Parse command line arguments.
     * <p><b>Note :</b> we don't want to use events for Tamarin compatibility.</p>
     * <p><b>Example :</b></p>
     * <pre>
     * my.exe -h
     * my.exe /?
     * my.exe -s -T:hello myfile.txt
     * my.exe myfile1.txt myfile2.txt
     * </pre>
     */
    public class ArgumentsParser
    {
        /**
         * @private
         */
        private var _switchSymbols:Array;
        
        /**
         * @private
         */
        private var _caseSensitive:Boolean;
        
        /**
         * @private
         */
        private var _switchChars:Array = [ "/", "-" ];
        
        /**
         * Creates a new ArgumentParser instance.
         * @param switchSymbols The Array representation of all switch symbols.
         * @param caseSensitive Indicates if the case sensitive is enabled.
         * @param switchChars The Array of all switch characters.
         */
        public function ArgumentsParser( switchSymbols:Array,
                                         caseSensitive:Boolean = false,
                                         switchChars:Array = null )
        {
            _switchSymbols = switchSymbols;
            _caseSensitive = caseSensitive;
            
            if( switchChars != null )
            {
                _switchChars = switchChars ;
            }
        }
        
        /**
         * Used to display the usage string when an error occurs.
         * Need to be overrided.
         */
        public function onUsage( errorInfo:String = "" ):void
        {
        }
        
        /**
         * Used to display the usage string when a switch occurs.
         * Need to be overrided.
         */
        public function onSwitch( symbol:String, value:String ):SwitchStatus
        {
            return SwitchStatus.error;
        }
        
        /**
         * Used to display the usage string when a non switch occurs.
         * Need to be overrided.
         */
        public function onNonSwitch( value:String ):SwitchStatus
        {
            return SwitchStatus.error;
        }
        
        /**
         * Used to display the usage string when a parse occurs.
         * Need to be overrided.
         */
        public function onParsed():SwitchStatus
        {
            return SwitchStatus.error;
        }
        
        /**
         * Invoked to parse the specified Array of arguments.
         */
        public function parse( args:Array ):Boolean
        {
            var slots:Array = args;
            var status:SwitchStatus = SwitchStatus.noError;
            
            var num:int;
            var isSwitch:Boolean = false;
            var isLegal:Boolean = false;
            var switchIndex:int;
            var symbol:String;
            var value:String;
            
            var containSwitch:Function = function( element:String, index:int, array:Array ):Boolean
            {
                if( element == slots[num].charAt( 0 ) )
                {
                    return true;
                }
                
                return false;
            };
            
            var containLegalSwitch:Function = function( element:String, index:int, array:Array ):Boolean
            {
                var value:String = slots[num].charAt( 1 );
                
                if( ! _caseSensitive )
                {
                    element = element.toLowerCase( );
                    value = value.toLowerCase( );
                }
                
                if( element == value )
                {
                    switchIndex = index;
                    return true;
                }
                
                return false;
            };
            
            for( num = 0; (status == SwitchStatus.noError) && (num < slots.length) ; num++ )
            {
                isSwitch = _switchChars.some( containSwitch );
                
                if( isSwitch )
                {
                    isLegal = _switchSymbols.some( containLegalSwitch );
                    
                    if( ! isLegal )
                    {
                        status = SwitchStatus.error;
                        break;
                    }
                    else
                    {
                        symbol = _switchSymbols[switchIndex];
                        value = slots[num].substring( 1 + symbol.length );
                        status = this.onSwitch( _caseSensitive ? symbol : symbol.toLowerCase( ), value );
                    }
                }
                else
                {
                    status = this.onNonSwitch( slots[num] );
                }
            }
            
            
            if( status == SwitchStatus.noError )
            {
                status = this.onParsed( );
            }
            
            if( status == SwitchStatus.showUsage )
            {
                this.onUsage( );
            }
            
            if( status == SwitchStatus.error )
            {
                this.onUsage( (num == slots.length) ? "" : slots[num] );
            }
            
            return status == SwitchStatus.noError;
        }
    }
}