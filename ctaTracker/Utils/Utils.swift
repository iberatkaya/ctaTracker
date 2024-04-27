//
//  Utils.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/27/24.
//

import Foundation


func isPreviewBuilder() -> Bool {
    return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
}
