//
//  searchbar.swift
//  Auc
//
//  Created by Elijah Smith on 6/27/23.
//

import Foundation
import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            TextField("Search", text: $text)
                .padding(.horizontal, 15)
                .frame(height: 40)
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)
            
            Button(action: {
                // Clear search text
                text = ""
            }) {
                Image(systemName: "xmark.circle.fill")
                    .foregroundColor(.gray)
                    .font(.title2)
            }
            .padding(.trailing, 10)
            .opacity(text.isEmpty ? 0 : 1)
        }
    }
}
