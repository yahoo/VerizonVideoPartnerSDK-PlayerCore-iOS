//  Copyright 2018, Oath Inc.
//  Licensed under the terms of the MIT License. See LICENSE.md file in project root for terms.
import Foundation
import CoreMedia
import PlayerCore

func toCMTime(_ seconds: Double) -> CMTime {
    return CMTime(seconds: seconds, preferredTimescale: 600)
}
func toCMTime(_ seconds: Double, timescale: CMTimeScale) -> CMTime {
    return CMTime(seconds: seconds, preferredTimescale: timescale)
}

let testUrl = URL(string: "http://test.com")!
