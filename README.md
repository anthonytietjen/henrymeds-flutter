# Henry Meds

## Overview

- I used Flutter for this project.
- In the interest of time I only tested on iOS.
- My source code is in the [/lib](lib) folder
- Screen redording [here](https://github.com/anthonytietjen/henrymeds-flutter/issues/1).

## Notes

### Assumptions Made

- **15 Minute Max Appointments** - Assumption that each appointment can only take 15 minutes. This decision affected the display when looping over avaiable appointments for display purposes.

### Lines Drawn in the Sand

- **Time Slots** - Instead of representing time slots in the data as `DateTime` objects, I used `double` values. So the display time of `1:30 PM` is stored as `13.5` in the data. I'm not completely sold on this approach yet as it led to converting back and forth at run time for display purposes versus data storage purposes. Given more time, I would go back and consider whether there is more desired approach such as storing each time slot as a DateTime object.

### Shortcuts taken

- **Time Selector Widget** - I don't like the time selection widget used in the provider's add availability screen. I would rather show a custom widget that makes it more user-friendly to choose ranges in 15 minute increments. But in the interest of time, I used the default time selection widget and didn't add the ability to select a range.
- **Loading Indicators** - I added a loading indicator where the client chooses from a list of providers. Other indicators should be added when making API calls, but in the interest of time, I left `TODO` statments in those locations.
- **Fake Data** - My fake data can be found in the `/lib/api` folder. I added delays to simulate network latency. In a real scenario the app would use either the `http` or `graphql_flutter` library to make ether REST API calls or GraphQL queries.
- **No Login Screen** - Login wasn't part of the requirements, so I didn't worry about it for the assignment. For a real app, there would be a login screen, and session functionality.
- **Unit Tests** - I only wrote a few unit tests for the date formatting functions. I also modified the sample widget integration test that came with the boilerplate to launch the Home screen and only check for the existence of the two buttons. Ideally there would be more comprehensive tests.

### Things to consider

- **App Bundle Size** - If the same app is used by providers and clients, you would want to watch out for bundle size as the app grows. For example, if one group of users needs enhanced functionality such as PDF rendering, but the other group of users doesn't need that functionality, adding extra libraries to the project can add extra bloat for a subset of users who never use that feature.

### Bonus content
- **Icon and Logo** - As a bonus, I copied screnshots of the icon and logo from the Henry Meds website. They are not as high quality as they would be if I had the originals, but they added a nice touch to show proof-of-concept app icon and launch screen.


## Run app locally

```
flutter run
```

## Run unit tests

```
flutter test
```

## Regenerate app icon

This project uses [flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons) to generate the icon at the different required sizes.
If you replace the icon, regenerate the different sizes by running the command below.

```
flutter pub run flutter_launcher_icons
```