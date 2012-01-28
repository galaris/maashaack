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
    /**
     * Reports the index position of the last occurrence in this instance of one or more characters specified in a Unicode array.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint"> 
     * import core.strings.lastIndexOfAny ;
     * trace( lastIndexOfAny("hello world", ["2", "hello", "5"]) ); // 0
     * trace( lastIndexOfAny("Five 5 = 5 and not 2" , ["2", "hello", "5"]) ); // 19
     * trace( lastIndexOfAny("Five 5 = 5 and not 2" , ["5", "hello", "2"]) ); // 9
     * trace( lastIndexOfAny("Five 5 = 5 and not 2" , ["5", "hello", "2"] , 8) ); // 5
     * trace( lastIndexOfAny("Five 5 = 5 and not 2" , ["5", "hello", "2"] , 8 , 3) ); // -1
     * </pre> 
     * @param source The string to transform.
     * @param anyOf The Array of Unicode characters to find in the String.
     * @param startIndex The init position of the search process.
     * @param count The number of elements to check.
     * @return the index position of the last occurrence in this instance of one or more characters specified in a Unicode array.
     * @throws ArgumentError if the anyOf argument is 'null' or 'undefined'.
     */
    public const lastIndexOfAny:Function = function( source:String, anyOf:Array, startIndex:int = 0x7FFFFFFF, count:uint = 0x7FFFFFFF ):int 
    {
        var i:int;
        var index:int ;
        if( !anyOf || source == null || source.length == 0 )
        {
            return - 1;
        }
        if ( startIndex > source.length )
        {
            startIndex = source.length ;
        }
        else if( startIndex < 0 )
        {
            return - 1 ;
        }
        var endIndex:int = startIndex - count + 1 ;
        if ( endIndex < 0 )
        {
            endIndex = 0 ;
        }
        source = source.slice( endIndex, startIndex + 1 ) ;
        var len:uint = anyOf.length ;
        for ( i = 0 ; i < len ; i++ )
        {
            index = source.lastIndexOf( anyOf[i], startIndex ) ;
            if (index > - 1) 
            {
                return index + endIndex;
            }
        }
        
        return - 1 ;
    };
}
