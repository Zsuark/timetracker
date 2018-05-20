/**
 * Tests ProjectUserAssignments domain layer
 * <p>
 * Required fields:
 * Project__c
 * User__c
 * <p>
 * Optional fields and defaults:
 * Is_Active__c          - true
 * Is_Project_Manager__c - false for regular users
 * Is_Project_Manager__c - true  for system administrators
 * Is_Project_Manager__c - true  for project managers
 * Hourly_Rate__c        - defaults to 0
 * Budget__c             - no default
 * <p>
 * Note: We are not testing defaults for project managers
 * or system administrators at the moment as it is outside
 * of scope for our current work. (?)
 *
 * @author Raphael Krausz
 * @date   2018-05-20
 */
@isTest
private class ProjectUserAssignmentsTest {

  /**
   * Test an assignment can be made with just a project and a user
   * <p>
   * "Happy path" - tests success when project and user are supplied
   */
  @isTest static void testMinimumAssignmentCreation() {

    // Grab a test user and a test project
    Test.startTest();
    User testUser = TimeEntriesTestDataFactory.createTestUsers(1)[0];
    Project__c testProject = TimeEntriesTestDataFactory.createProjectsAndClients(1)[0];
    Test.stopTest();

    System.assertNotEquals(null, testUser.Id);
    System.assertNotEquals(null, testProject.Id);

    // Assign the user to the project, expect success
    Project_User_Assignment__c testAssignment =
    new Project_User_Assignment__c(Project__c = testProject.Id,
                                   User__c    = testUser.Id);

    Test.startTest();
    try {
      insert testAssignment;
    } catch (Exception e) {
      System.assert(false,
                    'We tried to create a project user assignment, '
                    + 'with just a user and project, '
                    + ' but an exception was thrown');
      System.debug('Exception caught: ' + e);
      return;
    }
    Test.stopTest();

    // Expect the defaults are correctly set
    System.assert(testAssignment.Is_Active__c, 'Assignment not active');
    System.assertEquals(false, testAssignment.Is_Project_Manager__c, 'regular Assignment set to PM');
    System.assertEquals(0, testAssignment.Hourly_Rate__c, 'Hourly rate not 0');
    System.assertEquals(null, testAssignment.Budget__c, 'Budget filled in');
  }
}

