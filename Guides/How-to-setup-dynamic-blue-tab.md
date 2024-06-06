### DynamicBlueTabEntry Collection

There is a collection `DynamicBlueTabEntry` which contains all dynamic blue tab references. To make a tariff tab "dynamic," you need to create a record in this collection:

```json
{
  "headingLinksCode": "caDumpings",
  "year": "2022",
  "countryCode": "CA",
  "data": [
    {
      "bookCode": "CA_DMRS",
      "fieldName": "hsCode",
      "headingLength": 4,
      "rangeSplitter": " "
    }
  ]
}
```

Where `caDumpings` is a code from the `TariffTabEntries` collection. The `DynamicBlueTabEntry`'s data array is required to have at least one record that contains parameters to extract "active" headings.

### Options

1. **BookCode and TOC Title**
   - Used to extract a collection, with the field `ref` containing heading numbers used in this blue tab.
   ```json
   {
     "bookCode": "CA_TARIFF_CON_2021_2022",
     "tocTitle": "HS 2021-HS 2022",
     "fieldName": "ref",
     "headingLength": 4
   }
   ```

2. **Just BookCode**
   - Used to extract a collection with the `hsCode` field.
   ```json
   {
     "bookCode": "CA_DMRS",
     "fieldName": "hsCode",
     "headingLength": 4
   }
   ```

3. **Direct Collection Name**
   - Specify the collection name directly.
   ```json
   {
     "collectionName": "US_EN_PGA_2022",
     "fieldName": "ref",
     "headingLength": 4
   }
   ```

4. **Filter Query**
   - Option to specify a `filterQuery` to apply to the collection for extracting headings.
   ```json
   {
     "collectionName": "ZA_EN_ImportTariff_Schedule1_Parts_2022",
     "fieldName": "ref",
     "headingLength": 4,
     "filterQuery": "{ partNo: 2, part: '2a' }"
   }
   ```
5. **Heading Range Field**
   - Option to Specify range fields to get 'from' and 'to' values, where 'from' and 'to' is names of fields in the collection:  
   ```
   {
     "collectionName": "US_EN_ImportTariff_SectionNotes_AdditionalNotes_Tab_2022",
     "headingFieldRange": {
	    "from": "headingFrom",
	    "to": "headingTo"
      }
   }
   ```
6. **Headings List**
   - Instead of referencing a field in a collection, you can provide a static list of headings.
   ```json
   {
     "headingLength": 4,
     "headingsRange": "2710 3826"
   }
   ```

If the `data` array contains more than one element, they are combined by an "OR" condition:

```json
{
  "headingLinksCode": "hsConcordance",
  "year": "2022",
  "countryCode": "US",
  "data": [
    {
      "bookCode": "US_CONCO_HTS_2021_2022",
      "tocTitle": "Concordance HTS 2022-2021",
      "fieldName": "ref",
      "headingLength": 4,
      "rangeSplitter": " "
    },
    {
      "bookCode": "US_CONCO_HTS_2021_2022",
      "tocTitle": "Concordance HTS 2021-2022",
      "fieldName": "ref",
      "headingLength": 4,
      "rangeSplitter": " "
    }
  ]
}
```

### Dynamic Blue Tabs Update

- If there is a parameter `bookCode`, it will update when the corresponding book is updated. Use the book's `timestamp`.
- If there is no `bookCode`, the DynamicBlueTab updates once a week.
- To trigger the update, you can unset `DynamicBlueTab.timestamp` for the corresponding records.