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
  
  The Original Code is [flashdoc].
  
  The Initial Developers of the Original Code are
  Zwetan Kjukov <zwetan@gmail.com> and Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developers are Copyright (C) 2006-2010
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

package flashdoc
{
    import C.stdlib.*;
    import avmplus.File;
    import avmplus.System;
    import flash.system.Capabilities;
    
    public class Application
    {
        
        private var _options:Options;
        
        public var verbose:Boolean = false;
        
        
        public var flash_doc_root:XML =
        <toolbox>
            <actionspanel>
            </actionspanel>
            <codehints>
            </codehints>
            <colorsyntax>
            </colorsyntax>
        </toolbox>
        
        
        public function Application()
        {
            _options = new Options( this );
        }
        
        private function _readFile( filename:String ):String
        {
            if( verbose )
            {
                trace( "reading file: " + filename );
            }
            
            return File.read( filename );
        }
        
        private function _writeFile( filename:String, data:String ):void
        {
            if( verbose )
            {
                trace( "writing file: " + filename );
            }
            
            File.write( filename, data );
        }
        
        private function _makeDirectory( name:String ):void
        {
            
            if( !File.exists( name ) )
            {
                if( verbose )
                {
                    trace( "creating directory: " + name );
                }
                
                System.exec( "mkdir " + name );
            }
            else
            {
                if( verbose )
                {
                    trace( "we don't create directory: " + name + " as it already exists" );
                }
            }
            
            /*
            switch( Capabilities.os )
            {
                case "Windows":
                System.exec( "mkdir " + name );
                break;
                
                case "Macintosh":
                case "Linux":
                System.exec( "mkdir " + name );
                break;
            }
            */
        }
        
        private function _parseXML( data:XML ):XML
        {
            var doc:XML = flash_doc_root.copy();
            
            return doc;
        }
        
        private function _saveResult( doc:XML ):void
        {
            var header:String = "<?xml version=\"1.0\" encoding=\"utf-8\"?>\r\n";
            var data:String   = header + doc.toXMLString();
            
            _makeDirectory( _options.foldername );
            
            var filename:String = _options.outputname;
            
            if( !Strings.endsWith( filename, ".xml" ) )
            {
                filename += ".xml";
            }
            
            _writeFile( _options.foldername+"/"+filename, data );
            
            var name:XML =
<toolboxes>
    <definition name="" foldername=""/>
</toolboxes>
            
            name.definition.@name       = _options.outputname;
            name.definition.@foldername = _options.foldername;
            
            var namedata:String = header + name.toXMLString();
            
            _writeFile( _options.foldername+"/name.xml", namedata );
        }
        
        public function showUsages():void
        {
            var usage:String = "";
            
            usage += "flashdoc: [-?] [-v] [-f:<foldername>] [-o:<outputname>] <filename>\n";
            usage += "           -?                 show this help\n";
            usage += "           -v                 verbose\n";
            usage += "           -f:<foldername>    the folder to create (default is \"FlashDoc\")\n";
            usage += "           -o:<outputname>    the output file to generate (default is \"Test\")\n";
            usage += "                              the *.xml extension will be added automatically\n";
            usage += "           <filename>         the XML file to convert\n";
//            usage += "\n";
            
            trace( usage );
        }
        
        public function getHelp():String
        {
            var help:String = "";
                help += "\n";
                help += "flashdoc will take the toplevel.xml file generated by asdoc -keep-xml\n";
                help += "and generate xml files to use in the Flash IDE\n";
                help += "         ... \n";
                help += "           |_ FlashDoc \n";
                help += "                   |_ name.xml \n";
                help += "                   |_ Test.xml \n";
            
            return help;
        }
        
        
        public function run( args:Array ):void
        {
            trace( "flashdoc 0.2" );
            
            if( args.length == 0 )
            {
                showUsages();
                exit( EXIT_FAILURE );
            }
            
            var success:Boolean = _options.parse( args );
            
            if( !success || _options.showUsage )
            {
                showUsages();
                exit( EXIT_FAILURE );
            }
            
            verbose = _options.verbose;
            
            if( verbose )
            {
                trace( "options passed" );
                trace( "verbose: " + _options.verbose );
                trace( "showUsage: " + _options.showUsage );
                trace( "filename: " + _options.filename );
                trace( "foldername: " + _options.foldername );
                trace( "outputname: " + _options.outputname );
            }
            
            var result:XML;
            
            if( File.exists( _options.filename ) )
            {
                try
                {
                
                var data:String = _readFile( _options.filename );
                
                result = _parseXML( new XML( data ) );
                
                }
                catch( e:Error )
                {
                    trace( "## Error: " + e.message + " ##" );
                    
                    if( Capabilities.isDebugger )
                    {
                        trace( e.getStackTrace() );
                    }
                    
                    exit( EXIT_FAILURE );
                }
                
                
                if( result )
                {
                    _saveResult( result );
                    exit( EXIT_SUCCESS );
                }
                else
                {
                    trace( "## Error: in parsing " + _options.filename + ", did not produce a valid XML file ##" );
                    exit( EXIT_FAILURE );
                }
            }
            else
            {
                trace( "## Error: " + _options.filename + " does not exists ##" );
                exit( EXIT_FAILURE );
            }
            
        }
    }
}

