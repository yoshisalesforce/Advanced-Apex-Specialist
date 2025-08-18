@isTest
private class OrderTests {
  @TestSetup static void SetupTestData() {
    TestDataFactory.InsertTestData(1);
  }

  @isTest
  public static void OrderUpdate_UnitTest(){
    // テスト前のProduct2のQuantity_Ordered__cを取得
    List<Product2> productsBefore = [SELECT Id, Quantity_Ordered__c FROM Product2];
    Map<Id, Product2> productsBeforeMap = new Map<Id, Product2>(productsBefore);

    List<Order> orders = [SELECT Id, Status FROM Order];
    for(Order order : orders){
      system.debug(
        'Order before update: ' + order.Id + ' - Status: ' + order.Status
      );
      order.Status = Constants.ACTIVATED_ORDER_STATUS;
      system.debug(
        'Order after update: ' + order.Id + ' - Status: ' + order.Status
      );
    }
    test.startTest();
    update orders;
    test.stopTest();

    // テスト後のProduct2のQuantity_Ordered__cを取得
    List<Product2> productsAfter = [SELECT Id, Quantity_Ordered__c FROM Product2];

    // VerifyQuantityOrderedメソッドを使用して検証
    for(Product2 productAfter : productsAfter){
      Product2 productBefore = productsBeforeMap.get(productAfter.Id);
      TestDataFactory.VerifyQuantityOrdered(productBefore, productAfter, Constants.DEFAULT_ROWS);
    }
  }

  @isTest
  public static void OrderUpdate_NoStatusChange_UnitTest(){
    // ステータスを変更しない場合のテスト
    List<Product2> productsBefore = [SELECT Id, Quantity_Ordered__c FROM Product2];
    Map<Id, Product2> productsBeforeMap = new Map<Id, Product2>(productsBefore);

    List<Order> orders = [SELECT Id, Status FROM Order];
    // ステータスを変更せずに更新
    test.startTest();
    update orders;
    test.stopTest();

    // Assertion: Product2のQuantity_Ordered__cが変更されていないことを確認
    List<Product2> productsAfter = [SELECT Id, Quantity_Ordered__c FROM Product2];
    for(Product2 productAfter : productsAfter){
      Product2 productBefore = productsBeforeMap.get(productAfter.Id);
      System.assertEquals(
        productBefore.Quantity_Ordered__c,
        productAfter.Quantity_Ordered__c,
        'Product Quantity_Ordered__c should not change when order status is not changed to Activated'
      );
    }
  }
}