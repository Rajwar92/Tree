# Caveats (READ ME)
## Reactivity
Orval does not seem to recognize changes to prop values. This means that if you are passing a prop as a parameter to a `useQuery` hook, the query won't be re-run when the prop value is updated. To work around this issue, convert the prop to a `ref` in order to make it reactive.

Example from [`/Frontend/src/views/content-setup/content-definition/ConfigurationTab.tsx`](https://devops.wisetechglobal.com/wtg/BorderWise/_git/WebWatcher?path=%2FFrontend%2Fsrc%2Fviews%2Fcontent-setup%2Fcontent-definition%2FConfigurationTab.tsx&_a=contents&version=GBmaster):

❌ Bad code:
```
setup(props) {
  const apiExtractionLineQuery = useApiExtractionLineGETAllOfSelected(props.itemPK);
  const customExtractionLineQuery = useCustomExtractionLineGETAllOfSelected(props.itemPK);
  const webExtractionLineQuery = useWebExtractionLineGETAllOfSelected(props.itemPK);
}
```

✅ Good code:
```
setup(props) {
  const itemPK = toRef(() => props.itemPK);
  const apiExtractionLineQuery = useApiExtractionLineGETAllOfSelected(itemPK);
  const customExtractionLineQuery = useCustomExtractionLineGETAllOfSelected(itemPK);
  const webExtractionLineQuery = useWebExtractionLineGETAllOfSelected(itemPK);
}
```

# Overview
## Generation Process
1. Backend build generates a `swagger.json` file containing the OpenAPI schema that describes all of the endpoints that the backend exposes. This file is stored at [`/Swagger/swagger.json`](https://devops.wisetechglobal.com/wtg/BorderWise/_git/WebWatcher?path=%2FSwagger%2Fswagger.json).
1. Frontend has an npm script [`swagger:generate`](https://devops.wisetechglobal.com/wtg/BorderWise/_git/WebWatcher?path=%2FFrontend%2Fpackage.json&version=GBmaster&line=23&lineEnd=23&lineStartColumn=6&lineEndColumn=22&lineStyle=plain&_a=contents) which runs Orval. This is automatically done post install as well.
1. Orval uses the defined config at [`/Frontend/orval.config.js`](https://devops.wisetechglobal.com/wtg/BorderWise/_git/WebWatcher?path=%2FFrontend%2Forval.config.js) to generate the queries and respective hooks that correspond to the various endpoints outlined in the swagger schema file. The generated code is located at [`/Frontend/src/api`](https://devops.wisetechglobal.com/wtg/BorderWise/_git/WebWatcher?path=%2FFrontend%2Fsrc). (_Note: the generated code is ignored by git_)
1. To use any of the queries or hooks simply import them from `/Frontend/src/api`.