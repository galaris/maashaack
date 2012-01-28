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

package core.strings
{
    import flash.utils.ByteArray;
    
    /**
     * Format a ByteArray to an hexadecimal string, from start to end (or length),
     * adding a `sep` `every` n chars with a maximum line length of `width`.
     * @param bytes The ByteArray to format.
     * @param start The start position to format the ByteArray.
     * @param end The end position to format the ByteArray. If this value is negative the length of the ByteArray is used.
     * @param every Inserts a separator every n chars (default 2).
     * @param separator The separator to insert between the n chars.
     * @param width The width of the line of chars.
     * @param header An optional header to insert in the front of the result string.
     */
    public function hexformat( bytes:ByteArray, start:uint = 0, end:int = -1,
                               every:uint = 2, separator:String = " ", width:uint = 80, header:String = "" ):String
    {
        if ( bytes == null )
        {
            return "" ;
        }
        
        if( end == -1 ) { end = bytes.length; }
        
        var stream:String   = "";
        var formated:String = "";
        var hex:String      = "";
        
        var original:uint = bytes.position;
        bytes.position = start;
        while( bytes.position < end )
        {
            hex     = uint( bytes.readUnsignedByte() ).toString( 16 );
            stream += (hex.length>1) ? hex: "0"+hex;
        }
        bytes.position = original;
        
        var len:uint     = stream.length;
        var min:uint     = 0;
        var max:uint     = every;
        var total:uint   = 0;
        var linelen:uint = 0;
        
        while( total < len )
        {
            formated += stream.substr( min, max ) + separator;
            linelen  += max + separator.length;
            
            if( linelen >= width ) { formated += "\n" + header; linelen = 0; }
            
            min   += every;
            total += every;
        }
        
        if ( formated.lastIndexOf( separator ) == formated.length -1 )
        {
            formated = formated.slice(0,formated.length-1) ;
        }
        
        return formated;
    }
}