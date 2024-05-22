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
    
    var isFaved: Bool
    let route: BusRoute
    let onSavePress: (_ route: BusRoute) -> Void
    let onDeletePress: (_ route: BusRoute) -> Void
    
    var body: some View {
        HStack(spacing: 0) {
            if (isFaved) {
                Image(systemName: "star.fill")
                    .font(.system(size: 16, weight: .light)).foregroundColor(Color.yellow)
                    .padding(.trailing, 8)
            }
            (Text(route.number).bold() + Text(" - " + route.name)).font(.system(size: 15))
                
        }.padding(.vertical, 4)
        .swipeActions {
            if (isFaved) {
                Button(action: {
                    onDeletePress(route)
                }, label: {
                    #if os(iOS)
                    Text("Delete")
                    #elseif os(watchOS)
                    Image(systemName: "trash.fill")
                    #endif
                })
                .tint(.red)
            } else {
                Button(action: {
                    onSavePress(route)
                }, label: {
                    #if os(iOS)
                    Text("Save")
                    #elseif os(watchOS)
                    Image(systemName: "star.fill")
                    #endif
                })
                .tint(.yellow)
            }
        }
    }
}

#Preview {
    var view = BusRouteItemView(route: BusRoute(number: "151", name: "Sheridan", color: "#f0f"))
    view.isFaved = true
    return view
}
