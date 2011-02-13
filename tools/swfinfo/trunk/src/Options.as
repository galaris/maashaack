package
{
    import system.cli.SwitchStatus;
    import system.cli.ArgumentsParser;
    import core.strings.trim;

    public class Options extends ArgumentsParser
    {
        private var _app:Application;
        
        public var filename:String;
        public var showUsage:Boolean;
        public var showVersion:Boolean;
        public var showLicense:Boolean;
        public var saveRemoteFile:Boolean;
        public var outputOption:Boolean;
        public var outputValue:String;
        public var outputFormat:String;
        
        public var parseTags:Boolean;
        public var parseTagsContent:Boolean;
        public var showUnparsedValidTags:Boolean;
        public var showParsedValidTags:Boolean;
        public var fullKnownTagInfo:Boolean;
        public var fullUnknownTagInfo:Boolean;
        public var truncateTags:uint;
        public var hexgroup:uint;
        public var hexwidth:uint;
        
        
        public function Options( app:Application )
        {
            //super( switchSymbols, caseSensitive, switchChars );
            super( ["h","v","L","s","o","p","a","n","x","k","u","t","g","w"], true );
            
            _app = app;
            
            filename              = "";     // file
            showUsage             = false;  // -h
            showVersion           = false;  // -v
            showLicense           = false;  // -L
            saveRemoteFile        = false;  // -s
            outputOption          = false;  // -o:val[=opt]
            outputValue           = "";     //    val
            outputFormat          = "";     //         opt
            
            parseTags             = false;  // -p
            parseTagsContent      = true;   // -a
            showUnparsedValidTags = false;  // -n
            showParsedValidTags   = false;  // -x
            fullKnownTagInfo      = false;  // -k
            fullUnknownTagInfo    = false;  // -u
            truncateTags          = 200;    // -t:val
            hexgroup              = 8;      // -g:val
            hexwidth              = 80;     // -w:val
        }
        
        public override function onUsage( errorInfo:String = "" ):void
        {
            if( errorInfo != "" ) { trace( "CLI switch error: " + errorInfo ); }
            showUsage = true;
        }
        
        public override function onNonSwitch( value:String ):SwitchStatus
        {
            filename = value;
            return SwitchStatus.noError;
        }
        
        public override function onSwitch( symbol:String, value:String ):SwitchStatus
        {
            var status:SwitchStatus = SwitchStatus.noError;
            
            switch( symbol )
            {
                case "h":
                status = SwitchStatus.showUsage;
                break;
                
                case "v":
                showVersion = true;
                break;
                
                case "L":
                showLicense = true;
                break;
                
                case "s":
                saveRemoteFile = true;
                break;
                
                case "o":
                outputOption = true;
                value = trim( value, [":"] );
                var foundFormat:Boolean = value.indexOf( "=" ) > -1;
                
                if( foundFormat )
                {
                    var tmp:Array = value.split( "=" );
                    outputValue   = tmp[0];
                    outputFormat  = tmp[1];
                }
                else
                {
                    outputValue = value;
                }
                break;
                
                case "p":
                parseTags = true;
                break;
                
                case "a":
                parseTagsContent = false;
                break;
                
                case "n":
                showUnparsedValidTags = true;
                break;
                
                case "x":
                showParsedValidTags = true;
                break;

                case "k":
                fullKnownTagInfo = true;
                break;
                
                case "u":
                fullUnknownTagInfo = true;
                break;
                
                case "t":
                value = trim( value, [":"] );
                truncateTags = parseInt( value );
                break;
                
                case "g":
                value = trim( value, [":"] );
                hexgroup = parseInt( value );
                break;
                
                case "w":
                value = trim( value, [":"] );
                hexwidth = parseInt( value );
                break;
                
                default:
                status = SwitchStatus.error;
            }
            
            return status;
        }
        
        public override function onParsed():SwitchStatus
        {
            var status:SwitchStatus = SwitchStatus.noError;
            
            if( parseTags && (filename == "") )
            {
                status = SwitchStatus.error;
                trace( "you need to provide a <filename>" );
                return status;
            }
            
            return status;
        }
        
    }
}