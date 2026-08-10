# Wavebrook NetSignal

The Wavebrook NetSignal SDK for Flutter.

## Requirements

- Android 5.0+ (API 21), with [core library desugaring](https://developer.android.com/studio/write/java8-support#library-desugaring) enabled
- iOS 15.0+ (raise `platform :ios` in the Podfile and the Runner deployment target if needed)

## Installation

Add the dependencies to your `pubspec.yaml`. Note that `wavebrook` is required.

```yaml
dependencies:
  wavebrook: ^2.2.0
  wavebrook_netsignal: ^1.2.0
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

Some partners can optionally use additional capabilities (App Tracking Transparency, background
fetch). They are never required — enable them in your app only if agreed with Wavebrook.
