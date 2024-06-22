//
//  BusStopPredictionsViewModel.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/28/24.
//

import Foundation
import SwiftUI
import SwiftData

@MainActor
class BusStopPredictionsViewModel: ObservableObject {
    init(busRoute: BusRoute, stop: BusRouteStop, busPredictions: BusStopPredictions? = nil) {
        self.busRoute = busRoute
        self.stop = stop
        self.busPredictions = busPredictions ?? BusStopPredictions(predictions: [])
    }
    
    var busRoute: BusRoute
    var stop: BusRouteStop
    @Published var busPredictions: BusStopPredictions
    @Environment(\.modelContext) var modelContext
    @Published var predictionsLoading = false
    @Published var noScheduledService = false
    @Published var didFetchDataOnce = false
    let repo = BusRepository()
    @Published var fetchDate: Date? = nil
    
    func fetchPredictions() async {
        didFetchDataOnce = true
        predictionsLoading = true
        noScheduledService = false
        fetchDate = Date.now
        do {
            if let res = await repo.getRouteStopPredictions(routeNumber: busRoute.number, stopID: stop.stopID)  {
                busPredictions.predictions = try BusStopPredictions.fromDataObject(data: res).predictions
            } else {
                noScheduledService = true
            }
        } catch {
            noScheduledService = true
        }
        withAnimation(.easeOut(duration: TimeInterval(0.25))) {
            predictionsLoading = false
        }
    }
}
