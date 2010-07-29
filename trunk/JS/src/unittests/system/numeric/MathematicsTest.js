/*

  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  
           http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is VEGAS Framework.
  
  The Initial Developer of the Original Code is
  ALCARAZ Marc (aka eKameleon)  <ekameleon@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2004-2010
  the Initial Developer. All Rights Reserved.
  
  Contributor(s) :
  
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

// ---o Constructor

system.numeric.MathematicsTest = function( name ) 
{
    buRRRn.ASTUce.TestCase.call( this , name ) ;
}

// ----o Inherit

system.numeric.MathematicsTest.prototype             = new buRRRn.ASTUce.TestCase() ;
system.numeric.MathematicsTest.prototype.constructor = system.numeric.MathematicsTest ;

// ----o Public Methods

system.numeric.MathematicsTest.prototype.testSingleton = function () 
{
    this.assertNotNull( system.numeric.Mathematics ) ; 
}

system.numeric.MathematicsTest.prototype.testCeil = function()
{
    var result ;
    
    result = system.numeric.Mathematics.ceil(4.572525153, 2) ;
    this.assertEquals( result , 4.58 , "system.numeric.Mathematics.ceil(4.572525153, 2) failed" ) ;
    
    result = system.numeric.Mathematics.ceil(4.572525153, 0) ;
    this.assertEquals( result , 5 , "system.numeric.Mathematics.ceil(4.572525153, 0) failed" ) ;
    
    result = system.numeric.Mathematics.ceil(4.572525153, -1) ;
    this.assertEquals( result , 5 , "system.numeric.Mathematics.ceil(4.572525153, -1) failed" ) ;
    
    result = system.numeric.Mathematics.ceil(NaN, 0) ;
    this.assertEquals( result , NaN , "system.numeric.Mathematics.ceil(NaN, 0) failed" ) ;
    
    result = system.numeric.Mathematics.ceil(4.572525153, NaN) ;
    this.assertEquals( result , 5 , "system.numeric.Mathematics.ceil(4.572525153, NaN) failed" ) ;
    
}

system.numeric.MathematicsTest.prototype.testClamp = function()
{
    var result ;
    
    result = system.numeric.Mathematics.clamp(4, 5, 10) ;
    this.assertEquals( result , 5 , "system.numeric.Mathematics.clamp(4, 5, 10) failed" ) ;
    
    result = system.numeric.Mathematics.clamp(12, 5, 10) ;
    this.assertEquals( result , 10 , "system.numeric.Mathematics.clamp(12, 5, 10) failed" ) ;
    
    result = system.numeric.Mathematics.clamp(6, 5, 10) ;
    this.assertEquals( result , 6 , "system.numeric.Mathematics.clamp(6, 5, 10) failed" ) ;
    
    result = system.numeric.Mathematics.clamp(NaN, 5, 10) ;
    this.assertEquals( result , NaN , "system.numeric.Mathematics.clamp(NaN, 5, 10) failed" ) ;
    
}

system.numeric.MathematicsTest.prototype.testFloor = function()
{
    var result ;
    
    result = system.numeric.Mathematics.floor(4.572525153, 2) ;
    this.assertEquals( result , 4.57 , "system.numeric.Mathematics.floor(4.572525153, 2) failed" ) ;
    
    result = system.numeric.Mathematics.floor(4.572525153, 0) ;
    this.assertEquals( result , 4 , "system.numeric.Mathematics.floor(4.572525153, 0) failed" ) ;
    
    result = system.numeric.Mathematics.floor(4.572525153, -1) ;
    this.assertEquals( result , 4 , "system.numeric.Mathematics.floor(4.572525153, -1) failed" ) ;
    
    result = system.numeric.Mathematics.floor(NaN, 0) ;
    this.assertEquals( result , NaN , "system.numeric.Mathematics.floor(NaN, 0) failed" ) ;
    
    result = system.numeric.Mathematics.floor(4.572525153, NaN) ;
    this.assertEquals( result , 4 , "Mathematics.floor(4.572525153, NaN) failed" ) ;
}

system.numeric.MathematicsTest.prototype.testGcd = function()
{
    var result ;
    
    result = system.numeric.Mathematics.gcd( 320 , 320 ) ;
    this.assertEquals( result , 320 , "system.numeric.Mathematics.gcd( 320 , 320 ) failed" ) ;
    
    result = system.numeric.Mathematics.gcd( 320 , 240 ) ;
    this.assertEquals( result , 80 , "system.numeric.Mathematics.gcd( 320 , 240 ) failed" ) ;
    
    result = system.numeric.Mathematics.gcd( 320 , 0 ) ;
    this.assertEquals( result , 320 , "system.numeric.Mathematics.gcd( 320 , 0 ) failed" ) ;
    
    result = system.numeric.Mathematics.gcd( 320 , 1 ) ;
    this.assertEquals( result , 1 , "system.numeric.Mathematics.gcd( 320 , 1 ) failed" ) ;
    
    result = system.numeric.Mathematics.gcd( 320 , 2 ) ;
    this.assertEquals( result , 2 , "system.numeric.Mathematics.gcd( 320 , 2 ) failed" ) ;
    
    result = system.numeric.Mathematics.gcd( 320 , 320 ) ;
    this.assertEquals( result , 320 , "system.numeric.Mathematics.gcd( 320 , 2 ) failed" ) ;
    
    result = system.numeric.Mathematics.gcd( 640 , 480 ) ;
    this.assertEquals( result , 160 , "system.numeric.Mathematics.gcd( 640 , 480 ) failed" ) ;
    
    result = system.numeric.Mathematics.gcd( -640 , 480 ) ;
    this.assertEquals( result , -160 , "system.numeric.Mathematics.gcd( -640 , 480 ) failed" ) ; 
    
    result = system.numeric.Mathematics.gcd( 640 , -480 ) ;
    this.assertEquals( result , 160 , "system.numeric.Mathematics.gcd( 640 , -480 ) failed" ) ;
    
    result = system.numeric.Mathematics.gcd( -640 , -480 ) ;
    this.assertEquals( result , -160 , "system.numeric.Mathematics.gcd( -640 , -480 ) failed" ) ;
}

system.numeric.MathematicsTest.prototype.testInterpolate = function()
{
    var result ;
    
    result = system.numeric.Mathematics.interpolate( 0.5, 0 , 100 ) ;
    this.assertEquals( result , 50 , "system.numeric.Mathematics.interpolate( 0.5, 0 , 100 ) failed" ) ;
}

system.numeric.MathematicsTest.prototype.testMap = function()
{
    var result ;
    
    result = system.numeric.Mathematics.map( 10, 0 , 100, 20, 80 ) ;
    this.assertEquals( result , 26 , "system.numeric.Mathematics.map( 10, 0 , 100, 20, 80 ) failed" ) ; 
    
    result = system.numeric.Mathematics.map( 26, 20 , 80, 0, 100 ) ;
    this.assertEquals( result , 10 , "system.numeric.Mathematics.map( 26, 20 , 80, 0, 100 ) failed" ) ;
}

system.numeric.MathematicsTest.prototype.testNormalize = function()
{
    var result ;
    
    result = system.numeric.Mathematics.normalize( 10, 0 , 100 ) ;
    this.assertEquals( result , 0.1 , "system.numeric.Mathematics.normalize( 10, 0 , 100 ) failed" ) ;
    
    result = system.numeric.Mathematics.normalize( 50 , 0 , 500 ) ;
    this.assertEquals( result , 0.1 , "system.numeric.Mathematics.normalize( 50, 0 , 500  ) failed" ) ;
    
    result = system.numeric.Mathematics.normalize( 100 , 0 , 500 ) ;
    this.assertEquals( result , 0.2 , "system.numeric.Mathematics.normalize( 100 , 0 , 500  ) failed" ) ;
    
    result = system.numeric.Mathematics.normalize( 10, 25 , 100 ) ;
    this.assertEquals( result , -0.2 , "system.numeric.Mathematics.normalize( 10, 25 , 100 ) failed" ) ;
    
    result = system.numeric.Mathematics.normalize( 10, 25 , 500 ) ;
    this.assertEquals( result , -0.031578947368421054 , "system.numeric.Mathematics.normalize( 10, 25 , 500 ) failed" ) ;
}

system.numeric.MathematicsTest.prototype.testPercentage = function()
{
    var result ;
    
    result = system.numeric.Mathematics.percentage( 10, 100 ) ;
    this.assertEquals( result , 10 , "system.numeric.Mathematics.getPercent( 10, 100 ) failed" ) ;
    
    result = system.numeric.Mathematics.percentage( 50, 100 ) ;
    this.assertEquals( result , 50 , "system.numeric.Mathematics.getPercent( 50, 100 ) failed" ) ;
    
    result = system.numeric.Mathematics.percentage( 68, 425 ) ;
    this.assertEquals( result , 16 , "system.numeric.Mathematics.getPercent( 68, 425 ) failed" ) ;
    
    result = system.numeric.Mathematics.percentage( NaN, NaN ) ;
    this.assertEquals( result , NaN , "system.numeric.Mathematics.getPercent( NaN, NaN ) failed" ) ;
    
    result = system.numeric.Mathematics.percentage( NaN, 100 ) ;
    this.assertEquals( result , NaN , "system.numeric.Mathematics.getPercent( NaN, 100 ) failed" ) ;
    
    result = system.numeric.Mathematics.percentage( 25, NaN ) ;
    this.assertEquals( result , NaN , "system.numeric.Mathematics.getPercent( 25, NaN ) failed" ) ;
}

system.numeric.MathematicsTest.prototype.testRound = function()
{
    var result ;
    
    result = system.numeric.Mathematics.round(4.572525153, 2) ;
    this.assertEquals( result , 4.57 , "system.numeric.Mathematics.round(4.572525153, 2) failed" ) ;
    
    result = system.numeric.Mathematics.round(4.572525153, 0) ;
    this.assertEquals( result , 5 , "system.numeric.Mathematics.round(4.572525153, 0) failed" ) ;
    
    result = system.numeric.Mathematics.round(4.572525153, -1) ;
    this.assertEquals( result , 5 , "system.numeric.Mathematics.round(4.572525153, -1) failed" ) ;
    
    result = system.numeric.Mathematics.round(NaN, 0) ;
    this.assertEquals( result , NaN , "system.numeric.Mathematics.round(NaN, 0) failed" ) ;
    
    result = system.numeric.Mathematics.round(4.572525153, NaN) ;
    this.assertEquals( result , 5 , "system.numeric.Mathematics.round(4.572525153, NaN) failed" ) ;
}

system.numeric.MathematicsTest.prototype.testSign = function()
{
    var result ;
    
    result = system.numeric.Mathematics.sign( 10 ) ;
    this.assertEquals( result , 1 , "system.numeric.Mathematics.sign(10) failed" ) ;
    
    result = system.numeric.Mathematics.sign( -10 ) ;
    this.assertEquals( result , -1 , "system.numeric.Mathematics.sign(-10) failed" ) ;
    
    result = system.numeric.Mathematics.sign( 0 ) ;
    this.assertEquals( result , 1 , "system.numeric.Mathematics.sign(0) failed" ) ;
    
    try
    {
        result = system.numeric.Mathematics.sign( NaN ) ;
        this.fail( "system.numeric.Mathematics.sign(NaN) failed 01." ) ;
    }
    catch( e )
    {
        this.assertEquals( "Mathematics.sign, the passed-in value not must be NaN." , e.message ) ;
    }
}