@IsTest
private with sharing class LookupControllerTest {
    @TestSetup
    static void makeData() {
        Account acc = new Account(Name = 'test');
        insert acc;
    }

    @IsTest
    static void testFindRecordsWithoutExtraFilter() {
        LookupQueryConfiguration queryConfig = new LookupQueryConfiguration();
        queryConfig.searchField = 'Name';
        queryConfig.objectName = 'Account';
        queryConfig.searchKey = 'te';
        List<SObject> records = LookupController.findRecords(queryConfig);

        List<Account> expectedResult = [SELECT Name FROM Account WHERE Name LIKE '%te%' WITH SECURITY_ENFORCED LIMIT 10];
        System.assertEquals(expectedResult.size(), records.size(), 'records size should match expectedResult (1 record)');
    }

    @IsTest
    static void testFindRecordsWithExtraFilters() {
        Account acc = [SELECT Id FROM Account];
        LookupQueryConfiguration queryConfig = new LookupQueryConfiguration();
        queryConfig.searchField = 'Name';
        queryConfig.objectName = 'Account';
        queryConfig.searchKey = 'te';
        queryConfig.extraFilterType = 'AccountFilter';
        queryConfig.filterFormattingParameters = new List<Id>{ acc.Id };
        List<SObject> records = LookupController.findRecords(queryConfig);

        List<Account> expectedResult = [
            SELECT Name
            FROM Account
            WHERE Name LIKE '%Deploy%' AND Name != 'MasterAccount' AND Id != :acc.Id
            WITH SECURITY_ENFORCED
            LIMIT 10
        ];
        System.assertEquals(expectedResult.size(), records.size(), 'records size should match expecteResult (empty with 0 records)');
    }

    @IsTest
    static void testFindRecordsWithInvalidExtraFilters() {
        LookupQueryConfiguration queryConfig = new LookupQueryConfiguration();
        queryConfig.searchField = 'Name';
        queryConfig.objectName = 'Account';
        queryConfig.searchKey = 'te';
        queryConfig.extraFilterType = 'NotAccountFilter';
        List<SObject> records = LookupController.findRecords(queryConfig);

        List<Account> expectedResult = [SELECT Name FROM Account WHERE Name LIKE '%te%' WITH SECURITY_ENFORCED LIMIT 10];
        System.assertEquals(expectedResult.size(), records.size(), 'records size should match expectedResult (1 record)');
    }
}