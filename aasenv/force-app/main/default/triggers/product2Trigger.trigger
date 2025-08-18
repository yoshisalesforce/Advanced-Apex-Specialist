/**
 * @name product2Trigger
 * @description Trigger to notify staff of low levels of inventory
 **/
trigger product2Trigger on Product2 (after update) {
    try {
        for (Product2 p : Trigger.New){
            if (Inventory_Setting__mdt.getInstance(p.Family).Low_Quantity_Alert__c	> p.Quantity_Remaining__c){
                AnnouncementQueueable.PostAnnouncements(announcements);
            }
        }
    } catch ( Exception e ){
        //A good developer would do something with this Exception!
    }
}