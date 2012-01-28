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

package graphics 
{
    import system.Cloneable;
    import system.Equatable;
    import system.Serializable;
    
    /**
     * Determinates the corner definition.This object is use to set for example the CornerRectanglePen implementation (Bevel, RoundedComplex, etc.)
     */
    public class Corner implements Cloneable, Equatable, Serializable
    {
        /**
         * Creates a new Corner instance.
         * @param tl The bottom left flag value.
         * @param tr The bottom right flag value.
         * @param br The bottom right flag value.
         * @param bl The bottom left flag value.
         */
        public function Corner( tl:Boolean=true , tr:Boolean=true , br:Boolean=true , bl:Boolean=true )
        {
            if ( !tl ) 
            {
                this.tl = tl ;
            }
            if ( !br ) 
            {
                this.br = br ;
            }
            if ( !tr ) 
            {
                this.tr = tr ;
            }
            if ( !bl ) 
            {
                this.bl = bl ;
            }
        }
        
        /**
         * The bottom left flag value.
         */
        public var bl:Boolean = true ; 
        
        /**
         * The bottom right flag value.
         */
        public var br:Boolean = true ; 
        
        /**
         * The top left flag value.
         */
        public var tl:Boolean = true ; 
        
        /**
         * The top right flag value.
         */
        public var tr:Boolean = true ; 
        
        /**
         * Creates and returns a shallow copy of the object.
         * @return A new object that is a shallow copy of this instance.
         */
        public function clone():*
        {
            return new Corner( tl , tr , br , bl ) ;
        }
        
        /**
         * Compares the specified object with this object for equality.
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
         */
        public function equals( o:* ):Boolean
        {
            if ( o == this )
            {
                return true ;
            }
            else if ( o is Corner )
            {
                return tl == (o as Corner).tl && (o as Corner).tr == tr && (o as Corner).bl == bl && (o as Corner).br == br ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Returns a Eden representation of the object.
         * @return a string representation the source code of the object.
         */
        public function toSource( indent:int = 0 ):String  
        {
            var source:String = "new graphics.Corner(" ;
            source += tl == true ? "true" : "false" ;
            source += "," ;
            source += tr == true ? "true" : "false" ;
            source += "," ;
            source += br == true ? "true" : "false" ;
            source += "," ;
            source += bl == true ? "true" : "false" ;
            source += ")" ;
            return source ;
        }
        
        /**
         * Returns the string representation of this object.
         * @return the string representation of this object.
         */
        public function toString():String 
        {
            return "[Corner tl:" + tl + " tr:" + tr + " br:" + br  + " bl:" + bl + "]" ;
        }
    }
}
