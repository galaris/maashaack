package flash.errors
{
    /**
     * This class contains the constants that represent the possible values for
     * the <code>SQLError.operation</code> property.
     * These values indicate the attempted operation that caused the error to occur.
     * 
     * @langversion ActionScript 3.0
     * @playerversion AIR 1.0
     */
    [API(CONFIG::AIR_1_0)]
    public class SQLErrorOperation
    {
        [API(CONFIG::AIR_1_0)] public static const ANALYZE:String = "analyze";
        [API(CONFIG::AIR_1_0)] public static const ATTACH:String = "attach";
        [API(CONFIG::AIR_1_0)] public static const BEGIN:String = "begin";
        [API(CONFIG::AIR_1_0)] public static const CLOSE:String = "close";
        [API(CONFIG::AIR_1_0)] public static const COMMIT:String = "commit";
        [API(CONFIG::AIR_1_0)] public static const COMPACT:String = "compact";
        [API(CONFIG::AIR_1_0)] public static const DEANALYZE:String = "deanalyze";
        [API(CONFIG::AIR_1_0)] public static const DETACH:String = "detach";
        [API(CONFIG::AIR_1_0)] public static const EXECUTE:String = "execute";
        [API(CONFIG::AIR_1_0)] public static const OPEN:String = "open";
        [API(CONFIG::AIR_1_5)] public static const REENCRYPT:String = "reencrypt";
        [API(CONFIG::AIR_2_0)] public static const RELEASE_SAVEPOINT:String = "releaseSavepoint";
        [API(CONFIG::AIR_1_0)] public static const ROLLBACK:String = "rollback";
        [API(CONFIG::AIR_2_0)] public static const ROLLBACK_TO_SAVEPOINT:String = "rollbackToSavepoint";
        [API(CONFIG::AIR_1_0)] public static const SCHEMA:String = "schema";
        [API(CONFIG::AIR_2_0)] public static const SET_SAVEPOINT:String = "setSavepoint";
    }
}