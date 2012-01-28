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
     * CMYK (short for cyan, magenta, yellow, and key (black), and often referred to as process color or four color) is a subtractive color model, used in color printing, also used to describe the printing process itself. 
     */
    public class CMYK extends CMY
    {
        
        use namespace hack ;
        
        /**
         * Creates a new CMYK instance.
         * @param c The cyan component, value between 0 and 1 (default 0).
         * @param m The magenta component, value between 0 and 1 (default 0).
         * @param y The yellow component, value between 0 and 1 (default 0). 
         * @param k The black component, value between 0 and 1 (default 0).
         */
        public function CMYK( c:Number = 0 , m:Number = 0 , y:Number = 0 , k:Number = 0 )
        {
            this.c = c ;
            this.m = m ;
            this.y = y ;
            this.k = k ;
        }
        
        /**
         * The black component (between 0 and 1)
         */
        public function get k():Number
        {
            return _k ;
        }
        
        /**
         * @private
         */
        public function set k( value:Number ):void
        {
            _k = clamp( isNaN(value) ? 0 : value , 0, 1 ) ;
        } 
        
        /**
         * Creates and returns a shallow copy of the object.
         * @return A new object that is a shallow copy of this instance.
         */
        public override function clone():* 
        {
            return new CMYK( _c , _m , _y, _k ) ;
        }
        
        /**
         * Transforms the cyan, magenta, yellow and black components of the color in this difference color representation.
         */
        public override function difference():void
        {
            super.difference() ;
            _k = 1 - _k ; 
        }
        
        /**
         * Compares the specified object with this object for equality.
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
         */
        public override function equals( o:* ):Boolean
        {
            if ( o == this )
            {
                return true ;
            }
            else if ( o is CMYK )
            {
                return ( (o as CMYK)._c == _c ) && ( (o as CMYK)._m == _m ) && ( (o as CMYK)._y == _y ) && ( (o as CMYK)._k == _k ) ;
            }
            else
            {
                return false ;
            }
        }
        
        /**
         * Interpolate the color and returns a new CMY object.
         * @param color The CMY reference used to interpolate the current CMY object.
         * @param level The level of the interpolation as a decimal, ﻿where <code>0</code> is the start and <code>1</code> is the end.
         * @return The new interpolate CMY reference.
         */
        public override function interpolate( color:CMY , level:Number = 1 ):CMY
        {
            var c:CMYK = color as CMYK ;
            if ( c == null )
            {
                return null ;
            }
            var p:Number = clamp( isNaN(level) ? 1 : level , 0 , 1) ;
            var q:Number = 1 - p ;
            return new CMYK
            (
                _c * q + c._c * p ,
                _m * q + c._m * p ,
                _y * q + c._y * p ,
                _k * q + c._k * p  
            ) ;
        }
        
        /**
         * Sets all cmyk components.
         * @param c The cyan component, value between 0 and 1 (default 0).
         * @param m The magenta component, value between 0 and 1 (default 0).
         * @param y The yellow component, value between 0 and 1 (default 0). 
         * @param k The black component, value between 0 and 1 (default 0).
         */
        public override function set( ...args:Array ):void
        {
            c = Number(args[0]) ;
            m = Number(args[1]) ;
            y = Number(args[2]) ;
            k = Number(args[3]) ;
        }
        
        /**
         * Converts an object to an equivalent Object value.
         * @return the Object representation of the instance.
         */
        public override function toObject():Object 
        {
            return { c:_c , m:_m , y:_y , k:_k } ;
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public override function toSource( indent:int = 0 ):String
        {
            return "new graphics.colors.CMYK(" + _c.toString() + "," + _m.toString() + "," + _y.toString() + "," + _k.toString() + ")" ; 
        }
        
        /**
         * Returns a String representation of the object.
         * @return a String representation of the object.
         */
        public override function toString():String
        {
            return "[CMYK c:" + _c + " m:" + _m + " y:" + _y + " k:" + _k + "]";
        }
        
        /**
         * @private
         */
        hack var _k:Number ;
    }
}
