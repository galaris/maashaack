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
    /**
     * Static tool class to manipulate and transform <code class="prettyprint">Plane</code> references.
     */
    public class Planes 
    {
        /**
         * Returns the Plane reference defines by the specified object with the properties a, b, c and d.
         * <p><b>Example :</b></p>
         * <code class="prettyprint">
         * import graphics.geom.Plane ;
         * import graphics.util.PlaneUtil ;
         * 
         * var p:Plane = PlaneUtil.getPlaneByObject( { a:10 , b:10 , c:100 , d:100 } ) ;
         * trace(p) ; // [Plane:{10,10,100,100}]
         * </code>
         * @return the Plane reference defines by the specified object with the properties a, b, c and d.
         */
        public static function getPlaneByObject( o:Object ):Plane
        {
            return new Plane( o.a, o.b, o.c, o.d ) ;
        } 
        
        /**
         * Returns the Plane reference defines by the specified object with the two vectors in argument.
         * <p><b>Example :</b></p>
         * <code class="prettyprint">
         * import graphics.geom.Plane ;
         * import graphics.geom.Vector2 ;
         * import graphics.util.PlaneUtil ;
          * 
         * var v1:Vector2 = new Vector2(10,10) ;
         * var v2:Vector2 = new Vector2(100,100) ;
         * var p:Plane = PlaneUtil.getPlaneByVector( v1, v2 ) ;
         * trace(p) ; // [Plane:{10,10,100,100}]
         * </code>
          * @return the Plane reference defines by the specified object with the two vectors in argument.
         */
        public static function getPlaneByVector( v1:Vector2 , v2:Vector2 ):Plane
        {
            return new Plane( v1.x, v1.y, v2.x, v2.y ) ;
        } 
        
    }
}

// TODO crossPoint see http://gotoandplay.it/_articles/2005/01/ppbr3d.php
// TODO project
// TODO normal
// TODO xpar
// TODO ypar
