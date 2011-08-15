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

package system.formatters 
{
    import library.ASTUce.framework.ArrayAssert;
    import library.ASTUce.framework.TestCase;
    
    import system.numeric.Range;
    
    public class DateFormatterTest extends TestCase 
    {
        public function DateFormatterTest(name:String = "")
        {
            super(name);
        }
        
        public var date_am:Date ;
        
        public var date_pm:Date ;
        
        public var formatter:DateFormatter ;
        
        public function setUp():void
        {
            date_am   = new Date(2008, 3, 30, 11, 25, 0, 0) ;
            date_pm   = new Date(2008, 3, 30, 23, 35, 0, 0) ;
            formatter = new DateFormatter() ;
        }
        
        public function tearDown():void
        {
            date_am   = null ;
            date_am   = null ;
            formatter = null ;
        }
        
        public function testConstructor():void
        {
            assertNotNull(formatter, "01 - The DateFormatter instance not must be null.") ;
            assertEquals(formatter.pattern, "dd.mm.yyyy HH:nn:ss", "02 - The DateFormatter default argument in the constructor failed.") ;
            
            var formatter2:DateFormatter = new DateFormatter("HH:nn t") ;
            assertNotNull(formatter2, "03 - The DateFormatter instance not must be null.") ;
            assertEquals(formatter2.pattern, "HH:nn t", "04 - The DateFormatter argument in the constructor failed.") ;
        }
        
        public function testInterfaces():void
        {
            assertTrue(formatter is Formattable, "01 - The DateFormatter implements IFormatter failed.") ;
            //assertTrue(formatter is Serializable, "02 - The DateFormatter implements Serializable failed.") ;
        }
        
        public function testAM_PM():void
        {
            assertEquals(DateFormatter.AM_PM, "t", "DateFormatter.AM_PM failed.") ;
        }
        
        public function testCAPITAL_AM_PM():void
        {
            assertEquals(DateFormatter.CAPITAL_AM_PM, "T", "DateFormatter.CAPITAL_AM_PM failed.") ;
        }
        
        public function testDEFAULT_AM_EXPRESSION():void
        {
            assertEquals(DateFormatter.DEFAULT_AM_EXPRESSION, "am", "DateFormatter.DEFAULT_AM_EXPRESSION failed.") ;
        }
        
        public function testDEFAULT_DATE_FORMAT():void
        {
            assertEquals(DateFormatter.DEFAULT_DATE_FORMAT, "dd.mm.yyyy HH:nn:ss", "DateFormatter.CAPITAL_AM_PM failed.") ;
        }
        
        public function testDAY_AS_NUMBER():void
        {
            assertEquals(DateFormatter.DAY_AS_NUMBER, "d", "DateFormatter.DAY_AS_NUMBER failed.") ;
        }
        
        public function testDAY_AS_TEXT():void
        {
            assertEquals(DateFormatter.DAY_AS_TEXT, "D", "DateFormatter.DAY_AS_TEXT failed.") ;
        }
        
        public function testDEFAULT_PM_EXPRESSION():void
        {
            assertEquals(DateFormatter.DEFAULT_PM_EXPRESSION, "pm", "DateFormatter.DEFAULT_PM_EXPRESSION failed.") ;
        }
        
        public function testHOUR_IN_AM_PM():void
        {
            assertEquals(DateFormatter.HOUR_IN_AM_PM, "h", "DateFormatter.HOUR_IN_AM_PM failed.") ;
        }
        
        public function testHOUR_IN_DAY():void
        {
            assertEquals(DateFormatter.HOUR_IN_DAY, "H", "DateFormatter.HOUR_IN_AM_PM failed.") ;
        }
        
        public function testMINUTE():void
        {
            assertEquals(DateFormatter.MINUTE, "n", "DateFormatter.HOUR_IN_AM_PM failed.") ;
        }
        
        public function testMILLISECOND():void
        {
            assertEquals(DateFormatter.MILLISECOND, "S", "DateFormatter.MILLISECOND failed.") ;
        }
        
        public function testMONTH_AS_NUMBER():void
        {
            assertEquals(DateFormatter.MONTH_AS_NUMBER, "m", "DateFormatter.MONTH_AS_NUMBER failed.") ;
        } 
        
        public function testMONTH_AS_TEXT():void
        {
            assertEquals(DateFormatter.MONTH_AS_TEXT, "M", "DateFormatter.MONTH_AS_TEXT failed.") ;
        }
        
        public function testQUOTE():void
        {
            assertEquals(DateFormatter.QUOTE, "'", "DateFormatter.QUOTE failed.") ;
        }
        
        public function testRANGE_DAY_AS_TEXT():void
        {
            assertEquals(DateFormatter.RANGE_DAY_AS_TEXT, new Range(0, 6), "DateFormatter.RANGE_DAY_AS_TEXT failed.") ;
        }
        
        public function testRANGE_HOUR():void
        {
            assertEquals(DateFormatter.RANGE_HOUR, new Range(0, 23), "DateFormatter.RANGE_HOUR failed.") ;
        }
        
        public function testRANGE_MINUTE():void
        {
            assertEquals(DateFormatter.RANGE_MINUTE, new Range(0, 59), "DateFormatter.RANGE_MINUTE failed.") ;
        }
        
        public function testRANGE_MILLISECOND():void
        {
            assertEquals(DateFormatter.RANGE_MILLISECOND, new Range(0, 999), "DateFormatter.RANGE_MILLISECOND failed.") ;
        }
        
        public function testRANGE_MONTH():void
        {
            assertEquals(DateFormatter.RANGE_MONTH, new Range(0, 11), "DateFormatter.RANGE_MONTH failed.") ;
        }
        
        public function testRANGE_SECOND():void
        {
            assertEquals(DateFormatter.RANGE_SECOND, new Range(0, 59), "DateFormatter.RANGE_SECOND failed.") ;
        }
        
        public function testSECOND():void
        {
            assertEquals(DateFormatter.SECOND, "s", "DateFormatter.SECOND failed.") ;
        }  
        
        public function testYEAR():void
        {
            assertEquals(DateFormatter.YEAR, "y", "DateFormatter.YEAR failed.") ;
        }
        
        public function testPattern():void
        {
            var f:DateFormatter = new DateFormatter("dd.mm.yyyy HH:nn:ss tt") ;
            
            assertEquals(f.pattern, "dd.mm.yyyy HH:nn:ss tt", "01 - pattern attribute failed.") ;
            
            f.pattern = "hh:nn:ss" ;
            
            assertEquals(f.pattern, "hh:nn:ss", "02 - pattern attribute failed.") ;
        }
        
        public function testClone():void
        {
            var clone:DateFormatter = formatter.clone() as DateFormatter ;
            assertNotNull(clone, "clone failed, the clone not must be 'null' or 'undefined'.") ;
            assertEquals(clone.pattern, formatter.pattern, "clone method, the pattern property must be the same.") ;
        } 
        
        public function testFormat():void
        {
            var f:DateFormatter = new DateFormatter() ;
            
            // full pm
            f.pattern = "dd.mm.yyyy HH:nn:ss tt" ;
            assertEquals(f.format(date_pm), "30.04.2008 23:35:00 pm", "01_01 - format method failed with pattern : " + f.pattern) ;
            
            f.pattern = "dd.mm.yyyy HH:nn:ss t" ;
            assertEquals(f.format(date_pm), "30.04.2008 23:35:00 p", "01_02 - format method failed with pattern : " + f.pattern) ;
            
            f.pattern = "dd.mm.yyyy hh:nn:ss TT" ;
            assertEquals(f.format(date_pm), "30.04.2008 11:35:00 PM", "01_03 - format method failed with pattern : " + f.pattern) ;
            
            f.pattern = "dd.mm.yyyy hh:nn:ss T" ;
            assertEquals(f.format(date_pm), "30.04.2008 11:35:00 P", "01_04 - format method failed with pattern : " + f.pattern) ;
            
            // full am
            f.pattern = "dd.mm.yyyy HH:nn:ss tt" ;
            assertEquals(f.format(date_am), "30.04.2008 11:25:00 am", "01_05 - format method failed with pattern : " + f.pattern) ;
            
            f.pattern = "dd.mm.yyyy HH:nn:ss t" ;
            assertEquals(f.format(date_am), "30.04.2008 11:25:00 a", "01_06 - format method failed with pattern : " + f.pattern) ;
            
            f.pattern = "dd.mm.yyyy hh:nn:ss TT" ;
            assertEquals(f.format(date_am), "30.04.2008 11:25:00 AM", "01_07 - format method failed with pattern : " + f.pattern) ;
            
            f.pattern = "dd.mm.yyyy hh:nn:ss T" ;
            assertEquals(f.format(date_am), "30.04.2008 11:25:00 A", "01_08 - format method failed with pattern : " + f.pattern) ;
            
            
            // DAY_AS_NUMBER
            f.pattern = "d" ;
            assertEquals(f.format(date_pm), "30", "02_01 - format method failed with pattern : " + f.pattern) ;
            
            f.pattern = "dd" ;
            assertEquals(f.format(date_pm), "30", "02_02 - format method failed with pattern : " + f.pattern) ;
            
            // DAY_AS_TEXT
            f.pattern = "DD" ;
            assertEquals(f.format(date_pm), "We", "03_01 - format method failed with pattern : " + f.pattern) ;
            
            f.pattern = "DDD" ;
            assertEquals(f.format(date_pm), "We", "03_02 - format method failed with pattern : " + f.pattern) ;
            
            f.pattern = "DDDD" ;
            assertEquals(f.format(date_pm), "Wednesday", "03_03 - format method failed with pattern : " + f.pattern) ;
            
            // TODO complete more test ?
        }
        
        public function testGetMonthNames():void
        {
            var f:DateFormatter = new DateFormatter() ;
            ArrayAssert.assertEquals( f.getMonthNames() , ["January","February","March","April","May","June","July","August","September","October","November","December"] ) ;
        }
        
        public function testGetWeekdayNames():void
        {
            var f:DateFormatter = new DateFormatter() ;
            ArrayAssert.assertEquals( f.getWeekdayNames() , ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"] ) ;
        }
        
        public function testSetMonthNames():void
        {
            var f:DateFormatter = new DateFormatter() ;
            f.setMonthNames( ["Janvier","Février","Mars","Avril","Mai","Juin","Juillet","Août","Septembre","Octobre","Novembre","Décembre"] ) ;
            ArrayAssert.assertEquals( f.getMonthNames() , ["Janvier","Février","Mars","Avril","Mai","Juin","Juillet","Août","Septembre","Octobre","Novembre","Décembre"] ) ;
            f.setMonthNames(null) ; // default
            ArrayAssert.assertEquals( f.getMonthNames() , ["January","February","March","April","May","June","July","August","September","October","November","December"] ) ;
        }
        
        public function testSetWeekdayNames():void
        {
            var f:DateFormatter = new DateFormatter() ;
            f.setWeekdayNames( ["Dimanche","Lundi","Mardi","Mercredi","Jeudi","Vendredi","Samedi"] ) ;
            ArrayAssert.assertEquals( f.getWeekdayNames() , ["Dimanche","Lundi","Mardi","Mercredi","Jeudi","Vendredi","Samedi"] ) ;
            f.setWeekdayNames(null) ; // default
            ArrayAssert.assertEquals( f.getWeekdayNames() , ["Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"] ) ;
        }
        
//        public function testToSource():void
//        {
//            assertEquals(formatter.toSource(), 'new system.formatters.DateFormatter("dd.mm.yyyy HH:nn:ss")', "toSource() method failed.") ;
//        }
    }
}
