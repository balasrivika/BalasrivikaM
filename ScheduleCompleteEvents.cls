global class ScheduleCompleteEvents implements Schedulable {
    global void execute(SchedulableContext context) {
        Database.executeBatch(new BatchCompleteEvents(), 200);
    }
}
