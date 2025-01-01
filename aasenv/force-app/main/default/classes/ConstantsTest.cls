@isTest
public with sharing class ConstantsTest {
    @isTest
    public static void ConstantsTest() {
        System.assertEquals(5, Constants.DEFAULT_ROWS);
        System.assertEquals(System.Label.Select_One, Constants.SELECT_ONE);
        System.assertEquals(System.Label.Inventory_Level_Low, Constants.INVENTORY_LEVEL_LOW);
        System.assertEquals(4, Constants.PRODUCT_FAMILY.size());
    }
}