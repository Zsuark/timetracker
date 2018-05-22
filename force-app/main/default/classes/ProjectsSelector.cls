/**
* Selector for Projects
* @author Raphael Krausz
* @date 2018-05-17
*/

public class ProjectsSelector extends fflib_SObjectSelector {

  public List<Schema.SObjectField> getSObjectFieldList() {
    return new List<Schema.SObjectField> {
      Project__c.Id,
      Project__c.Client__c,
      Project__c.Is_Active__c
    };
  }


  public Schema.SObjectType getSObjectType() {
    return Project__c.sObjectType;
  }

  public List<Project__c> selectById(Set<Id> idSet) {
    return (List<Project__c>) selectSObjectsById(idSet);
  }


  public List<Project__c> selectByUserId(Set<Id> userIdSet) {
    if (userIdSet == null || userIdSet.isEmpty()) {
      // We should either return an empty list,
      // null or raise an error (exception)
      return new List<Project__c>();
    }

    List<Project_User_Assignment__c> assignments =
    new ProjectUserAssignmentsSelector().selectByUserId(userIdSet);

    if (assignments == null || assignments.isEmpty()) {
      return new List<Project__c>();
    }

    Set<Id> projectIdSet = new Set<Id>();
    for (Project_User_Assignment__c assignment : assignments) {
      projectIdSet.add(assignment.Project__c);
    }


    return (List<Project__c>)
    Database.query(newQueryFactory(false).
                   selectField(Project__c.Id).
                   selectField(Project__c.Name).
                   selectField(Project__c.Code__c).
                   selectField('Client__r.Name').
                   selectField('Client__r.Id').
                   setCondition('Project__c IN :projectIdSet').
                   setCondition('Is_Active__c = true').
                   toSOQL());
  }



}
