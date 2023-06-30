//
//  VendorModel.swift
//  Auc
//
//  Created by Elijah Smith on 6/27/23.
//

import Foundation
struct Vendor: Identifiable {
    var id = UUID()
    var name: String
    var category: String
    var image: Image
    var school: String
    var Open: String
}
import SwiftUI

class VendorViewModel: ObservableObject {
    @Published var selectedTab = 0

    let categories = ["All", "Food", "Clothes", "Hair", "Tutor", "Tattoo"]
    
    let sampleVendors = [
        Vendor(name: "Aunties Wings", category: "Food", image: Image(systemName: "cart") , school: "Morehouse" , Open: "Open"),
        Vendor(name: "PIY", category: "Clothes", image: Image(systemName: "tag") , school: "Spelman" , Open: "Open"),
        Vendor(name: "Hair braider", category: "Hair", image: Image(systemName: "scissors") , school: "CAU" , Open: "6-10"),
        Vendor(name: "Comp Sci tutor", category: "Tutor", image: Image(systemName: "book") , school: "Georgie Tech" , Open: "Closes soon"),
        Vendor(name: "Ink Palm", category: "Tattoo", image: Image(systemName: "paintbrush") , school: "Morehouse" , Open: "Closed")
    ]
    
    var filteredVendors: [Vendor] {
        if selectedTab == 0 {
            return Array(sampleVendors.dropFirst())
        } else {
            let selectedCategory = categories[selectedTab]
            return sampleVendors.filter { $0.category == selectedCategory }
        }
    }
}


