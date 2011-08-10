This file is an example of configuration file to customize the MySQL connection.

In a configuration with severals OS for one project(ex. OSX, Windows...) the MySQL port couldn't be the same
and this file could customize this difference renaming it to mysql.properties 
and ignoring it in the local repository.

There are 3 possibilities to configure mysql connection:

1- Creates a custom .properties file and defines it in the MysqlConfig constructor.
2- Creates a mysql.properties, if the custom file doesn't exit MysqlConfig tries to open this one.
3- Configures the default_mysql.properties, if custom file and mysql.properties file don't exist, 
the MysqlConfig class tries to open this one and configures the MySQL connection.


USAGE:
{{{
<?php
    require_once ("../src/egallery/net/mysql/MysqlConfig.php") ;
    require_once ("../src/egallery/net/mysql/Tables.php") ;
    require_once ("../src/egallery/net/mysql/MysqlConnector.php") ;
    require_once ("../src/egallery/vo/PictureVO.php") ;
    
    /**
     * This AMFPhp remoting service is used to return the list of all pictures in a gallery.
     */
    class Gallery
    {
       
        /**
         * Creates a new Gallery instance.
         */
        function Gallery() 
        {
            $mysqlConfig   = new MysqlConfig() ;
            $this->connect = new MysqlConnector( $mysqlConfig->host , $mysqlConfig->user , $mysqlConfig->pass , $mysqlConfig->name ) ;
...     }
    }
?>
}}}