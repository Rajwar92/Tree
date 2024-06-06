# Mocking

In Vue tests we provide some mocks for AngularJS services, such as `userServiceMock`, `utilServiceMock`, `tariffServiceMock`, etc.

They are registered in `src/utils/testHelpers.ts` by calling `vi.mock("../angularjs-services/services", ...`

So, when writing your tests you need to make sure that you import mocks before importing the component that you're testing.

So this will work:
```ts
// mocks are registered first because testHelpers is executed at the time of import
import { contentServiceMock, libraryServiceMock, renderWithVuetify } from "../../utils/testHelpers";

// mocks registered in the previous step will be used in place of the real module when importing the component
import { CountrySelection } from "../CountrySelection";
```

But if you flip these lines around - you will import the component first with actual modules, and then register mocks which won't do anything since component was already imported with real modules.
