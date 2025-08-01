@isTest (seeAllData=true)
private class Product2Tests {

    /**
     * @name product2Extension_UnitTest
     * @description UnitTest for product2Extension
    **/
    static TestMethod void Product2Extension_UnitTest(){
        Test.startTest();
            // テスト用のProduct2レコードを作成
            Product2 testProduct = new Product2(
                Name = 'Test Product',
                Family = 'Electronics'
            );
            insert testProduct;

            // StandardControllerを作成してProduct2Extensionをインスタンス化
            ApexPages.StandardController stdController = new ApexPages.StandardController(testProduct);
            Product2Extension ext = new Product2Extension(stdController);
            ext.addRows();
            ext.save();
        Test.stopTest();
    }

}