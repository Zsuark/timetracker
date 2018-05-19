trigger TimeEntryTrigger
  on Time_Entry__c
  (after delete, after insert, after update, after undelete,
   before delete, before insert, before update) {
  // Creates Domain class instance and calls appropriate methods
  fflib_SObjectDomain.triggerHandler(TimeEntries.class);
}
