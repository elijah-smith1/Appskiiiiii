//
//  LaunchView.swift
//  Auc
//
//  Created by Elijah Smith on 6/21/23.
//

import SwiftUI

struct LaunchView: View {
    var body: some View {
        @EnvironmentObject var userData: UserData
        NavigationStack {
            TabView {
                
                Login()
                    .tabItem {
                        Label("Login", systemImage: "person.crop.circle")
                    }
                Signup()
                    .tabItem {
                        Label("Sign Up", systemImage: "person.crop.circle.badge.plus")
                    }
                
            }
        }
    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LaunchView()
                .environmentObject(UserData()) // Add the environment object here
        }
    }
}
