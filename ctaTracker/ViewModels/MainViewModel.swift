//
//  MainViewModel.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/30/24.
//

import Foundation
import SwiftUI

@MainActor
class MainViewModel: ObservableObject {
    
    @Published var trainStops = TrainStops(stops: [])
    let repo = TrainRepository()
    
    func loadJSON() async {
        let jsonData = try? getJSONFile("stations")
        trainStops = TrainStops(stops: jsonData?.map({ TrainStop.fromJSON($0) }) ?? [])
    }
}

