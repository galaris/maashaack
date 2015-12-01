## Introduction ##

A Configurator allow you to configure options of an application and/or packages.

| **important:** this way of doing gonna change in a futur iteration |
|:-------------------------------------------------------------------|

## Details ##

By default, at the root of your application you can have a config variable
that can allow you to configure (duh!) the application.

By extension, this main config also allow you to configure packages within the application.

Ideally you would want this configuration to be dynamically loaded,
so you could change behaviours within your application at runtime,
but you also want to have the default configuration hardcoded for cases
where someone forgot to copy this config file, or delete it, or if you simply
don't need it.


### Configurator ###

The usage is pretty basic, let's see how to create a default config.

define your custom configurator
```
package com.myapp
{
    import system.Configurator;
    
    public class ApplicationConfigurator extends Configurator
    {
        public function ApplicationConfigurator( config:Object )
        {
            super( config );
        }

        public function get debug():Boolean
        {
            return _config.debug;
        }

        public function set debug( value:Boolean ):void
        {
            _config.debug = value;
        }
    }
}
```

then instantiate it
```
package com.myapp
{
    public var config:ApplicationConfigurator = new ApplicationConfigurator( {debug:false} );
}
```

Alternatively you can also make this config a [Singleton](Singleton.md) by declaring it as a constant
```
package com.myapp
{
    public const config:ApplicationConfigurator = new ApplicationConfigurator( {debug:false} );
}
```


### Dynamically load your configuration ###

In addition to the classes above, here how you can load your config in your application

```
package
{
    import flash.display.Sprite;
    import flash.events.Event;
    import flash.events.IOErrorEvent;
    import flash.net.URLLoader;
    import flash.net.URLLoaderDataFormat;

    import system.eden;

   import  com.myapp.config;

    public class Application extends Sprite
    {
        private var _config:URLLoader;

        public function Application()
        {
            _config = new URLLoader();
            _config.dataFormat = URLLoaderDataFormat.TEXT;
       
            _config.addEventListener( Event.COMPLETE, onConfigLoaded );
            _config.addEventListener( IOErrorEvent.IO_ERROR, onConfigError );

            if( stage )
            {
                onAddedToStage();
            }
            else
            {
                addEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
            }
        }

        private function _configure():void
        {
            _config.load( new URLRequest( "config.txt" ) );
        }

        private function _run():void
        {
            //build your app here
            // if config.debug etc.
        }

        private function onAddedToStage( event:Event = null ):void
        {
            removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
            _configure();
        }

        private function onConfigError( event:IOErrorEvent ):void
        {
            trace( "## Error : could not find \"config.txt\" ##" );
            _run();
        }

        private function onConfigLoaded( event:Event ):void
        {
            var source:String = event.target.data as String;
            var newconfig:*   = eden.deserialize( source );

            config.load( newconfig ); //reference com.myapp.config
        }

    }

}
```