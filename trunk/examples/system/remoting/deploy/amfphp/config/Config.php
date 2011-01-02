<?php
    /**
     * Define the app config.
     */
    class Config
    {
        /**
         * Is the app on localhost for dev ?
         */
        const LOCALE = 1 ;
        
        /**
         * The recorder app id in shop DB.
         */
        const PRODUCT_ID = 3 ;
        
        /**
         * The states of the recorder app.
         */
        const ERROR_STATE   = "reject_state";
        const MAIN_STATE    = "recorder_state"; //"home_state";
        
        /**
         * The maximum duration time for a video (milliseconds)
         */
        const DURATION = 120000; 
    }
?>