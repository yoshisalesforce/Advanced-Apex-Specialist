public with sharing class Constants {
    public static Integer DEFAULT_ROWS = 5;
    public static String SELECT_ONE = System.Label.Select_One;
    public static String INVENTORY_LEVEL_LOW = System.Label.Inventory_Level_Low;
    public static List<Schema.PicklistEntry> PRODUCT_FAMILY {
        get{
            Schema.DescribeFieldResult F = Product2.Family.getDescribe();
            return F.getPicklistValues();
        }
    }
}