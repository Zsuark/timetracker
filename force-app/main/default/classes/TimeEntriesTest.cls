/**
 * Tests the domain layer of TimeEntries
 *
 * @author Raphael Krausz
 * @date   2018-05-19
 */

@isTest
private class TimeEntriesTest {

  /*
  What do we need for testing?

  Test users
  ? A test user who is a normal user of the application (not a PM)
  ? A test user who is a system administrator
  ? A test use who is a project manager on a project

  Client(s), Project(s), Task(s).
  */

  /**
   * Tests the creation of standard users for testing
   * and that they have the Time Tracker (this application) permission
   * set applied
   */
  @isTest static void testUserCreation() {
    // Create users
    Test.startTest();
    List<User> userList = TimeEntriesTestDataFactory.createTestUsers(2);
    Test.stopTest();

    // Grab them from the database
    List<User> dbUserList = [
    SELECT Id, Profile.Name, LastName, IsActive
    FROM User
    WHERE Email LIKE 'timetracker%@blackthorn.com'
    AND Profile.Name = 'Standard Platform User'
    AND IsActive = true
    ORDER BY LastName
    ];

    // Check they are as expected
    System.assertEquals(2, userList.size());
    System.assertEquals(2, dbUserList.size());
    System.assertEquals('TestUser1', dbUserList[0].LastName);
    System.assertEquals('TestUser2', dbUserList[1].LastName);


    // Check they are assigned to the Time Tracker permission set
    Map<Id, User> userIdMap = new Map<Id, User>(dbUserList);
    Set<Id> userIdSet = userIdMap.keySet();

    List<PermissionSetAssignment> psaList = [
      SELECT Id, PermissionSet.Name, AssigneeId
      FROM PermissionSetAssignment
      WHERE AssigneeId IN :userIdSet
      AND PermissionSet.Name = 'TimeTracker_User_Permission_Set'
    ];

    System.assertEquals(2, psaList.size());
    for (PermissionSetAssignment psa : psaList) {
      System.assertEquals('TimeTracker_User_Permission_Set', psa.PermissionSet.Name);
      System.assert(userIdSet.contains(psa.AssigneeId));
    }

  }


  /**
   * Checking that our test data factory is working correctly for Projects
   */
  @isTest static void testProjectCreation() {
    List<Project__c> projectList = TimeEntriesTestDataFactory.createProjectsAndClients(2);

    System.assertEquals(2, projectList.size());

    System.assertEquals('TestProjectForTestClient1', projectList[0].Name);
    System.assertEquals('TestProjectForTestClient2', projectList[1].Name);

    List<Account> clients = [
    SELECT Name
    FROM Account
    ORDER BY Name];

    System.assertEquals(2, clients.size());
    System.assertEquals('TestClient1', clients[0].Name);
    System.assertEquals('TestClient2', clients[1].Name);


  }






  /*
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


  /*
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

}
