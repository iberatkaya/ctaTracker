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
                    .font(.system(size: 40))
                    .foregroundColor(.yellow)
                    .padding(.bottom, 8)
                
                Text("Favorites")
                    .font(.system(size: 16)).bold()
                    .foregroundColor(.yellow)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 18)
            .padding(.vertical, 12)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(.yellow, lineWidth: 4)
            )
    }
}

#Preview {
    FavoriteItemView()
}
