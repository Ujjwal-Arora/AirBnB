//
//  AuthService.swift
//  AirBnB
//
//  Created by Ujjwal Arora on 19/09/24.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseStorage

class UserService {
    func authSignIn(email : String, password : String) async throws -> AuthDataResult{
            try await Auth.auth().createUser(withEmail: email, password: password)
    }
    func authSignOut() throws{
            try Auth.auth().signOut()
    }
    func authLogIn(email : String, password : String) async throws -> AuthDataResult{
            try await Auth.auth().signIn(withEmail: email, password: password)
    }
}
