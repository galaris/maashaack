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
    /**
     * A class that provides constant values for visual blend mode effects.
     * These constants are used in the following:
     * <ul>
     * <li>The <code>blendMode</code> property of the <code>flash.display.DisplayObject</code> class.</li>
     * <li>The <code>blendMode</code> parameter of the <code>draw()</code> method of the <code>flash.display.BitmapData</code> class
     * </ul>
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 9
     * @playerversion AIR 1.0
     */
    public final class BlendMode
    {
        public static const NORMAL:String     = "normal";
        public static const LAYER:String      = "layer";
        public static const MULTIPLY:String   = "multiply";
        public static const SCREEN:String     = "screen";
        public static const LIGHTEN:String    = "lighten";
        public static const DARKEN:String     = "darken";
        public static const ADD:String        = "add";
        public static const SUBTRACT:String   = "subtract";
        public static const DIFFERENCE:String = "difference";
        public static const INVERT:String     = "invert";
        public static const OVERLAY:String    = "overlay";
        public static const HARDLIGHT:String  = "hardlight";
        public static const ALPHA:String      = "alpha";
        public static const ERASE:String      = "erase";
        public static const SHADER:String     = "shader";
    }
}
