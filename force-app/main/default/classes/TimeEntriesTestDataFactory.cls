/**
 * Supplies and populates the database with entities
 * needed for testing
 *
 * What do we need for testing TimeEntries?
 *
 * A test user who is a normal user of the application (not a PM)
 * A test user who is a system administrator
 * A test use who is a project manager on a project
 * Clients, Projects, and Tasks.
 *
 */
@isTest
public class TimeEntriesTestDataFactory {

  @future
  public static void assignPermissionSetToUsers(Set<Id> userIds) {

    // Assign users to the TimeTracker Permission set
    Id permissionSetId = [
    SELECT Id
    FROM PermissionSet
    WHERE Name = 'TimeTracker_User_Permission_Set'
    ].Id;

    System.debug('== Permission Set ID obtained ==');

    fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(new Schema.SObjectType[] {
      PermissionSetAssignment.SObjectType
    });

    for (Id  uid: userIds) {

      PermissionSetAssignment psa = new PermissionSetAssignment
      (PermissionSetId = permissionSetId,
       AssigneeId = uid);
      uow.registerNew(psa);
    }

    // update database with new permission set assignments
    uow.commitWork();

    System.debug('== Permission Set Assigned to users ==');

  }


  // TODO: Should this be moved to UserTestDataFactory?
  /**
   * Creates test users for testing
   * TODO: Assign permission sets, etc.
   *
   * @author Raphael Krausz
   * @date   2018-05-19
   * @param  numberOfUsers the number of Users to create
   * @return a List<User> with the created users
   */
  public static List<User> createTestUsers(Integer numberOfUsers) {
    if (numberOfUsers <= 0) return new List<User>();

    // Create the users
    Id standardPlatformUserProfileId = [SELECT Id FROM Profile WHERE Name = 'Standard Platform User'].Id;

    List<User> users = new List<User>();

    // Start new unit of work
    fflib_SObjectUnitOfWork uow = new fflib_SObjectUnitOfWork(new Schema.SObjectType[] {
      User.SObjectType
    });

    for(Integer i = 1; i <= numberOfUsers; i++) {
      User u = new User(ProfileId = standardPlatformUserProfileId,
                        LastName = 'TestUser' + i,
                        Email = 'timetracker' + i + '@blackthorn.com',
                        Username = 'timetracker' + i + '@blackthorn.com',
                        Alias = 'tu' + i,
                        TimeZoneSidKey = 'America/Los_Angeles',
                        LocaleSidKey = 'en_US',
                        EmailEncodingKey = 'UTF-8',
                        LanguageLocaleKey = 'en_US'
                        );
      users.add(u);
      uow.registerNew(u);
    }

    // Update the database with the new users
    uow.commitWork();

    System.debug('= Users inserted =');

    Map<Id, User> userMap = new Map<Id, User>(users);

    assignPermissionSetToUsers(userMap.keySet());

    return users;
  }


  // TODO: Should this be moved to ProjectsTestDataFactory?

  /**
   * Creates projects and dependent client Accounts for testing
   * <p>
   * If numberOfProjects is less than or equal to zero, nothing is done
   * and an empty list of projects is returned.
   *
   * @author Raphael Krausz
   * @date   2018-05-19
   * @param  numberOfProjects the number of projects to create
   * @param  isBillable true means the project should be billed
   * @param  billBy must be one of: 'Project', 'Tasks', 'People', 'none'
   * @param  budgetBy must be one of: 'project', 'project_cost', 'task', 'task_fees', 'person', 'none'
   * @return A List of Project__c
   */
  public static List<Project__c>
  createProjectsAndClients(Integer numberOfProjects,
                           Boolean isBillable,
                           String  billBy,
                           String  budgetBy) {

    if (numberOfProjects <= 0) return new List<Project__c>();


    // Start new unit of work
    fflib_SObjectUnitOfWork uow
    = new fflib_SObjectUnitOfWork(
                                  new Schema.SObjectType[] {
                                    Account.SObjectType
                                  });


    // We need to know where to start our index at
    Integer numberOfExistingTestClients =
    Database.countQuery('SELECT Count()'
                        + ' FROM Account'
                        + ' WHERE Name LIKE \'TestClient%\'');


    // Setup client Accounts
    List<Account> clients  = new List<Account>();

    for (Integer i = 1 + numberOfExistingTestClients;
         i <= numberOfProjects + numberOfExistingTestClients;
         i++)
    {
      String clientName = 'TestClient' + i;
      System.debug('+++--- adding client: ' + clientName + ' ---+++');
      Account client  = new Account(Name=clientName);
      clients.add(client);
      uow.registerNew(client);
    }

    for (Account client : clients) {
      System.debug('**** Client Account: ' + client.Name);
      System.debug('**** ' + client);
    }

    System.debug('+++--- about to insert client accounts ---+++');

    // insert clients;

    // Update the database
    uow.commitWork();


    System.debug('= Client accounts inserted =');


    // Start new unit of work
    // SObjectUnitOfWork uow = new SObjectUnitOfWork(SERVICE_SOBJECTS);
    uow = new fflib_SObjectUnitOfWork(new Schema.SObjectType[] {
      Project__c.SObjectType
    });



    // Create the projects
    List<Project__c> projects = new List<Project__c>();
    for (Account client : clients) {

      System.debug('+++--- client.Name:' + client.Name);
      System.debug('+++--- client.Id:' + client.Id);

      Project__c project = new Project__c(Name = 'TestProject'
                                          + 'For' + client.Name,
                                          Client__c = client.Id,
                                          Is_Billable__c = isBillable,
                                          Bill_by__c = billBy,
                                          Budget_By__c = budgetBy);
      projects.add(project);
      uow.registerNew(project);
    }

    // insert projects
    uow.commitWork();

    System.debug('= Projects inserted =');

    return projects;
  }


  /**
   * Creates projects and dependent client Accounts for testing
   * where each project is billable by Project and budgeted by Project
   * <p>
   * If numberOfProjects is less than or equal to zero, nothing is done
   * and an empty list of projects is returned.
   *
   * @author Raphael Krausz
   * @param  numberOfProjects the number of projects to create
   * @return A List of Project__c
   */
  public static List<Project__c>
  createProjectsAndClients(Integer numberOfProjects) {
    return createProjectsAndClients(numberOfProjects, true, 'Project', 'project');
  }


}
