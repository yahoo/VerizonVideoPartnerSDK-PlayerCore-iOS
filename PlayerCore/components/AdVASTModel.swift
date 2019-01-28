//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.

import Foundation
extension Ad {
    public struct VASTModel: Hashable {
        public let adVerifications: [AdVerification]
        public let videos: [VideoType]
        public let clickthrough: URL?
        public let adParameters: String?
        public let pixels: AdPixels
        public let id: String?
        
        public struct MediaFile: Hashable {
            public let url: URL
            public let width: Int
            public let height: Int
            public let scalable: Bool
            public let maintainAspectRatio: Bool
            
            public init(url: URL,
                        width: Int,
                        height: Int,
                        scalable: Bool,
                        maintainAspectRatio: Bool) {
                self.url = url
                self.width = width
                self.height = height
                self.scalable = scalable
                self.maintainAspectRatio = maintainAspectRatio
            }
        }
        public enum VideoType: Hashable {
            case mp4(MediaFile)
            case vpaid(MediaFile)
            
            public var url: URL {
                switch self {
                case .mp4(let mediaFile): return mediaFile.url
                case .vpaid(let mediaFile): return mediaFile.url
                }
            }
        }
        
        public struct AdVerification: Hashable {
            public let vendorKey: String?
            public let javaScriptResource: URL
            public let verificationParameters: URL?
            public let verificationNotExecuted: URL?
            
            public init(vendorKey: String?,
                        javaScriptResource: URL,
                        verificationParameters: URL?,
                        verificationNotExecuted: URL?) {
                self.vendorKey = vendorKey
                self.javaScriptResource = javaScriptResource
                self.verificationParameters = verificationParameters
                self.verificationNotExecuted = verificationNotExecuted
            }
        }
        public init(adVerifications: [AdVerification],
                    videos: [VideoType],
                    clickthrough: URL?,
                    adParameters: String?,
                    pixels: AdPixels,
                    id: String?) {
            self.adVerifications = adVerifications
            self.videos = videos
            self.clickthrough = clickthrough
            self.adParameters = adParameters
            self.pixels = pixels
            self.id = id
        }
    }
}
