public with sharing class LookupQueryConfiguration {
    @AuraEnabled
    public String searchField {
        get {
            if (searchField != null) {
                searchField = String.escapeSingleQuotes(searchField);
            }
            return searchField;
        }
        set;
    }
    @AuraEnabled
    public String objectName { get; set; }
    @AuraEnabled
    public String searchKey {
        get {
            if (searchKey != null) {
                searchKey = String.format('%{0}%', new List<String>{ String.escapeSingleQuotes(searchKey) });
            }
            return searchKey;
        }
        set;
    }
    @AuraEnabled
    public String extraFilterType { get; set; }
    @AuraEnabled
    public List<Object> filterFormattingParameters { get; set; }

    private static final Map<String, AdditionalFilter> ADDITIONAL_FILTERS = new Map<String, AdditionalFilter>{
        'AccountFilter' => new AccountFilter()
    };

    private String queryTemplate = 'SELECT {0} FROM {1} WHERE {2} LIKE \'\'{3}\'\' {4} WITH SECURITY_ENFORCED LIMIT 10';

    // PUBLIC

    public String getFormattedQuery() {
        List<Object> formatParams = getFormatParams();
        return String.format(queryTemplate, formatParams);
    }

    // PRIVATE

    private List<Object> getFormatParams() {
        List<Object> result = new List<Object>{ searchField, objectName, searchField, searchKey };
        if (ADDITIONAL_FILTERS.containsKey(extraFilterType)) {
            String extraFilter = getExtraFilter();
            result.add(extraFilter);
        } else {
            // If there is not extraFilter, replace {4} with an empty string
            result.add('');
        }
        return result;
    }

    private String getExtraFilter() {
        AdditionalFilter filter = (AdditionalFilter) ADDITIONAL_FILTERS.get(extraFilterType);
        return filter.getFilterConditions(filterFormattingParameters);
    }

    // INNER

    private interface AdditionalFilter {
        String getFilterConditions(List<Object> formatParams);
    }

    /**
     * Example of AdditionalFilter implementation
    */
    private class AccountFilter implements AdditionalFilter {
        private final String FILTER_TEMPLATE = 'AND Name != \'\'MasterAccount\'\' AND Id != \'\'{0}\'\'';

        // PUBLIC

        public String getFilterConditions(List<Object> formatParams) {
            return String.format(FILTER_TEMPLATE, formatParams);
        }
    }
}