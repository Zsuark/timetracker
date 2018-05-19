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
   * Given a set of pairs of project Ids and user Ids
   * return a list of Project User Assignments containing the
   * given inputs. (Pairs are stored as List<Id>s)
   */
  public List<Project_User_Assignment__c> selectByProductUserPairs(Set<List<Id>> projectUserPairs) {
    Set<String> assignmentNames = new Set<String>();
    for(List<Id> ids : projectUserPairs) {
      String nameString = ids[0] + '::' + ids[1];
      assignmentNames.add(nameString);
    }

    return selectByName(assignmentNames);
  }

  public List<Project_User_Assignment__c> selectByName(Set<String> nameSet) {
    return (List<Project_User_Assignment__c>)
    Database.query(
                   newQueryFactory().
                   selectField(Project_User_Assignment__c.Id).
                   selectField(Project_User_Assignment__c.Name).
                   selectField(Project_User_Assignment__c.Is_Active__c).
                   selectField(Project_User_Assignment__c.Project__c).
                   selectField(Project_User_Assignment__c.User__c).
                   selectField('Project__r.Is_Active__c').
                   setCondition('Name in :nameSet').
                   setCondition('Is_Active__c = true').
                   setCondition('Project__r.Is_Active__c = true').
                   toSOQL());
  }



}
