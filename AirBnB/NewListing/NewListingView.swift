//
//  NewListingView.swift
//  AirBnB
//
//  Created by Ujjwal Arora on 19/09/24.
//

import SwiftUI
import FirebaseFirestore
import PhotosUI
struct NewListingView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var userVM : UserViewModel
    @StateObject var newListingVM : NewListingViewModel
    init(userVM: UserViewModel) {
        _userVM = ObservedObject(wrappedValue: userVM)
        _newListingVM = StateObject(wrappedValue: NewListingViewModel(userViewModel: userVM))
    }
    @State private var  amenities = Amenitie.selfCheckIn
    
    var body: some View {
        ScrollView {
            Text(userVM.currentFetchedUser?.fullname ?? "no user")
            
            
            VStack {
                PhotosPicker(selection: $newListingVM.selectedListingItems) {
                    Text("Select images for listing")
                        .foregroundStyle(.black)
                }.padding()
                
                TextField("title", text: $newListingVM.title)
                Stepper("Maximum guests alllowed : \(newListingVM.maximumGuests)", value: $newListingVM.maximumGuests)
                Stepper("number of Bedrooms : \(newListingVM.numberOfBedrooms)", value: $newListingVM.numberOfBedrooms)
                Stepper("Number of Bathrooms : \(newListingVM.numberOfBathrooms)", value: $newListingVM.numberOfBathrooms)
                TextField("address", text: $newListingVM.address)
                TextField("city", text: $newListingVM.city)
                TextField("state", text: $newListingVM.state)
                TextField("country", text: $newListingVM.country)
                HStack{
                    Text("Price per night (Rs.) :")
                    TextField("Eg 1500 ", text: $newListingVM.pricePerNight)
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.trailing)
                }

                ScrollView(.horizontal) {
                    
                    HStack {
                        Text("Amenities :")
                            .bold()
                        ForEach(Amenitie.allCases){amenity in
                            Button(action: {
                                if let index = newListingVM.amenities.firstIndex(where: {$0 == amenity}){
                                    newListingVM.amenities.remove(at: index)
                                }else{
                                    newListingVM.amenities.append(amenity)
                                }
                            }, label: {
                                Text(amenity.title)
                                    .padding()
                                    .font(.footnote)
                                    .foregroundStyle(.white)
                                    .background(newListingVM.amenities.contains(amenity) ? .pink : .gray)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            })
                            
                        }
                    }
                }
                Divider()
                ScrollView(.horizontal) {
                    HStack {
                        Text("Features :")
                            .bold()
                        
                        ForEach(Feature.allCases){feature in
                            Button(action: {
                                if let index = newListingVM.features.firstIndex(where: {$0 == feature}){
                                    newListingVM.features.remove(at: index)
                                }else{
                                    newListingVM.features.append(feature)
                                }
                            }, label: {
                                Text(feature.title)
                                    .padding()
                                    .font(.footnote)
                                    .foregroundStyle(.white)
                                    .background(newListingVM.features.contains(feature) ? .pink : .gray)
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                            })
                        }
                    }
                }
                Divider()
                Picker("Building Type", selection: $newListingVM.buildingType) {
                    ForEach(BuildingType.allCases){buildingType in
                        Text(buildingType.title)
                            .tag(buildingType)
                        
                    }
                }
                .pickerStyle(.segmented)
                .padding(.vertical)
                
                
                Button(action: {
                    Task{
                        try await newListingVM.uploadListingImagesToFirebaseStorage()
                        try await newListingVM.uploadListingToFirestore()
                        dismiss()
                    }
                }, label: {
                    Text("Save listing")
                        .foregroundStyle(.white)
                        .modifier(BoxModifier(backgroundColor: .pink))
                })
            }
            .font(.callout)
            .padding()
            
        }
    }
    
}

#Preview {
    NewListingView(userVM: UserViewModel())
}
