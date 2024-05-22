//
//  MainView.swift
//  ctaTracker Watch App
//
//  Created by Ibrahim Berat Kaya on 5/19/24.
//

import SwiftUI
import SwiftData

struct MainView: View {
    
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: { BusRoutesView() }, label: { Text("Bus Routes").font(.system(size: 16)) })
                NavigationLink(destination: { TrainRoutesView() }, label: { Text("Train Routes").font(.system(size: 16)) })
            }.padding(.horizontal, 2)
        }
    }
}

#Preview {
    MainView()
}
