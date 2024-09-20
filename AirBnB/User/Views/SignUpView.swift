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
   // @Environment(\.dismiss) var dismiss
    @ObservedObject var vm : AuthViewModel
    @StateObject var photoPickerVM = PhotoPickerViewModel1()
    @State private var selectedPickerItemInSignUp : PhotosPickerItem?

    var body: some View {
        VStack(spacing : 15){
            Spacer()
            VStack{
                if let uiImage = photoPickerVM.outputUiImages.first{
                    Image(uiImage: uiImage)
                        .resizable()
                        .clipShape(Circle())
                }else {
                    Image("logo")
                        .resizable()
                }
            }
            .scaledToFill()
            .frame(width: 100, height: 100)

//            Button("click for storage") {
//                Task{
//                    try await photoPickerVM.uploadUiImageToFirebaseStorage(folderName: "profileImages")
//                }
//            }
//            Text(photoPickerVM.firebaseStorageImageUrls.first ?? "no url")
            
            PhotosPicker(selection: $selectedPickerItemInSignUp) {
                Text("Select Profile Photo")
                    .foregroundStyle(.black)
                    .bold()
            }.onChange(of: selectedPickerItemInSignUp) { oldValue, newValue in
                if let item = newValue{
                    Task{
                        try await photoPickerVM.loadPhotoPickerImage(selectedItems: [item])
                    }
                }
            }
            
            TextField("Enter fullname", text: $vm.fullname)
                .modifier(BoxModifier(backgroundColor: .gray.opacity(0.1)))
            TextField("Enter email", text: $vm.email)
                .modifier(BoxModifier(backgroundColor: .gray.opacity(0.1)))
                .textInputAutocapitalization(.never)
                .keyboardType(.emailAddress)
            SecureField("Enter your password", text: $vm.password)
                .modifier(BoxModifier(backgroundColor: .gray.opacity(0.1)))
                .textInputAutocapitalization(.never)
            
//            Text(Auth.auth().currentUser?.email ?? "no user")
//            Text(vm.authService.currentUser?.email ?? "no user")

            Button(action: {
                Task{
// changed this     if photoPickerVM.outputUiImage != nil {
                    if selectedPickerItemInSignUp != nil {
                        try await photoPickerVM.uploadUiImageToFirebaseStorage(folderName: "profileImages")
                        vm.profilePhotoUrl = photoPickerVM.firebaseStorageImageUrls.first
                    }
                    try await vm.signUp()
                    if vm.currentAuthUserSession != nil{
                        vm.showLogInView = false
                        vm.showSignUpView = false
                    }
                }

            }, label: {
                Text("SignUp")
                    .foregroundStyle(.white)
                    .modifier(BoxModifier(backgroundColor: .pink))
            })
            Spacer()

        }.padding()
    }
}

#Preview {
    NavigationStack{
        SignUpView(vm: AuthViewModel())
    }
}
