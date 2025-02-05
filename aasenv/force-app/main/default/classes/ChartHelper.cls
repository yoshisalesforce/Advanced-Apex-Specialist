public without sharing class ChartHelper {
    @AuraEnabled(cacheable=true)
    public static List<ChartData> GetInventory(){
        List<ChartData> cht = new List<ChartData>();
        //ToDo: Perform a calculation that aggregates active Products that have a positive Quantity_Remaining__c
        //  And return a list of chartData
        //  Where the name is the Product Family and the Qty is the sum of the Quantity_Remaining__c
        // 商品の集計処理
        Map<String, Decimal> inventoryMap = new Map<String, Decimal>();

        // クエリで有効な在庫ありの Product2 を取得
        List<AggregateResult> results = [
            SELECT Family, SUM(Quantity_Remaining__c) totalQty
            FROM Product2
            WHERE IsActive = true AND Quantity_Remaining__c > 0
            GROUP BY Family
        ];

        // 取得したデータをマップに格納
        for (AggregateResult ar : results) {
            String familyName = (String) ar.get('Family');
            Decimal totalQty = (Decimal) ar.get('totalQty');
            inventoryMap.put(familyName, totalQty);
        }

        // 結果を ChartData のリストに変換
        for (String family : inventoryMap.keySet()) {
            cht.add(new ChartData(family, inventoryMap.get(family)));
        }

        return cht;
    }

    public class ChartData {
        public String name {get;set;}
        public Decimal val {get;set;}

        public ChartData(String name, Decimal val){
            this.name = name;
            this.val = val;
        }
    }

}