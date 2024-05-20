//
//  FavoriteItemView.swift
//  ctaTracker
//
//  Created by Ibrahim Berat Kaya on 5/9/24.
//

import SwiftUI

struct FavoriteItemView: View {
    var body: some View {
        VStack(spacing: 0) {
            Image(systemName: "star.fill")
                #if os(iOS)
                .font(.system(size: 40))
                #elseif os(watchOS)
                .font(.system(size: 36))
                #endif
                .foregroundColor(.yellow)
                .padding(.bottom, 8)
            
            Text("Favorites")
                #if os(iOS)
                .font(.system(size: 16)).bold()
                #elseif os(watchOS)
                .font(.system(size: 14)).bold()
                #endif
                .foregroundColor(.yellow)
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
                .stroke(.yellow, lineWidth: 4)
        )
    }
}

#Preview {
    FavoriteItemView()
}
