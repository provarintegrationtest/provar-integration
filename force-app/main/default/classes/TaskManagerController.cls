public with sharing class TaskManagerController {
    @AuraEnabled(cacheable=true)
    public static List<Task> getTasks() {
        return [SELECT Id, Subject, ActivityDate, Status FROM Task WHERE OwnerId = :UserInfo.getUserId() ORDER BY ActivityDate Desc];
    }

    @AuraEnabled
    public static void markTasksAsComplete(List<String> taskIds) {
        List<Task> tasksToComplete=new List<Task>();
        for(Id tid:taskIds){
            tasksToComplete.add(new Task(Id=tid,Status='Completed'));
        }
        if(!tasksToComplete.isEmpty()){
            update tasksToComplete;
        }
    }
}