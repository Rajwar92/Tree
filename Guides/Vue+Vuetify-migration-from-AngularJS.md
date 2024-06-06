When adding new features or migrating old components to Vue consider creating/migrating them straight to Vuetify.

We're using:
- Vue 3 ([docs](https://vuejs.org/guide/introduction.html)) - framework, replacement for AngualrJS
- TSX ([why and how](https://devops.wisetechglobal.com/wtg/BorderWise/_git/WebWatcher?path=%2FFrontend%2FVue-components.md&_a=preview)) - templating language, replacement for HTML
- Vuetify 3 ([docs](https://next.vuetifyjs.com/en/) - not the ones from Google results!) - UI library, a replacement for Bootstrap
- Material Design ([docs](https://m3.material.io/)) - design system, a replacement for Bootstrap's design system

The app design may slightly change when migrating to be in line with the Material Design system, and we need to put a bit of effort into that during the design phase, please consult with Maxim Mazurok (Material Design expert), especially at first while we build the foundation and set examples. Reach out to him with any questions or concerns.

## TSX

TSX (TypeScript+JSX) is slightly different from the HTML used in most examples in Vuetify docs.

Here is a basic example of how to translate them:
```html
<v-list lines="one">
  <v-list-item
    v-for="item in items"
    :key="item.title"
    :title="item.title"
    subtitle="..."
  ></v-list-item>
</v-list>
```
in TSX will look like this:
```tsx
<VList lines="one">
  {items.map((item) => (
    <VListItem
      key={item.title}
      title={item.title}
      subtitle="..."
    />
  ))}
</VList>
```

Check existing code that uses Vuetify components for more examples. 

See https://github.com/vuejs/babel-plugin-jsx#slot when something doesn't work, especially slots, etc.

## Icons

FontAwesome icons need to be replaced by Material Design Icons.

We're using [@mdi/js](https://www.npmjs.com/package/@mdi/js) to get icons.

Search for icons here: https://pictogrammers.com/library/mdi/

Prefer icons with "Created by Google" badge:
![image.png](/.attachments/image-be9476f0-d027-4092-99a1-aa39251aa629.png =300x)

Icons don't have to look the same as the old ones, aim for the best match by meaning.

For example,
We had this icon: ![image.png](/.attachments/image-36463d3d-b699-428d-afa6-cb77836083c1.png)
Now we use this one: ![image.png](/.attachments/image-a22c1255-cbc0-4cac-8d2a-9b8e032da9cb.png)
You can see they don't match exactly, however, they both have the same meaning: "history".

We currently have "Quick Links":
![image.png](/.attachments/image-f7522030-21f0-4f25-9818-15771deaf94d.png)
Let's search for "quick":
![image.png](/.attachments/image-5d5939ee-5edc-4f5a-901f-97865b8441a5.png)
Nothing has a matching meaning.
Let's search for "links": no results;
Let's search for "link":
This is a pretty good candidate, because it's a link icon - good way to represent links. And it's created by Google:
![image.png](/.attachments/image-7e031638-dd52-4377-9991-a30cc299580a.png)
However, usually it's used to represent a single link, maybe on a button to copy/open that link. In our case it's a dropdown of links collection, so probably not the best match on a meaning.
Current icon name is `fa-flash`:
![image.png](/.attachments/image-79b53413-0af8-4669-ba69-0c5bef67e212.png)
Let's search for "flash":
![image.png](/.attachments/image-5184086b-c928-42c8-b101-352586b73d20.png)
This is a pretty good match. It is created by google, similar to our current icon, and matches by meaning because the purpose of quick links is to be quickly accessible (quick as a flash), so this seems like a very good choice.

---

![vuetify-progression-Page-1.drawio.png](/.attachments/vuetify-progression-Page-1.drawio-799a1cb0-c817-4f12-818f-6a402e8912fc.png)