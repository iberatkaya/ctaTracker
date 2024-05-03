//
//  TrainRoutesView.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/30/24.
//

import SwiftUI
import SwiftData

struct TrainRoutesView: View {
    var body: some View {
        VStack {
            List {
                Section(header: Text("All Train Lines")) {
                    ForEach(TrainLine.allCases, id: \.rawValue) { route in
                        NavigationLink(destination: EmptyView(), label: {
                            TrainLineItemView(line: route)
                        })
                    }
                }
            }
        }
    }
}

#Preview {
    TrainRoutesView()
        .environmentObject(BusRoutes(routes: [BusRoute(number: "151", name: "Sheridan", color: "#f0f")]))
}
