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
                .font(.system(size: 40))
                .foregroundColor(mapTrainLineToColor(line))
                .padding(.bottom, 8)
            
            Text(mapTrainLineToName(line) + " Line")
                .font(.system(size: 16)).bold()
                .foregroundColor(mapTrainLineToColor(line))
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .padding(.horizontal, 18)
        .padding(.vertical, 12)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(mapTrainLineToColor(line), lineWidth: 4)
        )
    }
}

#Preview {
    TrainLineItemView(line: TrainLine.purpleExpress)
}
