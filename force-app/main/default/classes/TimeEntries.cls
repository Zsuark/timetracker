/**
 * @Description Domain layer of Time Entries
 * @Author: Raphael Krausz
 * @date: 2018-05-17
 */

public with sharing class TimeEntries extends fflib_SObjectDomain {
  public TimeEntries(List<Time_Entry__c> sObjectList) {
    super(sObjectList);
  }

  public class Constructor implements fflib_SObjectDomain.IConstructable {
    public fflib_SObjectDomain construct(List<SObject> sObjectList) {
      return new TimeEntries(sObjectList);
    }
  }

  /**
   * Apply Defaults to Time Entries
   *
   * Auto-populated data on create and update
   *
   * Link the time entry to the correct client
   * If the User ID is blank, fill it out with the executing user
   * If the spent date is blank, populate it with today
   * If the start time is blank, populate it with the current time
   *
   */
  public override void onApplyDefaults() {

    Set<Id> projectIdSet = new Set<Id>();

    for (Time_Entry__c te : (List<Time_Entry__c>) Records) {
      // Grab the Project__c IDs so that we can
      // populate the Client__c field later
      projectIdSet.add(te.Project__c);

      if (te.User__c == null)
        te.User__c = UserInfo.getUserId();

      if (te.Spent_Date__c == null)
        te.Spent_Date__c = Date.today();

      if (te.Started_Time__c == null)
        te.Started_Time__c = DateTime.now().time();
    }

    // Now we have the Project IDs, grab the projects
    // so that we may use their Client (Account) on
    // the Time Entry
    Map<Id, Project__c> projectMap = new Map<Id, Project__c>();
    ProjectsSelector ps = new ProjectsSelector();
    projectMap.putAll(ps.selectById(projectIdSet));


    // populate the Client__c field
    for (Time_Entry__c te : (List<Time_Entry__c>) Records) {
      Project__c proj = projectMap.get(te.Project__c);

      if (proj != null && proj.Is_Active__c == true) {
        // System.debug('proj.Client__c: ' + proj.Client__c);
        te.Client__c = proj.Client__c;
      }
    }

  }

  /**
   * Validate new Time Entries
   *
   * Ensure we have the right data
   * We need ensure the Project, and Time Tracker Task exist,
   * and are aligned correctly.
   *
   * A time entry's user must be a member of the listed project
   * A time entry's project must exist and be active
   * A time entry's task must exist and be active
   * A time entry's task must be a task of the given project
   * A time entry must have a date (Spent Date) of today or in the past
   * A time entry must have a started time in the past.
   *
   * Validation implemented but needing review:
   * A time entry user must be the executing user, except when
   * a system administrator is running. (E.g. for data loading)
   *
   *
   */
  public override void onValidate() {

    Map<Id, Id> entryIdToProjectId = new Map<Id, Id>();
    Map<Id, Id> entryIdToTaskId    = new Map<Id, Id>();

    for(Time_Entry__c te : (List<Time_Entry__c>) Records) {

    }



    /*

    Id executingUserId = UserInfo.getUserId();
    Set<List<Id>> projectUserPairs = new Set<List<Id>>();
    Set<List<Id>> projectTaskPairs = new Set<List<Id>>();

    for(Time_Entry__c te : (List<Time_Entry__c>) Records) {

      if (te.Started_Time__c == null)
        te.Started_Time__c.addError('Started time must be given');

      if (te.Spent_Date__c == null || te.Spent_Date__c > date.today())
        te.Spent_Date__c.addError('Spent Date must be today or earlier');
      else if (te.Spent_Date__c == date.today()
               && te.Started_Time__c > datetime.now().time())
        te.Started_Time__c.addError('Started time cannot be in the future');




      Id projectId = te.Project__c;
      Id taskId = te.Time_Tracker_Task__c;
      Id userId = (te.User__c == null) ? executingUserId : te.User__c;

      // if (te.User__c == null)
      //  te.User__c = executingUserId;


      if (projectId == null) {
        te.Project__c.addError('You must specify a project');
        continue;
      }

      if (taskId == null) {
        te.Time_Tracker_Task__c.addError('You must specify a time tracker task');
        continue;
      }

      projectTaskPairs.add(new List<Id> { projectId, taskId } );
      projectUserPairs.add(new List<Id> { projectId, userId } );

    }


    TaskAssignmentsSelector projectTaskSelector = new TaskAssignmentsSelector();
    ProjectUserAssignmentsSelector projectUserSelector = new ProjectUserAssignmentsSelector();

    List<Project_Task_Assignment__c> projectTasks = projectTaskSelector.selectByProjectTaskPairs(projectTaskPairs);
    List<Project_User_Assignment__c> projectUsers = projectUserSelector.selectByProductUserPairs(projectUserPairs);

    Set<String> projectTaskNames = new Set<String>();
    Set<String> projectUserNames = new Set<String>();

    for (Project_Task_Assignment__c pta : projectTasks) {
      projectTaskNames.add(pta.Name);
    }

    for (Project_User_Assignment__c pua : projectUsers) {
      projectUserNames.add(pua.Name);
    }

    for(Time_Entry__c te : (List<Time_Entry__c>) Records) {
      Id projectId = te.Project__c;
      Id taskId = te.Time_Tracker_Task__c;
      Id userId = te.User__c;

      if (projectId == null || taskId == null)
        continue;

      String projectTaskKey = projectId + '::' + taskId;
      String projectUserKey = projectId + '::' + userId;

      if ( ! projectTaskNames.contains(projectTaskKey) )
        te.addError('Project and task are not aligned');

      if ( ! projectUserNames.contains(projectUserKey) )
        te.addError('Project and user are not aligned');

    }

    */

  }

  // public override void onValidate(Map<Id,SObject> existingRecords) {
    // Validate changes to Opportunities
    // for(Opportunity opp : (List<Opportunity>) Records) {
    //  Opportunity existingOpp = (Opportunity) existingRecords.get(opp.Id);
    //  if(opp.Type != existingOpp.Type) {
    //    opp.Type.addError('You cannot change the Opportunity type once it has been created');
    //  }
    // }
  // }
}

/*
 The user needs to be able to add a time entry

  The task specified must belong to the project.
  The user should be on the project that task is assigned to.


  TODO: Add a before insert / before update triggers OR Validation logic
   - check the project exists
   - check the task belongs to the project
   - check the user belongs to the project
   - check the task is active
   - check the project is active

   LATER:
   - check the timesheet is not locked
   */
