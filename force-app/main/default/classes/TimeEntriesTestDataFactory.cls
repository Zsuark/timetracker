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

  // TODO: Should this be moved to UserTestDataFactory?
  /**
   */

  // TODO: Should this be moved to ProjectsTestDataFactory?

  /**
   * Creates projects and dependent client Accounts for testing
   * <p>
   * If numberOfProjects is less than or equal to zero, nothing is done
   * and an empty list of projects is returned.
   *
   * @author Raphael Krausz
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

    // We need to know where to start our index at
    Integer numberOfExistingTestClients =
    Database.countQuery('SELECT Count()'
                        + ' FROM Account'
                        + ' WHERE Name LIKE \'TestClient\\%\'');


    // Setup client Accounts
    List<Account> clients  = new List<Account>();

    for (Integer i = 1 + numberOfExistingTestClients;
         i <= numberOfProjects + numberOfExistingTestClients;
         i++)
    {
      Account client  = new Account(Name='TestClient' + i);
      clients.add(client);
    }

    insert clients;


    // Create the projects
    List<Project__c> projects = new List<Project__c>();
    for (Account client : clients) {
      Project__c project = new Project__c(Name = 'TestProject'
                                          + 'For' + client.Name,
                                          Client__c = client.Id,
                                          Is_Billable__c = isBillable,
                                          Bill_by__c = billBy,
                                          Budget_By__c = budgetBy);
      projects.add(project);
    }

    insert projects;

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
