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

package graphics.colors 
{
    import core.maths.clamp;
    
    import system.hack;
    
    /**
     * The XYZ color system, also called “norm color system”. 
     * It is superset of the RGB color system.  
     * It uses tristimulus values when encoding. 
     * X, Y and Z are all calculated through color-matching functions and are always positive. 
     * It was a system created by CIE.
     */
    public class XYZ implements ColorSpace
    {
        use namespace hack ;
        
        /**
         * Creates a new XYZ instance.
         * @param x The x component.
         * @param y The y component.
         * @param z The z component. 
         */
        public function XYZ( x:Number = 0 , y:Number = 0 , z:Number = 0 )
        {
            X = x ;
            Y = y ;
            Z = z ;
        }
        
        /**
         * The X component.
         */
        public function get X():Number
        {
            return _x ;
        }
        
        /**
         * @private
         */
        public function set X( value:Number ):void
        {
            _x = isNaN(value) ? 0 : value ;
        } 
        
        /**
         * The Y component.
         */        
        public function get Y():Number
        {
            return _y ;
        }
        
        /**
         * @private
         */
        public function set Y( value:Number ):void
        {
            _y = isNaN(value) ? 0 : value ;
        }
        
        /**
         * The Z component.
         */
        public function get Z():Number
        {
            return _z ;
        }

        /**
         * @private
         */
        public function set Z( value:Number ):void
        {
            _z = isNaN(value) ? 0 : value ;
        }
        
        /**
         * Creates and returns a shallow copy of the object.
         * @return A new object that is a shallow copy of this instance.
         */    
        public function clone():* 
        {
            return new XYZ( _x , _y , _z ) ;
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
            else if ( o is XYZ )
            {
                return ( (o as XYZ)._x == _x ) && ( (o as XYZ)._y == _y ) && ( (o as XYZ)._z == _z ) ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Interpolate the color and returns a new XYZ object.
         * @param color The XYZ reference used to interpolate the current XYZ object.
         * @param level The level of the interpolation as a decimal, ﻿where <code>0</code> is the start and <code>1</code> is the end.
         * @return The interpolate XYZ result of the specified color.
         */
        public function interpolate( color:XYZ , level:Number = 1 ):XYZ
        {
            var p:Number = clamp( isNaN(level) ? 1 : level , 0 , 1) ;
            var q:Number = 1 - p ;
            return new XYZ
            (
                _x * q + color._x * p ,
                _y * q + color._y * p ,
                _z * q + color._z * p  
            ) ;
        }
        
        /**
         * Sets all tree components of a color. 
         */
        public function set( ...args:Array ):void
        {
            X = Number(args[0]) ;
            Y = Number(args[1]) ;
            Z = Number(args[2]) ;
        }
        
        /**
         * Converts an object to an equivalent Object value.
         * @return the Object representation of the instance.
         */
        public function toObject():Object 
        {
            return { X:_x , Y:_y , Z:_z } ;
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource( indent:int = 0 ):String
        {
            return "new graphics.colors.XYZ(" + _x.toString() + "," + _y.toString() + "," + _z.toString() + ")" ; 
        }
        
        /**
         * Returns a String representation of the object.
         * @return a String representation of the object.
         */
        public function toString():String
        {
            return "[XYZ X:" + _x + " Y:" + _y + " Z:" + _z + "]";
        }
        
        /**
         * @private
         */
        hack var _x:Number ;
        
        /**
         * @private
         */
        hack var _y:Number ;
        
        /**
         * @private
         */
        hack var _z:Number ;
    }
}
