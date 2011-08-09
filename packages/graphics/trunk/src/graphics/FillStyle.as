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

package graphics 
{
    import flash.display.Graphics;
    
    /**
     * Defines the fill style of the vector shapes. See the flash.display.graphics.beginFill method.
     */
    public class FillStyle implements IFillStyle
    {
        /**
         * Creates a new FillStyle instance.
         * @param color The color value of the fill style.
         * @param alpha The alpha value of the fill style.
         */
        public function FillStyle( color:uint = 0 , alpha:Number = 1.0 )
        {
            this.alpha = alpha ;
            this.color = color ;
        }
        
        /**
         * The empty FillStyle singleton.
         */
        public static var EMPTY:FillStyle = new FillStyle() ;
        
        /**
         * The alpha value of the fill style.
         */
        public var alpha:Number;
        
        /**
         * The color value of the fill style.
         */
        public var color:uint;
        
        /**
         * Initialize and launch the beginFill method of the specified Graphics reference.
         */
        public function apply( graphic:Graphics ):void
        {
            graphic.beginFill( color, alpha );
        }
        
        /**
         * Creates and returns a shallow copy of the object.
         * @return A new object that is a shallow copy of this instance.
         */
        public function clone():* 
        {
            return new FillStyle( color , alpha ) ;
        }
        
        /**
         * Compares the specified object with this object for equality.
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
         */
        public function equals( o:* ):Boolean
        {
            var s:FillStyle = o as FillStyle ;
            if ( s )
            {
                return color == s.color
                    && alpha == s.alpha ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource(indent:int = 0):String
        {
            var source:String = "new graphics.FillStyle("
                              + color.toString() + "," 
                              + alpha.toString() 
                              + ")" ;
            return source ;
        }
    }
}
