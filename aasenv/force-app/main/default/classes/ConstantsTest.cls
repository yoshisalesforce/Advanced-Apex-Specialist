@isTest
public class ConstantsTest {
    @isTest
    public static void ConstantsTest() {
        System.assertEquals(5, Constants.DEFAULT_ROWS);
        System.assertEquals(System.Label.Select_One, Constants.SELECT_ONE);
        System.assertEquals(System.Label.Inventory_Level_Low, Constants.INVENTORY_LEVEL_LOW);
        System.assertEquals(4, Constants.PRODUCT_FAMILY.size());
        System.assertEquals('Draft', Constants.DRAFT_ORDER_STATUS);
        System.assertEquals('Activated', Constants.ACTIVATED_ORDER_STATUS);
        System.assertEquals('Inventory Announcements', Constants.INVENTORY_ANNOUNCEMENTS);
        System.assertEquals('An error has occurred, please take a screenshot with the URL and send it to IT.', Constants.ERROR_MESSAGE);
        System.assertEquals(Test.getStandardPricebookId(), Constants.STANDARD_PRICEBOOK_ID);
    }
}