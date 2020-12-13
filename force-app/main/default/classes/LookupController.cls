public with sharing class LookupController {
    // PUBLIC

    @AuraEnabled(cacheable=true)
    public static List<SObject> findRecords(LookupQueryConfiguration queryConfig) {
        try {
            return Database.query(queryConfig.getFormattedQuery());
        } catch (Exception e) {
            throw new ApplicationException().auraHandled(e);
        }
    }
}