
package examples 
{
    import system.events.EventDispatcher;
    import system.events.EventListener;
    import system.events.FrontController;
    
    import flash.display.Sprite;
    import flash.events.Event;    

    [SWF(width="740", height="480", frameRate="24", backgroundColor="#666666")]

    /**
     * Basic example to use the FrontController class and register an EventListener
     * and a simple function.
     */
    public class FrontControllerExample01 extends Sprite implements EventListener
    {

        public function FrontControllerExample01()
        {
            var controller:FrontController = new FrontController() ;
            var dispatcher:EventDispatcher = EventDispatcher.getInstance() ;
            
            controller.add( "type1" , this     ) ;
            controller.add( "type2" , listener ) ;
            
            dispatcher.dispatchEvent( new Event( "type1" ) ) ; // # action1 : type1
            dispatcher.dispatchEvent( new Event( "type2" ) ) ; // # action2 : type2
        }
        
        /**
         * Handles the event with an EventListener object 
         * (implementation with the EventListener interface).
         */
        public function handleEvent(e:Event):void
        {
            trace("# handleEvent : " + e.type ) ; 
        }

        /**
         * Handles the event with a basic listener function.
         */
        public function listener( e:Event ):void 
        {
            trace("# handleEvent : " + e.type ) ; 
        }

    }
}
