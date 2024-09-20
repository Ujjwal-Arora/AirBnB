//
//  SignUpView.swift
//  AirBnB
//
//  Created by Ujjwal Arora on 11/09/24.
//

import SwiftUI
import Firebase
import FirebaseAuth
import PhotosUI

struct SignUpView: View {
    @ObservedObject var vm : UserViewModel
    var body: some View {
        VStack(spacing : 15){
            Spacer()
            Image("logo")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
            
            PhotosPicker("Profile Photo", selection: $vm.selectedUserItem)
            
            TextField("Enter fullname", text: $vm.fullname)
                .modifier(BoxModifier(backgroundColor: .gray.opacity(0.1)))
            TextField("Enter email", text: $vm.email)
                .modifier(BoxModifier(backgroundColor: .gray.opacity(0.1)))
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
            SecureField("Enter your password", text: $vm.password)
                .modifier(BoxModifier(backgroundColor: .gray.opacity(0.1)))
                .textInputAutocapitalization(.never)
            Button(action: {
                Task{
                    try await vm.signIn()
                    if vm.currentAuthUser != nil{
                        vm.showLogInView = false
                        vm.showSignUpView = false
                    }
                    
                }
            }, label: {
                Text("SignIn")
                    .foregroundStyle(.white)
                    .modifier(BoxModifier(backgroundColor: .pink))
            })
            
            Spacer()
            
        }
        .font(.callout)
        .padding()
    }
}

#Preview {
    NavigationStack{
        SignUpView(vm: UserViewModel())
    }
}
