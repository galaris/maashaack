/*
  
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is eden: ECMAScript data exchange notation AS2. 
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2006
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):

*/	
package system.text.prettifier
    {
    import system.Strings;
    
    public class Keywords
        {
        
        private static var _k:Object = { a:[], b:[], c:[], d:[],
                                         e:[], f:[], g:[], h:[],
                                         i:[], j:[], k:[], l:[],
                                         m:[], n:[], o:[], p:[],
                                         q:[], r:[], s:[], t:[],
                                         u:[], v:[], w:[], x:[],
                                         y:[], z:[] };
        
        public function Keywords()
            {
            }
        
        private static function _addArray( words:Array ):void
            {
            var word:String;
            var letter:String;
            
            for( var i:int = 0; i<words.length; i++ )
                {
                word = words[i];
                letter = word.charAt(0).toLowerCase();
                
                if( word != "" )
                    {
                    _k[letter].push( word );
                    }
                }
            }
        
        public static function list( letter:String = "" ):Array
            {
            if( letter == "" )
                {
                var _all:Array = [];
                    _all.concat( _k.a, _k.b, _k.c, _k.d,
                                 _k.e, _k.f, _k.g, _k.h,
                                 _k.i, _k.j, _k.k, _k.l,
                                 _k.m, _k.n, _k.o, _k.p,
                                 _k.q, _k.r, _k.s, _k.t,
                                 _k.u, _k.v, _k.w, _k.x,
                                 _k.y, _k.z );
                
                return _all;
                }
            else
                {
                return _k[letter];
                }
            }
        
        public static function add( ...words ):void
            {
            var word:*;
            
            for( var i:int=0; i<words.length; i++ )
                {
                word = words[i];
                 
                if( word is String )
                    {
                    if( word.indexOf( " " ) > -1 )
                        {
                        _addArray( word.split( " " ) );
                        }
                    else
                        {
                        _addArray( [word] );
                        }
                    }
                else if( word is Array )
                    {
                    _addArray( word );
                    }
                
                }
            }
        
        public static function search( keyword:String ):Boolean
            {
            keyword = Strings.trim( keyword );
            
            if( keyword == "" )
                {
                return false;
                }
            
            var letter:String = keyword.charAt(0).toLowerCase();
            var word:String;
            
            
            if( _k[letter].join( " " ).indexOf( keyword ) == -1 )
                {
                return false;
                }
            
            for( var i:int = 0; i< _k[letter].length; i++ )
                {
                word = _k[letter][i];
                
                if( word == keyword )
                    {
                    return true;
                    } 
                
                }
            
            return false;
            }
        
        public static var CPP_KEYWORDS:String = "abstract bool break case catch char class const " +
                                                "const_cast continue default delete deprecated dllexport dllimport do " +
                                                "double dynamic_cast else enum explicit extern false float for friend " +
                                                "goto if inline int long mutable naked namespace new noinline noreturn " +
                                                "nothrow novtable operator private property protected public register " +
                                                "reinterpret_cast return selectany short signed sizeof static " +
                                                "static_cast struct switch template this thread throw true try typedef " +
                                                "typeid typename union unsigned using declaration, directive uuid " +
                                                "virtual void volatile while typeof";
        
        public static var CSHARP_KEYWORDS:String = "as base by byte checked decimal delegate descending " +
                                                   "event finally fixed foreach from group implicit in interface internal " +
                                                   "into is lock null object out override orderby params readonly ref sbyte " +
                                                   "sealed stackalloc string select uint ulong unchecked unsafe ushort var";
        
        public static var JAVA_KEYWORDS:String = "package synchronized boolean implements import throws " +
                                                 "instanceof transient extends final strictfp native super";
        
        public static var JSCRIPT_KEYWORDS:String = "debugger export function with NaN Infinity";
        
        public static var PERL_KEYWORDS:String = "require sub unless until use elsif BEGIN END";
        
        public static var PYTHON_KEYWORDS:String = "and assert def del elif except exec global lambda " +
                                                   "not or pass print raise yield False True None";
        
        public static var RUBY_KEYWORDS:String = "then end begin rescue ensure module when undef next " +
                                                 "redo retry alias defined";
        
        public static var SH_KEYWORDS:String = "done fi";
        
        
        add( CPP_KEYWORDS, CSHARP_KEYWORDS, JAVA_KEYWORDS, JSCRIPT_KEYWORDS, PERL_KEYWORDS, PYTHON_KEYWORDS, RUBY_KEYWORDS, SH_KEYWORDS );
        
        }
    
    }

