//
//  ListingViewModel.swift
//  AirBnB
//
//  Created by Ujjwal Arora on 20/09/24.
//

import Foundation

@MainActor
class ListingViewModel: ObservableObject{
    @Published var listings = [ListingModel]()
    @Published var searchText = ""
    @Published var incomingGuests = 1

    
    private let listingService = ListingService()
    
    
    func fetchListings() async throws {
        if searchText.isEmpty{
            self.listings = try await listingService.fetchAllListings()
            print("1yes")
        }else{
            self.listings = try await listingService.fetchFilteredListings(text: searchText, incomingGuests: incomingGuests)
            print("2yes")

        }
    }
}
