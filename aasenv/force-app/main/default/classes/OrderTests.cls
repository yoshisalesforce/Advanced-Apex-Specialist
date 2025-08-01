@isTest
private class OrderTests {
  @TestSetup static void createData() {
    TestDataFactory.InsertTestData(1);
  }
  @isTest
  public static void OrderUpdate_UnitTest(){
    List<Order> orders = [SELECT Id, Status FROM Order];
    for(Order order : orders){
      system.debug(
        'Order before update: ' + order.Id + ' - Status: ' + order.Status
      );
      order.Status = Constants.ACTIVATED_ORDER_STATUS;
      system.debug(
        'Order before update: ' + order.Id + ' - Status: ' + order.Status
      );
    }
    test.startTest();
    update orders;
    test.stopTest();
  }
}