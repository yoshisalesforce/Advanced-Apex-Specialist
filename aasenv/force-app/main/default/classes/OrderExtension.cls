/**
 * @name OrderExtension
 * @description This class is provided for you to facilitate the Super Badge
**/
public class OrderExtension {
    // フィールド
    public Order orderRecord {get;set;}
    public List<OrderItem> orderItemList {get;set;}
    public String selectedFamily {get;set;}
    public List<chartHelper.chartData> pieData {get;set;}
    public Decimal total {get;set;}
    public Integer rows {get;set;}
    public Integer pageNumber {get;set;}
    public Integer totalPages {get;set;}
    public Boolean hasPrevious {get;set;}
    public Boolean hasNext {get;set;}

    public Map<Id,OrderItem> orderItemMap;
    ApexPages.StandardSetController standardSetController;

    public OrderExtension(ApexPages.StandardController standardController){
        system.debug('スタート');
        this.orderRecord = (Order)standardController.getRecord();
        this.orderItemMap = new Map<id,OrderItem>();
        this.rows = Constants.DEFAULT_ROWS;
        this.standardSetController = new ApexPages.StandardSetController(new List<Order>());
        this.totalPages = GetTotalPages();
        this.pageNumber = GetPageNumber();
        this.hasNext = GetHasNext();
        this.hasPrevious = GetHasPrevious();
        this.pieData = new List<ChartHelper.ChartData>();
        this.total = 0;
        if ( orderRecord.Id != null ){
            orderRecord = queryOrderRecord(orderRecord.Id);
        }
        system.debug('ここ①');
        if(!orderRecord.OrderItems.isEmpty()){
            system.debug(orderRecord.OrderItems);
            if (orderRecord.OrderItems.size() > 0){
                this.orderItemList = new List<OrderItem>(orderRecord.OrderItems);
                for (OrderItem oi : this.orderItemList){
                    orderItemMap.put(oi.Product2Id,oi);
                    ChartHelper.ChartData data = new ChartHelper.ChartData(oi.Product2.Name, oi.Quantity * oi.UnitPrice);
                    if(this.pieData == null){
                        this.pieData = new List<ChartHelper.ChartData>();
                    }
                    this.pieData.add(data);
                }
            }
        }

    }

    //ToDo: Implement your own method to populate orderItemList
    //  that you will call after pagination and/or family selection


    /**
     * @name OnFieldChange
     * @description
    **/
    public void OnFieldChange(){
        //ToDo: Implement logic to store the values changed on the page
        //      and populate pieData
        //      and populate total
        this.pieData = new List<ChartHelper.ChartData>();
        this.orderItemMap = new Map<Id,OrderItem>();
        for (OrderItem oi : this.orderItemList){
            orderItemMap.put(oi.Product2Id,oi);
            ChartHelper.ChartData data = new ChartHelper.ChartData(oi.Product2.Name, oi.Quantity * oi.UnitPrice);
            if(this.pieData == null){
                this.pieData = new List<ChartHelper.ChartData>();
            }
            this.pieData.add(data);
        }
    }

    /**
     * @name SelectFamily
     * @description
    **/
    public void SelectFamily(){
        //ToDo: Implement logic to filter based on the selected product family
    }

    /**
     * @name Save
     * @description
    **/
    public void Save(){
        //ToDo: Implement logic to save the Order and populated OrderItems
        System.SavePoint sp = Database.setSavePoint();
        try {
            if(orderRecord.Pricebook2Id == null) {
                orderRecord.Pricebook2Id = Constants.STANDARD_PRICEBOOK_ID;
            }
            update orderRecord;

            List<OrderItem> orderItemsToUpsert = new List<OrderItem>();
            List<OrderItem> orderItemsToDelete = new List<OrderItem>();

            for (OrderItem oi : orderItemMap.values()) {
                if(oi.Quantity > 0) {
                    if(oi.OrderId == null) {
                        oi.OrderId = orderRecord.Id;
                    }
                    orderItemsToUpsert.add(oi);
                } else if(oi.Id != null) {
                    orderItemsToDelete.add(new OrderItem(id=oi.Id));
                    oi.Id = null;
                }
            }
            if(orderItemsToUpsert.size()>0) {upsert orderItemsToUpsert;}
            if(orderItemsToDelete.size()>0) {delete orderItemsToDelete;}
        }
        catch (Exception e){
            Database.rollback(sp);
            apexPages.addMessage(new ApexPages.message(ApexPages.Severity.INFO,Constants.ERROR_MESSAGE));
        }
    }


    /**
     * @name First
     * @description
    **/
    public void First(){
        standardSetController.first();
    }


    /**
     * @name Next
     * @description
    **/
    public void Next(){
        standardSetController.next();
    }


    /**
     * @name Previous
     * @description
    **/
    public void Previous(){
        standardSetController.previous();
    }

    /**
     * @name Last
     * @description
    **/
    public void Last(){
        standardSetController.last();
    }

    /**
     * @name GetHasPrevious
     * @description
    **/
    public Boolean GetHasPrevious(){
        return standardSetController.getHasPrevious();
    }

    /**
     * @name GetHasNext
     * @description
    **/
    public Boolean GetHasNext(){
        return standardSetController.getHasNext();
    }

    /**
     * @name GetTotalPages
     * @description
    **/
    public Integer GetTotalPages(){
        return this.standardSetController.getResultSize() / this.rows;
    }

    /**
     * @name GetPageNumber
     * @description
    **/
    public Integer GetPageNumber(){
        return this.standardSetController.getPageNumber();
    }

    /**
     * @name GetFamilyOptions
     * @description
    **/
    public List<SelectOption> getFamilyOptions(){
        List<SelectOption> options = new List<SelectOption>{new SelectOption('',Constants.SELECT_ONE)};
        for ( Schema.PicklistEntry entry : Constants.PRODUCT_FAMILY ){
            options.add(new SelectOption(entry.getLabel(), entry.getValue()));
        }
        return options;
    }

    /**
     * @name QueryOrderRecord
     * @description
    **/
    public static Order QueryOrderRecord(Id orderId){
        return [
            SELECT Id, AccountId, EffectiveDate, Name, Status, Pricebook2Id,
                (
                    SELECT Id, OrderId, Quantity, UnitPrice, PricebookEntryId, Product2Id,
                         Product2.Name, Product2.Family, Product2.Quantity_Remaining__c
                    FROM OrderItems
                )
            FROM Order
            WHERE Id = :orderId
        ];
    }

}