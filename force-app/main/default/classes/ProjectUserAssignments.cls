/**
 * Domain layer for assigning users to a project
 * <p>
 * Directly correlates to Harvest's "Project User Assignments"
 * and the "User Project Assignments" models
 *
 * @author Raphael Krausz
 * @date   2018-05-20
 */
public class ProjectUserAssignments extends fflib_SObjectDomain {

  // public ProjectUserAssignments(List<Project_User_Assignment__c> sObjectList) {
  //   super(sObjectList);
  // }

  // public class Constructor implements fflib_SObjectDomain.IConstructable {
  //   public fflib_SObjectDomain construct(List<SObject> sObjectList) {
  //     return new ProjectUserAssignments(sObjectList);
  //   }
  // }

  // /**
  //  * Apply Defaults to Project User Assignments
  //  * <p>
  //  * Auto-populated data on create and update
  //  * <p>
  //  * Optional fields defaults:
  //  * Is_Active__c          - true
  //  * Is_Project_Manager__c - false for regular users
  //  * Is_Project_Manager__c - true  for system administrators*
  //  * Is_Project_Manager__c - true  for project managers*
  //  * Hourly_Rate__c        - defaults to 0
  //  * <p>
  //  * * PM and sys admin defaults not implemented yet for
  //  * the Is_Project_Manager__c field (out of current scope)
  //  * <p>
  //  * At the moment, Is_Active__c and Is_Project_Manager__c are handled
  //  * by the SF object defaults.
  //  *
  //  */
  // public override void onApplyDefaults() {

  //   for(Project_User_Assignment__c puc : (List<Project_User_Assignment__c>) Records) {
  //     if (puc.Hourly_Rate__c == null)
  //       puc.Hourly_Rate__c = 0;

  //   }
  // }


  // public override void onValidate() {

  //   List<Id> projectIdList = new List<Id>();
  //   List<Id> userIdList    = new List<Id>();

  //   for(Project_User_Assignment__c puc : (List<Project_User_Assignment__c>) Records) {
  //     projectIdList.add(puc.Project__c);
  //     userIdList.add(puc.User__c);
  //   }



  // }



}

/*
 * Required fields:
 *
 * Project__c
 * User__c
 *
 *
 * Defaults - default values for optional fields:
 *
 * Is_Active__c - true
 * Is_Project_Manager__c - false for regular users
 * Is_Project_Manager__c - true  for system administrators
 * Is_Project_Manager__c - true  for project managers
 * Hourly_Rate__c        - defaults to 0
 *
 * No default on: Budget__c
 *
 */
