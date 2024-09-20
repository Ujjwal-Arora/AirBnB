//
//  ProfileView.swift
//  AirBnB
//
//  Created by Ujjwal Arora on 11/09/24.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct ProfileView: View {
    @StateObject private var vm = AuthViewModel()

    
    var body: some View {
        VStack(alignment : .leading,spacing: 15){
            Text("Profile")
                .font(.largeTitle)
                .fontWeight(.semibold)
            Text("Log in to start planning your next trip")
            
            
            Button {
                vm.showLogInView = true
            } label: {
                Text("LogIn")
                    .foregroundStyle(.white)
                    .modifier(BoxModifier(backgroundColor: .pink))
            }.sheet(isPresented: $vm.showLogInView, content: {
                LoginView(vm: vm)
            })

            HStack {
                Text("Dont have an account?")
                Button {
                    vm.showSignUpView = true
                } label: {
                    Text("Sign up")
                        .underline()
                        .fontWeight(.semibold)
                        .foregroundStyle(.black)
                }.sheet(isPresented: $vm.showSignUpView, content: {
                    SignUpView(vm: vm)
                })

            }.font(.caption)
            
            Text(vm.currentUser?.fullname ?? "no name")
            
            Text(vm.profilePhotoUrl ?? "no photo url in publisher")
            
            Text(vm.currentUser?.profilePhotoUrl ?? "no photo url in current user")
            
            if let imageUrlString = vm.currentUser?.profilePhotoUrl{
                let url = URL(string: imageUrlString)
                AsyncImage(url: url) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                } placeholder: {
                    ProgressView()
                }
            }else {
                Text("no image in async image")
            }
            Text(Auth.auth().currentUser?.email ?? "no user")
            
            Text(vm.authService.currentUser?.email ?? "no user")
            
            
            
            Button("signOut") {
                
                vm.signOut()
            }
            NavigationLink("new listing view") {
                UploadListingView(vm: vm)
            }

        }
        .padding(.horizontal)
        .navigationTitle("Profile view")
    }
    
}

#Preview {
    NavigationStack{
        ProfileView()
    }
}
