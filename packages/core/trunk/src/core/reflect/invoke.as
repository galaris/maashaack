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

package core.reflect
{
    /**
    * Invokes dynamically a class constructor.
    * <p><b>Example :</b></p>
    * <pre class="prettyprint">
    * import core.dump ;
    * import core.reflect.invoke ;
    * 
    * var ar:Array = invoke( Array , [1,2,3]) as Array ;
    * 
    * trace( dump( ar ) ) ;
    * </pre>
    * @param c the class to invoke.
    * @param args (optional) the arguments to pass to the constructor (max 32).
    * 
    * @return an instance of the class, or null if class can not construct.
    */
    public const invoke:Function = function( c:Class, args:Array = null ):*
    {
        if( !args )
        {
            return new c();
        }
        
        var a:Array = args;
        
        /* note:
           if we ever need more than 32 args
           will use CC for that special case
        */
        switch( a.length )
        {
            case 0:
            return new c();
            
            case 1:
            return new c( a[0] );
            
            case 2:
            return new c( a[0],a[1] );
            
            case 3:
            return new c( a[0],a[1],a[2] );
            
            case 4:
            return new c( a[0],a[1],a[2],a[3] );
            
            case 5:
            return new c( a[0],a[1],a[2],a[3],a[4] );
            
            case 6:
            return new c( a[0],a[1],a[2],a[3],a[4],a[5] );
            
            case 7:
            return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6] );
            
            case 8:
            return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7] );
            
            case 9:
            return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8] );
            
            case 10:
            return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9] );
            
            case 11:
            return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10] );
            
            case 12:
            return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11] );
            
            case 13:
            return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12] );
            
            case 14:
            return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13] );
            
            case 15:
            return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14] );
            
            case 16:
            return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15] );
            
            case 17:
            return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16] );
            
            case 18:
            return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],
                          a[17] );
            
            case 19:
            return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],
                          a[17],a[18] );
            
            case 20:
            return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],
                          a[17],a[18],a[19] );
            
            case 21:
            return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],
                          a[17],a[18],a[19],a[20] );
            
            case 22:
            return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],
                          a[17],a[18],a[19],a[20],a[21] );
            
            case 23:
            return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],
                          a[17],a[18],a[19],a[20],a[21],a[22] );
            
            case 24:
            return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],
                          a[17],a[18],a[19],a[20],a[21],a[22],a[23] );
            
            case 25:
            return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],
                          a[17],a[18],a[19],a[20],a[21],a[22],a[23],a[24] );
            
            case 26:
            return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],
                          a[17],a[18],a[19],a[20],a[21],a[22],a[23],a[24],a[25] );
            
            case 27:
            return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],
                          a[17],a[18],a[19],a[20],a[21],a[22],a[23],a[24],a[25],a[26] );
            
            case 28:
            return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],
                          a[17],a[18],a[19],a[20],a[21],a[22],a[23],a[24],a[25],a[26],a[27] );
            
            case 29:
            return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],
                          a[17],a[18],a[19],a[20],a[21],a[22],a[23],a[24],a[25],a[26],a[27],a[28] );
            
            case 30:
            return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],
                          a[17],a[18],a[19],a[20],a[21],a[22],a[23],a[24],a[25],a[26],a[27],a[28],a[29] );
            
            case 31:
            return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],
                          a[17],a[18],a[19],a[20],a[21],a[22],a[23],a[24],a[25],a[26],a[27],a[28],a[29],a[30] );
            
            case 32:
            return new c( a[0],a[1],a[2],a[3],a[4],a[5],a[6],a[7],a[8],a[9],a[10],a[11],a[12],a[13],a[14],a[15],a[16],
                          a[17],a[18],a[19],a[20],a[21],a[22],a[23],a[24],a[25],a[26],a[27],a[28],a[29],a[30],a[31] );
            
            default:
            return null;
        }
        
    };
}