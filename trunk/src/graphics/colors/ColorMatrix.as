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
  Portions created by the Initial Developers are Copyright (C) 2006-2010
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

package graphics.colors
{
    import system.Cloneable;
    
    /**
     * 5x4 matrix for transforming the color and alpha components of a display.
     */
    public class ColorMatrix implements Cloneable
    {
        /**
         * Creates a new ColorMatrix instance.
         */
        public function ColorMatrix( factory:* = null )
        {
            if ( factory is Array )
            {
                matrix = (factory as Array).concat() ;
            }
            else if( factory is ColorMatrix )
            {
                matrix = (factory as ColorMatrix).matrix.concat() ;
            }
            else
            {
                matrix = IDENTITY.concat() ;
            }
        }
        
        /**
         * The matrix representation of all color components values.
         */
        public var matrix:Array ;
        
        /**
         * Returns the shallow copy of the object.
         * @return the shallow copy of the object.
         */
        public function clone():*
        {
            return new ColorMatrix( matrix );
        }
        
        /**
         * Concatenates the elements of a matrix specified in the parameter with the elements in an array and creates a new matrix
         * @param Array The altered Matrix
         */ 
        public function concat( mat:Array ):void
        {
            var i:int      = 0;
            var temp:Array = [] ;
            for (var y:int = 0 ; y < 4 ; y++ )
            {
                for (var x:int = 0; x < 5 ; x++ )
                {
                    temp[i + x] =   mat[i]   * matrix[ x      ] + 
                                    mat[i+1] * matrix[ x +  5 ] + 
                                    mat[i+2] * matrix[ x + 10 ] + 
                                    mat[i+3] * matrix[ x + 15 ] +
                                    ( x == 4 ? mat[i+4] : 0 ) ;
                }
                i+=5 ;
            }
            
            matrix = temp;
        }
        
        /**
         * Sets this colormatrix to identity: [ 1 0 0 0 0 - red vector 0 1 0 0 0 - green vector 0 0 1 0 0 - blue vector 0 0 0 1 0 ] - alpha vector
         */
        public function reset():void
        {
            matrix = IDENTITY.concat() ;
        }
        
        /**
         * Returns the String representation of the object.
         * @return the String representation of the object.
         */
        public function toString():String 
        {
            return "[ColorMatrix "+ matrix.join(",") + "]";
        }
        
        /**
         * The identity internal vector to initialize the ColorMatrix.
         */
        protected static const IDENTITY:Array =
        [ 
            1,0,0,0,0,
            0,1,0,0,0,
            0,0,1,0,0,
            0,0,0,1,0 
        ];
    }
}
