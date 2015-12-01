# About #

**ASTUce** is a unit tests framework inspired by the [xUnit architecture](http://www.xprogramming.com/software.htm).

| **package** | **FPAPI** | **CC** | **dependencies** | **cross-platform** | **redtamarin** |
|:------------|:----------|:-------|:-----------------|:-------------------|:---------------|
| `library.ASTUce.*` | FP\_9\_0  | n/a    | [core](core.md)<br><a href='logd.md'>logd</a><br><a href='system_terminals.md'>system.terminals</a> <table><thead><th> yes                </th><th> 0.3.2<br>(a tool is in prep) </th></thead><tbody></tbody></table>

<table><thead><th> <b>browse</b> </th><th> <a href='http://code.google.com/p/astuce/source/browse/#svn%2Fas3%2Ftrunk'>/as3/trunk</a> (external site)</th></thead><tbody>
<tr><td> <b>checkout</b> </td><td> <code>svn checkout http://astuce.googlecode.com/svn/as3/trunk astuce-read-only</code>                    </td></tr></tbody></table>

<a href='http://maashaack.googlecode.com/svn/libs/trunk/swc/libraries/astuce.swc'><img src='http://maashaack.googlecode.com/svn/gfx/swc.png' align='left' /></a>
<a href='http://maashaack.googlecode.com/svn/libs/trunk/abc/libraries/astuce.abc'><img src='http://maashaack.googlecode.com/svn/gfx/abc.png' align='left' /></a>
<a href='http://maashaack.googlecode.com/svn/libs/trunk/abc/libraries/astuce-test.abc'><img src='http://maashaack.googlecode.com/svn/gfx/abc.png' align='left' /></a>

<br>
<br>
<br>
<br>

<h1>Introduction</h1>

This project started as a port from JUnit 3.8.1 to make an AS1/JS xUnit framework<br>
so any ECMA-262 compliant hosts could run unit tests.<br>
<br>
Then it evolved to AS2,  AS3 and when AS4 will come it will evolve again.<br>
<br>
People could ask why another AS3 unit tests framework when there is asunit and flexunit,<br>
it simple as: we do things differently and technically we were pre-existing those other<br>
frameworks so we see no reason to kill the project wether we are popular or not.<br>
<br>
<br>
<br>

<h1>Details</h1>

Here the few things we do differently but are very important to us:<br>
<ul><li>this framework is meant to run tests as fast as possible<br>
</li><li>we run synchronous on purpose<br>
</li><li>we don't use events on purpose<br>
</li><li>we don't want a GUI on purpose<br>
</li><li>we want to run on the command line</li></ul>

If your tests take to long to run you will either just run a part of it<br>
or not run them at all, our logic is if those tests run fast then the developers<br>
will have a tendency to run them all the time.<br>
<br>
We will favour mock objects, fake objects, to be able to run synchronously<br>
and without using events, and/or waiting for something to happen so the<br>
test can run.<br>
<br>
First, it is very hard 9and sometimes impossible) to generate certain type<br>
of events or errors or edge case unless you force them with a mock or a fake object.<br>
<br>
Second, as soon as you are async you could end up waiting for too long.<br>
<br>
Third, as our main goal is to run those tests on the command line by using<br>
<a href='http://code.google.com/p/redtamarin'>redtamarin</a>, we want to avoid events to make things simpler to integrate (as Tamarin does not support events).<br>
<br>
Ideally, as we build our code with Ant,<br>
we also want to build and run our tests with Ant<br>
<br>
it looks something like that<br>
<pre><code>&lt;exec executable="./ASTUce" failonerror="true"&gt;<br>
    &lt;arg line="-s" /&gt;<br>
    &lt;arg line="-l:my-tests.swf" /&gt;<br>
    &lt;arg line="my.package.AllTests" /&gt;<br>
&lt;/exec&gt;<br>
</code></pre>

See the <a href='http://code.google.com/p/gaforflash'>gaforflash</a> project ( <a href='http://code.google.com/p/gaforflash/issues/detail?id=40'>40</a> and <a href='http://code.google.com/p/gaforflash/issues/detail?id=41'>41</a> ) for some real world example of unit tests<br>
being run within an ant build.<br>
<br>
<br>
<br>

<hr />
<h1>Documentation</h1>

TODO<br>
<br>
<br>

<hr />
<h1>Usages</h1>

<h2>Create a test class</h2>

