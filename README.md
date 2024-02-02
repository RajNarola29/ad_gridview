# ad_gridview

A flutter widget to easily show Native Ad or any other Widget in Between a GridView.


## Features

- Easily insert Native Ad to GridView
- Easily insert any Widget to GridView

## Getting started

To use this package, add hash_cached_image as a dependency in your pubspec.yaml file.
```
dependencies:
  ...
  ad_gridview: <latest_version>
```
In your library add the following import:
```
import 'package:ad_gridview/ad_gridview.dart';
```
## Usage

```dart
    AdGridView(crossAxisCount: crossAxisCount,
itemCount: itemCount,
adIndex: adIndex,
adWidget: adWidget,
itemWidget: itemWidget)
```

### **Example**

![Image example][image_example]
<!-- Links -->
[image_example]: https://raw.githubusercontent.com/RajNarola29/ad_gridview/main/image/example_image.png