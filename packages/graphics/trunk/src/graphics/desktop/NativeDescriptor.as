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

package graphics.desktop
{
    import flash.desktop.NativeApplication;
    
    import flash.system.Capabilities;
    import system.data.SimpleValueObject;
    
    /**
     * The information object of the NativeApplication reference.
     */
    public class NativeDescriptor extends SimpleValueObject
    {
        /**
         * Creates a new NativeDescriptor instance.
         */
        public function NativeDescriptor()
        {
           var na:NativeApplication = NativeApplication.nativeApplication;
           
           if( na )
           {
                this.id = na.applicationID ;
                
                var ad:XML = na.applicationDescriptor;
                if( ad )
                {
                    var ns:Namespace = ad.namespace() ;
                    if ( ns )
                    {
                        _copyright     = ad.ns::copyright ;
                        _description   = ad.ns::description ;
                        _filename      = ad.ns::description ;
                        _versionNumber = ad.ns::versionNumber ;
                        _versionLabel  = ad.ns::versionLabel ;
                        
                        //// initialWindow
                        
                        var window:XMLList = ad.ns::initialWindow as XMLList;
                        
                        if( window )
                        {
                            _content      = window.ns::content ;
                            _title        = window.ns::title ;
                            
                            _width        = Number( window.ns::width ) ;
                            _height       = Number( window.ns::height ) ;
                            
                            _aspectRatio  = window.ns::aspectRatio ;
                            _renderMode   = window.ns::renderMode ;
                            _systemChrome = window.ns::systemChrome ;
                            
                            _autoOrients  = window.ns::autoOrients == "true" ;
                            _fullScreen   = window.ns::fullScreen  == "true" ;
                            _resizable    = window.ns::resizable   == "true" ;
                            _maximizable  = window.ns::maximizable == "true" ;
                            _minimizable  = window.ns::minimizable == "true" ;
                            _transparent  = window.ns::transparent == "true" ;
                            _visible      = window.ns::visible     == "true" ;
                        }
                    }
               }
            }
        }
        
        /**
         * Indicates if the native application aspectRatio value.
         */
        public function get aspectRatio():String
        {
            return _aspectRatio ;
        }
        
        /**
         * Indicates if the native application is set with a autoOrients mode.
         */
        public function get autoOrients():Boolean
        {
            return _autoOrients ;
        }
        
        /**
         * Indicates if the NativeDescriptor is available.
         */
        public function get available():Boolean
        {
            return NativeApplication.nativeApplication != null ;
        }
        
        /**
         * Indicates if the native application content value.
         */
        public function get content():String
        {
            return _content ;
        }
        
        /**
         * The copyright of the native application.
         */
        public function get copyright():String
        {
            return _copyright ;
        }
        
        /**
         * The description of the native application.
         */
        public function get description():String
        {
            return _description;
        }
        
        /**
         * Indicates the device type of the native desktop application.
         * @see com.agccpf.mobile.desktop.DeviceType
         */
        public function get device():String
        {
            const playerType:String = Capabilities.playerType ;
            
            if( playerType == PlayerType.desktop )
            {
                const manufacturer:String = Capabilities.manufacturer ;
                const os:String = Capabilities.os ;
                
                if( manufacturer == "Adobe iOS" )
                {
                    if( os.indexOf( "iPad" ) > -1 ) 
                    { 
                        return DeviceType.ipad ; 
                    }
                    else if( os.indexOf( "iPod" ) > -1 )
                    {
                        return DeviceType.ipod ;
                    }
                    else if( os.indexOf( "iPhone" ) > -1 ) 
                    { 
                        return DeviceType.iphone ; 
                    }
                    else
                    {
                        return DeviceType.unknow ;
                    }
                }
                else if( manufacturer == "Android Linux" )
                {
                    return DeviceType.android ;
                }
                else if ( manufacturer == "Adobe Windows" || manufacturer == "Adobe Macintosh" || manufacturer == "Adobe Linux" )
                {
                    return DeviceType.desktop ;
                }
                else if ( manufacturer.indexOf("Winchester") > -1 ) // BlackBerry PlayBook Tablet.
                {
                    return DeviceType.playbook ; // not tested yet !!
                }
                else if( manufacturer.indexOf( "VMware") > -1 ) // BlackBerry PlayBook Simulator.
                {
                    return DeviceType.simulator ;
                }
                else
                {
                    return DeviceType.unknow ;
                }
            }
            else
            {
                return DeviceType.unknow ;
            }
        }
        
        /**
         * The filename of the native application.
         */
        public function get filename():String
        {
            return _filename;
        }
        
        /**
         * Indicates if the native application is set with a fullScreen mode.
         */
        public function get fullScreen():Boolean
        {
            return _fullScreen ;
        }
        
        /**
         * The window's initial height.
         */
        public function get height():Number
        {
            return _height ;
        }
        
        /**
         * Indicates if the device of the application is based on the Google Android technology.
         */
        public function isAndroid():Boolean
        {
            return device == DeviceType.android ;
        }
        
        /**
         * Indicates if the device of the application is based on the Apple iOS technology.
         */
        public function isIOS():Boolean
        {
            const dev:String = device ;
            return (dev == DeviceType.ipad) || (dev == DeviceType.ipod) || (dev == DeviceType.iphone) ;
        }
        
        /**
         * Indicates if the native application is maximizable.
         */
        public function get maximizable():Boolean
        {
            return _maximizable ;
        }
        
        /**
         * Indicates if the native application is minimizable.
         */
        public function get minimizable():Boolean
        {
            return _minimizable ;
        }
        
        /**
         * Indicates if the native application renderMode.
         */
        public function get renderMode():String
        {
            return _renderMode ;
        }
        
        /**
         * Indicates if the native application is set with a resizable mode.
         */
        public function get resizable():Boolean
        {
            return _resizable ;
        }
        
        /**
         * Indicates if the native application systemChrome value.
         */
        public function get systemChrome():String
        {
            return _systemChrome ;
        }
        
        /**
         * Indicates if the native application title.
         */
        public function get title():String
        {
            return _title ;
        }
        
        /**
         * Indicates if the native application is transparent.
         */
        public function get transparent():Boolean
        {
            return _transparent ;
        }
        
        /**
         * Indicates if the native application versionLabel.
         */
        public function get versionLabel():String
        {
            return _versionLabel ;
        }
        
        /**
         * Indicates if the native application versionNumber.
         */
        public function get versionNumber():String
        {
            return _versionNumber ;
        }
        
        /**
         * The window's initial width.
         */
        public function get width():Number
        {
            return _width ;
        }
        
        /**
         * Returns the generic object of this value object.
         * @return the generic object of this value object.
         */
        public override function toObject():Object
        {
            var object:Object =
            {
                // informations
                
                avalaible:available,
                device:device,
                
                // main informations
                
                id:id,
                description:_description,
                copyright:_copyright,
                filename:_filename,
                
                // initialWindow
                
                content:_content,
                title:_title,
                
                width:_width ,
                height:_height,
                
                aspectRatio:_aspectRatio,
                renderMode:_renderMode,
                systemChrome:_systemChrome,
                
                autoOrients:_autoOrients,
                fullScreen:_fullScreen,
                resizable:_resizable,
                maximizable:_maximizable,
                minimizable:_minimizable,
                transparent:_transparent,
                visible:_visible,
                
                versionLabel:_versionLabel,
                versionNumber:_versionNumber
            };
            return object ;
        }
        
        /**
         * @private
         */
        private var _aspectRatio:String ;
        
        /**
         * @private
         */
        private var _autoOrients:Boolean ;
        
        /**
         * @private
         */
        private var _content:String ;
        
        /**
         * @private
         */
        private var _copyright:String ;
        
        /**
         * @private
         */
        private var _description:String ;
        
        /**
         * @private
         */
        private var _filename:String ;
        
        /**
         * @private
         */
        private var _fullScreen:Boolean ;
        
        /**
         * @private
         */
        private var _height:Number ;
        
        /**
         * @private
         */
        private var _maximizable:Boolean ;
        
        /**
         * @private
         */
        private var _minimizable:Boolean ;
        
        /**
         * @private
         */
        private var _renderMode:String ;
        
        /**
         * @private
         */
        private var _resizable:Boolean ;
        
        /**
         * @private
         */
        private var _systemChrome:String ;
        
        /**
         * @private
         */
        private var _title:String ;
        
        /**
         * @private
         */
        private var _transparent:Boolean ;
        
        /**
         * @private
         */
        private var _versionLabel:String ;
        
        /**
         * @private
         */
        private var _versionNumber:String ;
        
        /**
         * @private
         */
        private var _visible:Boolean ;
        
        /**
         * @private
         */
        private var _width:Number ;
    }
}
