//
//  MainMapView.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 5/11/24.
//

import SwiftUI

struct MainMapView: View {
    var body: some View {
        NavigationStack {
            AllTransitMapView()
        }
    }
}

#Preview {
    MainMapView()
}
