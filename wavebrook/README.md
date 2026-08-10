# Wavebrook Flutter SDK

The Wavebrook SDK for Flutter.

## Requirements

- Android 5.0+ (API 21)
- iOS 13.0+

## Installation

Add the dependency to your `pubspec.yaml`:

```yaml
dependencies:
  wavebrook: ^2.2.0
```

### iOS

If your project uses CocoaPods (the default unless Swift Package Manager support is enabled),
add the Wavebrook specs repository at the top of `ios/Podfile`:

```ruby
source 'https://github.com/wavebrook/cocoapods-specs.git'
source 'https://cdn.cocoapods.org/'
```

Projects with Flutter's Swift Package Manager integration enabled need no configuration — the
SDK resolves through the public [`ios-spm`](https://github.com/wavebrook/ios-spm) package.

## Usage

Import the library:

```dart
import 'package:wavebrook/wavebrook.dart';
```

Provide consent and initialize:

```dart
await ConsentManager.set(true);
await Wavebrook.initialize('<your-asset-key>');
```

The current consent is available as a typed model:

```dart
final ConsentData? consent = await ConsentManager.data;
```