If you want to test a class named <b>Money</b><br>
create a test class named <b>MoneyTest</b> which extends the class <b>TestCase</b>

and for each tests, write a public method starting with "test"<br>
<br>
<pre><code>package library.ASTUce.samples.money<br>
{<br>
    import library.ASTUce.framework.TestCase;<br>
    <br>
    [ExcludeClass]<br>
    public class MoneyTest extends TestCase<br>
    {<br>
        <br>
        private var _12eu:Money;<br>
        private var _14eu:Money;<br>
        private var _7usd:Money;<br>
        private var _21usd:Money;<br>
        <br>
        private var _MB1:IMoney;<br>
        private var _MB2:IMoney;<br>
        <br>
        public function MoneyTest( name:String = "" )<br>
        {<br>
            super( name );<br>
        }<br>
        <br>
        public function setUp():void<br>
        {<br>
            _12eu  = new Money( 12, "€" );<br>
            _14eu  = new Money( 14, "€" );<br>
            _7usd  = new Money(  7, "$" );<br>
            _21usd = new Money( 21, "$" );<br>
            <br>
            _MB1 = MoneyBag.create( _12eu, _7usd );<br>
            _MB2 = MoneyBag.create( _14eu, _21usd );<br>
        }<br>
        <br>
        public function testIsZero():void<br>
        {<br>
            assertTrue( _MB1.subtract( _MB1 ).isZero() );<br>
            assertTrue( MoneyBag.create( new Money(0,"€"), new Money(0,"$") ).isZero() );<br>
        }<br>
        <br>
        public function testBagNotEquals():void<br>
        {<br>
            var bag:IMoney = MoneyBag.create( _12eu, _7usd );<br>
            assertFalse( bag.equals( new Money(12,"¥").add( _7usd ) ) );<br>
        }<br>
        <br>
        public function testMoneyBagEquals():void<br>
        {<br>
            assertTrue( !_MB1.equals( null ) );<br>
            assertEquals( _MB1, _MB1 );<br>
            <br>
            var equal:IMoney = MoneyBag.create( new Money(12,"€"), new Money(7,"$") );<br>
            assertTrue(  _MB1.equals( equal ) );<br>
            assertTrue( !_MB1.equals( _12eu ) );<br>
            assertTrue( !_12eu.equals( _MB1 ) );<br>
            assertTrue( !_MB1.equals( _MB2 ) );<br>
        }<br>
        <br>
        public function testMoneyEquals():void<br>
        {<br>
            assertTrue( !_12eu.equals( null ) );<br>
            <br>
            var equalMoney:Money = new Money( 12, "€" );<br>
            assertEquals( _12eu, _12eu );<br>
            assertEquals( _12eu, equalMoney );<br>
        }<br>
        <br>
        public function testPrint():void<br>
        {<br>
            assertEquals( "[12€]", _12eu.toString() );<br>
        }<br>
    }<br>
    <br>
}<br>
</code></pre>

You can also use special methods <b>setUp</b> (run before each test) and <b>tearDown</b> (run after each test).<br>
<br>
<br>

<h2>Create a test suite</h2>

A suite is simply a group of test classes, by convention you will create<br>those suite inside an <b>AllTests</b> class<br>
<br>
<pre><code>package library.ASTUce.samples<br>
{<br>
    import library.ASTUce.framework.Test;<br>
    import library.ASTUce.framework.TestSuite;<br>
    import library.ASTUce.Runner;<br>
    import library.ASTUce.samples.money.MoneyTest;<br>
    <br>
    /**<br>
     * TestSuite that runs all the sample tests<br>
     */<br>
    [ExcludeClass]<br>
    public class AllTests<br>
    {<br>
        public function AllTests()<br>
        {<br>
        }<br>
        <br>
        public static function main( ...args ):void<br>
        {<br>
            Runner.run( suite() );<br>
        }<br>
        <br>
        public static function suite():Test<br>
        {<br>
            var suite:TestSuite = new TestSuite( "All ASTUce sample tests" );<br>
            <br>
            suite.addTest( ArrayTest.suite() );<br>
            <br>
            suite.addTestSuite( MoneyTest );<br>
            <br>
            return suite;<br>
        }<br>
    }<br>
}<br>
</code></pre>


The framework will look for the static method <b>suite</b>, if found it will use it,<br>
if not it will create the test suite by code reflection.<br>
<br>
<br>