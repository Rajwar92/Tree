# Terminology and Types

## PlanBook

[Plan books](https://devops.wisetechglobal.com/wtg/BorderWise/_git/BorderWiseWeb?path=%2FBackend%2FWebApi%2FCore%2FModels%2FPlanBook.cs&_a=contents&version=GBmaster) are a book type that represents books within a [Plan](https://devops.wisetechglobal.com/wtg/BorderWise/_git/BorderWiseWeb?path=%2FBackend%2FWebApi%2FCore%2FModels%2FPlan.cs&_a=contents&version=GBmaster) in the Plans collection. The Plans collection is made up of a bunch of 'Plans', each corresponding to a particular country (NOTE: one is global). Each 'Plan' contains a list of books. Thus, each plan book either belongs to a particular country plan (e.g Singapore (SG)) or the global plan (GB). The plan collection contains all the books found in the BorderWise library (as can be seen in the library tab).
![PlansCollection.png](/.attachments/PlansCollection-2b90aa0a-2dd2-4a81-ab5a-f00d4875438a.png =950x) ![LibraryTab.png](/.attachments/LibraryTab-63046bfd-0dd5-4339-b4bc-0a2fffb92dc9.png)

A few key properties:
| Property | Description | 
|--|--|
| Browsable |  This keeps track of whether the book should be added to 'My Books' by default for new users. More on that later. |

## LibraryBook

The [LibraryBook](https://devops.wisetechglobal.com/wtg/BorderWise/_git/Common?path=%2FCommon%2FModels%2FLibraryBook.cs&_a=contents&version=GBmaster) type is used to represent books that are stored in a [User](https://devops.wisetechglobal.com/wtg/BorderWise/_git/Common?path=%2FCommon%2FModels%2FUser.cs&_a=contents&version=GBmaster) in the Users collection. The Users collection keeps track of all the users that have signed up to BW. When a user decides to place some sort of preference on a book, for example, that they want it in their 'My Books' tab, the information from the corresponding PlanBook will be used to make a LibraryBook that is stored in that particular user's books list in the Users collection. To represent that the user has chosen to add it to their 'My Books', we set `browsable = true` for this LibraryBook. The 'My Books' list is constructed from this book list, filtering through and getting all the books where `browsable = true.`
![UsersCollection.png](/.attachments/UsersCollection-ddcc0686-048c-4a3f-9fd8-d84140faad28.png =900x) ![MyBooks.png](/.attachments/MyBooks-7e0b183a-716a-422d-a7ed-e4ef2ff5597a.png =x200)

A few key properties:

| Property | Description |
|--|--|
| Browsable | This determines whether the book should show in 'My Books' for this particular user. |
| Searchable | This determines whether the book should be searched when the 'My Books' search option is toggled on. |

# How are the 'My Books' and 'Library' tab lists? 
The 'My Books' tab list is constructed as the list of LibraryBook type books in the User's book list that have `browsable = true. 

The 'Library' tab list is constructed as the list of PlanBook type books in the Plan of the country that the user has selected, merged with the PlanBook type books from the global Plan. 

# How do we populate a user's 'my books' list when a user is first created?

As BW devs and product specialists, we have the ability to edit and create books. When doing so, you will notice the option to `Show in My Books by default for new clients`. By clicking this checkbox, it means that we set the corresponding PlanBook to have property `browsable = true`.
![ShowInMyBooks.png](/.attachments/ShowInMyBooks-d16def38-dfd6-4a65-8f26-a4942fdcf0ff.png)
When we create a new user, we look in the plan repository and find any books where either `browsable = true` or `searchable = true`. For these matching books, we create a new, corresponding LibraryBook and add it to the new user's book list. Hence, any book that had the `Show in My Books by default for new clients` checkbox checked at that point in time, will be added to the new user's book list.

# How does a user update their 'My Books' list?

A user can add a book to their 'My Books' list by clicking on the green plus button to the right of the book name in their library. 
![Add.png](/.attachments/Add-570988b4-3a7f-406d-a514-f8a90010e9d9.png)
When they click this button, we first look in the user's book list to see if the book already exists there. If it does, we set `browsable = true` and `searchable = true` for this LibraryBook. If it is not there, we create a new LibraryBook with the same information as the corresponding PlanBook but with `browsable = true` and `searchable = true`.

A user may remove a book from 'My Books' by clicking on the minus arrow to the right of the book name in the 'My Books' tab. When they click this button, the book is deleted from their user book list altogether (but remains in the plan collection so will still show under the library tab).
![Remove.png](/.attachments/Remove-e3d1796b-7c73-48d6-8d6d-637663ad4c3e.png)

# What is the searchable flag?

Books in 'My Books' have the option to be made 'searchable'. This is controlled by the checkbox to the left of the book name. This means, that when searching within my books, we will only search the books that have this box checked. 
![MyBooks.png](/.attachments/MyBooks-e7921f6b-d48a-4e58-8cbb-ca64776d7ece.png) ![MyBooksFilter.png](/.attachments/MyBooksFilter-fe123831-f994-42b5-be4c-5052b65d5ee2.png)

# Clarifying some references
Throughout the codebase, there are various lists of books and it is not always clear what type of book they are referring to. Here is a table to make it easier to follow. 

| File                | Type referred to | Name                      |
| ------------------- | ---------------- | ------------------------- |
| library.service.js  | LibraryBook      | service.data.books        |
| library.service.js  | PlanBook         | service.data.libraryBooks |
| books.controller.js | LibraryBook      | vm.myBooks                |
| books.controller.js | PlanBook         | vm.libraryBooks           |