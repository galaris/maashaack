## Introduction ##

Each time we update, add, change or build the maashaack libraries,
we save them in a repository path.

Those are called the **latest** libraries.<br>
(later we will add nighty build libraries)<br>
<br>
<br>
<h2>Details</h2>

simply use <b>svn</b>
<pre><code>svn co http://maashaack.googlecode.com/svn/libs/trunk maashaack-latest<br>
</code></pre>

form there you will get this directory tree<br>
<pre><code>.<br>
├── abc<br>
│   ├── libraries<br>
│   │   ├── astuce-test.abc<br>
│   │   ├── astuce.abc<br>
│   │   ├── eden.abc<br>
│   │   └── logd.abc<br>
│   └── packages<br>
│       ├── common.abc<br>
│       ├── core.abc<br>
│       ├── system.abc<br>
│       ├── system.cli.abc<br>
│       ├── system.data.abc<br>
│       ├── system.date.abc<br>
│       ├── system.errors.abc<br>
│       ├── system.network.abc<br>
│       ├── system.numeric.abc<br>
│       ├── system.rules.abc<br>
│       ├── system.signals.abc<br>
│       ├── system.terminals.abc<br>
│       └── system.text.abc<br>
├── exe<br>
│   ├── nix<br>
│   │   └── abcdump<br>
│   ├── osx<br>
│   │   └── abcdump<br>
│   ├── osx105<br>
│   │   └── abcdump<br>
│   └── win<br>
│       └── abcdump.exe<br>
└── swc<br>
    ├── libraries<br>
    │   ├── astuce.swc<br>
    │   ├── ax.swc<br>
    │   ├── eden.swc<br>
    │   ├── fx.swc<br>
    │   ├── logd.swc<br>
    │   └── molecule.swc<br>
    ├── maashaack.swc<br>
    └── packages<br>
        ├── common.swc<br>
        ├── core.swc<br>
        ├── graphics.swc<br>
        ├── system.broadcasters.swc<br>
        ├── system.cli.swc<br>
        ├── system.comparators.swc<br>
        ├── system.data.swc<br>
        ├── system.date.swc<br>
        ├── system.diagnostics.swc<br>
        ├── system.errors.swc<br>
        ├── system.evaluators.swc<br>
        ├── system.events.swc<br>
        ├── system.formatters.swc<br>
        ├── system.hosts.swc<br>
        ├── system.ioc.swc<br>
        ├── system.logging.swc<br>
        ├── system.logic.swc<br>
        ├── system.models.swc<br>
        ├── system.network.swc<br>
        ├── system.numeric.swc<br>
        ├── system.process.swc<br>
        ├── system.reflection.swc<br>
        ├── system.remoting.swc<br>
        ├── system.rules.swc<br>
        ├── system.signals.swc<br>
        ├── system.swc<br>
        ├── system.terminals.swc<br>
        └── system.text.swc<br>
</code></pre>

those are the latest compiled binaries<br>
wether it is a SWC, an ABC, or an EXEcutable<br>
it's all there