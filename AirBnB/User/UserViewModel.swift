//
//  UserViewModel.swift
//  AirBnB
//
//  Created by Ujjwal Arora on 19/09/24.
//

import Foundation
import Firebase
import FirebaseAuth
import FirebaseStorage
import PhotosUI
import SwiftUI

@MainActor
class UserViewModel : ObservableObject {
    @Published var showLogInView = false
    @Published var showSignUpView = false

    @Published var currentFetchedUser : UserModel?
    @Published var currentAuthUser = Auth.auth().currentUser
    @Published var email = "ujjwal@gmail.com"
    @Published var password = "qqqqqq"
    @Published var fullname = "Ujjwal"
    @Published var profilePhotoUrl = ""
    @Published var selectedUserItem : PhotosPickerItem?
    
    private let userService = UserService()
    
    init() {
        Task{
            print("0")
            print(currentAuthUser?.email ?? "no user")
            
            print("🌞")
            try await fetchUserFromFirestore()
        }
    }
    func signIn() async throws{
        do {
            let result = try await userService.authSignIn(email: email, password: password)
            self.currentAuthUser = result.user
            print("1")
            print("SignIn done \(currentAuthUser?.email ?? "no user")")
            try await uploadUserImageToFirebaseStorage()
            try await uploadUserToFirestore()
            try await fetchUserFromFirestore()
        }catch{
            print(error.localizedDescription)
        }
    }
    func signOut(){
        do {
            try userService.authSignOut()
            self.currentAuthUser = nil
            self.currentFetchedUser = nil
            
            print("1")
            
            print("SignOut done \(currentAuthUser?.email ?? "no user")")
            
        }catch{
            print(error.localizedDescription)
        }
    }
    func logIn() async throws{
        do {
            let result = try await userService.authLogIn(email: email, password: password)
            self.currentAuthUser = result.user
            print("1 LogIn done \(currentAuthUser?.email ?? "no user")")
            
            try await fetchUserFromFirestore()
        }catch{
            print(error.localizedDescription)
        }
    }
    func uploadUserToFirestore() async throws{
        do {
            let newUser = UserModel(email: email, fullname: fullname, profilePhotoUrl: profilePhotoUrl)
            let encodedUser = try Firestore.Encoder().encode(newUser)
            let reference = Firestore.firestore().collection("users").document(currentAuthUser?.uid ?? UUID().uuidString)
            try await reference.setData(encodedUser)
        }catch{
            print(error.localizedDescription)
        }
    }
    func fetchUserFromFirestore() async throws {
        do {
            guard let uid = currentAuthUser?.uid else { return print("👻 no Auth user found")}
            let userDoc = try await Firestore.firestore().collection("users").document(uid).getDocument(as: UserModel.self)
            self.currentFetchedUser = userDoc
            print("2 fetched user")
            print(currentFetchedUser?.email ?? "")
        }catch{
            print(error.localizedDescription)
        }
    }
    func uploadUserImageToFirebaseStorage() async throws{
        if let imageData = try await selectedUserItem?.loadTransferable(type: Data.self){
            let reference =  Storage.storage().reference(withPath: "profilePic/\(currentAuthUser?.uid ?? UUID().uuidString)")
            let _ = try await reference.putDataAsync(imageData)
            
            let imageUrl = try await reference.downloadURL()
            self.profilePhotoUrl = imageUrl.absoluteString
            print("❤️\(profilePhotoUrl)")
        }
    }
}
