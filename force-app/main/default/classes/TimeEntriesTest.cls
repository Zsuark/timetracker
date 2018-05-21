/**
 * Tests the domain layer of TimeEntries
 *
 * @author Raphael Krausz
 * @date   2018-05-19
 */

@isTest
private class TimeEntriesTest {

  // 1. As a user, I can log a time entry for a task under a project
  // Needed items: TimeEntries, Tasks, Projects... ? Timers?

  // Are time entries and timers different???

  // 2. As a user, I can start a timer
  // 3. As a user, I can pause the timer
  // 4. As a user, I can resume a timer of a single time entry (I should see the latest time entry or select a previous one from that day to resume)
  // 5. as a user, I see a weekly timesheet
  // 6. A new timesheet is auto-generated for each week in advance over sunday night
  // 7. All time entries created during the week by people under projects also show up under that week’s timesheet record
  // 8. As a user, I can see the aggregate $ and time amount on a timesheet
  // 9. As a user, I can approve a weekly timesheet
  // 10. Once a timesheet is approved, all time entries related to it are locked
  // 11. Not editable by anyone, unless manager unlocks the timesheet
  // 12. As a user, I can’t add a new time entry to a weekly timesheet once it’s been locked by the manager
  // 13. As a user, when on a project record, the time entry component already recognizes which project I’m on, I just need to start/resume the timer.
  // 14. Each time entry has a $ value (based on the task, project or person’s hourly rate)





  // /**
  //  * Apply Defaults to Time Entries
  //  *
  //  * Auto-populated data on create and update
  //  *
  //  * Link the time entry to the correct client
  //  * If the User ID is blank, fill it out with the executing user
  //  * If the spent date is blank, populate it with today
  //  * If the start time is blank, populate it with the current time
  //  *
  //  */
  // @IsTest
  // private static void


  // /*
  // What do we need for testing?

  // Test users
  // ? A test user who is a normal user of the application (not a PM)
  // ? A test user who is a system administrator
  // ? A test use who is a project manager on a project

  // Client(s), Project(s), Task(s).
  // */

  // /**
  //  * Tests the creation of standard users for testing
  //  * and that they have the Time Tracker (this application) permission
  //  * set applied
  //  */
  // @isTest static void testUserCreation() {
  //   // Create users
  //   Test.startTest();
  //   List<User> userList = TimeEntriesTestDataFactory.createTestUsers(2);
  //   Test.stopTest();

  //   // Grab them from the database
  //   List<User> dbUserList = [
  //   SELECT Id, Profile.Name, LastName, IsActive
  //   FROM User
  //   WHERE Email LIKE 'timetracker%@blackthorn.com'
  //   AND Profile.Name = 'Standard Platform User'
  //   AND IsActive = true
  //   ORDER BY LastName
  //   ];

  //   // Check they are as expected
  //   System.assertEquals(2, userList.size());
  //   System.assertEquals(2, dbUserList.size());
  //   System.assertEquals('TestUser1', dbUserList[0].LastName);
  //   System.assertEquals('TestUser2', dbUserList[1].LastName);


  //   // Check they are assigned to the Time Tracker permission set
  //   Map<Id, User> userIdMap = new Map<Id, User>(dbUserList);
  //   Set<Id> userIdSet = userIdMap.keySet();

  //   List<PermissionSetAssignment> psaList = [
  //     SELECT Id, PermissionSet.Name, AssigneeId
  //     FROM PermissionSetAssignment
  //     WHERE AssigneeId IN :userIdSet
  //     AND PermissionSet.Name = 'TimeTracker_User_Permission_Set'
  //   ];

  //   System.assertEquals(2, psaList.size());
  //   for (PermissionSetAssignment psa : psaList) {
  //     System.assertEquals('TimeTracker_User_Permission_Set', psa.PermissionSet.Name);
  //     System.assert(userIdSet.contains(psa.AssigneeId));
  //   }

  // }


  // /**
  //  * Checking that our test data factory is working correctly for Projects
  //  */
  // @isTest static void testProjectCreation() {
  //   List<Project__c> projectList = TimeEntriesTestDataFactory.createProjectsAndClients(2);

  //   System.assertEquals(2, projectList.size());

  //   System.assertEquals('TestProjectForTestClient1', projectList[0].Name);
  //   System.assertEquals('TestProjectForTestClient2', projectList[1].Name);

  //   List<Account> clients = [
  //   SELECT Name
  //   FROM Account
  //   ORDER BY Name];

  //   System.assertEquals(2, clients.size());
  //   System.assertEquals('TestClient1', clients[0].Name);
  //   System.assertEquals('TestClient2', clients[1].Name);


  // }






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
