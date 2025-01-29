public with sharing class OrderHelper {

    /**
     * @name AfterUpdate
     * @description
     * @param List<Order> newList
     * @param List<Order> oldList
     * @return void
    **/
    public static void AfterUpdate(List<Order> newList, List<Order> oldList){
        Set<Id> orderIds = new Set<Id>();
        for (Integer i = 0; i < newList.size(); i++){
            if (newList[i].Status == Constants.ACTIVATED_ORDER_STATUS && oldList[i].Status == Constants.DRAFT_ORDER_STATUS){
                orderIds.add(newList[i].Id);
            }
        }
        RollUpOrderItems(orderIds);
    }

    /**
     * @name RollUpOrderItems
     * @description Given a set of Activated Order ids, query the child Order Items and related Products to calculate Inventory levels
     * @param Set<Id> activatedOrderIds
     * @return void
    **/
    public static void RollUpOrderItems(Set<Id> activatedOrderIds){
        //ToDo: Declare a Map named "productMap" of Ids to Product2 records
        Map<Id, Product2> productMap = new Map<Id, Product2>();
        //ToDo: Loop through a query of OrderItems related to the activatedOrderIds
        for (OrderItem oi : [SELECT Id, Product2Id, Quantity FROM OrderItem WHERE OrderId IN :activatedOrderIds] ){
            //ToDo: Populate the map with the Id of the related Product2 as the key and Product2 record as the value
            if(!productMap.containsKey(oi.Product2Id)){
                productMap.put(oi.Product2Id, oi.Product2Id);
                System.debug(productMap);
            }
        }
        //ToDo: Loop through a query that aggregates the OrderItems related to the Products in the ProductMap keyset
        for (AggregateResult ag : [SELECT Product2Id, SUM(Quantity) totalQuantity FROM OrderItem WHERE Product2Id IN :productMap.keySet() GROUP BY Product2Id] ){
        //ToDo: Perform an update on the records in the productMap
            Id product2Id = (Id)ag.get('Product2Id');
            Product2 prod = productMap.get(product2Id);
            prod.Quantity_Ordered__c = (Decimal)ag.get('expr0');
            productMap.put(product2Id, prod);
        }
        try {
            if(productMap.values().size() != null && productMap.values().size() > 0){
                update productMap.values();
            }
        }catch(Exception e){
            System.debug(Constants.ERROR_MESSAGE + ' ' + e.getMessage());
        }
    }

}