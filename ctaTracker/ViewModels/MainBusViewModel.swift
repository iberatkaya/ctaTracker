//
//  MainViewModel.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/28/24.
//

import Foundation
import SwiftUI

@MainActor 
class MainBusViewModel: ObservableObject {
    
    @Published var busRoutes: BusRoutes = BusRoutes(routes: [])
    let repo = BusRepository()
    
    func fetchData() async {
        guard let response = await repo.getRoutes() else { return }
        busRoutes.routes = BusRoutes.fromDataObject(data: response).routes
    }
}
