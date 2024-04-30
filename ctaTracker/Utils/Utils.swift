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

func parseNumbersFromString(_ str: String) -> [Int] {
    var items: [Int] = Array()
    let arr = str.components(separatedBy: CharacterSet.decimalDigits.inverted)
    for item in arr {
        if let number = Int(item) {
            items.append(number)
        }
    }
    return items
}
