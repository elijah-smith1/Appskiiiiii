//
//  CreateAccount.swift
//  Auc
//
//  Created by Elijah Smith on 6/21/23.
//



import SwiftUI
import Firebase
import Foundation
import FirebaseStorage
import FirebaseFirestore

struct CreateAccount: View {
    var uid: String
    @EnvironmentObject var userData: UserData
    @State private var showingAlert = false
    @State private var alertMessage: String = ""
    @State private var profileImage: UIImage?
    @State private var isActive: Bool = false
    @State private var isShowingImagePicker = false

    var body: some View {
        NavigationStack { // Wrap VStack with NavigationView
            VStack {
                // Title and profile image
                Text("Create Your Account")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .padding(.bottom, 35)

                if profileImage != nil {
                    Image(uiImage: profileImage!)
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding(.bottom, 5)
                } else {
                    Image(systemName: "person.circle")
                        .resizable()
                        .aspectRatio(contentMode: .fill)
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .padding(.bottom, 5)
                }

                // Button to upload profile picture
                Button(action: {
                    self.isShowingImagePicker = true
                }) {
                    Text("Upload Profile Picture")
                        .font(.headline)
                        .padding()
                        .foregroundColor(Color.white)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .sheet(isPresented: $isShowingImagePicker, onDismiss: loadImage) {
                    ImagePicker(image: self.$profileImage, sourceType: .photoLibrary)
                }

                // Form for profile information
                Form {
                    Section(header: Text("Profile Information")) {
                        TextField("Username (Required)", text: $userData.username)
                            .font(.headline)
                            .foregroundColor(.black)
                        TextField("Biography (Max 150 characters)", text: $userData.bio)
                            .frame(height: 100)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                        Picker("Status", selection: $userData.status) {
                            ForEach(statuses, id: \.self) {
                                Text($0)
                            }
                        }
                        Picker("School", selection: $userData.school) {
                            ForEach(schools, id: \.self) {
                                Text($0)
                            }
                        }
                    }
                }

                // Create account button
                Button(action: {
                    createAccount()
                }) {
                    Text("Create Account")
                        .font(.headline)
                        .padding()
                        .foregroundColor(Color.white)
                        .frame(maxWidth: .infinity)
                        .background(Color.black)
                        .cornerRadius(10)
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 50)
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("Got it!")))
                }
            }
            .padding() // Add padding to the VStack content
            .navigationBarHidden(true) // Hide the navigation bar
        }
        .accentColor(.blue)
        .padding(.bottom, 5)
    }

    // Load the selected image
    private func loadImage() {
        guard let _ = profileImage else {
            self.alertMessage = "Please select a profile picture"
            self.showingAlert = true
            return
        }
    }

    // Create the user account
    private func createAccount() {
        guard let profileImage = profileImage,
              let imageData = profileImage.jpegData(compressionQuality: 0.8) else {
            self.alertMessage = "Please select a profile picture"
            self.showingAlert = true
            return
        }

        let storageRef = Storage.storage().reference().child("profilePictures/\(uid)/profilePicture.jpg")

        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        storageRef.putData(imageData, metadata: metadata) { (metadata, error) in
            if let error = error {
                self.alertMessage = error.localizedDescription
                self.showingAlert = true
            } else {
                storageRef.downloadURL { (url, error) in
                    if let error = error {
                        self.alertMessage = error.localizedDescription
                        self.showingAlert = true
                    } else if let downloadURL = url?.absoluteString {
                        let userData = [
                            "bio": self.userData.bio,
                            "username": self.userData.username,
                            "status": self.userData.status,
                            "school": self.userData.school,
                            "profilePictureURL": downloadURL
                        ]

                        Firestore.firestore().collection("users").document(uid).setData(userData) { error in
                            if let error = error {
                                self.alertMessage = error.localizedDescription
                                self.showingAlert = true
                            } else {
                                DispatchQueue.main.async {
                                    self.isActive = true
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

struct CreateAccount_Previews: PreviewProvider {
    static var previews: some View {
        // Simulate a logged-in user by retrieving the UID from Firebase Authentication
        if let currentUser = Auth.auth().currentUser {
            let uid = currentUser.uid
            return CreateAccount(uid: uid)
                .environmentObject(UserData()) // Add the environment object here
        }

        // Fallback preview for a non-logged-in user
        return CreateAccount(uid: "vCc9DwVzIKc9OLwE64F1ZTMkPVA2")
            .environmentObject(UserData()) // Add the environment object here
    }
}


