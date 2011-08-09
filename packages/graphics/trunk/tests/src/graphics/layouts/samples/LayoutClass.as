package graphics.layouts.samples 
{
    import graphics.layouts.Layout;
    
    import system.signals.Signaler;
    
    import flash.display.DisplayObjectContainer;
    import flash.geom.Rectangle;
    
    public class LayoutClass implements Layout 
    {
        public function get align():uint
        {
            return _align;
        }
        
        public function set align(value:uint):void
        {
            _align = value;
        }
        
        public function get bounds():Rectangle
        {
            return _bounds;
        }
        
        public function set bounds(area:Rectangle):void
        {
            _bounds = area;
        }
        
        public function get container():DisplayObjectContainer
        {
            return _container;
        }
        
        public function set container(container:DisplayObjectContainer):void
        {
            _container = container ;
        }
        
        public function get measuredHeight():Number
        {
            return _bounds.height;
        }
        
        public function set measuredHeight(value:Number):void
        {
            _bounds.height = value;
        }
        
        public function get measuredWidth():Number
        {
            return _bounds.width;
        }
        
        public function set measuredWidth(value:Number):void
        {
            _bounds.width = value;
        }
        
        public function get renderer():Signaler
        {
            return _renderer;
        }
        
        public function set renderer(signal:Signaler):void
        {
            _renderer = signal ;
        }
        
        public function set udpater(signal:Signaler):void
        {
            _updater = signal ;
        }
        
        public function get udpater():Signaler
        {
            return _updater;
        }
        
        public function isLocked():Boolean
        {
            return _locked;
        }
        
        public function lock():void
        {
            _locked = true;
        }
        
        public function unlock():void
        {
            _locked = false;
        }
        
        public function measure():void
        {
            throw "measure";
        }
        
        public function render():void
        {
            throw "render";
        }
        
        public function run(...arguments:Array):void
        {
            throw "run";
        }
        
        public function update():void
        {
            throw "update";
        }
        
        private var _align:uint;
        
        private var _bounds:Rectangle;
        
        private var _container:DisplayObjectContainer ;
        
        private var _locked:Boolean ;
        
        private var _renderer:Signaler ;
        
        private var _updater:Signaler ;
    }
}
