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
     * A collection of drawing commands and the coordinate parameters for those commands.
     * Use a GraphicsPath object with the <code>Graphics.drawGraphicsData()</code> method.
     * Drawing a GraphicsPath object is the equivalent of calling the <code>Graphics.drawPath()</code> method.
     * 
     * The GraphicsPath class also has its own set of methods (<code>curveTo()</code>, <code>lineTo()</code>,
     * <code>moveTo()</code>, <code>wideLineTo()</code> and <code>wideMoveTo()</code>) similar to those in the
     * Graphics class for making adjustments to the <code>GraphicsPath.commands</code>
     * and <code>GraphicsPath.data</code> vector arrays.
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 10
     * @playerversion AIR 1.5
     */
    [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
    public final class GraphicsPath implements IGraphicsPath, IGraphicsData
    {
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)] public var commands:Vector.<int>;
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)] public var data:Vector.<Number>;
        
        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)] private var _winding:String;

        public function GraphicsPath( commands:Vector.<int> = null, data:Vector.<Number> = null,
                                      winding:String = "evenOdd" )
        {
            CFG::dbg{ trace( "new GraphicsPath( " + [commands,data,winding].join(", ") + " )" ); }
            super();
            this.commands = commands;
            this.data     = data;

            if( !(winding == GraphicsPathWinding.EVEN_ODD) && !(winding == GraphicsPathWinding.NON_ZERO) )
            {
                Error.throwError( ArgumentError, 2008, "winding" );
            }
            _winding = winding;
        }

        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function get winding():String
        {
            CFG::dbg{ trace( "GraphicsPath.get winding()" ); }
            return _winding;
        }

        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function set winding( value:String ):void
        {
            CFG::dbg{ trace( "GraphicsPath.set winding( " + value + " )" ); }
            if( !(value == GraphicsPathWinding.EVEN_ODD) && !(value == GraphicsPathWinding.NON_ZERO) )
            {
                Error.throwError( ArgumentError, 2008, "winding" );
            }
            _winding = value;
        }

        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function moveTo( x:Number, y:Number ):void
        {
            CFG::dbg{ trace( "GraphicsPath.moveTo( " + [x,y].join(", ") + " )" ); }
            if( commands == null ) { commands = new Vector.<int>(); }

            if( data == null ) { data = new Vector.<Number>(); }

            commands.push( GraphicsPathCommand.MOVE_TO );
            data.push( x, y );
        }

        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function lineTo( x:Number, y:Number ):void
        {
            CFG::dbg{ trace( "GraphicsPath.lineTo( " + [x,y].join(", ") + " )" ); }
            if( commands == null ) { commands = new Vector.<int>(); }

            if( data == null ) { data = new Vector.<Number>(); }

            commands.push( GraphicsPathCommand.LINE_TO );
            data.push( x, y );
        }

        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function curveTo( controlX:Number, controlY:Number, anchorX:Number, anchorY:Number ):void
        {
            CFG::dbg{ trace( "GraphicsPath.curveTo( " + [controlX,controlY,anchorX,anchorY].join(", ") + " )" ); }
            if( commands == null ) { commands = new Vector.<int>(); }

            if( data == null ) { data = new Vector.<Number>(); }

            commands.push( GraphicsPathCommand.CURVE_TO );
            data.push( controlX, controlY, anchorX, anchorY );
        }

        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function wideLineTo( x:Number, y:Number ):void
        {
            CFG::dbg{ trace( "GraphicsPath.wideLineTo( " + [x,y].join(", ") + " )" ); }
            if( commands == null ) { commands = new Vector.<int>(); }

            if( data == null ) { data = new Vector.<Number>(); }

            commands.push( GraphicsPathCommand.WIDE_LINE_TO );
            data.push( 0, 0, x, y );
        }

        [API(CONFIG::FP_10_0,CONFIG::AIR_1_5)]
        public function wideMoveTo( x:Number, y:Number ):void
        {
            CFG::dbg{ trace( "GraphicsPath.wideMoveTo( " + [x,y].join(", ") + " )" ); }
            if( commands == null ) { commands = new Vector.<int>(); }

            if( data == null ) { data = new Vector.<Number>(); }

            commands.push( GraphicsPathCommand.WIDE_MOVE_TO );
            data.push( 0, 0, x, y );
        }
    }
}
