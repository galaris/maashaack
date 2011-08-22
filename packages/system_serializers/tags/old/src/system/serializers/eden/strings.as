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

package system.serializers.eden
{

    //TEMP CLASS
    /**
     * The string messages used in the eden class.
     */
    public class strings
    {

        /**
         * MultiSerialize require pairs of values.
         */
        public static var requirePairValue:String = "multiSerialize require pairs of values";

        /**
         * Name "{0}" is not a string, pair[{1},{2}] is ignored
         */
        public static var pairIsIgnored:String = "name \"{0}\" is not a string, pair[{1},{2}] is ignored";

        /**
         * "{0}" is a reserved keyword.
         */
        public static var reservedKeyword:String = "\"{0}\" is a reserved keyword";

        /**
         * "{0}" is a future reserved keyword.
         */
        public static var futurReservedKeyword:String = "\"{0}\" is a future reserved keyword";

        /**
         * "{0} is not a valid path
         */
        public static var notValidPath:String = "\"{0}\" is not a valid path";

        /**
         * Unterminated comment.
         */
        public static var unterminatedComment:String = "unterminated comment";

        /**
         * "{0}" is not a valid constructor.
         */
        public static var notValidConstructor:String = "\"{0}\" is not a valid constructor";

        /**
         * "{0}" does not exists
         */
        public static var doesNotExist:String = "\"{0}\" does not exists";

        /**
         * Bad array (unterminated array)
         */
        public static var errorArray:String = "bad array (unterminated array)";

        /**
         * Syntax error (comment) 
         */
        public static var errorComment:String = "syntax error (comment)";

        /*
         * Bad constructor
         */
        public static var errorConstructor:String = "bad constructor";

        /**
         * Bad identifier.
         */
        public static var errorIdentifier:String = "bad identifier";

        /**
         * Bad string (found line terminator in string)
         */
        public static var errorLineTerminator:String = "bad string (found line terminator in string)";

        /**
         * Bad number (not finite)
         */
        public static var errorNumber:String = "bad number (not finite)";

        /**
         * Bad object (unterminated object)
         */
        public static var errorObject:String = "bad object (unterminated object)";

        /**
         * Bad string (unterminated string)
         */
        public static var errorString:String = "bad string (unterminated string)";
        
        /**
         * Bad number (malformed hexadecimal)
         */
        public static var malformedHexadecimal:String = "bad number (malformed hexadecimal)";
        
        /**
         * External reference "{0}" does not exists
         */
        public static var extRefDoesNotExist:String = "external reference \"{0}\" does not exists";
        
        /**
         * Syntax error
         */
        public static var errorKeyword:String = "syntax error";
        
        /**
         * "{0}" is not an authorized constructor
         */
        public static var notAuthorizedConstructor:String = "\"{0}\" is not an authorized constructor";
        
        /**
         * "{0}" is not an authorized external reference
         */
        public static var notAuthorizedExternalReference:String = "\"{0}\" is not an authorized external reference";
        
        /**
         * "{0}" is not an authorized path
         */
        public static var notAuthorizedPath:String = "\"{0}\" is not an authorized path";
        
        /**
         * "{0}" is not a valid function
         */
        public static var notValidFunction:String = "\"{0}\" is not a valid function";
        
        /**
         * Bad function
         */
        public static var errorFunction:String = "bad function";
        
        /**
         * function call "{0}( {1} )"is not allowed
         */
        public static var notFunctionCallAllowed:String = "function call \"{0}( {1} )\"is not allowed";
        
        /**
         * "{0}" is not an authorized function
         */
        public static var notAuthorizedFunction:String = "\"{0}\" is not an authorized function";
    }
}