/* -*- c-basic-offset: 4; indent-tabs-mode: nil; tab-width: 4 -*- */
/* vi: set ts=4 sw=4 expandtab: (add to ~/.vimrc: set modeline modelines=5) */
/* ***** BEGIN LICENSE BLOCK *****
 * Version: MPL 1.1/GPL 2.0/LGPL 2.1
 *
 * The contents of this file are subject to the Mozilla Public License Version
 * 1.1 (the "License"); you may not use this file except in compliance with
 * the License. You may obtain a copy of the License at
 * http://www.mozilla.org/MPL/
 *
 * Software distributed under the License is distributed on an "AS IS" basis,
 * WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
 * for the specific language governing rights and limitations under the
 * License.
 *
 * The Original Code is [Open Source Virtual Machine.].
 *
 * The Initial Developer of the Original Code is
 * Adobe System Incorporated.
 * Portions created by the Initial Developer are Copyright (C) 2004-2006
 * the Initial Developer. All Rights Reserved.
 *
 * Contributor(s):
 *   Adobe AS3 Team
 *   Zwetan Kjukov <zwetan@gmail.com>.
 *
 * Alternatively, the contents of this file may be used under the terms of
 * either the GNU General Public License Version 2 or later (the "GPL"), or
 * the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
 * in which case the provisions of the GPL or the LGPL are applicable instead
 * of those above. If you wish to allow use of your version of this file only
 * under the terms of either the GPL or the LGPL, and not to allow others to
 * use your version of this file under the terms of the MPL, indicate your
 * decision by deleting the provisions above and replace them with the notice
 * and other provisions required by the GPL or the LGPL. If you do not delete
 * the provisions above, a recipient may use your version of this file under
 * the terms of any one of the MPL, the GPL or the LGPL.
 *
 * ***** END LICENSE BLOCK ***** */

package flash.display
{
    import __AS3__.vec.*;
    
    /**
     * Defines an ordered set of triangles that can be rendered using either (u,v) fill coordinates or a normal fill.
     * Each triangle in the path is represented by three sets of (x, y) coordinates,
     * each of which is one point of the triangle.
     *
     * The triangle vertices do not contain z coordinates and do not necessarily represent 3D faces.
     * However a triangle path can be used to support the rendering of 3D geometry in a 2D space.
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 10
     * @playerversion AIR 1.5
     */
    [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
    public final class GraphicsTrianglePath implements IGraphicsPath, IGraphicsData
    {
        private var _culling:String;
        
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)] public var indices:Vector.<int>;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)] public var vertices:Vector.<Number>;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)] public var uvtData:Vector.<Number>;
        
        public function GraphicsTrianglePath(vertices:Vector.<Number>=null, indices:Vector.<int>=null, uvtData:Vector.<Number>=null, culling:String="none")
        {
            CFG::dbg{ trace( "new GraphicsTrianglePath( " + [vertices,indices.uvtData,culling].join(", ") + " )" ); }
            super();

            _culling = culling;
            
            this.vertices = vertices;
            this.indices  = indices;
            this.uvtData  = uvtData;
            
            if( !(_culling == TriangleCulling.NONE) &&
                !(_culling == TriangleCulling.POSITIVE) &&
                !(_culling == TriangleCulling.NEGATIVE) )
            {
                Error.throwError( ArgumentError, 2008, "culling" );
            }
        }

        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function get culling():String
        {
            CFG::dbg{ trace( "GraphicsTrianglePath.get culling()" ); }
            return _culling;
        }

        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]        
        public function set culling( value:String ):void
        {
            CFG::dbg{ trace( "GraphicsTrianglePath.set culling( " + value + " )" ); }
            if( !(value == TriangleCulling.NONE) &&
                !(value == TriangleCulling.POSITIVE) &&
                !(value == TriangleCulling.NEGATIVE) )
            {
                Error.throwError( ArgumentError, 2008, "culling" );
            }
            
            _culling = value;
        }
    }
}
