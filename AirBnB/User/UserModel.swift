//
//  UserModel.swift
//  AirBnB
//
//  Created by Ujjwal Arora on 18/09/24.
//

import Foundation
import FirebaseFirestore

struct UserModel : Identifiable,Codable,Hashable{
    @DocumentID var id: String?
    let email : String
    let fullname : String
    let profilePhotoUrl : String
}
