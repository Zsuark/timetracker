/**
* Selector for Project User Assignments
* @author Raphael Krausz
* @date 2018-05-17
*/

public class ProjectUserAssignmentsSelector extends fflib_SObjectSelector {
  public ProjectUserAssignmentsSelector() {
    super(false);
  }



  public List<Schema.SObjectField> getSObjectFieldList() {
    return new List<Schema.SObjectField> {
      Project_User_Assignment__c.Id,
      Project_User_Assignment__c.Name,
      Project_User_Assignment__c.Is_Active__c,
      Project_User_Assignment__c.Project__c,
      Project_User_Assignment__c.User__c
    };
  }

  public Schema.SObjectType getSObjectType() {
    return Project_User_Assignment__c.sObjectType;
  }


  /**
   * Given a user Id, return the active assignments for that user
   */
  public List<Project_User_Assignment__c>
  selectByUserId(Set<Id> userIdSet) {
    if (userIdSet == null || userIdSet.isEmpty()) {
      // We should either return an empty list,
      // null or raise an error (exception)
      return new List<Project_User_Assignment__c>();
    }

    return (List<Project_User_Assignment__c>)
    Database.query(newQueryFactory().
                   setCondition('User__c IN :userIdSet').
                   setCondition('Is_Active__c = true').
                   toSOQL());
  }


  // /**
  //  * Given a list of project Ids and a list of corresponding user Ids
  //  * return a list of Project User Assignments containing the
  //  * given inputs.
  //  * <p>
  //  * The lists must be of equal length and are paired with the
  //  * corresponding position in the list.
  //  * <p>
  //  * So, a project ID in position 0 of the product ID list corresponds
  //  * to the User ID in position 0 of the user ID
  //  */
  // public List<Project_User_Assignment__c>
  // selectByProjectAndUser(List<Id> projectIds, List<Id> userIds) {

  //   // if projectIds.size() != userIds.size - return error

  //   List<Project_User_Assignment__c> unfilteredResults =
  //   (List<Project_User_Assignment__c>)
  //   Database.query(
  //                  newQueryFactory().
  //                  selectField(Project_User_Assignment__c.Id).
  //                  selectField(Project_User_Assignment__c.Name).
  //                  selectField(Project_User_Assignment__c.Is_Active__c).
  //                  selectField(Project_User_Assignment__c.Project__c).
  //                  selectField(Project_User_Assignment__c.User__c).
  //                  // selectField('Project__r.Is_Active__c').
  //                  setCondition('Project__c in :projectIds').
  //                  setCondition('User__c in :userIds').
  //                  // setCondition('Is_Active__c = true').
  //                  // setCondition('Project__r.Is_Active__c = true').
  //                  toSOQL());

  //   Map<Id, Map<Id, Project_User_Assignment__c>> projectAndUserIdMap
  //   = new Map<Id, Map<Id, Project_User_Assignment__c>>();

  //   for (Project_User_Assignment__c assignment : unfilteredResults) {

  //     Id projectId = assignment.Project__c;
  //     Id userId = assignment.User__c;

  //     Map<Id, Project_User_Assignment__c> userIdToAssignmentMap;

  //     if (projectAndUserIdMap.containsKey(projectId)) {
  //       userIdToAssignmentMap = projectAndUserIdMap.get(projectId);
  //     } else {
  //       userIdToAssignmentMap = new Map<Id, Project_User_Assignment__c>();
  //     }

  //     userIdToAssignmentMap.put(userId, assignment);
  //     projectAndUserIdMap.put(projectId, userIdToAssignmentMap);
  //   }

  //   List<Project_User_Assignment__c> filteredResults = new List<Project_User_Assignment__c>();

  //   for (Integer i = 0; i < projectIds.size(); i++) {
  //     Id projectId = projectIds.get(i);
  //     Id userId    = userIds.get(i);

  //     if (! projectAndUserIdMap.containsKey(projectId) ) continue;
  //     Map<Id, Project_User_Assignment__c> userIdToProjectMap
  //     = projectAndUserIdMap.get(projectId);

  //     if (! userIdToProjectMap.containsKey(userId) ) continue;

  //     filteredResults.add(userIdToProjectMap.get(userId));

  //   }

  // }

}
