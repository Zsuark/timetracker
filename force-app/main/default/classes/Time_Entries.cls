public with sharing class Time_Entries extends fflib_SObjectDomain {
    public Time_Entries(List<Time_Entry__c> sObjectList) {
        super(sObjectList);
    }

    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new Opportunities(sObjectList);
        }
    }    
}

/*
 The user needs to be able to add a time entry

  The task specified must belong to the project.
  The user should be on the project that task is assigned to.


  TODO: Add a before insert / before update triggers
   - check the project exists
   - check the task belongs to the project
   - check the user belongs to the project
   
   LATER:
   - check the timesheet is not locked
*/
