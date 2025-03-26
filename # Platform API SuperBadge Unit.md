# Advanced Apex Specialist
<img src="logo.webp" width="100">

## Table of contents
- [Advanced Apex Specialist](#advanced-apex-specialist)
  - [Table of contents](#table-of-contents)
  - [Business Requirement](#business-requirement)
    - [Initial Setup](#initial-setup)
    - [Use Constants to Store Data](#use-constants-to-store-data)
    - [Use custom metadata types](#use-custom-metadata-types)
  - [Correctly Calculate Inventory Quantities](#correctly-calculate-inventory-quantities)
## Business Requirement
### Initial Setup
- Install [unmanaged Superbadge package](https://login.salesforce.com/packaging/installPackage.apexp?p0=04tf4000001O5si&_ga=2.154842424.1473528582.1742856606-331653713.1736060557)
- Update the **Product Family** field on the **Product2** sObject to only have the following values: Entree, Side, Dessert, Beverage
- Update the **Product page layout** to include the Initial Inventory, Quantity Ordered, and Quantity Remaining fields
- Update the **Account page layout "Account Layout"** to display the Orders related list
- Remove the **Contract Number** field from the **Order page layout** if it is currently there
- Use the methods provided in the unmanaged package without changing their name or signature unless explicitly mentioned in the requirements below.
- Insart [Preliminary Test Data](PreliminaryData.csv)
### Use Constants to Store Data
- Create **Constants.apex** to
- Create **two custom labels("Select One" and "Inventory Level Low")**
### Use custom metadata types
- Create **Inventory Setting** and set threshold value for each product family</br>

  **Inventory Setting's metadata type**
  | Field | Value |
  | --- | --- |
  | Type | Number |
  | Field Label	| Low Quantity Alert |
  | Length | 18 |
  | Decimal Places | 0 |
  | Field Name | Low_Quantity_Alert |

  **Custom metadata records**
  | Label | Low Quantity Alert |
  | --- | --- |
  |Entree|20|
  |Side|10|
  |Dessert|15|
  |Beverage|5|

## Correctly Calculate Inventory Quantities
To solve following issues
1. The value of the Quantity Ordered field isn’t accurate
1. Saving a new order is often impossible because of system errors
1. Draft orders—orders that are in-flight but not yet activated—decrement available inventory prematurely.
