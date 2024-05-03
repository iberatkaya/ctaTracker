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
        HStack {
            Text(mapTrainLineToName(line) + " Line")
        }
    }
}

#Preview {
    TrainLineItemView(line: TrainLine.blue)
}
