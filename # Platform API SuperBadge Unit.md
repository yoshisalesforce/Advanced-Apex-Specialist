# Advanced Apex Specialist
<img src="logo.webp" width="100">

## Table of contents
- [Advanced Apex Specialist](#advanced-apex-specialist)
  - [Table of contents](#table-of-contents)
  - [Environment](#environment)
  - [Business Requirement](#business-requirement)
  - [Insert Lead data as CSV using Bulk2.0 in Postman](#insert-lead-data-as-csv-using-bulk20-in-postman)
  - [Optimize Workshop Registration](#optimize-workshop-registration)
  - [Streamline the Drone Kit Purchase](#streamline-the-drone-kit-purchase)
## Environment
**Admin<br>**
User : ~~ry241106@gmail.com~~ yr.980827@resilient-badger-2hny0t.com<br>
Pass : ~~cg241106~~ Cap230222,<br><br>
**Integration user<br>**
User : integration.user.krpsozmwkei6.5jctgllnuijl@gmail.com<br>
Pass : cg241106

## Business Requirement
-

## Insert Lead data as CSV using Bulk2.0 in Postman
I refered to [This URL](https://medium.com/@sdas199421/how-to-insert-csv-using-bulk-api-2-0-of-salesforce-and-postman-8f72e4ecf8e9).<br>
Flow:
1. Post Creating Job
1. Put Uploading Job data
1. Patch Updating Status
1. Get Checking Statuss

## Optimize Workshop Registration
- When an attendee attends the workshop, their badge is scanned.
- The requirment is to stremline the process to createn a new opportunity for the sale of an advanced traing course as well as related task to send email on the opportunity.
- Should form a new task related contact with a note
- Create a case to send a survey and get their feedback about the course

1. Create a contact record with the name Emily Cloudshine.
1. Create a related opportunity for the advanced training course with the following details.
   - Name: Advanced Training
   - Stage: Prospecting
   - Close Date: Any date
1. Create a task related to the contact and opportunity, using any field values for subject and priority.
1. Create a related task for the contact with the following details.
   - Subject: Learning Resources
   - Priority: Normal
1. Create a related case for survey feedback with the following details.
   - Subject: Class Survey
   - Priority: Low
   - Status: New

[Sample Request](reqbody.json)

## Streamline the Drone Kit Purchase
[Sample Request](reqbody2.json)
