@isTest
private class TimeEntriesTest {

  /*
  What do we need for testing?

  A test user who is a normal user of the application (not a PM)
  A test user who is a system administrator
  A test use who is a project manager on a project

  Client(s), Project(s), Task(s).

  */



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
