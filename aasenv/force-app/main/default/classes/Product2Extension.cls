public class Product2Extension {
    // メンバー変数を追加
    public List<productWrapper> productsToInsert {get;set;}
    public List<SelectOption> familyOptions {get;set;}
    public List<ChartHelper.ChartData> inventory {get;set;}
    // コンストラクタを追加
    public Product2Extension(ApexPages.StandardController stdController) {
        this.productsToInsert = new List<productWrapper>();
        this.familyOptions = getFamilyOptions();
        addRows();
    }
    // メソッドを追加
    public List<SelectOption> getFamilyOptions(){
        List<SelectOption> options = new List<SelectOption>{new SelectOption('',Constants.SELECT_ONE)};
        for ( Schema.PicklistEntry entry : Constants.PRODUCT_FAMILY ){
            options.add(new SelectOption(entry.getLabel(), entry.getValue()));
        }
        return options;
    }
    public void AddRows(){
        for ( Integer i=0; i<Constants.DEFAULT_ROWS; i++ ){
            this.productsToInsert.add(new productWrapper());
        }
    }
    public List<ChartHelper.ChartData> getInventory(){
        return ChartHelper.GetInventory();
    }
    // トランザクションを追加
    public PageReference addInventory(){
        this.inventory = new List<ChartHelper.ChartData>();
        List<ChartHelper.ChartData> cds = getInventory();
        for (ChartHelper.ChartData cd : cds){
            if(cd.name != null){
                this.inventory.add(cd);
            }
        }
        return null;
    }
    public PageReference save(){
        Savepoint sp = Database.setSavepoint();
        try {
            List<Product2> products = new List<Product2>();
            List<PricebookEntry> pricebookEntries = new List<PricebookEntry>();
            for ( productWrapper pw : productsToInsert ){
                if(pw.productRecord.Name != null || pw.productRecord.Family != null || pw.productRecord.Quantity_Remaining__c != null){
                    products.add(pw.productRecord);
                }
            }
            insert(products);
            for (Integer i = 0; i<productsToInsert.size() ; i++){
                if(productsToInsert[i].pricebookEntryRecord.UnitPrice != null){
                    PricebookEntry pbe = productsToInsert[i].pricebookEntryRecord;
                    pbe.Product2Id = products[i].Id;
                    pbe.Pricebook2Id = Constants.STANDARD_PRICEBOOK_ID;
                    pbe.IsActive = true;
                    pricebookEntries.add(pbe);
                }
            }
            insert(pricebookEntries);
            //If successful clear the list and display an informational message
            productsToInsert.clear();   //Do not remove
            addRows();  //Do not remove
        } catch (Exception e){
            //If an error occurs display an error message
            Database.rollback(sp);  // 保存ポイントにロールバック
            apexPages.addMessage(new ApexPages.Message(ApexPages.Severity.ERROR, Constants.ERROR_MESSAGE));
        }
        return null;
    }
    // クラスを追加
    public class productWrapper{
        public Product2 productRecord {get;set;}
        public PricebookEntry pricebookEntryRecord {get;set;}
        // コンストラクタを追加
        public productWrapper() {
            this.productRecord = new Product2();
            this.pricebookEntryRecord = new PricebookEntry();
        }
    }
}