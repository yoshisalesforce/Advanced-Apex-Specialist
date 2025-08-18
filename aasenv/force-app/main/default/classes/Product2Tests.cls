@isTest(seeAllData=false)
private class Product2Tests {
    
    /**
     * @name product2Extension_UnitTest
     * @description UnitTest for product2Extension
     **/
    @isTest
    private static void Product2Extension_UnitTest(){
        Test.setCurrentPage(Page.Product2New);
        Test.startTest();
        // StandardControllerを作成してProduct2Extensionをインスタンス化
        ApexPages.StandardController stdController = new ApexPages.StandardController(new Product2());
        Product2Extension ext = new Product2Extension(stdController);
        Assert.areEqual(Constants.DEFAULT_ROWS, ext.productsToInsert.size());
        ext.addRows();
        Assert.areEqual(Constants.DEFAULT_ROWS * 2 , ext.productsToInsert.size());
        for(Integer i = 0; i < Constants.DEFAULT_ROWS; i++){
            ext.productsToInsert[i].productRecord.Name = 'Updated Product' + i;
            ext.productsToInsert[i].productRecord.Family = 'Side';
            ext.productsToInsert[i].productRecord.IsActive = true;
            ext.productsToInsert[i].productRecord.Initial_Inventory__c = 100;
            ext.productsToInsert[i].pricebookEntryRecord.UnitPrice = 50;
        }
        ext.save();
        Assert.areEqual(5, [SELECT COUNT() FROM Product2]);
        Test.stopTest();
    }
    @isTest
    private static void updateProduct(){
        Product2 prod = new Product2(Name = 'Test Product', IsActive = true, Initial_Inventory__c = 100, Family = 'Side');
        insert prod;
        Test.startTest();
        prod.Name = 'Updated Product';
        prod.Family = 'Dessert';
        prod.Initial_Inventory__c = 10;
        update prod;
        Test.stopTest();
    }
}