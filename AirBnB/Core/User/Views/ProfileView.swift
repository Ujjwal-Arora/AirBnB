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
    @StateObject private var vm = UserViewModel()

    
    var body: some View {
        VStack(alignment : .leading,spacing: 15){
            Text("Profile")
                .font(.largeTitle)
                .fontWeight(.semibold)
            if vm.currentAuthUser == nil{
                
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
            }else{
                if let imageUrlString = vm.currentFetchedUser?.profilePhotoUrl,let url = URL(string: imageUrlString){
                    AsyncImage(url: url) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 100, height: 100)
                            .clipShape(Circle())
                    } placeholder: {
                        ProgressView()
                    }
                }
                Text("Hello, \(vm.currentFetchedUser?.fullname ?? "no name")")
                                                                
                Button {
                    vm.signOut()
                } label: {
                    Text("Sign Out")
                        .foregroundStyle(.white)
                        .modifier(BoxModifier(backgroundColor: .pink))
                }
                
                NavigationLink {
                    NewListingView(userVM: vm)
                } label: {
                    Text("Add your property on AirBnB")
                        .foregroundStyle(.white)
                        .modifier(BoxModifier(backgroundColor: .pink))
                }
            }
        }
        .font(.callout)
        .padding(.horizontal)
    }
    
}

#Preview {
    NavigationStack{
        ProfileView()
    }
}
