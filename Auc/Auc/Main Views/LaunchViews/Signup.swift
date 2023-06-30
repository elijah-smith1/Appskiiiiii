//
//  Signup.swift
//  Auc
//
//  Created by Elijah Smith on 6/21/23.
//

import SwiftUI
import FirebaseAuth
import Foundation


struct Signup: View {
   
        @State private var email: String = ""
        @State private var password: String = ""
        @State private var signupSuccessful = false
        @State private var uid: String = ""
        
        var body: some View {
            VStack {
                Spacer()
                
                Text("Create an Account")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Image("logo") // Replace with your app logo image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 150, height: 150)
                
                VStack(spacing: 20) {
                    TextField("Email", text: $email)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .font(.headline)
                    
                    SecureField("Password", text: $password)
                        .padding()
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                        .font(.headline)
                }
                .padding(.horizontal, 30)
                
                Button(action: {signup()}) {
                    Text("Sign Up")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                }.padding()
                    .background(Color.white)
                    .edgesIgnoringSafeArea(.all)
                    .fullScreenCover(isPresented: $signupSuccessful) {
                        CreateAccount(uid: uid)
                    }
                    
                
                
                Spacer()
                
               
            }
            .padding()
            .background(Color.white)
            .edgesIgnoringSafeArea(.all)
        }


        
    
        func signup() {
            Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
                if let error = error {
                    // Handle signup error
                    print("Signup error: \(error.localizedDescription)")
                } else {
                    // Signup successful, proceed to AccountCreation
                    print("Signup successful")
                    if let user = authResult?.user {
                        self.uid = user.uid
                    }
                    self.signupSuccessful = true
                }
            }
        }
    }




struct Signup_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            Signup()
                .environmentObject(UserData()) // Add the environment object here
        }
    }
}
