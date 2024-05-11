//
//  LocationIndicator.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 5/11/24.
//

import SwiftUI
import ActivityIndicatorView

struct LocationIndicator: View {
    @State var showLocation = true
    
    var body: some View {
        ZStack {
            ActivityIndicatorView(isVisible: $showLocation, type: .growingCircle)
                .frame(width: 48, height: 48)
                .opacity(0.65)
                .foregroundStyle(Color.blue)
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
