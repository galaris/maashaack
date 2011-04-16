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

package flash.accessibility
{
    import flash.geom.Rectangle;
    
    /**
     * The AccessibilityImplementation class is the base class in Flash Player
     * that allows for the implementation of accessibility in components.
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 9
     * @playerversion AIR 2.0
     */
    [API(CONFIG::FP_9_0,CONFIG::AIR_2_0)]
    public class AccessibilityImplementation
    {
        [API(CONFIG::FP_9_0,CONFIG::AIR_2_0)] public var stub:Boolean;
        [API(CONFIG::FP_9_0,CONFIG::AIR_2_0)] public var errno:uint;

        public function AccessibilityImplementation()
        {
            CFG::dbg{ trace( "new AccessibilityImplementation()" ); }
            super();
            
            stub  = false;
            errno = 0;
        }

        [API(CONFIG::FP_9_0,CONFIG::AIR_2_0)]
        public function get_accRole( childID:uint ):uint
        {
            CFG::dbg{ trace( "AccessibilityImplementation.get_accRole( " + childID + " )" ); }
            Error.throwError( Error, 2143 );
            return null;
        }

        [API(CONFIG::FP_9_0,CONFIG::AIR_2_0)]
        public function get_accName( childID:uint ):String
        {
            CFG::dbg{ trace( "AccessibilityImplementation.get_accName( " + childID + " )" ); }
            return null;
        }

        [API(CONFIG::FP_9_0,CONFIG::AIR_2_0)]
        public function get_accValue( childID:uint ):String
        {
            CFG::dbg{ trace( "AccessibilityImplementation.get_accValue( " + childID + " )" ); }
            return null;
        }

        [API(CONFIG::FP_9_0,CONFIG::AIR_2_0)]
        public function get_accState( childID:uint ):uint
        {
            CFG::dbg{ trace( "AccessibilityImplementation.get_accState( " + childID + " )" ); }
            Error.throwError( Error, 2144 );
            return null;
        }

        [API(CONFIG::FP_9_0,CONFIG::AIR_2_0)]
        public function get_accDefaultAction( childID:uint ):String
        {
            CFG::dbg{ trace( "AccessibilityImplementation.get_accDefaultAction( " + childID + " )" ); }
            return null;
        }

        [API(CONFIG::FP_9_0,CONFIG::AIR_2_0)]
        public function accDoDefaultAction( childID:uint ):void
        {
            CFG::dbg{ trace( "AccessibilityImplementation.accDoDefaultAction( " + childID + " )" ); }
        }

        [API(CONFIG::FP_9_0,CONFIG::AIR_2_0)]
        public function isLabeledBy( labelBounds:Rectangle ):Boolean
        {
            CFG::dbg{ trace( "AccessibilityImplementation.isLabeledBy( " + labelBounds + " )" ); }
            return false;
        }

        [API(CONFIG::FP_9_0,CONFIG::AIR_2_0)]
        public function getChildIDArray():Array
        {
            CFG::dbg{ trace( "AccessibilityImplementation.getChildIDArray()" ); }
            return null;
        }

        [API(CONFIG::FP_9_0,CONFIG::AIR_2_0)]
        public function accLocation( childID:uint )
        {
            CFG::dbg{ trace( "AccessibilityImplementation.accLocation( " + childID + " )" ); }
            return null;
        }

        [API(CONFIG::FP_9_0,CONFIG::AIR_2_0)]
        public function get_accSelection():Array
        {
            CFG::dbg{ trace( "AccessibilityImplementation.get_accSelection()" ); }
            return null;
        }

        [API(CONFIG::FP_9_0,CONFIG::AIR_2_0)]
        public function get_accFocus():uint
        {
            CFG::dbg{ trace( "AccessibilityImplementation.get_accFocus()" ); }
            return 0;
        }

        [API(CONFIG::FP_9_0,CONFIG::AIR_2_0)]
        public function accSelect( operation:uint, childID:uint ):void
        {
            CFG::dbg{ trace( "AccessibilityImplementation.accSelect( " + [operation,childID].join(", ") + " )" ); }
        }
        
    }
}
