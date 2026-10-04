@IsTest
private class EventForceAutomationTest {
    @TestSetup
    static void createVenue() {
        insert new Venue__c(Name = 'Test Venue');
    }

    @IsTest
    static void venueStatusTracksEventStatus() {
        Venue__c venue = [SELECT Id, Availability_Status__c FROM Venue__c LIMIT 1];
        Event__c eventRecord = new Event__c(
            Name = 'Test Event',
            Venue__c = venue.Id,
            Event_Date__c = Date.today().addDays(5),
            Event_Type__c = 'Wedding',
            Event_Status__c = 'Confirmed'
        );
        insert eventRecord;
        venue = [SELECT Availability_Status__c FROM Venue__c WHERE Id = :venue.Id];
        System.assertEquals('Reserved', venue.Availability_Status__c);

        eventRecord.Event_Status__c = 'Canceled';
        update eventRecord;
        venue = [SELECT Availability_Status__c FROM Venue__c WHERE Id = :venue.Id];
        System.assertEquals('Available', venue.Availability_Status__c);
    }

    @IsTest
    static void blocksDuplicateVenueAndDate() {
        Venue__c venue = [SELECT Id FROM Venue__c LIMIT 1];
        insert new Event__c(
            Name = 'First Event', Venue__c = venue.Id,
            Event_Date__c = Date.today().addDays(8), Event_Status__c = 'Planned'
        );
        Event__c duplicateEvent = new Event__c(
            Name = 'Second Event', Venue__c = venue.Id,
            Event_Date__c = Date.today().addDays(8), Event_Status__c = 'Planned'
        );
        Test.startTest();
        Database.SaveResult result = Database.insert(duplicateEvent, false);
        Test.stopTest();
        System.assertEquals(false, result.isSuccess());
        System.assert(result.getErrors()[0].getMessage().contains('already booked'));
    }

    @IsTest
    static void batchCompletesPastEvents() {
        insert new Event__c(
            Name = 'Past Event', Event_Date__c = Date.today().addDays(-1),
            Event_Status__c = 'Confirmed'
        );
        Test.startTest();
        Database.executeBatch(new BatchCompleteEvents(), 200);
        Test.stopTest();
        Event__c completed = [SELECT Event_Status__c FROM Event__c WHERE Name = 'Past Event' LIMIT 1];
        System.assertEquals('Completed', completed.Event_Status__c);
    }
}
