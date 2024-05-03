//
//  Utils.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/27/24.
//

import Foundation
import CoreLocation


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

func parseLocationStringToLocation(_ str: String) -> CLLocationCoordinate2D? {
    let pureValue = str.replacingOccurrences(of: "\"", with: "", options: .caseInsensitive, range: nil).replacingOccurrences(of: "(", with: "", options: .caseInsensitive, range: nil).replacingOccurrences(of: ")", with: "", options: .caseInsensitive, range: nil)

    let array = pureValue.components(separatedBy: ", ")
    if let lat = Double(array[0]), let lon = Double(array[1]) {
        return CLLocationCoordinate2D(latitude: lat, longitude: lon)
    }
    return nil
}

func getJSONFile(_ file: String) throws -> [TrainStopJSONData] {
    if let url = Bundle.main.url(forResource: file, withExtension: "json") {
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode([TrainStopJSONData].self, from: data)
            return jsonData
        } catch {
            print(error)
        }
    }
    throw JSONFileParseError.parseError
}

enum JSONFileParseError: Error {
    case parseError
}

func mapTrainLineToName(_ line: TrainLine) -> String {
    if (line == TrainLine.red) { return "Red" }
    if (line == TrainLine.blue) { return "Blue" }
    if (line == TrainLine.orange) { return "Orange" }
    if (line == TrainLine.pink) { return "Pink" }
    if (line == TrainLine.purple) { return "Purple" }
    if (line == TrainLine.purpleExpress) { return "Purple Express" }
    if (line == TrainLine.brown) { return "Brown" }
    if (line == TrainLine.green) { return "Green" }
    return "Yellow"
}

func mapTrainLineToKey(_ line: TrainLine) -> String {
    if (line == TrainLine.red) { return "red" }
    if (line == TrainLine.blue) { return "blue" }
    if (line == TrainLine.orange) { return "orange" }
    if (line == TrainLine.pink) { return "pink" }
    if (line == TrainLine.purple || line == TrainLine.purpleExpress) { return "purple" }
    if (line == TrainLine.brown) { return "brown" }
    if (line == TrainLine.green) { return "green" }
    return "yellow"
}
