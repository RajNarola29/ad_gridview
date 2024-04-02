# ad_gridview

A Flutter Widget to easily show Native Ad or any other Widget in between a GridView.


## Features

- Seamlessly integrate Native Advertisements into your GridView with a few simple clicks.
- Effortlessly incorporate any Widget of your choice into your GridView.
- Add Widgets to your GridView layout effortlessly, whether it's a single instance or multiple instances with just a few straightforward steps.

## Getting started

To use this package, add ad_gridview as a dependency in your pubspec.yaml file.
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
