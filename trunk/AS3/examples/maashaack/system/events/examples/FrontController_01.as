
package examples 
{
    import system.events.EventDispatcher;
    import system.events.FrontController;
    
    import flash.display.Sprite;
    import flash.events.Event;    

    /**
     * This class provides an example of the FrontController class 
     * with this static method getInstance().
     */
    public class FrontController_01 extends Sprite 
    {

        public function FrontController_01()
        {
        
            var controller:FrontController = FrontController.getInstance( "myChannel" ) ;
            var dispatcher:EventDispatcher = EventDispatcher.getInstance( "myChannel" ) ;
            
            controller.add( "type1" , listener1 ) ;
            controller.add( "type2" , listener2 ) ;
            
            dispatcher.dispatchEvent( new Event( "type1" ) ) ; // # action1 : type1
            dispatcher.dispatchEvent( new Event( "type2" ) ) ; // # action2 : type2
            
        }
        
        public function listener1( e:Event ):void 
        {
            trace("# action1 : " + e.type ) ; 
        }

        public function listener2( e:Event ):void 
        {
            trace("# action2 : " + e.type ) ; 
        }
        
    }
}
