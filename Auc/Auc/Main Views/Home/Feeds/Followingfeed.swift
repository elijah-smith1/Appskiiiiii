//
//  Followingfeed.swift
//  Auc
//
//  Created by Elijah Smith on 6/21/23.
//

import SwiftUI

struct Followingfeed: View {
    var body: some View {
       PostListView()
            .navigationBarBackButtonHidden(true)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Menu {
                        NavigationLink(destination: Followingfeed()) {
                            Label("Following", systemImage: "person.fill")
                        }
                        
                        NavigationLink(destination: Favoritefeed()) {
                            Label("Favorites", systemImage: "star.fill")
                        }
                        
                        NavigationLink(destination: Explorefeed()) {
                            Label("Explore", systemImage: "magnifyingglass")
                        }
                    } label: {
                        Label("Menu", systemImage: "line.horizontal.3")
                            .font(.title)
                            .foregroundColor(.black)
                    }
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: Notifications()) {
                        Label("Notifications", systemImage: "bell.fill")}
                }
            }.navigationTitle("Following")
        
    }

}

struct Followingfeed_Previews: PreviewProvider {
    static var previews: some View {
        Followingfeed()
    }
}
