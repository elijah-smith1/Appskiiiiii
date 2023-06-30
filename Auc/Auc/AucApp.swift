//
//  AucApp.swift
//  Auc
//
//  Created by Elijah Smith on 5/27/23.
//

import SwiftUI
import Firebase

@main

struct MyApp: App {
    @StateObject private var userData = UserData()

    init() {
        FirebaseApp.configure()
    }

    var body: some Scene {
        WindowGroup {
            LaunchView()
                .environmentObject(userData)
        }
    }
}
