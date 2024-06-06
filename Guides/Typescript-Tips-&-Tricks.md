We use typescript across BWW, WW, UMP and WCT. This page is to act as a collection of handy tips and tricks to help you when working with typescript.
 
## Troubleshooting
Sometimes when working with typescript, we may come across error messages such as: 
```
The expected type comes from property 'variant' which is declared here on type 'IntrinsicAttributes & Partial<{ symbol: any; replace: boolean; flat: boolean; exact: boolean; active: boolean; block: boolean; disabled: boolean; size: string | number; tag: string; ... 4 more ...; ripple: boolean; }> & ... 16 more ... & Omit<...>'
```
which can be hard to interpret. In these situations, you can use `noErrorTruncation` in tsconfig (under `compilerOptions`) to expand all of the `...` and to help us understand what is actually going on. For more information on this, check out https://www.typescriptlang.org/tsconfig. 

To see full TS definitions on mouse hover in VS Code you can try this: https://stackoverflow.com/a/69223288/4536543