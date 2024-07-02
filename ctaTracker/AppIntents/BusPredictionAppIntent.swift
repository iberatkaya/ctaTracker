//
//  BusPredictionAppIntent.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 6/28/24.
//

import AppIntents
import Foundation

struct BusPredictionIntent: AppIntent {
    static let title = LocalizedStringResource("Get predictions")

    @Parameter(title: "Bus Route")
    var busRoute: String

    @Parameter(title: "Bus Stop ID")
    var busStopID: String

    @MainActor
    func perform() async throws -> some IntentResult & ProvidesDialog & ReturnsValue<String> {
        let repo = BusRepository()
        let data = await repo.getRouteStopPredictions(routeNumber: busRoute, stopID: busStopID)
        if let data, let predictions = try? BusStopPredictions.fromDataObject(data: data) {
            let res = predictions.predictions.map { i in
                if let pred = try? timestampDiffFromNowInMinutes(date: i.prediction, type: .bus, curDate: Date.now) {
                    return pred > 0 ? "\(String(pred)) mins left" : "Arriving soon"
                } else {
                    return "Error"
                }
            }.joined(separator: ", ")
            
            let firstItem = predictions.predictions.first
            
            return .result(value: res, dialog: "\(res) for \(firstItem?.stopName ?? "") (\(firstItem?.routeDirection ?? ""))")
        }
        
        return .result(value: "Error", dialog: "Error")
    }
}

struct BusPredictionShortcuts: AppShortcutsProvider {
    static var appShortcuts: [AppShortcut] {
        AppShortcut(
            intent: BusPredictionIntent(),
            phrases: [
                "Get bus predictions 1in \(.applicationName)",
            ],
            shortTitle: "Get bus predictions",
            systemImageName: "clock.fill"
        )
    }

    static var shortcutTileColor: ShortcutTileColor = .blue
}
