//
//  BusRoutesView.swift
//  ctaTracker Watch App
//
//  Created by Ibrahim Berat Kaya on 5/19/24.
//

import SwiftUI
import ActivityIndicatorView

struct BusRoutesView: View {
    @ObservedObject var viewModel = BusRoutesViewModel(routes: [])
    
    var body: some View {
        List {
            if viewModel.isLoading {
                ActivityIndicatorView(isVisible: $viewModel.isLoading, type: .growingArc(.blue, lineWidth: 3))
                     .frame(width: 54.0, height: 54.0)
            } else {
                ForEach(viewModel.busRoutes.routes, id: \.name) { i in
                    Text("\(i.number) - \(i.name)")
                }
            }
        }
        .task {
            _ = await viewModel.fetchData()
        }
    }
}

#Preview {
    BusRoutesView(viewModel: BusRoutesViewModel(routes: [BusRoute(number: "151", name: "Sheridan", color: "Blue")]))
}
