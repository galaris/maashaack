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

package avmplus
{
    /* note:
       this class is not part of the Flash Platform API

       Because the avmglue can be used to mock parts of the FPAPI
       we need a "container" to be able to override system configurations and/or settings

       Also we need to be able to use native resolution for certain properties

       for ex:
       "hasAccessibility"
       if by default we have no native implementation
       we need a default config set to "false", but with the option
       to override it to "true" for mocks / tests / unit tests
       
       if later we do have a native implementation,
       we still need to be able to support the override mode
       for mocks / tests / unit tests

       based on the implementation in redtamarin 0.2.5
       (see http://code.google.com/p/redtamarin/source/browse/trunk/src/extensions/flash_system.as)
       for something as "locale" it could get even more complicated
       with C.stdlib.getenv
       getenv( "LC_ALL" ) or getenv( "LANG" )
       could allow a user to override the system settings with an environment variable
       
       so the logic would go like that
       if( override )
       {
         use override value
       }
       else if( getenv( "LC_ALL" ) or getenv( "LANG" ) )
       {
         use environment variable
       }
       else if( native getLocale() )
       {
         use locale found by the system
       }
       else
       {
         use default "xu" (for Other/Unknown)
       }

       scenarios:
       
       a) I want to test with avmglue as if I was
          - Flash Player 10 running in the browser
          - on an english system (en_GB)
          - on a Windows OS
          - etc.
          load a config file into the HostConfig
          and mark the config as "override"
          so even if  you run your tests on the command line
          with tamarin something like "Capabilities.hasMP3" will return "true"

       b) same as a) but here we want to run our tests
          only by overriding some environment variables like "LANG=en_GB"
          we need to be able to load a config file into the HostConfig
          and mark the config as "override"
          and mark some properties as "exception" (or "ignored")
          for ex: "language"
          something like "Capabilities.hasMP3" will return "true"
          but something like "Capabilities.language" will return the value from LANG
           if( override && !languageIgnore )
           {
             use override value
           }
           else
           {
             ...
           }
          
       c) I want to use avmglue to have identical ATS test media
          don't mark the HostConfig as override
          and the default or native implementation would be used
          something like "Capabilities.hasMP3" will return "false"
          - no MP3 capabilities natively implemented in redtamarin
          something like "Capabilities.language"
          will return either the environment variable if found
          or the locale found by the system natively
          etc.

       problems:
       now we just provide a very dumb implementation
       - what format to use for the config file ? eden ? json ? xml ?
       - be carefull of which properties can be overrided by environment variables
       - be carefull with api versioning andf config file
       - version: if we have api versioning do we allow to override ?
         if yes, then here an interesting use case
         I want to emulate FP 10.0.32.18 but api versioning set the API to CONFIG::FP_9_0
         - throw an error ?
         - set the default FP to 9.0.15.0 and ignore the override ?
       - serverString: should be dynamic only
       - isDebugger: allow the override ?
       etc.
    */
    public class HostConfig
    {
        /* TODO:
           - add override logic
        */

        
        //Capabilities
        private static var _isEmbeddedInAcrobat:Boolean;
        private static var _hasEmbeddedVideo:Boolean;
        private static var _hasAudio:Boolean;
        private static var _avHardwareDisable:Boolean;
        private static var _hasAccessibility:Boolean;
        private static var _hasAudioEncoder:Boolean;
        private static var _hasMP3:Boolean;
        private static var _hasPrinting:Boolean;
        private static var _hasScreenBroadcast:Boolean;
        private static var _hasScreenPlayback:Boolean;
        private static var _hasStreamingAudio:Boolean;
        private static var _hasStreamingVideo:Boolean;
        private static var _hasVideoEncoder:Boolean;
        private static var _isDebugger:Boolean;
        private static var _localFileReadDisable:Boolean;
        private static var _language:String;
        [API(CONFIG::AIR_1_5)] private static var _languages:Array;
        private static var _manufacturer:String;
        private static var _os:String;
        private static var _cpuArchitecture:String;
        private static var _playerType:String;
        private static var _serverString:String;
        private static var _version:String;
        private static var _screenColor:String;
        private static var _pixelAspectRatio:Number;
        private static var _screenDPI:Number;
        private static var _screenResolutionX:Number;
        private static var _screenResolutionY:Number;
        [API(CONFIG::FP_10_1,CONFIG::AIR_2_0)] private static var _touchscreenType:String;
        private static var _hasIME:Boolean;
        private static var _hasTLS:Boolean;
        private static var _maxLevelIDC:String;
        [API(CONFIG::FP_10_0_32,CONFIG::AIR_1_5_2)] private static var _supports32BitProcesses:Boolean;
        [API(CONFIG::FP_10_0_32,CONFIG::AIR_1_5_2)] private static var _supports64BitProcesses:Boolean;



        //Capabilities
        
        public static function get isEmbeddedInAcrobat():Boolean
        {
            return _isEmbeddedInAcrobat;
        }
        
        public static function set isEmbeddedInAcrobat( value:Boolean ):void
        {
            _isEmbeddedInAcrobat = value;
        }

        public static function get hasEmbeddedVideo():Boolean
        {
            return _hasEmbeddedVideo;
        }
        
        public static function set hasEmbeddedVideo( value:Boolean ):void
        {
            _hasEmbeddedVideo = value;
        }

        public static function get hasAudio():Boolean
        {
            return _hasAudio;
        }
        
        public static function set hasAudio( value:Boolean ):void
        {
            _hasAudio = value;
        }

        public static function get avHardwareDisable():Boolean
        {
            return _avHardwareDisable;
        }
        
        public static function set avHardwareDisable( value:Boolean ):void
        {
            _avHardwareDisable = value;
        }

        public static function get hasAccessibility():Boolean
        {
            return _hasAccessibility;
        }
        
        public static function set hasAccessibility( value:Boolean ):void
        {
            _hasAccessibility = value;
        }

        public static function get hasAudioEncoder():Boolean
        {
            return _hasAudioEncoder;
        }
        
        public static function set hasAudioEncoder( value:Boolean ):void
        {
            _hasAudioEncoder = value;
        }

        public static function get hasMP3():Boolean
        {
            return _hasMP3;
        }
        
        public static function set hasMP3( value:Boolean ):void
        {
            _hasMP3 = value;
        }

        public static function get hasPrinting():Boolean
        {
            return _hasPrinting;
        }
        
        public static function set hasPrinting( value:Boolean ):void
        {
            _hasPrinting = value;
        }

        public static function get hasScreenBroadcast():Boolean
        {
            return _hasScreenBroadcast;
        }
        
        public static function set hasScreenBroadcast( value:Boolean ):void
        {
            _hasScreenBroadcast = value;
        }

        public static function get hasScreenPlayback():Boolean
        {
            return _hasScreenPlayback;
        }
        
        public static function set hasScreenPlayback( value:Boolean ):void
        {
            _hasScreenPlayback = value;
        }

        public static function get hasStreamingAudio():Boolean
        {
            return _hasStreamingAudio;
        }
        
        public static function set hasStreamingAudio( value:Boolean ):void
        {
            _hasStreamingAudio = value;
        }

        public static function get hasStreamingVideo():Boolean
        {
            return _hasStreamingVideo;
        }
        
        public static function set hasStreamingVideo( value:Boolean ):void
        {
            _hasStreamingVideo = value;
        }

        public static function get hasVideoEncoder():Boolean
        {
            return _hasVideoEncoder;
        }
        
        public static function set hasVideoEncoder( value:Boolean ):void
        {
            _hasVideoEncoder = value;
        }

        public static function get isDebugger():Boolean
        {
            return _isDebugger;
        }
        
        public static function set isDebugger( value:Boolean ):void
        {
            _isDebugger = value;
        }

        public static function get localFileReadDisable():Boolean
        {
            return _localFileReadDisable;
        }
        
        public static function set localFileReadDisable( value:Boolean ):void
        {
            _localFileReadDisable = value;
        }

        public static function get language():String
        {
            return _language;
        }
        
        public static function set language( value:String ):void
        {
            _language = value;
        }

        [API(CONFIG::AIR_1_5)]
        public static function get languages():Array
        {
            return _languages;
        }

        [API(CONFIG::AIR_1_5)]
        public static function set languages( value:Array ):void
        {
            _languages = value;
        }

        public static function get manufacturer():String
        {
            return _manufacturer;
        }
        
        public static function set manufacturer( value:String ):void
        {
            _manufacturer = value;
        }

        public static function get os():String
        {
            return _os;
        }
        
        public static function set os( value:String ):void
        {
            _os = value;
        }

        public static function get cpuArchitecture():String
        {
            return _cpuArchitecture;
        }
        
        public static function set cpuArchitecture( value:String ):void
        {
            _cpuArchitecture = value;
        }

        public static function get playerType():String
        {
            return _playerType;
        }
        
        public static function set playerType( value:String ):void
        {
            _playerType = value;
        }

        public static function get serverString():String
        {
            return _serverString;
        }
        
        public static function set serverString( value:String ):void
        {
            _serverString = value;
        }

        public static function get version():String
        {
            return _version;
        }
        
        public static function set version( value:String ):void
        {
            _version = value;
        }

        public static function get screenColor():String
        {
            return _screenColor;
        }
        
        public static function set screenColor( value:String ):void
        {
            _screenColor = value;
        }

        public static function get pixelAspectRatio():Number
        {
            return _pixelAspectRatio;
        }
        
        public static function set pixelAspectRatio( value:Number ):void
        {
            _pixelAspectRatio = value;
        }

        public static function get screenDPI():Number
        {
            return _screenDPI;
        }
        
        public static function set screenDPI( value:Number ):void
        {
            _screenDPI = value;
        }

        public static function get screenResolutionX():Number
        {
            return _screenResolutionX;
        }
        
        public static function set screenResolutionX( value:Number ):void
        {
            _screenResolutionX = value;
        }

        public static function get screenResolutionY():Number
        {
            return _screenResolutionY;
        }
        
        public static function set screenResolutionY( value:Number ):void
        {
            _screenResolutionY = value;
        }

        [API(CONFIG::FP_10_1,CONFIG::AIR_2_0)]
        public static function get touchscreenType():String
        {
            return _touchscreenType;
        }

        [API(CONFIG::FP_10_1,CONFIG::AIR_2_0)]
        public static function set touchscreenType( value:String ):void
        {
            _touchscreenType = value;
        }

        public static function get hasIME():Boolean
        {
            return _hasIME;
        }
        
        public static function set hasIME( value:Boolean ):void
        {
            _hasIME = value;
        }

        public static function get hasTLS():Boolean
        {
            return _hasTLS;
        }
        
        public static function set hasTLS( value:Boolean ):void
        {
            _hasTLS = value;
        }

        public static function get maxLevelIDC():String
        {
            return _maxLevelIDC;
        }
        
        public static function set maxLevelIDC( value:String ):void
        {
            _maxLevelIDC = value;
        }

        [API(CONFIG::FP_10_0_32,CONFIG::AIR_1_5_2)]
        public static function get supports32BitProcesses():Boolean
        {
            return _supports32BitProcesses;
        }

        [API(CONFIG::FP_10_0_32,CONFIG::AIR_1_5_2)]
        public static function set supports32BitProcesses( value:Boolean ):void
        {
            _supports32BitProcesses = value;
        }

        [API(CONFIG::FP_10_0_32,CONFIG::AIR_1_5_2)]
        public static function get supports64BitProcesses():Boolean
        {
            return _supports64BitProcesses;
        }

        [API(CONFIG::FP_10_0_32,CONFIG::AIR_1_5_2)]
        public static function set supports64BitProcesses( value:Boolean ):void
        {
            _supports64BitProcesses = value;
        }

    }
}
