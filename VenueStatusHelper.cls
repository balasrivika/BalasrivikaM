public with sharing class VenueStatusHelper {
    public static void updateVenueStatus(List<Event__c> events) {
        Map<Id, Venue__c> venuesById = new Map<Id, Venue__c>();
        for (Event__c eventRecord : events) {
            if (eventRecord.Venue__c == null) continue;
            if (eventRecord.Event_Status__c == 'Confirmed') {
                venuesById.put(eventRecord.Venue__c, new Venue__c(
                    Id = eventRecord.Venue__c,
                    Availability_Status__c = 'Reserved'
                ));
            } else if (eventRecord.Event_Status__c == 'Canceled') {
                venuesById.put(eventRecord.Venue__c, new Venue__c(
                    Id = eventRecord.Venue__c,
                    Availability_Status__c = 'Available'
                ));
            }
        }
        if (!venuesById.isEmpty()) update venuesById.values();
    }
}
