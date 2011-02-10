package
{
    import system.cli.ArgumentsParser;

    public class Options extends ArgumentsParser
    {
        private var _app:Application;
        
        public var filename:String;
        public var showUsage:Boolean;
        public var saveRemoteFile:Boolean;
        public var outputOption:String;
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
            super( ["h","s","o","p","a","n","x","k","u","t","g","w"], true );
            
            _app = app;
            
            filename              = "";     // file
            showUsage             = false;  // -h
            saveRemoteFile        = false;  // -s
            outputOption          = "";     // -o:val[|opt]
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
        
    }
}