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

  // /**
  //  * Test an assignment can be made with just a project and a user
  //  * <p>
  //  * "Happy path" - tests success when project and user are supplied
  //  */
  // @isTest static void testMinimumAssignmentCreation() {
  //   Test.startTest();

  //   // Grab a test user and a test project
  //   User testUser = TimeEntriesTestDataFactory.createTestUsers(1)[0];
  //   Project__c testProject = TimeEntriesTestDataFactory.createProjectsAndClients(1)[0];

  //   System.assertNotEquals(null, testUser.Id);
  //   System.assertNotEquals(null, testProject.Id);

  //   // Assign the user to the project, expect success
  //   Project_User_Assignment__c testAssignment =
  //   new Project_User_Assignment__c(Project__c = testProject.Id,
  //                                  User__c    = testUser.Id);

  //   try {
  //     insert testAssignment;
  //   } catch (Exception e) {
  //     System.assert(false,
  //                   'We tried to create a project user assignment, '
  //                   + 'with just a user and project, '
  //                   + ' but an exception was thrown');
  //     System.debug('Exception caught: ' + e);
  //     return;
  //   }

  //   Test.stopTest();

  //   // Refresh the test assignment with the required fields
  //   testAssignment = [
  //   SELECT Id,
  //   Is_Active__c,
  //   Is_Project_Manager__c,
  //   Hourly_Rate__c,
  //   Budget__c
  //   FROM  Project_User_Assignment__c
  //   WHERE Id = :testAssignment.Id
  //   ];

  //   // Expect the defaults are correctly set
  //   System.assert(testAssignment.Is_Active__c, 'Assignment not active');
  //   System.assertEquals(false, testAssignment.Is_Project_Manager__c, 'regular Assignment set to PM');
  //   System.assertEquals(0, testAssignment.Hourly_Rate__c, 'Hourly rate not 0');
  //   System.assertEquals(null, testAssignment.Budget__c, 'Budget filled in');
  // }

  // /**
  //  * Only one Project user assignment should exist for a
  //  * user on a project
  //  */
  // @isTest static void testNoDuplicateAssignment() {
  //   Test.startTest();

  //   // Grab a test user and a test project
  //   User testUser = TimeEntriesTestDataFactory.createTestUsers(1)[0];
  //   Project__c testProject = TimeEntriesTestDataFactory.createProjectsAndClients(1)[0];

  //   Test.stopTest();

  //   System.assertNotEquals(null, testUser.Id);
  //   System.assertNotEquals(null, testProject.Id);

  //   // Assign the user to the project, expect success
  //   Project_User_Assignment__c testAssignment1 =
  //   new Project_User_Assignment__c(Project__c = testProject.Id,
  //                                  User__c    = testUser.Id);

  //   Project_User_Assignment__c testAssignment2 =
  //   new Project_User_Assignment__c(Project__c = testProject.Id,
  //                                  User__c    = testUser.Id);

  //   try {
  //     insert new List<Project_User_Assignment__c>{testAssignment1, testAssignment2};
  //   } catch (Exception e) {
  //     System.debug('Duplicate assignment caused exception, as expected');
  //     System.debug('Exception: ' + e);
  //     return;
  //   }

  //   System.debug('Duplicate assignment did not cause exception, as it should have');
  //   System.assert(false, 'Duplicate assignment made');
  // }

}

