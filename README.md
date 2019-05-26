# Verizon Video Partner SDK - Player Core

> PlayerCore contains important player logic which is used by Verizon Video Partner SDK.

<p>
    <a href="https://travis-ci.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS">
        <img src="https://travis-ci.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS.svg?branch=master" alt="Build Status" />
    </a>
    <a href="https://codecov.io/gh/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/branch/master">
        <img src="https://codecov.io/gh/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/branch/master/graphs/badge.svg" alt="Code Coverage" />
    </a>
    <a href="https://raw.githubusercontent.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-iOS/master/LICENSE.md">
        <img src="https://img.shields.io/badge/License-MIT-blue.svg?style=flat" alt="MIT LICENSE" />
    </a>
    <img src="https://img.shields.io/badge/Swift-4.2-orange.svg" alt="Swift 4.2" />
</p>

## Table of Contents

[Verizon Video Partner SDK - for iOS and tvOS](#Verizon-video-partner-sdk---for-ios-and-tvos)
1. [Install](#install)
   1. [Cocoapods](#cocoapods)
   2. [Carthage](#carthage)
2. [Usage](#usage)
3. [Contribute](#contribute)
4. [Maintainers](#maintainers)
5. [License](#license)

## Install

### Cocoapods

You can install this module using CocoaPods. 
You have to add PlayerCore pod in a Podfile:

```ruby
target 'Target-Name' do
    pod 'PlayerCore'
end
```

After that execute this command in a Podfile folder: 

```bash
pod install
```

### Carthage

To use Carthage, all you need is to add this repository in your Cartfile as:
```bash
github "VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS"
```

And then you have to execute command:
```bash
carthage update 
```

## Usage

This project is used in [Verizon VideoPartner SDK](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-iOS).
It is a required dependency for the OVPSDK and it is not expected to be used separately from the SDK.

## Contribute

Please refer to [the contributing.md file](Contributing.md) for information about how to get involved. We welcome issues, questions, and pull requests. Pull Requests are welcome.

## Maintainers

- [Andrey Moskvin](mailto:andrey.moskvin@verizonmedia.com)
- [Roman Tysiachnik](mailto:roman.tysiachnik@verizonmedia.com)
- [Vladyslav Anokhin](mailto:vladyslav.anokhin@verizonmedia.com)

## License

This project is licensed under the terms of the MIT open source license. Please refer to [LICENSE](LICENSE) for the full terms.

