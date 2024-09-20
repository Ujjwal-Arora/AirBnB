//
//  AirBnBApp.swift
//  AirBnB
//
//  Created by Ujjwal Arora on 18/09/24.
//

import SwiftUI
import Firebase

@main
struct AirBnBApp: App {
//    @StateObject var authService = AuthService()
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack{
                ContentView()
                //           .environmentObject(authService)
            }
        }
    }
}
