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

  public List<Project__c> selectById(Set<ID> idSet) {
    return (List<Project__c>) selectSObjectsById(idSet);
  }

}
