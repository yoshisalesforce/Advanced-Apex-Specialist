# Advanced Apex Specialist
<img src="logo.webp" width="100">

## Table of contents
- [Advanced Apex Specialist](#advanced-apex-specialist)
  - [Table of contents](#table-of-contents)
  - [Environment](#environment)
  - [Initial Setting](#initial-setting)
  - [Business Requirement](#business-requirement)
    - [Update the codebase to use best practices](#update-the-codebase-to-use-best-practices)
    - [Use custom metadata types](#use-custom-metadata-types)
  - [Update the order trigger](#update-the-order-trigger)
## Environment
**Admin<br>**
User : yr.980827@resilient-badger-2hny0t.com<br>
Pass : Cap230222,<br><br>
## Initial Setting
- [x] Register preliminary test data
- [x] Modify Product Family pick list value
## Business Requirement
### Update the codebase to use best practices
- Install [unmanaged Superbadge package](https://login.salesforce.com/packaging/installPackage.apexp?p0=04tf4000001O5si&_ga=2.154842424.1473528582.1742856606-331653713.1736060557)
- Update the **Product Family** field on the **Product2** sObject to only have the following values: Entree, Side, Dessert, Beverage
- Update the **Product page layout** to include the Initial Inventory, Quantity Ordered, and Quantity Remaining fields
- Update the **Account page layout "Account Layout"** to display the Orders related list
- Remove the **Contract Number** field from the **Order page layout** if it is currently there
- Use the methods provided in the unmanaged package without changing their name or signature unless explicitly mentioned in the requirements below.
- Insart [Preliminary Test Data](PreliminaryData.csv)
- Create Constants.apex and test class

### Use custom metadata types
- Create **<span style="color:red;">Inventory Setting</span>** and set threshold value for each product family

## Update the order trigger

