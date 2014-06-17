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
  Portions created by the Initial Developers are Copyright (C) 2006-2014
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
package core.random
{
    import flash.crypto.generateRandomBytes;
    import flash.utils.ByteArray;
    
    /**
     * Generates a variant 2, version 4 (randomly generated number) UUID as per RFC 4122.
     */
    public function generateUUID():String
    {
        /* note:
           using flash.crypto.generateRandomBytes
           force a dependency on a minimum version of Flash Player 11.0 / AIR 3.0
           it can be refactored later to target lower versions
        */
        
        var randomBytes:ByteArray = generateRandomBytes( 16 );
            randomBytes[6] &= 0x0f; /* clear version */
            randomBytes[6] |= 0x40; /* set to version 4 */
            randomBytes[8] &= 0x3f; /* clear variant */
            randomBytes[8] |= 0x80; /* set to IETF variant */
        
        var toHex:Function = function( n:uint ):String
        {
            var h:String = n.toString( 16 );
                h = (h.length > 1 ) ? h : "0"+h ;
            return h;
        } ;
        
        var str:String = "";
        
        var i:uint;
        var l:uint = randomBytes.length;
        
        randomBytes.position = 0 ;
        
        var byte:uint;
        
        for( i = 0 ; i < l ; i++ )
        {
            byte = randomBytes[ i ];
            str += toHex( byte );
        }
        
        /* note:
           The UUID string representation is as described by this BNF
           UUID = <time_low> "-" <time_mid> "-" <time_high_and_version> "-" <variant_and_sequence> "-" <node>
           time_low = 4*<hexOctet>
           time_mid = 2*<hexOctet>
           time_high_and_version = 2*<hexOctet>
           variant_and_sequence = 2*<hexOctet>
           node = 6*<hexOctet>
           hexOctet = <hexDigit><hexDigit>
        
           see http://en.wikipedia.org/wiki/Universally_unique_identifier#Version_4_.28random.29
           Version 4 UUIDs have the form xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx
           where x is any hexadecimal digit and y is one of 8, 9, a, or b
           (e.g., f47ac10b-58cc-4372-a567-0e02b2c3d479).
        */
        var uuid:String = "";
        
            uuid += str.substr( 0, 8 );
            uuid += "-";
            uuid += str.substr( 8, 4 );
            uuid += "-";
            uuid += str.substr( 12, 4 );
            uuid += "-";
            uuid += str.substr( 16, 4 );
            uuid += "-";
            uuid += str.substr( 20, 12 );
        
        return uuid;
    }
}
