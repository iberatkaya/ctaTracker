//
//  TrainRouteItemView.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 4/30/24.
//

import SwiftUI

struct TrainLineItemView: View {
    init(line: TrainLine) {
        self.line = line
    }
    
    let line: TrainLine
    
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "train.side.front.car")
                #if os(iOS)
                .font(.system(size: 40))
                #elseif os(watchOS)
                .font(.system(size: 36))
                #endif
                .foregroundColor(mapTrainLineToColor(line))
                .padding(.bottom, 8)
            
            Text(mapTrainLineToName(line) + " Line")
                #if os(iOS)
                .font(.system(size: 16)).bold()
                #elseif os(watchOS)
                .font(.system(size: 14)).bold()
                #endif
                .foregroundColor(mapTrainLineToColor(line))
                .multilineTextAlignment(.center)
                .padding(.horizontal, 4)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        #if os(iOS)
        .padding(.horizontal, 18)
        .padding(.vertical, 12)
        #elseif os(watchOS)
        .padding(.horizontal, 4)
        .padding(.vertical, 12)
        #endif
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(mapTrainLineToColor(line), lineWidth: 4)
        )
    }
}

#Preview {
    ScrollView {
        LazyVGrid(
            columns: [GridItem(spacing: 12), GridItem(spacing: 0)],
            spacing: 12
        ) {
            FavoriteItemView()
            
            ForEach(TrainLine.allCases, id: \.rawValue) { route in
                TrainLineItemView(line: route)
            }
        }
        .padding(.top, 4)
        .padding(.horizontal, 4)
        Spacer()
    }
}
