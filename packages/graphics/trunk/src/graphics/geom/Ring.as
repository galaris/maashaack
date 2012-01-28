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
    import core.dump;
    import core.reflect.getClassName;
    import core.reflect.getClassPath;
    import graphics.Geometry;
    
    /**
     * Defines a flat ring or disk within three dimensional space that is specified via the ring's center point, an up vector, an inner radius, and an outer radius.
     */
    public class Ring implements Geometry 
    {
        /**
         * Creates a new Ring instance.
         * @param center the center of the ring.
         * @param up the unit up vector defining the ring's orientation.
         * @param innerRadius the ring's inner radius.
         * @param outerRadius the ring's outer radius.
         */
        public function Ring( center:Vector3 = null , up:Vector3 = null , innerRadius:Number = 0 , outerRadius:Number = 1 )
        {
            this.center      = center ;
            this.up          = up ;
            this.innerRadius = innerRadius ;
            this.outerRadius = outerRadius ;
        }
        
        /**
         * The center vector of the ring.
         */
        public var center:Vector3 ;
        
        /**
         * The ring's inner radius.
         */
        public var innerRadius:Number ;
        
        /**
         * The ring's outer radius.
         */
        public var outerRadius:Number ;
        
        /**
         * The the unit up vector defining the ring's orientation.
         */
        public var up:Vector3 ;
        
        /**
         * Returns a shallow copy of this instance.
         * @return a shallow copy of this instance.
         */
        public function clone():*
        {
            return new Ring( (center ? center.clone() : null) , (up ? up.clone() : null) , innerRadius , outerRadius ) ;
        }
        
        /**
         * Compares the specified object with this object for equality.
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
         */
        public function equals( o:* ):Boolean
        {
            if( o == this )
            {
                return true ;
            }
            var r:Ring = o as Ring ;
            if ( r == null )
            {
                return false ;
            }
            else
            {
                if ( center == null && r.center != null )
                {
                    return false ;
                }
                else if ( center != null )
                {
                    if ( !center.equals( r.center ) )
                    {
                       return false ;
                    }
                }
                if ( up == null && r.up != null )
                {
                    return false ;
                }
                else if ( up != null )
                {
                    if ( !up.equals( r.up ) )
                    {
                       return false ;
                    }
                }
                if ( (innerRadius != r.innerRadius)  || (outerRadius != r.outerRadius) )
                {
                    return false ;
                }
            }
            return true ;
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource(indent:int = 0):String
        {
            return "new " + getClassPath(this,true) + "(" + dump(center) + "," + dump(up) + "," + dump(innerRadius) + "," + dump(outerRadius) + ")" ;
        }
        
        /**
         * Returns the string representation of the object.
         * @return the string representation of the object.
         */
        public function toString():String
        {
            return "[" + getClassName(this) + "]" ;
        }
    }
}
