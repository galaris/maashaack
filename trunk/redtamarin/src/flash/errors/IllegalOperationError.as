package flash.errors
{
   /**
    * The IllegalOperationError exception is thrown when a method is not implemented or the 
    * implementation doesn't cover the current usage.
    * 
    * Examples of illegal operation error exceptions include:
    * <ul>
    *     <li>A base class, such as DisplayObjectContainer, provides more functionality than a Stage 
    * can support (such as masks)</li>
    *     <li>Certain accessibility methods are called when Flash Player is compiled without accessibility 
    * support</li>
    *     <li>The mms.cfg setting prohibits a FileReference action</li>
    *     <li>ActionScript tries to run a FileReference.browse() call when a browse dialog box is already up</li>
    *     <li>ActionScript tries to use an unsupported protocol for FileReference (such as FTP)</li>
    * <span class="flashonly">
    *     <li>Authoring only features are invoked from a run-time player.</li>
    *     <li>An attempt is made to set the name of a timeline-placed object.</li>
    * </span>
    * </ul>
    * 
    *
    * 
    * @includeExample examples\IllegalOperationErrorExample.as -noswf
    * 
    * @playerversion Flash 9
    * @langversion 3.0
    * @helpid
    * @refpath 
    * @keyword Error
    */
    public dynamic class IllegalOperationError extends Error {
        /**
        * Creates a new IllegalOperationError object.
        * 
        * @param message A string associated with the error object.
        *
        * @playerversion Flash 9
        * @langversion 3.0
        * @helpid
        * @refpath 
        * @keyword
        **/
        function IllegalOperationError(message:String = "") {
            super(message);
        }   
    }
}