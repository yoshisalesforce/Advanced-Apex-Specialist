/**
 * @name TestDataFactory
 * @description Contains methods to construct and/or validate commonly used records
**/
public without sharing class TestDataFactory {

    /**
     * @name ConstructCollaborationGroup
     * @description
    **/
    public static CollaborationGroup ConstructCollaborationGroup(){
        //ToDo: Ensure this method returns a single Chatter CollaborationGroup
        //    whose Name starts with 'TEST' followed by the INVENTORY_ANNOUNCEMENTS constant
        //    and configured so anyone can join, see and post updates.
        CollaborationGroup chatterGroup = new CollaborationGroup(
              Name = 'TEST' + Constants.INVENTORY_ANNOUNCEMENTS,
              CollaborationType = 'Public',
              IsArchived = false,
              IsAutoArchiveDisabled = true
        );
        return chatterGroup;
    }

    /**
     * @name CreateProducts
     * @description Constructs a list of Product2 records for unit tests
    **/
    public static List<Product2> ConstructProducts(Integer cnt){
        //ToDo: Ensure this method returns a list, of size cnt, of uniquely named Product2 records
        //  with all the required fields populated
        //  and IsActive = true
        //  an Initial Inventory set to 10
        //  and iterating through the product family picklist values throughout the list.
        List<Product2> prods = new List<Product2>();
        for(Integer i = 0; i < cnt; i++){
            Integer j = Math.mod(i, Constants.PRODUCT_FAMILY.size());
            Product2 prod = new Product2(Name = 'Test' + i, IsActive = true, Initial_Inventory__c = 10, Family = Constants.PRODUCT_FAMILY[j].getValue());
            system.debug(prod);
            prods.add(prod);
            system.debug(prods);
        }
        return prods;
    }

    /**
     * @name CreatePricebookEntries
     * @description Constructs a list of PricebookEntry records for unit tests
    **/
    public static List<PricebookEntry> ConstructPricebookEntries(List<Product2> prods){
        //ToDo: Ensure this method returns a corresponding list of PricebookEntries records
        //  related to the provided Products
        //  with all the required fields populated
        //  and IsActive = true
        //  and belonging to the standard Pricebook
        List<PricebookEntry> pbes = new List<PricebookEntry>();
        for(Product2 prod : prods){
            PricebookEntry pbe = new PricebookEntry(Product2Id = prod.Id, Pricebook2Id = Constants.STANDARD_PRICEBOOK_ID, UnitPrice = 100, IsActive = true);
            pbes.add(pbe);
        }
        return pbes;
    }

    /**
     * @name CreateAccounts
     * @description Constructs a list of Account records for unit tests
    **/
    public static List<Account> ConstructAccounts(Integer cnt){
        //ToDo: Ensure this method returns a list of size cnt of uniquely named Account records
        //  with all of the required fields populated.
        List<Account> accts = new List<Account>();
        for(Integer i = 0; i < cnt; i++){
            Account acct = new Account(Name = 'Test' + i);
            accts.add(acct);
        }
        return accts;
    }

    /**
     * @name CreateContacts
     * @description Constructs a list of Contacxt records for unit tests
    **/
    public static List<Contact> ConstructContacts(Integer cnt, List<Account> accts){
        //ToDo: Ensure this method returns a list, of size cnt, of uniquely named Contact records
        //  related to the provided Accounts
        //  with all of the required fields populated.
        List<Contact> cons = new List<Contact>();
        for(Integer i = 0; i < cnt; i++){
            Contact con = new Contact(FirstName = 'Test' + i, LastName = 'Contact' + i, AccountId = accts[i].Id);
            cons.add(con);
        }
        return cons;
    }

    /**
     * @name CreateOrders
     * @description Constructs a list of Order records for unit tests
    **/
    public static List<Order> ConstructOrders(Integer cnt, List<Account> accts){
        //ToDo: Ensure this method returns a list of size cnt of uniquely named Order records
        //  related to the provided Accounts
        //  with all of the required fields populated.
        List<Order> ords = new List<Order>();
        for(Integer i = 0; i < cnt; i++){
            Order ord = new Order(AccountId = accts[i].Id, Status = Constants.DRAFT_ORDER_STATUS, EffectiveDate = Date.today(), Pricebook2Id = Constants.STANDARD_PRICEBOOK_ID);
            ords.add(ord);
        }
        return ords;
    }

    /**
     * @name CreateOrderItems
     * @description Constructs a list of OrderItem records for unit tests
    **/
    public static List<OrderItem> ConstructOrderItems(integer cnt, list<pricebookentry> pbes, list<order> ords){
        //ToDo: Ensure this method returns a list of size cnt of OrderItem records
        //  related to the provided Pricebook Entries
        //  and related to the provided Orders
        //  with all of the required fields populated.
        //  Hint: Use the DEFAULT_ROWS constant for Quantity as it will be used in the next challenge
        List<OrderItem> ois = new List<OrderItem>();
        for(Integer i = 0; i < cnt; i++){
            OrderItem oi = new OrderItem(OrderId = ords[i].Id, PricebookEntryId = pbes[i].Id, Quantity = Constants.DEFAULT_ROWS, UnitPrice = pbes[i].UnitPrice);
            ois.add(oi);
        }
        return ois;
    }

    /**
     * @name SetupTestData
     * @description Inserts accounts, contacts, Products, PricebookEntries, Orders, and OrderItems.
    **/
    public static void InsertTestData(Integer cnt){
        //ToDo: Ensure this method calls each of the construct methods
        //  and inserts the results for use as test data.
        if(cnt < 1){
            return;
        }
        CollaborationGroup ch = ConstructCollaborationGroup();
        insert ch;
        List<Product2> prods = ConstructProducts(cnt);
        insert prods;
        System.debug(prods);
        List<PricebookEntry> pe = ConstructPricebookEntries(prods);
        insert pe;
        System.debug(pe);
        List<Account> ac = ConstructAccounts(cnt);
        insert ac;
        List<Contact> co = ConstructContacts(cnt, ac);
        insert co;
        System.debug(co);
        List<Order> ord = ConstructOrders(cnt, ac);
        insert ord;
        System.debug(ord);
        List<OrderItem> ordi = ConstructOrderItems(cnt, pe, ord);
        insert ordi;
    }
    public static void VerifyQuantityOrdered(Product2 originalProduct, Product2 updatedProduct, Integer qtyOrdered){
        Decimal newQuantity = qtyOrdered + originalProduct.Quantity_Ordered__c;
        System.Assert.areEqual(updatedProduct.Quantity_Ordered__c ,newQuantity);
    }

}