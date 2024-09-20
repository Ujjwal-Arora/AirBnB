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
    @ObservedObject var vm : UserViewModel
    
    @State private var title = "Goa Villa"
    @State private var rating = 3.5
    @State private var pricePerNight = 1000
    @State private var maximumGuests = 4
    @State private var numberOfBedrooms = 4
    @State private var numberOfBathrooms = 4
    @State private var latitude = 0.0
    @State private var longitude = 0.0
    @State private var address = "Church Street"
    @State private var city = "Panji"
    @State private var state = "Goa"
    @State private var country = "India"
    @State private var imageUrl = [String]()
    @State private var amenities : [Amenitie] = [.selfCheckIn,.superHost]
    @State private var features : [Feature] = [.petsAllowed,.pool,.fireSafety]
    @State private var buildingType : BuildingType = .villa

    var body: some View {
        Text(vm.currentFetchedUser?.fullname ?? "no user")
        
        TextField("title", text: $title)
        Stepper("maximum guests \(maximumGuests)", value: $maximumGuests)
        Stepper("numberOfBedrooms \(numberOfBedrooms)", value: $numberOfBedrooms)
        Stepper("numberOfBathrooms \(numberOfBathrooms)", value: $numberOfBathrooms)
        TextField("address", text: $address)
        TextField("city", text: $city)
        TextField("state", text: $state)
        TextField("country", text: $country)
        
        PhotosPicker("pics", selection: $vm.selectedListingItem)
        
        Button("save listing") {
            Task{
                try await vm.uploadListingImagesToFirebaseStorage()
                try await uploadListingToFirestore()
            }
        }
        
        
    }
    func uploadListingToFirestore() async throws{
        do {
            if let user = vm.currentFetchedUser{
                let newListing = ListingModel(title: title, pricePerNight: pricePerNight, maximumGuests: maximumGuests, numberOfBedrooms: numberOfBedrooms, numberOfBathrooms: numberOfBathrooms, latitude: latitude, longitude: longitude, address: address, city: city, state: state, country: country, imagesUrls: vm.listingPhotosUrl, amenities: amenities, features: features, buildingType: buildingType, Owner: user)
                let encodedListing = try Firestore.Encoder().encode(newListing)
                try await Firestore.firestore().collection("listings").addDocument(data: encodedListing)
            }
        }catch{
            print(error.localizedDescription)
        }
    }
}

#Preview {
    NewListingView(vm: UserViewModel())
}
