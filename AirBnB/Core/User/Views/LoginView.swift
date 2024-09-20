//
//  LoginView.swift
//  AirBnB
//
//  Created by Ujjwal Arora on 11/09/24.
//

import SwiftUI
import Firebase
import FirebaseAuth

struct LoginView: View {
    @ObservedObject var vm : UserViewModel
    var body: some View {
        VStack(spacing : 15){
            Spacer()
            Image("logo")
                .resizable()
                .scaledToFill()
                .frame(width: 100, height: 100)
                .padding()
            TextField("Enter email", text: $vm.email)
                .modifier(BoxModifier(backgroundColor: .gray.opacity(0.1)))
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)

            SecureField("Enter your password", text: $vm.password)
                .modifier(BoxModifier(backgroundColor: .gray.opacity(0.1)))
                .textInputAutocapitalization(.never)
            Button(action: {
                Task{
                    try await vm.logIn()
                    if vm.currentAuthUser != nil{
                        vm.showLogInView = false
                    }
                }
            }, label: {
                Text("LogIn")
                    .foregroundStyle(.white)
                    .modifier(BoxModifier(backgroundColor: .pink))
            })
            Spacer()
            Button {
                vm.showSignUpView = true
                
            } label: {
                Text("Dont have an account? SignUp")
                    .font(.subheadline)
                    .bold()
                    .foregroundStyle(.blue)
                    .padding()
            }
            .sheet(isPresented: $vm.showSignUpView, content: {
                SignUpView(vm: vm)
            })

        }
        .font(.callout)
        .padding()
    }
}

#Preview {
    NavigationStack{
        LoginView(vm: UserViewModel())
    }
}
