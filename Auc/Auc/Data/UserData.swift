//
//  UserData.swift
//  Auc
//
//  Created by Elijah Smith on 6/21/23.
//


import Foundation

class UserData: ObservableObject {
    @Published var bio: String = ""
    @Published var username: String = ""
    @Published var status: String = ""
    @Published var school: String = ""
    @Published var profilePictureURL: String = ""
  
}
let statuses = ["Online", "Offline", "Do Not Disturb", "Studying", "Geeked", "Partying", "Bored", "In Gym"]
let schools = ["Clark Atlanta","Emory","Georgia","Georgia State","Georgia Tech","Kennesaw State","Morehouse", "Morris Brown", "Spelman", "SCAD"]
