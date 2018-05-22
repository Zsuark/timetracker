public with sharing class ProjectListController {

  @AuraEnabled
  public static List<Project__c> getProjectForCurrentUser() {
    Id uid = UserInfo.getUserId();
    return new ProjectsSelector().selectByUserId(new Set<Id>{ uid }) ;
  }

}
