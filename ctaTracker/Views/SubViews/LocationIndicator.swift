//
//  LocationIndicator.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 5/11/24.
//

import SwiftUI
import ActivityIndicatorView

struct LocationIndicator: View {
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundStyle(.white.opacity(0.7))
                .frame(width: 24, height: 24)
            Circle()
                .foregroundStyle(.blue.opacity(0.85))
                .frame(width: 16, height: 16)
        }
    }
}

#Preview {
    LocationIndicator()
}
