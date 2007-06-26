
package avmplus
    {

    public class Domain
        {
        public function Domain()
            {
            }
        public function getClass(className:String):Class
            {
            return Object;
            }
        public static function get currentDomain():Domain
            {
            return new Domain();
            }
        }
 
    }

