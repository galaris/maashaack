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

package graphics.geom 
{
    import core.reflect.getClassPath;

    /**
     * UVW mapping is a mathematical technique for coordinate mapping. 
     * "UVW", like the standard Cartesian coordinate system, has three dimensions; the third dimension allows texture maps to wrap in complex ways onto irregular surfaces.
     */
    public class UVW extends UV
    {
        /**
         * Creates a new UVW instance.
         * @param u The horizontal coordinate value. The default value is zero.
         * @param v The vertical coordinate value. The default value is zero.
         * @param w The w coordinate value. The default value is zero.
         */
        public function UVW( u:Number = 0 , v:Number = 0 , w:Number = 0  )
        {
            super( u , v ) ;
            this.w = isNaN(w) ? 0 : w ;
        }
        
        /**
         * Defines the w coordinate value of the texture.
         */
        public var w:Number ;
        
        /**
         * Returns a shallow copy of this instance.
         * @return a shallow copy of this instance.
         */
        public override function clone():*
        {
            return new UVW(u,v,w) ;
        }
        
        /**
         * Compares the specified object with this object for equality.
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
         */
        public override function equals( o:* ):Boolean 
        {
            if ( o is UVW )
            {
                return ( o.u == u ) && ( o.v == v ) && ( o.w = w ) ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Returns the Object representation of this object.
         * @return the Object representation of this object.
         */
        public override function toObject():Object 
        {
            return { u:u , v:v , w:w } ;
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public override function toSource( indent:int = 0 ):String 
        {
            return "new " + getClassPath(this, true) + "(" +  u.toString() + "," + v.toString() + "," + w.toString() + ")" ;
        }
        
        /**
         * Returns the String representation of the object.
         * @return the String representation of the object.
         */
        public override function toString():String
        {
            return "[UVW u:" + u + " v:" + v + " w:" + w + "]" ;
        }
    }
}