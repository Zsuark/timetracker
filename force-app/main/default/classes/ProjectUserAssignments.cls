/**
 * Domain layer for assigning users to a project
 * <p>
 * Directly correlates to Harvest's "Project User Assignments" model
 *
 * @author Raphael Krausz
 * @date   2018-05-20
 */
public class ProjectUserAssignments extends fflib_SObjectDomain {

    public ProjectUserAssignments(List<Project_User_Assignment__c> sObjectList) {
        super(sObjectList);
    }

    public class Constructor implements fflib_SObjectDomain.IConstructable {
        public fflib_SObjectDomain construct(List<SObject> sObjectList) {
            return new ProjectUserAssignments(sObjectList);
        }
    }
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
