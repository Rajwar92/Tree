#Invalidating Related Queries
When using Vue Query it's very important to know which queries share common data with other queries. If any of these queries update data in the backend, we must make sure that all the other interrelated queries are invalidated so that they refresh their data.

For example: in WebWatcher we have our ContentSetup page that uses the `activeCollectionDetailsQuery` which displays a list of items in a table and their associated pieces of important data.

 `const activeCollectionDetailsQuery = useMonitoringRequestsGETDetailedMonitoringRequests(activeCollectionPK);`

However in other components such as ScheduleForm, we can update associated data such as `nextCheck`, `checkInterval`, and `isActive`.

`const saveScheduleQuery = useMonitoringSchedulePATCH({...});`

Currently in both WebWatcher and BorderWise this hasn't been a problem as most components will re-fetch data automatically when the component is re-rendered, however relying on this assumed behaviour could be dangerous and we should instead run 

```
const queryClient = useQueryClient();
queryClient.invalidateQueries(...)
```
