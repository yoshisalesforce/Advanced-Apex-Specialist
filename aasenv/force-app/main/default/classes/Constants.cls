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
    public static String DRAFT_ORDER_STATUS = 'Draft';
    public static String ACTIVATED_ORDER_STATUS = 'Activated';
    public static String INVENTORY_ANNOUNCEMENTS = 'Inventory Announcements';
    public static String ERROR_MESSAGE = 'An error has occurred, please take a screenshot with the URL and send it to IT.';
    public static String STANDARD_PRICEBOOK_ID = '01sIS000002mzhRYAQ';

}