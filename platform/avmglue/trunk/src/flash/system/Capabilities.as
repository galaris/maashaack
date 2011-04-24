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

package flash.system
{
    import avmplus.System;
    
    /**
     * The Capabilities class provides properties that describe the system and runtime that
     * are hosting the application.
     * For example, a mobile phone's screen might be 100 square pixels, black and white,
     * whereas a PC screen might be 1000 square pixels, color.
     * 
     * @langversion ActionScript 3.0
     * @playerversion Flash Player 9
     * @playerversion AIR 1.0
     */
    public final class Capabilities
    {
        public function Capabilities()
        {
        }
        
        //public static native function get isEmbeddedInAcrobat():Boolean;
        //  Flash Player 9.0.127.0, AIR 1.1
        [API(CONFIG::FP_9_0,CONFIG::AIR_1_5)]
        public static function get isEmbeddedInAcrobat():Boolean
        {
            CFG::dbg{ trace( "Capabilities.get isEmbeddedInAcrobat()" ); }
            return avmplus.System.profile.isEmbeddedInAcrobat;
        }

        //public static native function get hasEmbeddedVideo():Boolean;
        public static function get hasEmbeddedVideo():Boolean
        {
            CFG::dbg{ trace( "Capabilities.get hasEmbeddedVideo()" ); }
            return avmplus.System.profile.hasEmbeddedVideo;
        }

        //public static native function get hasAudio():Boolean;
        public static function get hasAudio():Boolean
        {
            CFG::dbg{ trace( "Capabilities.get hasAudio()" ); }
            return avmplus.System.profile.hasAudio;
        }

        //public static native function get avHardwareDisable():Boolean;
        public static function get avHardwareDisable():Boolean
        {
            CFG::dbg{ trace( "Capabilities.get avHardwareDisable()" ); }
            return avmplus.System.profile.avHardwareDisable;
        }

        //public static native function get hasAccessibility():Boolean;
        public static function get hasAccessibility():Boolean
        {
            CFG::dbg{ trace( "Capabilities.get hasAccessibility()" ); }
            return avmplus.System.profile.hasAccessibility;
        }

        //public static native function get hasAudioEncoder():Boolean;
        public static function get hasAudioEncoder():Boolean
        {
            CFG::dbg{ trace( "Capabilities.get hasAudioEncoder()" ); }
            return avmplus.System.profile.hasAudioEncoder;
        }

        //public static native function get hasMP3():Boolean;
        public static function get hasMP3():Boolean
        {
            CFG::dbg{ trace( "Capabilities.get hasMP3()" ); }
            return avmplus.System.profile.hasMP3;
        }

        //public static native function get hasPrinting():Boolean;
        public static function get hasPrinting():Boolean
        {
            CFG::dbg{ trace( "Capabilities.get hasPrinting()" ); }
            return avmplus.System.profile.hasPrinting;
        }

        //public static native function get hasScreenBroadcast():Boolean;
        public static function get hasScreenBroadcast():Boolean
        {
            CFG::dbg{ trace( "Capabilities.get hasScreenBroadcast()" ); }
            return avmplus.System.profile.hasScreenBroadcast;
        }

        //public static native function get hasScreenPlayback():Boolean;
        public static function get hasScreenPlayback():Boolean
        {
            CFG::dbg{ trace( "Capabilities.get hasScreenPlayback()" ); }
            return avmplus.System.profile.hasScreenPlayback;
        }

        //public static native function get hasStreamingAudio():Boolean;
        public static function get hasStreamingAudio():Boolean
        {
            CFG::dbg{ trace( "Capabilities.get hasStreamingAudio()" ); }
            return avmplus.System.profile.hasStreamingAudio;
        }

        //public static native function get hasStreamingVideo():Boolean;
        public static function get hasStreamingVideo():Boolean
        {
            CFG::dbg{ trace( "Capabilities.get hasStreamingVideo()" ); }
            return avmplus.System.profile.hasStreamingVideo;
        }

        //public static native function get hasVideoEncoder():Boolean;
        public static function get hasVideoEncoder():Boolean
        {
            CFG::dbg{ trace( "Capabilities.get hasVideoEncoder()" ); }
            return avmplus.System.profile.hasVideoEncoder;
        }

        //public static native function get isDebugger():Boolean;
        public static function get isDebugger():Boolean
        {
            CFG::dbg{ trace( "Capabilities.get isDebugger()" ); }
            return avmplus.System.profile.isDebugger;
        }

        //public static native function get localFileReadDisable():Boolean;
        public static function get localFileReadDisable():Boolean
        {
            CFG::dbg{ trace( "Capabilities.get localFileReadDisable()" ); }
            return avmplus.System.profile.localFileReadDisable;
        }

        //public static native function get language():String;
        public static function get language():String
        {
            CFG::dbg{ trace( "Capabilities.get language()" ); }
            return avmplus.System.profile.language;
        }

        /* note:
           the feature appears in AIR 1.1
           but api versioning does not have AIR_1_1
           so we resolve to the closer version AIR_1_5
        */
        //public static native function get languages():Array;
        [API(CONFIG::AIR_1_5)]
        public static function get languages():Array
        {
            CFG::dbg{ trace( "Capabilities.get languages()" ); }
            return avmplus.System.profile.languages;
        }

        //public static native function get manufacturer():String;
        public static function get manufacturer():String
        {
            CFG::dbg{ trace( "Capabilities.get manufacturer()" ); }
            return avmplus.System.profile.manufacturer;
        }

        //public static native function get os():String;
        public static function get os():String
        {
            CFG::dbg{ trace( "Capabilities.get os()" ); }
            return avmplus.System.profile.os;
        }

        //public static native function get cpuArchitecture():String;
        public static function get cpuArchitecture():String
        {
            CFG::dbg{ trace( "Capabilities.get cpuArchitecture()" ); }
            return avmplus.System.profile.cpuArchitecture;
        }

        //public static native function get playerType():String;
        public static function get playerType():String
        {
            CFG::dbg{ trace( "Capabilities.get playerType()" ); }
            return avmplus.System.profile.playerType;
        }

        //public static native function get serverString():String;
        public static function get serverString():String
        {
            CFG::dbg{ trace( "Capabilities.get serverString()" ); }
            return avmplus.System.profile.serverString;
        }

        //public static native function get version():String;
        public static function get version():String
        {
            CFG::dbg{ trace( "Capabilities.get version()" ); }
            return avmplus.System.profile.version;
        }

        //public static native function get screenColor():String;
        public static function get screenColor():String
        {
            CFG::dbg{ trace( "Capabilities.get screenColor()" ); }
            return avmplus.System.profile.screenColor;
        }

        //public static native function get pixelAspectRatio():Number;
        public static function get pixelAspectRatio():Number
        {
            CFG::dbg{ trace( "Capabilities.get pixelAspectRatio()" ); }
            return avmplus.System.profile.pixelAspectRatio;
        }

        //public static native function get screenDPI():Number;
        public static function get screenDPI():Number
        {
            CFG::dbg{ trace( "Capabilities.get screenDPI()" ); }
            return avmplus.System.profile.screenDPI;
        }

        //public static native function get screenResolutionX():Number;
        public static function get screenResolutionX():Number
        {
            CFG::dbg{ trace( "Capabilities.get screenResolutionX()" ); }
            return avmplus.System.profile.screenResolutionX;
        }

        //public static native function get screenResolutionY():Number;
        public static function get screenResolutionY():Number
        {
            CFG::dbg{ trace( "Capabilities.get screenResolutionY()" ); }
            return avmplus.System.profile.screenResolutionY;
        }

        //public static native function get touchscreenType():String;
        [API(CONFIG::FP_10_1,CONFIG::AIR_2_0)]
        public static function get touchscreenType():String
        {
            CFG::dbg{ trace( "Capabilities.get touchscreenType()" ); }
            return avmplus.System.profile.touchscreenType;
        }

        //public static native function get hasIME():Boolean;
        public static function get hasIME():Boolean
        {
            CFG::dbg{ trace( "Capabilities.get hasIME()" ); }
            return avmplus.System.profile.hasIME;
        }

        //public static native function get hasTLS():Boolean;
        public static function get hasTLS():Boolean
        {
            CFG::dbg{ trace( "Capabilities.get hasTLS()" ); }
            return avmplus.System.profile.hasTLS;
        }

        //public static native function get maxLevelIDC():String;
        public static function get maxLevelIDC():String
        {
            CFG::dbg{ trace( "Capabilities.get maxLevelIDC()" ); }
            return avmplus.System.profile.maxLevelIDC;
        }

        //public static native function get supports32BitProcesses():Boolean;
        [API(CONFIG::FP_10_0_32,CONFIG::AIR_1_5_2)]
        public static function get supports32BitProcesses():Boolean
        {
            CFG::dbg{ trace( "Capabilities.get supports32BitProcesses()" ); }
            return avmplus.System.profile.supports32BitProcesses;
        }

        //public static native function get supports64BitProcesses():Boolean;
        [API(CONFIG::FP_10_0_32,CONFIG::AIR_1_5_2)]
        public static function get supports64BitProcesses():Boolean
        {
            CFG::dbg{ trace( "Capabilities.get supports64BitProcesses()" ); }
            return avmplus.System.profile.supports64BitProcesses;
        }

        /* note:
           not sure what this is, need to investigate
        */
        //public static native function get _internal():uint;
        public static function get _internal():uint
        {
            return 0;
        }

    }
}