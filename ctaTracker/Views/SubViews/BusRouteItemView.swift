//
//  BusRouteItemView.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/28/24.
//

import SwiftUI

struct BusRouteItemView: View {
    init(route: BusRoute, onSavePress: @escaping (BusRoute) -> Void = {_ in }, onDeletePress: @escaping (BusRoute) -> Void = {_ in }, isFaved: Bool = false) {
        self.isFaved = isFaved
        self.route = route
        self.onSavePress = onSavePress
        self.onDeletePress = onDeletePress
    }
    
    let isFaved: Bool
    let route: BusRoute
    let onSavePress: (_ route: BusRoute) -> Void
    let onDeletePress: (_ route: BusRoute) -> Void
    
    var body: some View {
        HStack {
            if (isFaved) {
                Image(systemName: "star.fill")
                    .font(.system(size: 16, weight: .light)).foregroundColor(Color.yellow)
            }
            Text(route.number + " - " + route.name)
                .swipeActions {
                    if (isFaved) {
                        Button("Delete") {
                            onDeletePress(route)
                        }
                        .tint(.red)
                    } else {
                        Button("Save") {
                            onSavePress(route)
                        }
                        .tint(.yellow)
                    }
                }
        }
    }
}

#Preview {
    BusRouteItemView(route: BusRoute(number: "151", name: "Sheridan", color: "#f0f"))
}
