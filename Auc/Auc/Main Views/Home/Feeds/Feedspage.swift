//
//  Feedspage.swift
//  Auc
//
//  Created by Elijah Smith on 6/27/23.
//



import SwiftUI
import Firebase


struct HomeView: View {
    @State private var isShowingFollowingView = false
    @State private var isShowingFavoritesView = false
    
   
        var body: some View {
               NavigationStack {
                   VStack {
                       Followingfeed()
                   }
               }
           }
       }





struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
        
          
    }
}
