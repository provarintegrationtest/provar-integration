import { LightningElement, wire, track } from 'lwc';
import { refreshApex } from '@salesforce/apex';
import getTasks from '@salesforce/apex/TaskManagerController.getTasks';
import markTasksAsComplete from '@salesforce/apex/TaskManagerController.markTasksAsComplete';
import { NavigationMixin } from 'lightning/navigation';

const columns = [
    { label: 'Subject', fieldName: 'Subject', type: 'text' },
    { label: 'Due Date', fieldName: 'ActivityDate', type: 'date' },
    { label: 'Status', fieldName: 'Status', type: 'text' },
];

export default class TaskManager extends NavigationMixin(LightningElement) {
    @wire(getTasks) wiredTasks;
    @track tasks = [];
    columns = columns;
    selectedRows = [];

    // This getter is used to enable or disable the "Mark Selected as Completed" button
    get isMarkButtonDisabled() {
        return this.selectedRows.length === 0;
    }

    handleRowSelection(event) {
        this.selectedRows = event.detail.selectedRows;
    }

    handleCompleteTasks() {
        const taskIds = this.selectedRows.map(task => task.Id);
        markTasksAsComplete({ taskIds:taskIds })
            .then(() => {
                // Refresh the task list
                return refreshApex(this.wiredTasks);
            })
            .catch(error => {
                console.error('Error marking tasks as complete: ', error);
            });
    }

    handleNewTask() {
         // Use Lightning Navigation Service to navigate to a new task creation page
         this[NavigationMixin.Navigate]({
            type: 'standard__objectPage',
            attributes: {
                objectApiName: 'Task',
                actionName: 'new'
            }
        });
    }
    renderedCallback(){
        refreshApex(this.wiredTasks);
    }

    get disableMarkComplete(){
        return this.selectedRows?.length>0 ? false:true;
    }
}