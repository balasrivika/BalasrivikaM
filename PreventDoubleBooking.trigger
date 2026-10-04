trigger PreventDoubleBooking on Event__c (before insert, before update) {
    Set<Id> venueIds = new Set<Id>();
    for (Event__c eventRecord : Trigger.new) {
        if (eventRecord.Venue__c != null && eventRecord.Event_Date__c != null) {
            venueIds.add(eventRecord.Venue__c);
        }
    }
    if (venueIds.isEmpty()) return;

    Map<Id, Set<Date>> datesByVenue = new Map<Id, Set<Date>>();
    for (Event__c existing : [
        SELECT Id, Venue__c, Event_Date__c
        FROM Event__c
        WHERE Venue__c IN :venueIds AND Event_Date__c != null
    ]) {
        if (Trigger.isUpdate && Trigger.newMap.containsKey(existing.Id)) continue;
        if (!datesByVenue.containsKey(existing.Venue__c)) {
            datesByVenue.put(existing.Venue__c, new Set<Date>());
        }
        datesByVenue.get(existing.Venue__c).add(existing.Event_Date__c);
    }

    for (Event__c eventRecord : Trigger.new) {
        if (eventRecord.Venue__c == null || eventRecord.Event_Date__c == null) continue;
        if (datesByVenue.containsKey(eventRecord.Venue__c)
            && datesByVenue.get(eventRecord.Venue__c).contains(eventRecord.Event_Date__c)) {
            eventRecord.addError('This Venue is already booked on this date.');
        }
        if (!datesByVenue.containsKey(eventRecord.Venue__c)) {
            datesByVenue.put(eventRecord.Venue__c, new Set<Date>());
        }
        if (!datesByVenue.get(eventRecord.Venue__c).add(eventRecord.Event_Date__c)) {
            eventRecord.addError('This Venue is already booked on this date.');
        }
    }
}
