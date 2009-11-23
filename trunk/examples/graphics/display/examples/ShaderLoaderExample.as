/*

  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is Vegas Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2009
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
*/

package examples 
{
    import graphics.display.ShaderLoader;

    import flash.display.Loader;
    import flash.display.Sprite;
    import flash.display.StageScaleMode;
    import flash.events.Event;
    import flash.filters.ShaderFilter;
    import flash.net.URLRequest;

    /**
     * Test the ShaderLoader class, this example work only with a FP10 or sup.
     */
    public class ShaderLoaderExample extends Sprite 
    {
        public function ShaderLoaderExample()
        {
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            
            picture = new Loader() ;
            picture.x = 20 ;
            picture.y = 20 ;
            
            picture.load( new URLRequest("library/picture.jpg") ) ;
            
            addChild( picture ) ;
            
            loader = new ShaderLoader() ;
            loader.load( new URLRequest( "pbj/RGBInvert.pbj" ) ) ;
            loader.addEventListener( Event.COMPLETE , complete ) ;
        }
        
        public var loader:ShaderLoader ;
        
        public var picture:Loader ;
        
        public function complete( e:Event ):void
        {
            picture.filters = [ new ShaderFilter( loader.shader ) ] ;
        }
    }
}
