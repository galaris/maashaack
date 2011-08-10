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
  Portions created by the Initial Developers are Copyright (C) 2006-2011
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

package system
{
    import buRRRn.ASTUce.framework.TestCase;

    import system.data.Map;
    import system.network.URIScheme;

    public class URITest extends TestCase
    {
        public function URITest( name:String = "" )
        {
            super( name );
        }
        
        public function testParse1():void
        {
            var s:String = "http://www.ics.uci.edu/pub/ietf/uri/#Related";
            var u:URI = new URI( s );
            
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
            var u:URI = new URI( s );
            
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
            var u:URI = new URI( s );
            
            assertEquals( u.scheme,    "http" );
            assertEquals( u.authority, "username@www.ics.uci.edu:8080" );
            assertEquals( u.host,      "www.ics.uci.edu" );
            assertEquals( u.userinfo,  "username" );
            assertEquals( u.path,      "/pub/ietf/uri/" );
            assertEquals( u.query,     "a=1&b=2" );
            assertEquals( u.fragment,  "Related" );
            
        }
        
        public function testParse4():void
        {
            var s:String = "tel:+1-816-555-1212";
            var u:URI = new URI( s );
            
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
            var u:URI = new URI( s );
            
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
            var u:URI = new URI( s );
            
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
            var u:URI = new URI( s );
            
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
            var u:URI = new URI( s );
            
            assertEquals( u.scheme,    "ldap" );
            assertEquals( u.authority, "[2001:db8::7]" );
            assertEquals( u.host,      "[2001:db8::7]" );
            assertEquals( u.userinfo,  "" );
            assertEquals( u.path,      "/c=GB" );
            // FIXME assertEquals( u.query,     "objectClass?one" );
            assertEquals( u.fragment,  "" );
            
        }
        
        public function testParse9():void
        {
            var s:String = "urn:oasis:names:specification:docbook:dtd:xml:4.1.2";
            var u:URI = new URI( s );
            
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
            var u:URI = new URI( s );
            
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
            var u:URI = new URI( s );
            
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
            var u:URI = new URI( s );
            
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
            var u:URI = new URI( s );
            
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
            var u:URI = new URI( s );
            
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
            var u:URI = new URI( s );
            
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
            var u:URI = new URI( s );
            
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
            var u:URI = new URI( s );
            
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
            var u:URI = new URI( s );
            
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
            var u:URI = new URI( s );
            
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
            var u:URI = new URI( s );
            
            assertEquals( u.scheme,    "http" );
            assertEquals( u.authority, "www.ics.uci.edu" );
            assertEquals( u.host,      "www.ics.uci.edu" );
            assertEquals( u.userinfo,  "" );
            assertEquals( u.path,      "/pub/ietf/uri/" );
            assertEquals( u.query,     "" );
            assertEquals( u.fragment,  "" );
            
        }
        
        
        public function testParse():void
        {
//            var s1:String = "http://www.ics.uci.edu/pub/ietf/uri/#Related";
//            var s2:String = "http://www.ics.uci.edu/pub/ietf/uri/?a=1&b=2#Related";
//            var s3:String = "http://username:password@www.ics.uci.edu:8080/pub/ietf/uri/?a=1&b=2#Related";
//            var s4:String = "tel:+1-816-555-1212";
//            var s5:String = "mailto:John.Doe@example.com";
//            var s6:String = "news:comp.infosystems.www.servers.unix";
//            var s7:String = "telnet://192.0.2.16:80/";
//            var s8:String = "ldap://[2001:db8::7]/c=GB?objectClass?one";
//            var s9:String = "urn:oasis:names:specification:docbook:dtd:xml:4.1.2";
//            var s10:String = "//server/my/path/file.txt";
//            var s11:String = "file:///some/path/and/file.txt";
//            var s12:String = "\\\\server\\my\\path\\file.txt";
//            var s13:String = "C:\\directory\\file.txt";
//            var s14:String = "file:///C:/Documents%20and%20Settings/bob/Desktop";
//            var s15:String = "file:///Users/bob/Desktop";
//            var s16:String = "\\\\ComputerName\\SharedFolder\\Resource";
//            var s17:String = "hostname:/directorypath/resource";
//            var s18:String = "smb://hostname/directorypath/resource";
//            var s19:String = "///server/my/path/file.txt";
//            var s20:String = "http://www.ics.uci.edu/pub/ietf/uri/?";
            //URI.parse( s1 );
            //var u1:URI = new URI( s1 );
            //var u2:URI = new URI( s2 );
            //var u3:URI = new URI( s3 );
            //trace( "u3: [" + u3 + "]" );
            
            //var uri:URI = u3;
            
//            trace( "scheme: " + uri.scheme );
//            trace( "authority: " + uri.authority );
//            trace( "host: " + uri.host );
//            trace( "userinfo: " + uri.userinfo );
//            trace( "path: " + uri.path );
//            trace( "query: " + uri.query );
//            trace( "fragment: " + uri.fragment );
            
            
        }
        
        public function testIsValidScheme():void
        {
            assertTrue( URI.isValidScheme( URIScheme.HTTP.scheme ) );
            assertTrue( URI.isValidScheme( URIScheme.HTTPS.scheme ) );
            assertTrue( URI.isValidScheme( URIScheme.FTP.scheme ) );
            assertTrue( URI.isValidScheme( URIScheme.FILE.scheme ) );
            assertTrue( URI.isValidScheme( URIScheme.MAILTO.scheme ) );
            assertTrue( URI.isValidScheme( URIScheme.NEWS.scheme ) );
            assertTrue( URI.isValidScheme( URIScheme.NNTP.scheme ) );
            assertTrue( URI.isValidScheme( URIScheme.GOPHER.scheme ) );
            assertTrue( URI.isValidScheme( URIScheme.AIRAPPLICATION.scheme ) );
            assertTrue( URI.isValidScheme( URIScheme.AIRSTORAGE.scheme ) );
            
            assertFalse( URI.isValidScheme( "ftp$2" ) );
            assertFalse( URI.isValidScheme( "app:2" ) );
            assertFalse( URI.isValidScheme( "2ftp" ) );
        }
        
        public function testIsValidPort():void
        {
            assertTrue( URI.isValidPort( 0 ) );
            assertTrue( URI.isValidPort( 65535 ) );
            assertTrue( URI.isValidPort( 80 ) );
            assertTrue( URI.isValidPort( 21 ) );
            
            assertFalse( URI.isValidPort( -1 ) );
        }
        
        public function testIsIPv4Address():void
        {
            assertTrue( URI.isIPv4Address( "0.0.0.0" ) );
            assertTrue( URI.isIPv4Address( "127.0.0.1" ) );
            assertTrue( URI.isIPv4Address( "255.255.255.255" ) );
            
            assertFalse( URI.isIPv4Address( "255.1024.255.255" ) );
            assertFalse( URI.isIPv4Address( "255.25.5.25.5.255" ) );
            assertFalse( URI.isIPv4Address( "a.b.c.d" ) );
        }
        
        public function testIsDomainAddress():void
        {
            assertTrue( URI.isDomainAddress( "a_1.google.com" ) );
        }
        
        public function testQueryGET():void
        {
           // test the "get" property
            var s:String ;
            var u:URI ;
            
            s =  "http://www.ics.uci.edu/?a=1&b=2";
            u = new URI( s );
            assertEquals( u.query , "a=1&b=2" ) ;
            
            s =  "http://www.ics.uci.edu/?a=1:b=2";
            u = new URI( s );
            assertEquals( u.query , "" ) ;
            
            s =  "http://www.ics.uci.edu/?a=1&b=2#home";
            u = new URI( s );
            assertEquals( u.query , "a=1&b=2" ) ;
            assertEquals( u.fragment , "home" ) ;
            
            s =  "http://www.ics.uci.edu/?a=1";
            u = new URI( s );
            assertEquals( u.query , "a=1" ) ;
        }
        
        public function testQuerySET():void
        {
            // test the "set" property
            var s:String ;
            var u:URI ;
            
            s =  "http://www.ics.uci.edu/";
            u = new URI( s );
            
            u.query = "a=1&b=2" ;
            assertEquals( u.query , "a=1&b=2" ) ;
            
            u.query = "a=1:b=2" ;
            assertEquals( u.query , "" ) ;
            
            u.query = "a=1" ;
            assertEquals( u.query , "a=1" ) ;
        }
        
        public function testGetQueryMap():void
        {
            var s:String ;
            var u:URI ;
            s =  "http://www.ics.uci.edu/?a=1&b=2";
            u = new URI( s );
            var m:Map = u.getQueryMap() ;
            assertNotNull( m ) ;
        }
        
        public function testGetParameter():void
        {
            var s:String ;
            var u:URI ;
            s =  "http://www.ics.uci.edu/?a=1&b=2";
            u = new URI( s );
            assertEquals( u.getParameter("a") , "1" ) ;
        }
        
        public function testHasFragment():void
        {
            var s:String ;
            var u:URI ;
            s =  "http://www.ics.uci.edu/?a=1&b=2#fragment";
            u = new URI( s );
            assertTrue( u.hasFragment() ) ;
            s =  "http://www.ics.uci.edu/?a=1&b=2#";
            u = new URI( s );
            assertTrue( u.hasFragment() ) ;
            s =  "http://www.ics.uci.edu/?a=1&b=2";
            u = new URI( s );
            assertFalse( u.hasFragment() ) ;
        }
        
        public function testHasParameter():void
        {
            var s:String ;
            var u:URI ;
            
            s =  "http://www.ics.uci.edu/?a=1&b=2";
            u = new URI( s );
            
            assertTrue( u.hasParameter("a") ) ;
            assertFalse( u.hasParameter("c") ) ;
        }
        
        public function testHasQuery():void
        {
            var s:String ;
            var u:URI ;
            
            s =  "http://www.ics.uci.edu/?a=1&b=2";
            u = new URI( s );
            assertTrue( u.hasQuery() ) ;
            
            s =  "http://www.ics.uci.edu/?a=1";
            u = new URI( s );
            assertTrue( u.hasQuery() ) ;
            
            s =  "http://www.ics.uci.edu/";
            u = new URI( s );
            assertFalse( u.hasQuery() ) ;
            
            s =  "http://www.ics.uci.edu/?";
            u = new URI( s );
            assertFalse( u.hasQuery() ) ;
            
            s =  "http://www.ics.uci.edu/?a=1?b=2";
            u = new URI( s );
            assertFalse( u.hasQuery() ) ;
            
            s =  "http://www.ics.uci.edu/?a=1?b=2"; // FIXME see the rfc if the query contains multi ?
            u = new URI( s );
            assertFalse( u.hasQuery() ) ;
        }
        
        public function testRemoveAllParameters():void
        {
            var s:String ;
            var u:URI ;
            s =  "http://www.ics.uci.edu/?a=1&b=2";
            u = new URI( s );
            u.removeAllParameters() ;
            assertEquals( u.query , "" ) ;
            assertFalse( u.hasQuery() ) ;
        }
        
        public function testRemoveParameter():void
        {
            var s:String ;
            var u:URI ;
            s =  "http://www.ics.uci.edu/?a=1&b=2";
            u = new URI( s );
            u.removeParameter("a") ;
            assertEquals( u.query , "b=2" ) ;
            assertTrue( u.hasQuery() ) ;
        }
        
        public function testSetParameterValue():void
        {
            var s:String ;
            var u:URI ;
            s =  "http://www.ics.uci.edu/?a=1&b=2";
            u = new URI( s );
            u.setParameterValue("a", 0 ) ;
            assertEquals( u.query , "a=0&b=2" ) ;
            u.setParameterValue("c", "3" ) ;
            assertEquals( u.query , "a=0&b=2&c=3" ) ;
            u.setParameterValue("c", undefined ) ;
            assertEquals( u.query , "a=0&b=2" ) ;
        }
        
        public function testSetParameterValueWithUndefinedValue():void
        {
            var s:String ;
            var u:URI ;
            s =  "http://www.ics.uci.edu/?a=1&b=2";
            u = new URI( s );
            u.setParameterValue("b", undefined ) ;
            assertEquals( u.query , "a=1" ) ;
            u.setParameterValue("a", undefined ) ;
            assertEquals( u.query , "" ) ;
        }
        
        /* not implemented yet
        public function testRelativeURI():void
        {
            var s:String ;
            var u:URI ;
            s =  "test/index.html?a=1&b=2#test";
            u = new URI( s );
            assertEquals( u.scheme,    "" , "scheme failed.");
            assertEquals( u.authority, "" , "authority failed.");
            assertEquals( u.host,      "" , "host failed.");
            assertEquals( u.userinfo,  "" , "userinfo failed.");
            assertEquals( u.path,      "/test/index.html" , "path failed.");
            assertEquals( "a=1&b=2" , u.query , "query failed.");
            assertEquals( u.fragment,  "test", "fragment failed.");
        }
        */
    }
}