//
//  BusStopItemView.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 6/1/24.
//

import SwiftUI

struct BusStopItemView: View {
    internal init(busStop: BusRouteStop, isFaved: Bool, title: String? = nil, onSavePress: ((BusRouteStop) -> Void)? = nil, onDeletePress: ((BusRouteStop) -> Void)? = nil) {
        self.busStop = busStop
        self.isFaved = isFaved
        self.title = title
        self.onSavePress = onSavePress
        self.onDeletePress = onDeletePress
    }
    
    let busStop: BusRouteStop
    let isFaved: Bool
    let title: String?
    let onSavePress: ((_ stop: BusRouteStop) -> Void)?
    let onDeletePress: ((_ stop: BusRouteStop) -> Void)?
    
    var body: some View {
        HStack(alignment: .center, spacing: 0) {
            if (isFaved) {
                Image(systemName: "star.fill")
                    .font(.system(size: 16, weight: .light)).foregroundColor(Color.yellow)
                    .padding(.trailing, 4)
            }
            Image(systemName: "circle.fill")
                .font(.system(size: 6)).foregroundColor(Color.black)
                .padding(.trailing, 8)
            Text(title ?? busStop.name)
                .font(.system(size: 16, weight: .regular))
                .padding(.vertical, 2)
            Spacer()
        }
        .swipeActions {
            if isFaved {
                Button(action: {
                    onDeletePress?(busStop)
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
                    onSavePress?(busStop)
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
    BusStopItemView(busStop: BusRouteStop(stopID: "123", name: "Lake Shore Dr", lat: 12, lon: 12), isFaved: true)
}
