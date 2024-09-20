//
//  ListingModel.swift
//  AirBnB
//
//  Created by Ujjwal Arora on 19/09/24.
//

import Foundation

struct ListingModel : Identifiable, Codable, Hashable  {
    var id = UUID().uuidString
    let title : String
    let pricePerNight : Int
    let maximumGuests : Int
    let numberOfBedrooms : Int
    let numberOfBathrooms : Int
    let latitude : Double
    let longitude : Double
    let address : String
    let city : String
    let state : String
    let country : String
    let imagesUrls : [String]
    var amenities : [Amenitie]
    var features : [Feature]
    var buildingType : BuildingType
    var Owner : UserModel
    
}
enum Amenitie : Int, Identifiable, Codable , Hashable{
    case selfCheckIn , superHost
    
    var title : String {
        switch self {
        case .selfCheckIn:
            return "Self CheckIn"
        case .superHost:
            return "Super Host"
        }
    }
    var imageName : String {
        switch self {
        case .selfCheckIn:
            return "door.left.hand.open"
        case .superHost:
            return "medal"
        }
    }
    var description : String {
        switch self {
        case .selfCheckIn:
            return "Self check-in means guests can access a place without needing the Host to be there."
        case .superHost:
            return "A Superhost is a Host who goes above and beyond to provide excellent hospitality."
        }
    }
    
    var id: Int {
        return self.rawValue
    }
}
enum Feature : Int, Identifiable, Codable , Hashable{
    case pool,kitchen,wifi,tv,laundry,alarmSystem,fireSafety,petsAllowed,balcony
    
    var title : String {
        switch self {
        case .pool:
            return "Pool"
        case .kitchen:
            return "Kitchen"
        case .wifi:
            return "Wifi"
        case .tv:
            return "TV"
        case .laundry:
            return "Laundry"
        case .alarmSystem:
            return "Alarm System"
        case .fireSafety:
            return "Fire Safety"
        case .petsAllowed:
            return "Pets Allowed"
        case .balcony:
            return "Balcony"
        }
    }
    var imageName : String {
        switch self {
        case .pool:
            return "figure.pool.swim"
        case .kitchen:
            return "fork.knife"
        case .wifi:
            return "wifi"
        case .tv:
            return "tv"
        case .laundry:
            return "washer"
        case .alarmSystem:
            return "bolt.shield"
        case .fireSafety:
            return "flame"
        case .petsAllowed:
            return "dog"
        case .balcony:
            return "building"
        }
    }
    var id: Int {
        return self.rawValue
    }
}
enum BuildingType : Int , Codable, Identifiable, Hashable{
    case house,villa,flat,farmHouse
    
    var title : String {
        switch self {
        case .house:
            return "House"
        case .villa:
            return "Villa"
        case .flat:
            return "Flat"
        case .farmHouse:
            return "Farm House"
        }
    }
    var id: Int {
        return self.rawValue
    }
    
}

