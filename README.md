# Deployment Steps

1. Clone the repository in local
2. Open the folder in Visual Studio Code
3. Run SFDX command `Authorize an Org` and connect to the target org.
4. Open file `manifest/package.xml` and right click inside the file and select `Deploy code to source org`.
5. The changes will be deployed.

# Assignment Testing Steps

## Task 1: REST API Integration

1. Create Location__c object record by navigating to App Launcher > Locations.
2. On saving the record, the page will display the Weather Information component on the right section.
3. The weather information will retrieve from OpenWeatherMap.org and display the latest weather info.

## Task 2: Lightning Web Component Development

1. The component is present on the Home page. If not visible, navigate to App Launcher > Home. (If not visible, click on Gear Icon > Edit Page > Drag and Drop the TaskManager LWC component on the layout.)
2. On the Task Manager component, you will see the list of tasks assigned to you.
3. Two buttons provided:
   - i. **Mark Selected as completed:** This button will mark the selected tasks as completed.
   - ii. **Create New Task:** This will launch a modal to create a new task.
