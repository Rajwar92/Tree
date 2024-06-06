In the wild most often you will find docs/examples of Vue code written using Vue.js Templates which looks more like regular HTML.
What we are using in BWW and WW is TSX (JSX + TypeScript) templates, which uses similar syntax to React.
You can find more on it here https://vuejs.org/guide/extras/render-function.html#jsx-tsx
And various examples here: https://github.com/vuejs/babel-plugin-jsx#usage

Short summary of differences:
- `v-for` => `[].map()`
- `@click` => `onClick`
- `:some-value` => just `someValue`
- `v-model="bla"` => `v-model={bla}`
- `some-attribute="some string"` => `someAttribute="some string"` or `someAttribute={"some string"}`
- `<a v-if="bla"/>` => `bla && <a />`