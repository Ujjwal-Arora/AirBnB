//
//  NewListingViewModel.swift
//  AirBnB
//
//  Created by Ujjwal Arora on 20/09/24.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage
import PhotosUI
import SwiftUI

@MainActor
class NewListingViewModel : ObservableObject{
    private let userViewModel : UserViewModel
    init(userViewModel : UserViewModel) {
        self.userViewModel = userViewModel
    }
    @Published var listingPhotosUrl = [String]()
    @Published var selectedListingItems = [PhotosPickerItem]()

    @Published var title = "Goa Villa"
    @Published var rating = 3.5
    @Published var pricePerNight = "1500"
    @Published var maximumGuests = 4
    @Published var numberOfBedrooms = 4
    @Published var numberOfBathrooms = 4
    @Published var latitude = 0.0
    @Published var longitude = 0.0
    @Published var address = "Church Street"
    @Published var city = "Panji"
    @Published var state = "Goa"
    @Published var country = "India"
    @Published var imageUrl = [String]()
    @Published var amenities = [Amenitie]()
    @Published var features = [Feature]()
    @Published var buildingType : BuildingType = .villa
    
    func uploadListingToFirestore() async throws{
        do {
            if let user = userViewModel.currentFetchedUser{
                let newListing = ListingModel(title: title, pricePerNight: Int(pricePerNight) ?? 0, maximumGuests: maximumGuests, numberOfBedrooms: numberOfBedrooms, numberOfBathrooms: numberOfBathrooms, latitude: latitude, longitude: longitude, address: address, city: city, state: state, country: country, imagesUrls: listingPhotosUrl, amenities: amenities, features: features, buildingType: buildingType, Owner: user)
                let encodedListing = try Firestore.Encoder().encode(newListing)
                try await Firestore.firestore().collection("listings").addDocument(data: encodedListing)
            }
        }catch{
            print(error.localizedDescription)
        }
    }
    func uploadListingImagesToFirebaseStorage() async throws{
        guard let uid = userViewModel.currentAuthUser?.uid else { return print("👻 no Auth user found")}
        self.listingPhotosUrl.removeAll() //check by removing this
        for item in selectedListingItems {
            let reference =  Storage.storage().reference(withPath: "listingPics/\(uid)\(UUID().uuidString)")
            if let imageData = try await item.loadTransferable(type: Data.self){
                let _ = try await reference.putDataAsync(imageData)
                
                let imageUrl = try await reference.downloadURL()
                self.listingPhotosUrl.append(imageUrl.absoluteString)
                print("❤️\(listingPhotosUrl)")
            }
        }
    }
}
