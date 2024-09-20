//
//  ListingService.swift
//  AirBnB
//
//  Created by Ujjwal Arora on 19/09/24.
//

import Foundation
import FirebaseFirestore

class ListingService{
    func fetchAllListings() async throws -> [ListingModel]{
        let listingsSnapshot = try await Firestore.firestore().collection("listings").getDocuments()
        print("❤️\(listingsSnapshot.documents)")
        return try listingsSnapshot.documents.map { document in
            try document.data(as: ListingModel.self)
        }
    }
    func fetchFilteredListings(text : String, incomingGuests : Int) async throws -> [ListingModel]{
        let query = Firestore.firestore().collection("listings")
            .whereFilter(Filter.andFilter([Filter.whereField("maximumGuests", isGreaterThan: incomingGuests),
                                           Filter.orFilter([Filter.whereField("city", isEqualTo: text),
                                                            Filter.whereField("state", isEqualTo: text),
                                                            Filter.whereField("country", isEqualTo: text)
                                                           ])
                                          ]))
        
        let queryListingSnapshot = try await query.getDocuments()
        print("❤️\(queryListingSnapshot.documents)")
        
        return try queryListingSnapshot.documents.map { document in
            try document.data(as: ListingModel.self)
        }
    }
    
}
