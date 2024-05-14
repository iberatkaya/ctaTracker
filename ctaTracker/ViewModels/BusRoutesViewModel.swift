//
//  BusRoutesViewModel.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/28/24.
//

import Foundation
import SwiftUI

@MainActor 
class BusRoutesViewModel: ObservableObject {
    init(routes: [BusRoute]) {
        self.busRoutes = BusRoutes(routes: routes)
    }
    
    @Published var isLoading = true
    @Published var busRoutes: BusRoutes
    let repo = BusRepository()
    
    func fetchData() async -> [BusRoute]? {
        guard let response = await repo.getRoutes() else { return nil }
        let routes = BusRoutes.fromDataObject(data: response).routes
        busRoutes.routes = routes
        
        withAnimation(.easeOut(duration: TimeInterval(0.25))) {
            isLoading = false
        }
        return routes
    }
}
