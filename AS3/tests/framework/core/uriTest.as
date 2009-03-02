package core
{
    import buRRRn.ASTUce.framework.TestCase;
    
    public class uriTest extends TestCase
    {
        public function uriTest(name:String="")
        {
            super(name);
        }
        
        public function testParse1():void
        {
            var s:String = "http://www.ics.uci.edu/pub/ietf/uri/#Related";
            var u:uri = new uri( s );
            
            assertEquals( u.scheme,    "http" );
            assertEquals( u.authority, "www.ics.uci.edu" );
            assertEquals( u.host,      "www.ics.uci.edu" );
            assertEquals( u.userinfo,  "" );
            assertEquals( u.path,      "/pub/ietf/uri/" );
            assertEquals( u.query,     "" );
            assertEquals( u.fragment,  "Related" );
            
        }
        
        public function testParse2():void
        {
            var s:String = "http://www.ics.uci.edu/pub/ietf/uri/?a=1&b=2#Related";
            var u:uri = new uri( s );
            
            assertEquals( u.scheme,    "http" );
            assertEquals( u.authority, "www.ics.uci.edu" );
            assertEquals( u.host,      "www.ics.uci.edu" );
            assertEquals( u.userinfo,  "" );
            assertEquals( u.path,      "/pub/ietf/uri/" );
            assertEquals( u.query,     "a=1&b=2" );
            assertEquals( u.fragment,  "Related" );
            
        }
        
        public function testParse3():void
        {
            var s:String = "http://username:password@www.ics.uci.edu:8080/pub/ietf/uri/?a=1&b=2#Related";
            var u:uri = new uri( s );
            
            assertEquals( u.scheme,    "http" );
            assertEquals( u.authority, "username:password@www.ics.uci.edu:8080" );
            assertEquals( u.host,      "www.ics.uci.edu" );
            assertEquals( u.userinfo,  "username:password" );
            assertEquals( u.path,      "/pub/ietf/uri/" );
            assertEquals( u.query,     "a=1&b=2" );
            assertEquals( u.fragment,  "Related" );
            
        }
        
        public function testParse4():void
        {
            var s:String = "tel:+1-816-555-1212";
            var u:uri = new uri( s );
            
            assertEquals( u.scheme,    "tel" );
            assertEquals( u.authority, "" );
            assertEquals( u.host,      "" );
            assertEquals( u.userinfo,  "" );
            assertEquals( u.path,      "+1-816-555-1212" );
            assertEquals( u.query,     "" );
            assertEquals( u.fragment,  "" );
            
        }
        
        public function testParse5():void
        {
            var s:String = "mailto:John.Doe@example.com";
            var u:uri = new uri( s );
            
            assertEquals( u.scheme,    "mailto" );
            assertEquals( u.authority, "" );
            assertEquals( u.host,      "" );
            assertEquals( u.userinfo,  "" );
            assertEquals( u.path,      "John.Doe@example.com" );
            assertEquals( u.query,     "" );
            assertEquals( u.fragment,  "" );
            
        }
        
        public function testParse6():void
        {
            var s:String = "news:comp.infosystems.www.servers.unix";
            var u:uri = new uri( s );
            
            assertEquals( u.scheme,    "news" );
            assertEquals( u.authority, "" );
            assertEquals( u.host,      "" );
            assertEquals( u.userinfo,  "" );
            assertEquals( u.path,      "comp.infosystems.www.servers.unix" );
            assertEquals( u.query,     "" );
            assertEquals( u.fragment,  "" );
            
        }
        
        public function testParse7():void
        {
            var s:String = "telnet://192.0.2.16:80/";
            var u:uri = new uri( s );
            
            assertEquals( u.scheme,    "telnet" );
            assertEquals( u.authority, "192.0.2.16:80" );
            assertEquals( u.host,      "192.0.2.16" );
            assertEquals( u.userinfo,  "" );
            assertEquals( u.path,      "/" );
            assertEquals( u.query,     "" );
            assertEquals( u.fragment,  "" );
            
        }
        
        public function testParse8():void
        {
            var s:String = "ldap://[2001:db8::7]/c=GB?objectClass?one";
            var u:uri = new uri( s );
            
            assertEquals( u.scheme,    "ldap" );
            assertEquals( u.authority, "[2001:db8::7]" );
            assertEquals( u.host,      "[2001:db8::7]" );
            assertEquals( u.userinfo,  "" );
            assertEquals( u.path,      "/c=GB" );
            assertEquals( u.query,     "objectClass?one" );
            assertEquals( u.fragment,  "" );
            
        }
        
        public function testParse9():void
        {
            var s:String = "urn:oasis:names:specification:docbook:dtd:xml:4.1.2";
            var u:uri = new uri( s );
            
            assertEquals( u.scheme,    "urn" );
            assertEquals( u.authority, "" );
            assertEquals( u.host,      "" );
            assertEquals( u.userinfo,  "" );
            assertEquals( u.path,      "oasis:names:specification:docbook:dtd:xml:4.1.2" );
            assertEquals( u.query,     "" );
            assertEquals( u.fragment,  "" );
            
        }
        
        public function testParse10():void
        {
            var s:String = "//server/my/path/file.txt";
            var u:uri = new uri( s );
            
            assertEquals( u.scheme,    "file" );
            assertEquals( u.authority, "" );
            assertEquals( u.host,      "" );
            assertEquals( u.userinfo,  "" );
            assertEquals( u.path,      "/server/my/path/file.txt" );
            assertEquals( u.query,     "" );
            assertEquals( u.fragment,  "" );
            
        }
        
        public function testParse11():void
        {
            var s:String = "file:///some/path/and/file.txt";
            var u:uri = new uri( s );
            
            assertEquals( u.scheme,    "file" );
            assertEquals( u.authority, "" );
            assertEquals( u.host,      "" );
            assertEquals( u.userinfo,  "" );
            assertEquals( u.path,      "/some/path/and/file.txt" );
            assertEquals( u.query,     "" );
            assertEquals( u.fragment,  "" );
            
        }
        
        public function testParse12():void
        {
            var s:String = "\\\\server\\my\\path\\file.txt";
            var u:uri = new uri( s );
            
            assertEquals( u.scheme,    "file" );
            assertEquals( u.authority, "server" );
            assertEquals( u.host,      "server" );
            assertEquals( u.userinfo,  "" );
            assertEquals( u.path,      "/my/path/file.txt" );
            assertEquals( u.query,     "" );
            assertEquals( u.fragment,  "" );
            
        }
        
        public function testParse13():void
        {
            var s:String = "C:\\directory\\file.txt";
            var u:uri = new uri( s );
            
            assertEquals( u.scheme,    "file" );
            assertEquals( u.authority, "" );
            assertEquals( u.host,      "" );
            assertEquals( u.userinfo,  "" );
            assertEquals( u.path,      "/C:/directory/file.txt" );
            assertEquals( u.query,     "" );
            assertEquals( u.fragment,  "" );
            
        }
        
        public function testParse14():void
        {
            var s:String = "file:///C:/Documents%20and%20Settings/bob/Desktop";
            var u:uri = new uri( s );
            
            assertEquals( u.scheme,    "file" );
            assertEquals( u.authority, "" );
            assertEquals( u.host,      "" );
            assertEquals( u.userinfo,  "" );
            assertEquals( u.path,      "/C:/Documents%20and%20Settings/bob/Desktop" );
            assertEquals( u.query,     "" );
            assertEquals( u.fragment,  "" );
            
        }
        
        public function testParse15():void
        {
            var s:String = "file:///Users/bob/Desktop";
            var u:uri = new uri( s );
            
            assertEquals( u.scheme,    "file" );
            assertEquals( u.authority, "" );
            assertEquals( u.host,      "" );
            assertEquals( u.userinfo,  "" );
            assertEquals( u.path,      "/Users/bob/Desktop" );
            assertEquals( u.query,     "" );
            assertEquals( u.fragment,  "" );
            
        }
        
        public function testParse16():void
        {
            var s:String = "\\\\ComputerName\\SharedFolder\\Resource";
            var u:uri = new uri( s );
            
            assertEquals( u.scheme,    "file" );
            assertEquals( u.authority, "ComputerName" );
            assertEquals( u.host,      "ComputerName" );
            assertEquals( u.userinfo,  "" );
            assertEquals( u.path,      "/SharedFolder/Resource" );
            assertEquals( u.query,     "" );
            assertEquals( u.fragment,  "" );
            
        }
        
        public function testParse17():void
        {
            var s:String = "hostname:/directorypath/resource";
            var u:uri = new uri( s );
            
            assertEquals( u.scheme,    "hostname" );
            assertEquals( u.authority, "" );
            assertEquals( u.host,      "" );
            assertEquals( u.userinfo,  "" );
            assertEquals( u.path,      "/directorypath/resource" );
            assertEquals( u.query,     "" );
            assertEquals( u.fragment,  "" );
            
        }
        
        public function testParse18():void
        {
            var s:String = "smb://hostname/directorypath/resource";
            var u:uri = new uri( s );
            
            assertEquals( u.scheme,    "smb" );
            assertEquals( u.authority, "hostname" );
            assertEquals( u.host,      "hostname" );
            assertEquals( u.userinfo,  "" );
            assertEquals( u.path,      "/directorypath/resource" );
            assertEquals( u.query,     "" );
            assertEquals( u.fragment,  "" );
            
        }
        
        public function testParse19():void
        {
            var s:String = "///server/my/path/file.txt";
            var u:uri = new uri( s );
            
            assertEquals( u.scheme,    "file" );
            assertEquals( u.authority, "" );
            assertEquals( u.host,      "" );
            assertEquals( u.userinfo,  "" );
            assertEquals( u.path,      "/server/my/path/file.txt" );
            assertEquals( u.query,     "" );
            assertEquals( u.fragment,  "" );
            
        }
        
        public function testParse20():void
        {
            var s:String = "http://www.ics.uci.edu/pub/ietf/uri/?";
            var u:uri = new uri( s );
            
            assertEquals( u.scheme,    "http" );
            assertEquals( u.authority, "www.ics.uci.edu" );
            assertEquals( u.host,      "www.ics.uci.edu" );
            assertEquals( u.userinfo,  "" );
            assertEquals( u.path,      "/pub/ietf/uri/" );
            assertEquals( u.query,     "" );
            assertEquals( u.fragment,  "" );
            
        }
        
        
        
        
        
    }
}