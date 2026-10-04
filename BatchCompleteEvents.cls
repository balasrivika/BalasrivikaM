global class BatchCompleteEvents implements Database.Batchable<SObject> {
    global Database.QueryLocator start(Database.BatchableContext context) {
        return Database.getQueryLocator([
            SELECT Id, Event_Date__c, Event_Status__c
            FROM Event__c
            WHERE Event_Date__c < TODAY AND Event_Status__c != 'Completed'
        ]);
    }

    global void execute(Database.BatchableContext context, List<Event__c> scope) {
        for (Event__c eventRecord : scope) eventRecord.Event_Status__c = 'Completed';
        update scope;
    }

    global void finish(Database.BatchableContext context) {
        System.debug('Past events marked as Completed');
    }
}
