Recently we have finished something I've never seen anywhere else before: deep object/array reactivity from AngularJS into Vue.

It will allow us to pass complex/nested objects/arrays as props into <ve-*/> components

You can use it like this:

```
const data = { one: { two: 3 } };
const reactiveData = reactive(data);
// in template: <ve-some-component ng-prop-some_prop="$ctrl.reactiveData" ... />
// DO NOT do this:
ng-prop-some_prop="$ctrl.reactiveData.one" - will not work, only pass the "root" object that was defined using reactive()
reactiveData.one.two++; // this deep change will be detected and `ve-some-component` re-rendered
// DO NOT do this:
reactiveData = {} // NOT reactive anymore
// DO this instead:
reactiveData = reactive({})
// In Vue you need to use `AngularJSReactiveProperty` type to define props:
props: {
  something: {
    type: Object as PropType<AngularJSReactiveProperty<{ one: { two: number } }>>
  }
}
// To access reactive prop value, you need to use `.value` similar to how reactivity works in Vue:
setup(props) {
  console.log(props.something.value)
  // ...
  // There's internal `props.something._version` - this it to trigger re-render, don't worry about it
}
// In Vue you can also use watch() to detect changes:
watch(
  () => props.myObject,
  (new, old) => {
    // value change detected
    console.log(props.myObject.value);
    // NOTE: this is always true
    // DO NOT rely on old value
    new.value === old.value
  }
);
```

Learn more in [README](https://devops.wisetechglobal.com/wtg/BorderWise/_git/BorderWiseWeb?path=%2FFrontend%2Fvue-elements%2FREADME.md&_a=preview&anchor=reactivity-from-angularjs-to-vue)
There are also some plans to make it better and helps devs catch bugs/mistakes.


Feel free to start using it in your WIs, and ask questions or share feedback if something doesn't work as it's a very early stage.