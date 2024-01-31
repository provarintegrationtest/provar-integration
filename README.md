# How to deploy the repo code into another org

  Clone the repository in local
  Open the folder in Visual Studio Code
  Run SFDX command "Authorize an Org" and connect to the target org.
  Open file "manifest/package.xml" and right click inside the file and select "Deploy code to source org"
  THe changes will be deployed.

# How to test the assignment.

  Weather Assignment

    1. Create Location__c object record by navigating to App Launcher > Locations
    2. On save the record page will display the Weather Information component on the right section.
    3. THe weather information will retrieve from the OpenWeatherMap.org and display latest weather info.

  TaskManager Assignment
    1. The component is present on the Home page, if you are not on the home page, navigate to App Launcher > Home (In case the component is not visible please click on Gear Icon > Edit Page > Drag and Drop the taskManager LWC component on the layout)
    2. On the Task Manager component you will see the list of Tasks assigned to you.
    3. There are two buttons provided as below
      i. Mark task as completed: this button will mark the selected tasks as completed.
      ii. Create New Task: This will launch a modal to create a new task.
      
