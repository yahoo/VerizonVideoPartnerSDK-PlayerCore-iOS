# Change Log

## [Unreleased](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/tree/HEAD)

[Full Changelog](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/compare/1.0.4...HEAD)

**Merged pull requests:**

- Bump pod spec version to 1.0.4 [\#44](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/44) ([VladyslavAnokhin](https://github.com/VladyslavAnokhin))

## [1.0.4](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/tree/1.0.4) (2019-02-14)
[Full Changelog](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/compare/1.0.3...1.0.4)

**Merged pull requests:**

- Added open measurement skip action and updated ad finish tracker [\#42](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/42) ([RomanTysiachnik](https://github.com/RomanTysiachnik))
- Added progress pixel and refactored vast offset model [\#41](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/41) ([RomanTysiachnik](https://github.com/RomanTysiachnik))
- Added ad skip action and refactored AdFinishedTracker component [\#40](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/40) ([RomanTysiachnik](https://github.com/RomanTysiachnik))
- Renamed skipAd action to dropAd [\#39](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/39) ([RomanTysiachnik](https://github.com/RomanTysiachnik))
- Added case for other errors [\#38](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/38) ([VladyslavAnokhin](https://github.com/VladyslavAnokhin))
- Added skipOffset in VAST model [\#37](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/37) ([RomanTysiachnik](https://github.com/RomanTysiachnik))
- Updated struct VRMFinalResult -\> enum VRMFinalResult [\#36](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/36) ([VladyslavAnokhin](https://github.com/VladyslavAnokhin))
- Added internal id for AdCreative [\#35](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/35) ([VladyslavAnokhin](https://github.com/VladyslavAnokhin))
- Added timeoutBarrier to state [\#34](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/34) ([VladyslavAnokhin](https://github.com/VladyslavAnokhin))
- Added time range and item response time component [\#33](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/33) ([VladyslavAnokhin](https://github.com/VladyslavAnokhin))
- Clean up fetching/parsing queues if item completed or errored [\#32](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/32) ([VladyslavAnokhin](https://github.com/VladyslavAnokhin))
- Moved isOpenMeasurementAllowed from playAd action to State init [\#31](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/31) ([RomanTysiachnik](https://github.com/RomanTysiachnik))
- Reworked adCreative in Ad component [\#30](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/30) ([RomanTysiachnik](https://github.com/RomanTysiachnik))
- Added new ShowAd actions [\#29](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/29) ([RomanTysiachnik](https://github.com/RomanTysiachnik))
- Added max search time into ad settings [\#28](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/28) ([VladyslavAnokhin](https://github.com/VladyslavAnokhin))
- Added max ad search time [\#27](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/27) ([VladyslavAnokhin](https://github.com/VladyslavAnokhin))
- Added component to create an ad creative from new VAST model [\#26](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/26) ([RomanTysiachnik](https://github.com/RomanTysiachnik))
- enum VRMRequest -\> struct VRMRequest [\#25](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/25) ([VladyslavAnokhin](https://github.com/VladyslavAnokhin))
- Dropped boilerplate code for Hashable and Equatable [\#24](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/24) ([RomanTysiachnik](https://github.com/RomanTysiachnik))
- Added support for midrolls [\#23](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/23) ([VladyslavAnokhin](https://github.com/VladyslavAnokhin))
- Refactored VAST model media file and video type [\#22](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/22) ([RomanTysiachnik](https://github.com/RomanTysiachnik))
- Added action - NoMoreGroupsForProcessing [\#21](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/21) ([VladyslavAnokhin](https://github.com/VladyslavAnokhin))
- Add equatable to AdCreative [\#20](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/20) ([VladyslavAnokhin](https://github.com/VladyslavAnokhin))
- Added components for final result [\#19](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/19) ([VladyslavAnokhin](https://github.com/VladyslavAnokhin))
- Finish group action [\#18](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/18) ([VladyslavAnokhin](https://github.com/VladyslavAnokhin))
- Added component for error handling [\#17](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/17) ([VladyslavAnokhin](https://github.com/VladyslavAnokhin))
- Updated State to track when the ad is fully completed [\#16](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/16) ([RomanTysiachnik](https://github.com/RomanTysiachnik))
- Added components for timeout and max ad search [\#15](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/15) ([VladyslavAnokhin](https://github.com/VladyslavAnokhin))
- Added component for inline vasts [\#14](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/14) ([VladyslavAnokhin](https://github.com/VladyslavAnokhin))
- Added max redirect count in ad settings [\#13](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/13) ([VladyslavAnokhin](https://github.com/VladyslavAnokhin))
- Added components for unwrap vast wrappers [\#12](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/12) ([VladyslavAnokhin](https://github.com/VladyslavAnokhin))
- Submodule update + release 1.0.3 [\#11](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/11) ([AndriiMoskvin](https://github.com/AndriiMoskvin))

## [1.0.3](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/tree/1.0.3) (2019-01-14)
[Full Changelog](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/compare/1.0.2...1.0.3)

**Merged pull requests:**

- Podspec release 1.0.2 [\#10](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/10) ([AndriiMoskvin](https://github.com/AndriiMoskvin))

## [1.0.2](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/tree/1.0.2) (2019-01-02)
**Merged pull requests:**

-  Added parsing result queue [\#9](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/9) ([VladyslavAnokhin](https://github.com/VladyslavAnokhin))
- Added components for item parsing [\#8](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/8) ([VladyslavAnokhin](https://github.com/VladyslavAnokhin))
- Rename FetchCandidate -\> Candidate [\#7](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/7) ([VladyslavAnokhin](https://github.com/VladyslavAnokhin))
- Create components for item fetch [\#6](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/6) ([VladyslavAnokhin](https://github.com/VladyslavAnokhin))
- CPM improvements [\#5](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/5) ([AndriiMoskvin](https://github.com/AndriiMoskvin))
- Created components for item start controller [\#4](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/4) ([VladyslavAnokhin](https://github.com/VladyslavAnokhin))
- CPM implementation [\#3](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/3) ([AndriiMoskvin](https://github.com/AndriiMoskvin))
- Added components for group processing [\#2](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/2) ([VladyslavAnokhin](https://github.com/VladyslavAnokhin))
- Added components for VRM Request [\#1](https://github.com/VerizonAdPlatforms/VerizonVideoPartnerSDK-PlayerCore-iOS/pull/1) ([VladyslavAnokhin](https://github.com/VladyslavAnokhin))



\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*